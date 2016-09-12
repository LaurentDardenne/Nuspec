[cmdletBinding()]
param()
nuspec 'Projet one' '1.0' {
   properties @{
      Description='test'
   }
    
   Files -All {
      dependency 'machin' '1.0' 
   }

  Files {
  }
}