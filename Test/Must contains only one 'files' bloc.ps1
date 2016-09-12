[cmdletBinding()]
param()
nuspec '1.0' 'Projet one' {
   properties @{
      Description='test'
   }
    
   Files -All {
      dependency '1.0' 'machin'
   }

  Files {
  }
}