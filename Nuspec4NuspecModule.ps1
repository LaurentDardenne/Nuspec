
if(! (Test-Path variable:NuspecVcs))
{
    throw "The project configuration is required, see the 'Nuspec_ProjectProfile.ps1' script." 
}
$ModuleVersion=(Import-ManifestData "$NuspecVcs\PSNuspec.psd1").ModuleVersion

$Result=nuspec 'PSNuspec' $ModuleVersion {
   properties @{
        Authors='Dardenne Laurent'
        Owners='Dardenne Laurent'
        Description='Powershell DSL to create a nuspec file.'
        title='Nuspec module'
        summary='Powershell DSL to create a nuspec file.'
        copyright='Copyleft'
        language='fr-FR'
        licenseUrl='https://creativecommons.org/licenses/by-nc-sa/4.0/'
        projectUrl='https://github.com/LaurentDardenne/Nuspec'
        iconUrl='https://github.com/LaurentDardenne/Nuspec/blob/master/icon/Nuspec.png'
        releaseNotes="$(Get-Content "$NuspecVcs\releasenotes.md" -raw)"
        tags='nuspec XSD Powershell DSL'
   }
   
   dependencies {
        dependency XMLObject 1.0.0
   }     
   
   files {
        file -src "$NuspecVcs\lib\net40\NugetSchema.dll" -target "lib\net40\NugetSchema.dll"
        file -src "$NuspecVcs\nuspec.2013.05.xsd"
        file -src "$NuspecVcs\PSNuspec.psd1"
        file -src "$NuspecVcs\PSNuspec.psm1"
        file -src "$NuspecVcs\README.md"
        file -src "$NuspecVcs\releasenotes.md"
   }        
}

$Result|
  Push-nupkg -Path $NuspecDelivery -Source 'https://www.myget.org/F/ottomatt/api/v2/package'
  
