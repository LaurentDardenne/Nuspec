[cmdletBinding()]
param()

nuspec '1.0' 'Projet one' {
  properties @{
    Description='test'
  }
    
  dependencies {
    dependency '1.0' 'machin'
  }

  dependencies {
    dependency '1.0' 'machin'
  }
}
