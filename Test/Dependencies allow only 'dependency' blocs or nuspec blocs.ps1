[cmdletBinding()]
param()

nuspec 'ModuleX' '1.0' {
 
  dependencies { 
    properties @{
      Authors=$Env:USERNAME
      Description='test'
    }
    dependency -Id
  }
}