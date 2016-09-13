
nuspec 'Nuspec' '0.2' {
   properties @{
        Authors='Dardenne Laurent'
        Description='Powershell DSL to create a nuspec file.'
        title='Nuspec module'
        summary='Powershell DSL to create a nuspec file.'
        copyright='Copyleft'
        language='fr-FR'
        licenseUrl='https://creativecommons.org/licenses/by-nc-sa/4.0/'
        projectUrl='https://github.com/LaurentDardenne/Nuspec'
        iconUrl='https://github.com/LaurentDardenne/Nuspec/blob/master/icon/Nuspec.png'
        releaseNotes=''
        tags=$null
   }
   
   dependencies {
        dependency XMLObject 1.0.0
   }     
   
   files {
        file -src "$NuspecVcs\lib\net40\NugetSchema.dll" -target "lib\net40\NugetSchema.dll"
        file -src "$NuspecVcs\nuspec.2011.8.xsd"
        file -src "$NuspecVcs\Nuspec.psd1"
        file -src "$NuspecVcs\Nuspec.psm1"
        file -src "$NuspecVcs\README.md"
   }        
}|Save-Nuspec -FileName "$NuspecDelivery\Nuspec.nuspec"
