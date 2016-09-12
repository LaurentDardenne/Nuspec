[cmdletBinding()]
param()

nuspec '1.0' 'ModuleX' {
    properties @{
     Authors=$Env:USERNAME
     unknown=10
    }
}
