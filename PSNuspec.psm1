#Note : 
# Warning with 'Nuget pack MyNuspecFile' : Assembly outside lib folder. -->  https://github.com/NuGet/Home/issues/2834}

#
#  Init.ps1      : runs the first time a package is installed in a solution.
#  Install.ps1   : runs when a package is installed in a project.
#  Uninstall.ps1 : runs every time a package is uninstalled. 

#SchemaVersionV6
$XsdFile='$PSscriptRoot\nuspec.2013.05.xsd' 

$predicate={
    [System.Management.Automation.Language.Ast]$ast = $args[0]
      $ast -is [System.Management.Automation.Language.CommandAst]
}

[string[]] $script:AllowedPropertiesName=@(
  'title',
  'authors',
  'owners',
  'licenseUrl',
  'projectUrl',
  'iconUrl',
  'requireLicenseAcceptance',
  'requireLicenseAcceptanceSpecified',
  'developmentDependency',
  'developmentDependencySpecified',
  'description',
  'summary',
  'releaseNotes',
  'copyright',
  'language',
  'tags',
  'serviceable',
  'serviceableSpecified',
  'packageTypes',
  'dependencies',
  'frameworkAssemblies',
  'references',
  'contentFiles',
  'minClientVersion'
)

[string[]] $script:MandatoryPropertiesName=@(
  'authors',
  'description'
)

