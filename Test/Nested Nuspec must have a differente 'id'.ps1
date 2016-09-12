[cmdletBinding()]
param()

nuspec 'ModuleX' '1.0' {
   properties @{
     Authors=$Env:USERNAME
     Description='test'
   }
    
    dependencies {
      nuspec 'ModuleX' '1.1'  {
        properties @{
          Authors=$Env:USERNAME
          Description='test'
       }
     }
   } 
}