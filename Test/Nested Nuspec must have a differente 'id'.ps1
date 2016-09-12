[cmdletBinding()]
param()

nuspec '1.0' 'ModuleX' {
   properties @{
     Authors=$Env:USERNAME
     Description='test'
   }
    
    dependencies {
      nuspec '1.1' 'ModuleX' {
        properties @{
          Authors=$Env:USERNAME
          Description='test'
       }
     }
   } 
}