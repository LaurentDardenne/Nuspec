
$ModuleVersion=(Import-ManifestData "$NuspecVcs\PSNuspec.psd1").ModuleVersion

nuspec 'PSNuspec' $ModuleVersion {
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
        releaseNotes="$(Get-Content "$NuspecVcs\CHANGELOG.md" -raw)"
        tags='PSModule PSIncludes_Function PSFunction_nuspec PSFunction_properties PSFunction_Dependencies PSFunction_dependency PSFunction_Files PSFunction_file PSFunction_Save-Nuspec PSCommand_nuspec PSCommand_properties PSCommand_Dependencies PSCommand_dependency PSCommand_Files PSCommand_file PSCommand_Save-Nuspec'
        #tags='nuspec XSD Powershell DSL'
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
   }        
}|Save-Nuspec -FileName "$NuspecDelivery\PSNuspec.nuspec"