#Create proxy function : Save-Nuspec -Object $Nuspec -Filename $FileName
#The parameters 'SerializedType' and 'targetNamespaceWith' are pre-binded
XMLObject\Set-ParamAlias -Name Save-Nuspec -Command ConvertTo-XML `
 -parametersBinding @{
  SerializedType="'NugetSchema.package'"
  targetNamespace="'http://schemas.microsoft.com/packaging/2013/05/nuspec.xsd'"
  NoBom='$true'    #Nuget need XML file with encoding UTF8-NoBOM 
} 

function Test-NuspecRules {
  param( $Group)

  switch ($Group.Name) 
  {
    'nuspec'       {if ($group.count -ge 1) {$isError=$true; Write-Error "Nested Nuspec must be declared inside a 'dependencies' bloc."};break}
    'properties'   {if ($group.count -ne 1) {$isError=$true; Write-Error "Nuspec must have one and only one 'properties' bloc."}; break}
    'dependencies' {if ($group.count -ne 1) {$isError=$true; Write-Error "Nuspec must have one and only one 'dependencies' bloc."}; break}
    'files'        {if ($group.count -gt 1) {$isError=$true; Write-Error "Nuspec must have only one 'files' bloc."};break}
    
                    #Those commands are not containers
    'dependency'   {$isError=$true; Write-Error "dependency must be declared inside a 'dependencies' bloc."; break }
    'file'         {$isError=$true; Write-Error "file must be declared inside a 'files' bloc."; break }
  }
}

Function Test-DependenciesRules{
  [cmdletBinding()]
  param( $Group)
  
  switch ($Group.Name) 
  {
    'nuspec'                {break}
    { $_ -ne 'dependency'}  {$isError=$true; Write-Error "The command '$($Group.Name)' is not supported inside a 'dependencies' bloc."; break }
  }
}

Function Test-FilesRules{
  [cmdletBinding()]
  param( $Group)

  switch ($Group.Name) 
  {
    { $_ -ne 'file'}  {$isError=$true; Write-Error "The command '$($Group.Name)' is not supported inside a 'files' bloc."; break }
  }
}

Function Test-Rule{
# Validate 'grammar' rules for a a specific bloc.
  [cmdletBinding()]
  param (
     #Name of the bloc
      [Parameter(position=0,Mandatory=$true)]
     [string]$Container,
     
     #Name of the child bloc
      [Parameter(position=1,Mandatory=$true)]
     [string]$Content,
     
     #Name of the validation function
      [Parameter(position=2,Mandatory=$true)]
     [string] $Validator,
     
     #Code to validate
      [Parameter(position=3,Mandatory=$true)]
     [scriptblock] $Bloc
 )
 
  Write-Debug "Control the rules for : $Container - $Content "
   #Do not search in nested script blocks.
  $Commands=foreach( $cmd in $Bloc.Ast.FindAll($predicate, $false))
  {
    # todo Psake\Properties --> '(?<Qualifier>.*)\\(.*)$'
    $cmd.GetCommandName() -replace '.*\\(.*)$','$1'
  }
  $isError=$false
  if ($null -eq $commands) 
  {$isError=$true; Write-Error "$Container must contain at least a '$Content' bloc."}
  $CmdGrp=$Commands|Group-Object
  foreach($Group in $CmdGrp)
  {
    Write-Debug "Current command : $($Group.Name)"
    . $Validator -Group $Group
  }
  if ($isError)
  { throw "The $Container bloc contains one or more errors." } #todo détail AST 
}

function nuspec {
  [cmdletBinding()]
  [OutputType([NugetSchema.package])]
  param (
       #nuget.exe : Id must not exceed 100 characters.
       [parameter(position=0,Mandatory=$true)]
      [string]$id,

       #nuget.exe : '1.A.0' |'(1.0.0)' is not a valid version string.
       [parameter(position=1,Mandatory=$true)]
      [string]$version,

       [parameter(position=2,Mandatory=$true)]
      [scriptblock] $NuspecBloc,

      [switch] $DevelopmentDependency
  )
 process{ 
  Write-Debug "`r`n `tENTER Bloc nuspec"
  Test-Rule -Container 'Nuspec' -Content 'properties' -Validator  'Test-NuspecRules' -Bloc $NuspecBloc
   #La classe Stack est sensible à la casse
  $UpperId=$ID.ToUpper()
  if ( $null -eq $Stack)
  { 
     #Rappel : Le premier appel crée la variable, 
     #         les appels récursifs suivant recherche dans le scope parent 
     $Stack=New-Object System.Collections.Stack 
  }
  if ($Stack.Contains($upperId))
  { 
      #On interdit la création d'un nuspec portant un ID déjà référencé, même si la version différe.
      #Sinon on pourrait avoir, par exemple, 'Module1' version 1.0 qui dépend de 'Module1' version 1.1  
    throw  "The package name '$Id' is already declared." 
  }
  
  Write-Debug "`t`t CREATE nuspec object $id"
  $Nuspec= [NugetSchema.package]::new()
  $Stack.Push($upperId)
   
  $List=[System.Collections.Generic.List[NugetSchema.Dependency]]::new(6)
  foreach( $resultBloc in &$NuspecBloc)
  {
    $TypeName=$resultBloc.Gettype().Fullname
    Write-debug "In Nuspec : add $TypeName"
    switch($TypeName) {
       'NugetSchema.packageMetadata'  {
                                         Write-debug "Add metadata" 
                                         $Nuspec.metadata=$resultBloc
                                         break
                                      } 
       'NugetSchema.Dependency'       {
                                         Write-debug "Add dependencies"
                                         $List.Add($resultBloc)
                                         break
                                      }
                                                   
       'NugetSchema.packageFile[]'    {
                                         Write-debug "Add Files"
                                         $Nuspec.Files=$resultBloc
                                         break
                                      } 
       'NugetSchema.package'          {  
                                         Write-debug "WriteOutput nested nuspec  : $($resultbloc.metadata.id)- $($resultbloc.metadata.version)"
                                          #todo régle de versionning 
                                         $ImplicitDependency=Dependency -id $resultbloc.metadata.id -version $resultbloc.metadata.version
                                         $List.Add($ImplicitDependency)
                                          #Les différent objets sont tous envoyés dans un seul pipeline
                                          #certains sont consommés, les nested nuspec doivnet être réémis. 
                                         $PSCmdlet.WriteObject($resultBloc)
                                         break
                                      }
      default {
         throw  "Assert : the $TypeName is unexpected." 
      }
    }#switch                                                                                               
  }#foreach
  
  Write-debug "WriteOutput created nuspec  : $($Nuspec.metadata.id)-$($Nuspec.metadata.version)"
  if($List.Count -gt 0)
  { 
    $Nuspec.metadata.dependencies=[NugetSchema.packageMetadataDependencies]::new()
    $Nuspec.metadata.dependencies.Items=$List
  }
  $PSCmdlet.WriteObject($Nuspec)
  $Stack.Pop()>$null
  Write-debug "`r`n`tLEAVE nuspec"
 }
}

