[cmdletBinding()]
param()

nuspec 'ModuleX' '1.1'  {
    properties @{
        Authors=$Env:USERNAME
        Description='test'
     }

    nuspec 'Test' '2.0'  {
        properties @{
            Authors=$Env:USERNAME
            Description='test'
        }
    }
} 
