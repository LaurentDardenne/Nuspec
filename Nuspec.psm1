$XsdFile='$PSscriptRoot\nuspec.2011.8.xsd'

[System.Collections.Stack] $script:Stack=$null

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
  'description',
  'summary',
  'releaseNotes',
  'copyright',
  'language',
  'tags'
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
  targetNamespace="'http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd'"
} 

Function Test-NuspecRules{
# Validate 'grammar' rules for a 'nuspec' bloc.
  [cmdletBinding()]
  param (
      [Parameter(Mandatory=$true)]
     $Bloc
  )
  #Write-Debug "debug control rule for : $Container - $Content "
   #'Premier niveau' seulement
  $Commands=foreach( $cmd in $Bloc.Ast.FindAll($predicate, $false))
  {
    #todo Psake\Properties ??
    $cmd.GetCommandName() -replace '.*\\(.*)$','$1'
  }
  $isError=$false
  if ($null -eq $commands) 
  {$isError=$true; Write-Error "Nuspec must contain at least a 'properties' bloc."}
  $CmdGrp=$Commands|Group-Object
  foreach($Group in $CmdGrp)
  {
    Write-Debug "Current command : $($Group.Name)"
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
  if ($isError)
  {
    $script:Stack=$null  
    throw "The nuspec bloc contains one or more errors." #todo détail AST
  }
}

Function Test-DependenciesRules{
# Validate 'grammar' rules for a 'dependencies' bloc.  
  [cmdletBinding()]
  param (
      [Parameter(Mandatory=$true)]
     $Bloc
  )

   #'Premier niveau' seulement
  $Commands=foreach( $cmd in $Bloc.Ast.FindAll($predicate, $false))
  {  $cmd.GetCommandName() -replace '.*\\(.*)$','$1' }
  $isError=$false
  if ($null -eq $commands) 
  {$isError=$true; Write-Error "Dependencies must contain at least a 'dependency' command."}
  $CmdGrp=$Commands|Group-Object
  foreach($Group in $CmdGrp)
  {
    Write-Debug "Current command : $($Group.Name)"
    switch ($Group.Name) 
    {
      'nuspec'                {break}
      { $_ -ne 'dependency'}  {$isError=$true; Write-Error "The command '$($Group.Name)' is not supported inside a 'dependencies' bloc."; break }
    }
  }
  if ($isError)
  {
    $script:Stack=$null  
    throw "The dependencies bloc contains one or more errors." #todo détail AST
  }
}

Function Test-FilesRules{
  # Validate 'grammar' rules for a 'files' bloc.
  [cmdletBinding()]
  param (
      [Parameter(Mandatory=$true)]
     $Bloc
  )
  
   #'Premier niveau' seulement
  $Commands=foreach( $cmd in $Bloc.Ast.FindAll($predicate, $false))
  {  $cmd.GetCommandName() -replace '.*\\(.*)$','$1' }
  $isError=$false
   #todo régle avec -All !!! ?
  if ($null -eq $commands) 
  {$isError=$true; Write-Error "Files must contain at least a 'file' command."}
  $CmdGrp=$Commands|Group-Object
  foreach($Group in $CmdGrp)
  {
    Write-Debug "Current command : $($Group.Name)"
    switch ($Group.Name) 
    {
      { $_ -ne 'file'}  {$isError=$true; Write-Error "The command '$($Group.Name)' is not supported inside a 'files' bloc."; break }
    }
  }
  if ($isError)
  {
    $script:Stack=$null  
    throw "The files bloc contains one or more errors." #todo détail AST
  }
}

function nuspec {
  [cmdletBinding()]
  [OutputType([NugetSchema.package])]
  param (
      #todo validateAttribut : https://github.com/NuGetPackageExplorer/NuGetPackageExplorer/blob/master/Core/Utility/PackageIdValidator.cs
       [parameter(position=0,Mandatory=$true)]
      [string]$id,

       #todo validateAttribut regex 
       [parameter(position=1,Mandatory=$true)]
      [string]$version,

       [parameter(position=2,Mandatory=$true)]
      [scriptblock] $NuspecBloc
  )
 process{ 
  Write-Debug "`r`n `tENTER Bloc nuspec"
  Test-NuspecRules -Bloc $NuspecBloc
   #La classe Stack est sensible à la casse
  $UpperId=$ID.ToUpper()
  if ( $null -eq $script:Stack)
  { $script:Stack=New-Object System.Collections.Stack }
  if ($script:Stack.Contains($upperId))
  { 
      #On interdit la création d'un nuspec portant un ID déjà référencé, même si la version différe.
      #Sinon on pourrait avoir, par exemple, 'Module1' version 1.0 qui dépend de 'Module1' version 1.1  
    $script:Stack=$null
    throw  "The package name '$Id' is already declared." 
  }
  
  Write-Debug "`t`t CREATE nuspec object $id"
  $Nuspec= [NugetSchema.package]::new()
  $script:Stack.Push($upperId)
  $List=[System.Collections.Generic.List[NugetSchema.packageMetadataDependency]]::new(6)
  foreach( $resultBloc in &$NuspecBloc)
  {
    $TypeName=$resultBloc.Gettype().Fullname
    Write-debug "In Nuspec : add $TypeName"
    switch($TypeName) {
      'NugetSchema.packageMetadata'           {
                                                 Write-debug "Add metadata" 
                                                 $Nuspec.metadata=$resultBloc;break
                                              } 
      'NugetSchema.packageMetadataDependency' {
                                                 Write-debug "Add dependencies"
                                                 $List.Add($resultBloc);break
                                              }
      'NugetSchema.packageFile[]'             {
                                                 Write-debug "Add Files"
                                                 $Nuspec.Files=$resultBloc;break
                                              } 
      'NugetSchema.package'                   {  
                                                 Write-debug "WriteOutput nested nuspec  : $($resultbloc.metadata.id)- $($resultbloc.metadata.version)"
                                                 $ImplicitDependency=Dependency -id $resultbloc.metadata.id -version $resultbloc.metadata.version
                                                 $List.Add($ImplicitDependency)
                                                 $PSCmdlet.WriteObject($resultBloc)  ;break
                                              }
      default {
         throw  "Assert : the $TypeName is unexpected." 
      }
    }#switch                                                                                               
  }#foreach
  
  Write-debug "WriteOutput created nuspec  : $($Nuspec.metadata.id)- $($Nuspec.metadata.version)"
  if($List.Count -gt 0)
  { $Nuspec.metadata.dependencies=$List }
  $PSCmdlet.WriteObject($Nuspec)
  $script:Stack.Pop()>$null
  Write-debug "`r`n`tLEAVE nuspec"
 }
}

function Properties {
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
  { 
    $script:Stack=$null 
    throw "The names of the following properties are either unknown or misspelled : $SetProperties" 
  }

  $Mandatory=@()
  foreach ($Key in $Script:MandatoryPropertiesName)
  {
     if (-not $Properties.contains($key)) 
     {$Mandatory +=$Key}
  }
  if ($Mandatory.Count -gt 0 ) 
  { 
    $script:Stack=$null
    throw "The following properties are mandatory : $Mandatory" 
  } 
  #Récupère le Nuspec en cours: gv -scope -1
  New-NuspecMetadata -nuspec $Nuspec -ID $ID -Version $Version
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
      [string]$id
   )
 $Nuspec.metadata= New-Object NugetSchema.packageMetadata -Property $Properties
 $Nuspec.metadata.id=$Id
 $Nuspec.metadata.version=$version
}

