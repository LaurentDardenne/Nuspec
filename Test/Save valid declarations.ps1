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
        #developmentDependency=$False
        #developmentDependencySpecified=$False

         #default en-US'
        language='en-US'

        #PSData
        licenseUrl='https://creativecommons.org/licenses/by-nc-sa/4.0/'
        projectUrl='https://github.com/LaurentDardenne/'
        iconUrl='https://github.com/LaurentDardenne/Nuspec/blob/master/Icon/Nuspec.png'
        releaseNotes=''
        tags=$null
         #default $false
        #serviceable=$False #v3.5 ?
        #serviceableSpecified=$False
         #default '' or $null
        #packageTypes #v3.5 ? value: "Legacy","DotnetCliTool","Dependency"
        #contentFile Visual studio
        minClientVersion='2.7'        
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
