Nuspec 'Module one' '1.0' {
    properties @{
       Description='test'
       Authors=$Env:USERNAME
    }
    
    Files {
      file -src 'c:\temp\test'
      dependencies {
        dependency 'Machin' '1.0'
        dependency 'Truc' '2.0' 
      }
    }
} 