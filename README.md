# Nuspec
Powershell DSL to create a nuspec file.
Only the following features are implemented : Files, Dependencies

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
      file -src 'C:\temp\Remove-Conditionnal.ps1'
      file -src 'C:\temp\Replace-String.ps1'
   }
}|Save-Nuspec -FileName c:\temp\Test.nuspec -Nobom
```
It is possible to create nested nuspec :
```Powershell
$Nuspecs=Nuspec 'Module one' '1.0' {
    properties @{
       Description='test'
       Authors=$Env:USERNAME
    }

    dependencies {
       dependency 'Machin' '1.0'
       dependency 'Truc' '2.0'

       Nuspec 'Module two' '0.8' {
           properties @{
             Authors=$Env:USERNAME
             Description='test'
           }

          dependencies {
             dependency 'Bidule' '1.2'
             dependency 'Pester' '3.9'
          }
      }
    }
}
```
$Nuspecs contains two objects :
```Powershell
$nuspecs[0].metadata
```
```
id                                : Module two
version                           : 0.8
...
dependencies                      : {Bidule, Pester}
```
The dependencies list of the first nupsec object contains the nested nuspec as a dependency : 
```Powershell
$nuspecs[1].metadata
```
```
id                                : Module one
version                           : 1.0
...
dependencies                      : {Machin, Truc, Module two}
```
The 'Nuspec' bloc create an instance of _[NugetSchema.package]_, then the Save-Nuspec function create a XML file from the C# instance.
See the [XMLObject module](https://github.com/LaurentDardenne/XMLObject).

