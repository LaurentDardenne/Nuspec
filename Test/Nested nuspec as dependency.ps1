Nuspec '1.0' 'Projet one' {
    properties @{
     Description='test'
     Authors=$Env:USERNAME
    }
    
    dependencies {
        dependency '1.0' 'machin'
        
        Nuspec '1.1' 'Class two' {
            properties @{
            Authors=$Env:USERNAME
            Description='test'
            }
        }
    }
} 