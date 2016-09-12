Nuspec 'Projet one' '1.0' {
    properties @{
     Description='test'
     Authors=$Env:USERNAME
    }
    
    dependencies {
        dependency 'machin' '1.0' 
        dependency 'Class two' '1.1' 
    }
} 