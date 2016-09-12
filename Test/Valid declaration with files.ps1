[cmdletBinding()]
param()

nuspec 'ModuleX' '1.0' {
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
      file -src 'C:\temp\Lock-File.ps1'
      file -src 'C:\temp\Remove-Conditionnal.ps1'
      file -src 'C:\temp\Replace-String.ps1'
      file -src 'C:\temp\Show-BalloonTip.ps1'
      file -src 'C:\temp\Test-BOMFile.ps1'
      file -src 'C:\temp\Using-Culture.ps1'
   }
}
