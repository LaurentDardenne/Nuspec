Nuspec 'Module one' '1.0' {
    properties @{
       Description='test'
       Authors=$Env:USERNAME
    }
    
    Files {
      file -src 'c:\temp\test'
      Nuspec 'Module one' '1.0' {
         properties @{
            Description='test'
            Authors=$Env:USERNAME
        }
      } 
   }
} 