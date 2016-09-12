Nuspec 'Module one' '1.0' {
    properties @{
       Description='test'
       Authors=$Env:USERNAME
    }
    
    dependencies {
       dependency 'Machin' '1.0'
       dependency 'Truc' '2.0' 
        
       Nuspec 'Module two' '0.8' {
           properties @{
             Authors=$Env:USERNAME
             Description='test'
           }
       
          dependencies {
             dependency 'Bidule' '1.2'
             dependency 'Pester' '3.9' 
          }
       }
       
       Nuspec 'Module three' '2.5' {
           properties @{
             Authors=$Env:USERNAME
             Description='test'
           }
       }       
    }
} 