[cmdletBinding()]
param()

nuspec 'ModuleX' '1.0'  {
 
  Files { 
    Dependencies {
    }
    file -source 'c:\temp\test.txt'
  }
}