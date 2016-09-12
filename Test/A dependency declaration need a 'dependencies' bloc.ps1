[cmdletBinding()]
param()

nuspec 'Projet one' '1.0' {
  properties @{
    Description='test'
   }
    
  dependency 'machin' '1.0'
}