function properties {
  #Modifie la variable $nuspec
 [cmdletBinding()]
 param(
    [parameter(Mandatory=$true)]
   [hashtable] $properties
 )
  Write-Debug "`r`n `tENTER Bloc properties"
  $SetProperties=[System.Collections.Generic.HashSet[String]]::new([string[]]$Properties.keys,[StringComparer]::InvariantCultureIgnoreCase)
  $SetProperties.ExceptWith($script:AllowedPropertiesName)
  $ofs=','
  if ($SetProperties.Count -gt 0)
  {  throw "The names of the following properties are either unknown or misspelled : $SetProperties"  }

  $Mandatory=@()
  foreach ($Key in $Script:MandatoryPropertiesName)
  {
     if (-not $Properties.contains($key)) 
     {$Mandatory +=$Key}
  }
  if ($Mandatory.Count -gt 0 ) 
  { throw "The following properties are mandatory : $Mandatory" } 
  #Récupère le Nuspec en cours: gv -scope -1
  New-NuspecMetadata -nuspec $Nuspec -ID $ID -Version $Version -DevelopmentDependency:$DevelopmentDependency
  Write-debug "`r`n`tLEAVE properties"
}

function New-NuspecMetadata {
  [cmdletBinding()]
  param (
       [parameter(Mandatory=$true)]
      [NugetSchema.package] $Nuspec,

       [parameter(Mandatory=$true)]
      [string]$version,
        
       [parameter(Mandatory=$true)]
      [string]$id,
      
      [switch] $DevelopmentDependency
   )
 $Nuspec.metadata= New-Object NugetSchema.packageMetadata -Property $Properties
 $Nuspec.metadata.id=$Id
 $Nuspec.metadata.version=$version
 $Nuspec.metadata.DevelopmentDependency=$DevelopmentDependency
}

function Dependencies {
 [cmdletBinding()]
  #on ne gére pas les dependencyGroup spécifique à VS
 [OutputType([NugetSchema.Dependency])]
  #Le bloc peut contenir des déclarations imbriquées de package
 [OutputType([NugetSchema.package])] 
 param(
    [parameter(Mandatory=$true)]
   [scriptblock] $DependenciesBloc
 )
 process {
  Write-Debug "`r`n `tENTER Bloc Dependencies"
  Test-Rule -Container 'Dependencies' -Content 'dependency' -Validator 'Test-DependenciesRules' -Bloc $DependenciesBloc
  &$DependenciesBloc
  Write-debug "`r`n`tLEAVE dependencies"
 }
}

function dependency{
  [cmdletBinding()]
  [OutputType([NugetSchema.Dependency])]
  param (
     [parameter(position=0,Mandatory=$true)] 
    [string] $id,
    
     #nuget.exe : Dependency 'SampleDependency' has an invalid version.
     #            '1.0]' is not a valid version string.
     [parameter(position=1)]
    [string] $version
  )
  Write-Debug "Dependency ${ID}_$Version"
  New-Object NugetSchema.Dependency -Property $PSBoundParameters
}

