[cmdletBinding()]
param()

nuspec '1.0' 'Projet one' {
  properties @{
    Description='test'
   }
    
  dependency '1.0' 'machin'
}
