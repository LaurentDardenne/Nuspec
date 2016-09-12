[cmdletBinding()]
param()

nuspec '1.0' 'ModuleX' {
 
  Files { 
    Dependencies {
    }
    file -source 'c:\temptest.txt'
  }
}