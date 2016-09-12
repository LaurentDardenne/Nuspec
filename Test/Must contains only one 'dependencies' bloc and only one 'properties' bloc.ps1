[cmdletBinding()]
param()

nuspec '1.0' 'Projet one' {
    properties @{
       Authors=$Env:USERNAME
       Description='test'
    }
        
    properties @{
       Authors=$Env:USERNAME
       Description='test'
    }      
        
    dependencies {
      dependency '1.0' 'machin'
    }

    dependencies {
      dependency '1.0' 'machin'
    }
}
