[cmdletBinding()]
param()

nuspec '1.0' 'Projet one' {
    properties @{
        Authors=$Env:USERNAME
        Description='test'
     }
        
    dependency '1.0' 'machin'
  
    dependencies {
       dependency '1.0' 'machin'
    }      
}
