[cmdletBinding()]
param()

nuspec 'Projet one' '1.0' {
    properties @{
       Authors=$Env:USERNAME
       Description='test'
    }
        
    properties @{
       Authors=$Env:USERNAME
       Description='test'
    }      
        
    dependencies {
      dependency 'machin' '1.0'
    }

    dependencies {
      dependency 'machin' '1.0'
    }
}
