# Nuspec
Powershell DSL to create a nuspec file

```Powershell
nuspec '1.0' 'MyModule' {
   properties @{
        Authors=$Env:USERNAME
        Description='test'
        title=''
        summary=''
        #owners=''
        copyright='Copyleft'

         #default $false
        requireLicenseAcceptance=$False
        requireLicenseAcceptanceSpecified=$False

         #default en-US'
        language='en-US'

        #PSData
        licenseUrl='https://creativecommons.org/licenses/by-nc-sa/4.0/'
        projectUrl='https://github.com/LaurentDardenne/'
        iconUrl='https://github.com/LaurentDardenne/Nuspec/blob/master/Icon/Nuspec.png'
        releaseNotes=''
        tags=$null
   }
   files {
      file -src 'G:\PS\ProjectTools\Lock-File.ps1'
      file -src 'G:\PS\ProjectTools\Remove-Conditionnal.ps1'
      file -src 'G:\PS\ProjectTools\Replace-String.ps1'
      file -src 'G:\PS\ProjectTools\Show-BalloonTip.ps1'
      file -src 'G:\PS\ProjectTools\Test-BOMFile.ps1'
      file -src 'G:\PS\ProjectTools\Using-Culture.ps1'
   }
}|Save-Nuspec -FileName c:\temp\Test.nuspec
```