function Files {
 #DOC:
 #Par défaut 'nuget.exe pack' ajoute tous le fichiers du répertoire courant.
 #Il est recommandé de spécifier la balsies 'Files'. 
  [CmdletBinding(DefaultParameterSetName="All")] 
  [OutputType([NugetSchema.packageFile[]])]
  param (
    [string]$Source,
    
    [string[]]$Exclude,

     [parameter(Mandatory=$true,position=0,ParameterSetName='Source')]
    [scriptblock] $FilesBloc,
     
     [parameter(Mandatory=$true,ParameterSetName='All')]
    [switch] $All #todo
  )

  Write-Debug "`r`n `tENTER Bloc Files"
  Test-Rule -Container 'Files' -Content 'files' -Validator 'Test-FilesRules' -Bloc $FilesBloc
  $List=[System.Collections.Generic.List[NugetSchema.packageFile]]::new(12)
  &$FilesBloc|
  Foreach-Object {
   $List.Add($_)>$null
  }
  [NugetSchema.packageFile[]]$ReturnValue=$List
  ,$ReturnValue
  Write-Debug "`r`n`tLEAVE Files"
}

function file {
  [cmdletBinding()]
  [OutputType([NugetSchema.packageFile])]
  param (
      [parameter(Mandatory=$true)]
    [string]$src,
    
    [string]$target,

    [string]$exclude
  )
 Write-Debug "`r`n `tENTER Bloc file"
 Write-Debug "Add file -src $src"
 New-Object -TypeName NugetSchema.packageFile -Property $PSBoundParameters
 Write-Debug "`r`n`tLEAVE file"
}

function Import-ManifestData { 
# Requires PS version 4.0
#Lit un manifest de module et renvoi une hashtable contenant uniquement les clés qui y sont renseignées
#from http://stackoverflow.com/questions/25408815/how-to-read-powershell-psd1-files-safely
#Gére les clés ModuleToProcess (v4) ou RootModule (v5) 
#
#  Import-ManifestData -data "Mymodule.psd1"
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [Microsoft.PowerShell.DesiredStateConfiguration.ArgumentToConfigurationDataTransformation()]
        [hashtable] $data
    )
    return $data
}#Import-ManifestData

function Get-ScriptVersion {
  #renvoi le numéro de version d'un script versionné
 param( 
   [string] $Path,
   [int] $fieldCount
 )
 $FileInfo=Test-ScriptFileInfo -Path $Path
 if ($null -ne $FileInfo)
 {
    if ($PSBoundParameters.ContainsKey('fieldCount'))  
    { $FileInfo.Version.ToString($fieldCount) }
    else
    { $FileInfo.Version.ToString() }
 }
}
function Push-nupkg {
    #Push a nupkg to a server
    #The working directory is $env:temp

 [cmdletBinding()]
 param(
   #Nuget package to push   
     [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
     [ValidateNotNullOrEmpty()]
   [NugetSchema.package] $Package,

   #Directory where you are saving the nuspec file 
     [Parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]
   [string] $PathDelivery,

   #Url of the nuget server
     [Parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]
   [string] $Source,

     [ValidateNotNullOrEmpty()]
   [string] $ApiKey
 )   
 
 process {
   $PkgName=$Package.metadata.id
   $PkgVersion=$Package.metadata.version
   $PathNuspec="$PathDelivery\$PkgName.nuspec"
   
   Write-verbose "Save-Nuspec '$PathNuspec'"
   Save-Nuspec -Object $Package -FileName $PathNuspec
   try {
    $ErrorActionPreference='Stop'
    Push-Location $env:Temp
    nuget pack $PathNuspec 2>&1
    Write-verbose "push '$env:Temp\$PkgName.$PkgVersion.nupkg'"
    if ($PSBoundParameters.ContainsKey('ApiKey'))  
    {
      nuget push "$env:Temp\$PkgName.$PkgVersion.nupkg" -Source $source- Apikey $ApiKey 2>&1
    }
    else 
    {  
       #On utilise l'Apikey  sauvegardée sur le poste local
      nuget push "$env:Temp\$PkgName.$PkgVersion.nupkg" -Source $source 2>&1
    }
    #Error :
    #  'Feed does not exist' ->  la source n'existe pas
    #  'Method Not Allowed'  -> erreur d'url
    #  "An API key must be provided in the 'X-NuGet-ApiKey' header to use this service"  -> L'Apikey de la source est introuvable en local
   }
   finally {
     Pop-Location
     $ErrorActionPreference='Continue'
   }
 }
}