function Dependencies {
 [cmdletBinding()]
 [OutputType([NugetSchema.packageMetadataDependency])]
 [OutputType([NugetSchema.package])]
 param(
    [parameter(Mandatory=$true)]
   [scriptblock] $DependenciesBloc
 )
 process {
  Write-Debug "`r`n `tENTER Bloc Dependencies"
  Test-DependenciesRules -Bloc $DependenciesBloc
  &$DependenciesBloc
  Write-debug "`r`n`tLEAVE dependencies"
 }
}

function Dependency{
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadataDependency])]
  param (
     [parameter(position=0,Mandatory=$true)] 
    [string] $id,
     #todo https://docs.nuget.org/create/versioning#Specifying-Version-Ranges-in-.nuspec-Files
     #     https://github.com/NuGetPackageExplorer/NuGetPackageExplorer/blob/master/Core/Utility/VersionUtility.cs
     [parameter(position=1)]
    [string] $version
  )
  Write-Debug "Dependency ${ID}_$Version"
  New-Object NugetSchema.packageMetadataDependency -Property $PSBoundParameters
}

function Files {
  [CmdletBinding(DefaultParameterSetName="All")] 
  [OutputType([NugetSchema.packageFile[]])]
  param (
    [string]$Source,
    
    [string[]]$Exclude,

     [parameter(Mandatory=$true,position=0,ParameterSetName='Source')]
    [scriptblock] $FilesBloc,
     
     [parameter(Mandatory=$true,ParameterSetName='All')]
    [switch] $All
  )
  #control les files  considérés comme All ne doivent pas se retrouver dans
  #file src
  #et les excludes ne pas être en contradiction ( SI c'est possible à Faire !!)

#   Files -All #si files absent pareil
#   Files -All -exclude  
#   Files {
#      file src ''  target=''   exclude=''
#       All
#      } 
  Write-Debug "`r`n `tENTER Bloc Files"
  Test-FilesRules -Bloc $FilesBloc
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

#todo
function frameworkAssemblies{
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadataFrameworkAssembly[]])]
  param(
     [parameter(Mandatory=$true)]
    [scriptblock] $frameworkAssembliesBloc
  )
  Write-Debug "`r`n `tBloc frameworkAssemblies"
  throw "Not implemented"
  #frameworkAssemblies=[NugetSchema.packageMetadataFrameworkAssembly]::new()
  Write-Debug "`r`n`tLEAVE frameworkAssemblies"
}

function frameworkAssembly{
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadataFrameworkAssembly])]
  param(
     [parameter(Mandatory=$true)] 
    [string] $assemblyName,
         
    [string] $targetFramework
  )  
 Write-Debug "`r`n `tBloc frameworkAssembly"
 throw "Not implemented"
 Write-Debug "`r`n`tLEAVE frameworkAssembly"
}

function references{
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadataReference[]])]
  param(
    [parameter(Mandatory=$true)]
       [scriptblock] $ReferencesBloc
  )
  Write-Debug "`r`n `tBloc References"
  throw "Not implemented"
  #references=[NugetSchema.packageMetadataReference]::new()
  Write-Debug "`r`n`tLEAVE References"  
}

function reference{
 [cmdletBinding()]
 [OutputType([NugetSchema.packageMetadataReference])] 
 param(  
     [parameter(Mandatory=$true)] 
    [string] $file
 )
 Write-Debug "`r`n `tBloc reference"
 throw "Not implemented"
 Write-Debug "`r`n`tLEAVE reference"
}

