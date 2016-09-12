#todo test avec :
# $MyConfig={tags='1';owner='tt'}
#  properties $MyConfig
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

function Add-Dependency {
  #A nested Nuspec is added into the dependcies collection.
param(
  $Nuspec
)
 $Nuspec.metadata.dependencies += Dependency -id $Nuspec.metadata.id -version $Nuspec.metadata.version
}

function Test-Caller {
  [OutputType([System.Boolean])]
  param (
       [Parameter(Mandatory=$true)]
     [string] $BlocName,

     [switch] $Parent
  )
 if ($Parent)
 { $index=3 } # 2 + this call  
 #example:
 #      0        1         2            3
 # Test-Caller.nuspec.<ScriptBlock>.Dependencies
 #  Dependencies {
 #   nuspec {...}
 #  }

 $callStack = @(Microsoft.PowerShell.Utility\Get-PSCallStack)

 $callStack[$Index].Command -eq $BlocName
}

function New-NuspecMetadata {
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadata])]
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
 $Nuspec
}

function nuspec {
  [cmdletBinding()]
  [OutputType([NugetSchema.package])]
  param (
       [parameter(Mandatory=$true)]
      [string]$version,
       
       [parameter(Mandatory=$true)]
      [string]$id,
       
       [parameter(Mandatory=$true)]
      [scriptblock] $NuspecBloc)
  Write-Debug "Bloc nuspec"
  Test-NuspecRules -Bloc $NuspecBloc
   #La classe Stack est sensible à la casse
  $UpperId=$ID.ToUpper()
  if ( $null -eq $script:Stack)
  { 
    Write-warning "* create stack"
    $script:Stack=New-Object System.Collections.Stack 
  }
  if ($script:Stack.Contains($upperId))
  { 
      #On interdit la création d'un nuspec portant un ID déjà référencé, même si la version différe.
      #Sinon on pourrait avoir, par exemple, 'Module1' version 1.0 qui dépend de 'Module1' version 1.1  
    $script:Stack=$null
    throw  "The package name '$Id' is already declared." 
  }
  
  $Nuspec= [NugetSchema.package]::new()
  
  $script:Stack.Push($upperId)
  #todo annule
  $ret=&$NuspecBloc
  #foreach( $resultBloc in &$NuspecBloc)
  foreach( $resultBloc in $ret)
  {
    $TypeName=$resultBloc.Gettype().Fullname
    Write-debug "Nuspec $($ret.count) : add $TypeName"
    switch($TypeName) {
      'NugetSchema.packageMetadata'             {
                                                    $Nuspec.metadata=$resultBloc;break
                                                 } 
      'NugetSchema.packageMetadataDependency[]' {
                                                    $Nuspec.metadata.dependencies=$resultBloc;break
                                                 }
      'NugetSchema.packageFile[]'               {
                                                    $Nuspec.Files=$resultBloc;break
                                                 } 
      'NugetSchema.package'                     {
                                                    if (Test-Caller 'Dependencies' -Parent)
                                                    { 
                                                      Write-debug "In rule send  : $($resultbloc.metadata.id)- $($resultbloc.metadata.version)"
                                                      Write-Output $resultBloc 
                                                    } 
                                                    else{
                                                      Write-debug "In rule NOT send  : $($resultbloc.metadata.id)- $($resultbloc.metadata.version)"
                                                    }
                                                    break 
                                                 }
                                                   
                                                    # }
      default {
         throw  "Assert : the $TypeName is unexpected." 
      }
    }#switch                                                                                               
  }#foreach
  
  # if (Test-Caller 'Dependencies' -Parent)
  # { Add-Dependency -Nuspec $Nuspec }

  Write-debug " * Send created nuspec  : $($Nuspec.metadata.id)- $($Nuspec.metadata.version)"
  Write-output $Nuspec
  $script:Stack.Pop()>$null
}

function Properties {
 [cmdletBinding()]
 [OutputType([NugetSchema.packageMetadata])]
 param(
    [parameter(Mandatory=$true)]
   [hashtable] $properties
 )
 Write-Debug "Bloc properties"
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
}

function Dependencies {
 [cmdletBinding()]
 [OutputType([NugetSchema.packageMetadataDependency[]])]
 param(
    [parameter(Mandatory=$true)]
   [scriptblock] $DependenciesBloc
 )
  Write-Debug "Bloc Dependencies"
  Test-DependenciesRules -Bloc $DependenciesBloc
  $List=[System.Collections.Generic.List[NugetSchema.packageMetadataDependency]]::new(12)
  &$DependenciesBloc|
   Foreach-Object {
    if ($_ -is [NugetSchema.package])
    { 
      Write-debug "Nested Nuspec, we create a dependency"
      #Write-Output $_
      $List.Add((Add-Dependency -Nuspec $_))>$null
    }
    else 
    { 
      Write-debug "`tAdd dependency"
      $List.Add($_)>$null }
   }
  [NugetSchema.packageMetadataDependency[]]$ReturnValue=$List
  ,$ReturnValue
}

function Dependency{
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadataDependency])]
  param (
     [parameter(Mandatory=$true)] 
    [string] $id,
    
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
  Write-Debug "Bloc Files"
  Test-FilesRules -Bloc $FilesBloc
  $List=[System.Collections.Generic.List[NugetSchema.packageFile]]::new(12)
  &$FilesBloc|
  Foreach-Object {
   $List.Add($_)>$null
  }
  [NugetSchema.packageFile[]]$ReturnValue=$List
  ,$ReturnValue
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
 Write-Debug "file -src $src"
 New-Object -TypeName NugetSchema.packageFile -Property $PSBoundParameters
}

#todo
function frameworkAssemblies{
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadataFrameworkAssembly[]])]
  param(
     [parameter(Mandatory=$true)]
    [scriptblock] $frameworkAssembliesBloc
  )
  Write-Debug "Bloc frameworkAssemblies"
  throw "Not implemented"
  #frameworkAssemblies=[NugetSchema.packageMetadataFrameworkAssembly]::new()
}

function frameworkAssembly{
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadataFrameworkAssembly])]
  param(
     [parameter(Mandatory=$true)] 
    [string] $assemblyName,
         
    [string] $targetFramework
  )  
 Write-Debug "Bloc frameworkAssembly"
 throw "Not implemented"
}

function references{
  [cmdletBinding()]
  [OutputType([NugetSchema.packageMetadataReference[]])]
  param(
    [parameter(Mandatory=$true)]
       [scriptblock] $ReferencesBloc
  )
  Write-Debug "Bloc References"
  throw "Not implemented"
  #references=[NugetSchema.packageMetadataReference]::new()  
}

function reference{
 [cmdletBinding()]
 [OutputType([NugetSchema.packageMetadataReference])] 
 param(  
     [parameter(Mandatory=$true)] 
    [string] $file
 )
 Write-Debug "Bloc reference"
 throw "Not implemented"
}

#Create proxy function : Save-Nuspec -Object $Nuspec -Filename $FileName
#The parameters 'SerializedType' and 'targetNamespaceWith' are pre-binded
XMLObject\Set-ParamAlias -Name Save-Nuspec -Command ConvertTo-XML `
 -parametersBinding @{
  SerializedType="'NugetSchema.package'"
  targetNamespace="'http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd'"
} 
