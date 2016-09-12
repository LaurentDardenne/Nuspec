Nuspec '1.0' 'Projet one' {
    properties @{
     Description='test'
     Authors=$Env:USERNAME
    }
    
    dependencies {
        dependency '1.0' 'machin'
        dependency '1.1' 'Class two'
    }
} 