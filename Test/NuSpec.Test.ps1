$global:here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "Valide the rules of a Nuspec bloc" {

 Context "When there is errors" {
    it "Must contains a 'properties' bloc" {
      $Error.Clear()
      { .\"Must contains a 'properties' bloc.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "Nuspec must contain at least a 'properties' bloc."
    }

    it "Must contains only one 'properties' bloc" {
      $Error.Clear()
      { .\"Must contains only one 'properties' bloc.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "Nuspec must have one and only one 'properties' bloc."
    }

    it "Must solely declared known properties" {
      $Error.Clear()
      { .\"Must solely declared known properties.ps1" } | Should Throw
      $Error.Count | Should be 1
      $Error[0].Exception.Message | Should be "The names of the following properties are either unknown or misspelled : unknown"
    }    
    
    it "Must declared all mandatory properties" {
      $Error.Clear()
      { .\"Must declared all mandatory properties.ps1" } | Should Throw
      $Error.Count | Should be 1
      $Error[0].Exception.Message | Should be "The following properties are mandatory : description"
    }          


    it "Must contains only one 'dependencies' bloc" {
      $Error.Clear()
      { .\"Must contains only one 'dependencies' bloc.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "Nuspec must have one and only one 'dependencies' bloc."
    }

    it "Must contains only one 'dependencies' bloc and only one 'properties' bloc" {
      $Error.Clear()
      { .\"Must contains only one 'dependencies' bloc and only one 'properties' bloc.ps1" } | Should Throw
      $Error.Count | Should be 3
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "Nuspec must have one and only one 'dependencies' bloc."
      $Error[2].Exception.Message | Should be "Nuspec must have one and only one 'properties' bloc."
    }    

    it "A dependency declaration need a 'dependencies' bloc" {
      $Error.Clear()
      { .\"A dependency declaration need a 'dependencies' bloc.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "dependency must be declared inside a 'dependencies' bloc."
    }    

    it "A dependency must declared inside a 'dependencies' bloc" {
      $Error.Clear()
      { .\"A dependency must declared inside a 'dependencies' bloc.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "dependency must be declared inside a 'dependencies' bloc."
    }  

    it "Nuspec must be nested only in a 'dependencies' bloc" {
      $Error.Clear()
      { .\"Nuspec must be nested only in a 'dependencies' bloc.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "Nested Nuspec must be declared inside a 'dependencies' bloc."
    }  
    
    it "Must contains only one 'files' bloc" {
      $Error.Clear()
      { .\"Must contains only one 'files' bloc.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "Nuspec must have only one 'files' bloc."
    }  
#todo files vide sans -All ?

    it "Nested Nuspec must be declared inside a 'dependencies' bloc" {
      $Error.Clear()
      { .\"Nested Nuspec must be declared inside a 'dependencies' bloc.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Nuspec bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "Nested Nuspec must be declared inside a 'dependencies' bloc."
    }  

    it "Nested Nuspec must have a differente 'id'" {
      $Error.Clear()
      { .\"Nested Nuspec must have a differente 'id'.ps1" } | Should Throw
      $Error.Count | Should be 1
      $Error[0].Exception.Message | Should be "The package name 'ModuleX' is already declared."
    } 

    it "Dependencies allow only 'dependency' blocs." {
      $Error.Clear()
      { .\"Dependencies allow only 'dependency' blocs.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Dependencies bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "The command 'properties' is not supported inside a 'dependencies' bloc."
    }
    
    it "Files allow only 'file' blocs." {
      $Error.Clear()
      { .\"Files allow only 'file' blocs.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Files bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "The command 'Dependencies' is not supported inside a 'files' bloc."
    }
 }
  Context "When there no error" {
    it "Create nuspec with dependencies.ps1" {
     $result=.\"nuspec with dependencies.ps1"
     $result.count |Should be 1
     $result[0].version='1.0' 
     $result[0].id='Projet one'
     $result[0].dependencies.Count |should be 2
     $result[0].dependencies[0].id='1.0'
     $result[0].dependencies[0].version='machin'
     $result[0].dependencies[1].id='1.1'
     $result[0].dependencies[1].version='Class two'        
    }
    
    it "Create nuspec as dependency.ps1" {
     $result=.\"Nested nuspec as dependency.ps1"
     $result.count |Should be 2
     $result[0].version='1.0' 
     $result[0].id='Projet one'
     $result[1].version='1.1' 
     $result[1].id='Class two'

     $result[0].dependencies.Count |should be 2
     $result[0].dependencies[0].id='1.0'
     $result[0].dependencies[0].version='machin'
     $result[0].dependencies[1].id='1.1'
     $result[0].dependencies[1].version='Class two'        
    }
  }
}

# it "" {
#  $code=@'
#     Nuspec '1.0' 'ModuleX' {
#      properties @{
#         Authors=$Env:USERNAME
#         Description='test'
#       }
#     } 
# '@ 
# }

# it "" {
#  $code=@'
#     Nuspec '1.0' 'Projet one' {
#      properties @{
#         Description='test'
#       }
#       Files {
#         file -src 'c:\temp' -exclude='c:\temp\*.txt'
#         INCLUDEFile 'ModuleX''1.0'
#       }
#     }
# '@ 
# }
