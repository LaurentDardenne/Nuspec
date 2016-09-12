[cmdletBinding()]
param()

nuspec 'ModuleX' '1.0' {
   properties @{
     Authors=$Env:USERNAME
   }
}

