Param (
 # Specific to the development computer
 [string] $VcsPathRepository=''
) 

if (Test-Path env:APPVEYOR_BUILD_FOLDER)
{
  $VcsPathRepository=$env:APPVEYOR_BUILD_FOLDER
}

if (!(Test-Path $VcsPathRepository))
{
  Throw 'Configuration error, the variable $VcsPathRepository should be configured.'
}

#Variable commune à tous les postes
#todo ${env:Name with space}
if ( $null -eq [System.Environment]::GetEnvironmentVariable("ProfileNuspec","User"))
{ 
 [Environment]::SetEnvironmentVariable("ProfileNuspec",$VcsPathRepository, "User")
  #refresh the environment Provider
 $env:ProfileNuspec=$VcsPathRepository 
}

 # Variable spécifiques au poste de développement
$NuspecDelivery= "${env:temp}\Delivery\Nuspec"   
$NuspecLogs= "${env:temp}\Logs\Nuspec" 

 # Variable communes à tous les postes, leurs contenu est spécifique au poste de développement
$NuspecBin= "$VcsPathRepository\Bin"
$NuspecHelp= "$VcsPathRepository\Documentation\Helps"
$NuspecSetup= "$VcsPathRepository\Setup"
$NuspecVcs= "$VcsPathRepository"
$NuspecTests= "$VcsPathRepository\Tests"
$NuspecTools= "$VcsPathRepository\Tools"
$NuspecUrl= 'https://github.com/LaurentDardenne/Nuspec.git'

 #PSDrive sur le répertoire du projet 
$null=New-PsDrive -Scope Global -Name Nuspec -PSProvider FileSystem -Root $NuspecVcs 

Write-Host "Settings of the variables of Nuspec project." -Fore Green

rv VcsPathRepository

