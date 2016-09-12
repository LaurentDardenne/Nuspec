[cmdletBinding()]
param()

nuspec '1.0' 'ModuleX' {
   properties @{
     Authors=$Env:USERNAME
     Description='test'
   }

   nuspec '1.0' 'ModuleX' {
     properties @{
       Authors=$Env:USERNAME
       Description='test'
     }
   }
} 