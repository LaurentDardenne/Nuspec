Nuspec 'Module one' '1.0' {
    properties @{
       Description='test'
       Authors=$Env:USERNAME
    }
    
    dependencies {
       dependency 'Machin' '1.0'
       Files {
          file -src 'c:\temp\test'
       }
       dependency 'Truc' '2.0' 
    }
} 