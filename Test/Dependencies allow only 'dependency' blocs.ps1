[cmdletBinding()]
param()

nuspec '1.0' 'ModuleX' {
 
  dependencies { 
    properties @{
      Authors=$Env:USERNAME
      Description='test'
    }
    dependency -Id
  }
}