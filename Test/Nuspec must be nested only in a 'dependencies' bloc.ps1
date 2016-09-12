[cmdletBinding()]
param()

nuspec '1.0' 'ModuleX' {
    properties @{
        Authors=$Env:USERNAME
        Description='test'
     }

    nuspec '2.0' 'Test' {
        properties @{
            Authors=$Env:USERNAME
            Description='test'
        }
    }
} 
