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

    it "Dependencies allow only 'dependency' blocs or nuspec blocs." {
      $Error.Clear()
      { .\"Dependencies allow only 'dependency' blocs or nuspec blocs.ps1" } | Should Throw
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

    it "Dependencies inside 'Files' blocs." {
      $Error.Clear()
      { .\"Dependencies inside Files.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Files bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "The command 'dependencies' is not supported inside a 'files' bloc."
    }

    it "Files inside Dependencies blocs." {
      $Error.Clear()
      { .\"Files inside Dependencies.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Dependencies bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "The command 'Files' is not supported inside a 'dependencies' bloc."
    }

    it "Nuspec inside 'Files' bloc" {
      $Error.Clear()
      { .\"Nuspec inside Files.ps1" } | Should Throw
      $Error.Count | Should be 2
      $Error[0].Exception.Message | Should be "The Files bloc contains one or more errors."
      $Error[1].Exception.Message | Should be "The command 'Nuspec' is not supported inside a 'files' bloc."
    }
 }
  Context "When there no error" {
    it "Create a simple nuspec.ps1" {
     $result=.\"Valid declaration.ps1"
     $result.count |Should be 1
     $result[0].metadata.version |Should be '1.0' 
     $result[0].metadata.id |Should be 'ModuleX'

     $result[0].Files |should be $null
     $result[0].metadata.dependencies |should be $null
    }

    it "Create nuspec with files.ps1" {
     $result=.\"Valid declaration with files.ps1"
     $result.count |Should be 1
     $result[0].metadata.version |Should be '1.0' 
     $result[0].metadata.id |Should be 'ModuleX'

     $result[0].Files.Count |should be 6
     $result[0].Files[0].src|should be 'C:\temp\Lock-File.ps1'
     $result[0].Files[-1].src|should be 'C:\temp\Using-Culture.ps1'
    }

    it "Create nuspec with dependencies" {
     $result=.\"nuspec with dependencies.ps1"
     $result.count |Should be 1
     $result[0].metadata.version |should be '1.0' 
     $result[0].metadata.id |should be 'Projet one'
     $result[0].metadata.dependencies.Items.Count |should be 2
     $result[0].metadata.dependencies.Items[0].id |should be 'machin'
     $result[0].metadata.dependencies.Items[0].version |should be '1.0'
     $result[0].metadata.dependencies.Items[1].id |should be 'Class two'
     $result[0].metadata.dependencies.Items[1].version |should be '1.1'         
    }

    it "Create nuspec as dependency.ps1" {
     $result=.\"Nested nuspec as dependency.ps1"
     $result.count |Should be 2
     $result[0].metadata.version |should be '0.8' 
     $result[0].metadata.id |should be 'Module two'
     $result[1].metadata.version |should be '1.0' 
     $result[1].metadata.id |should be 'Module one'
 

     $result[0].metadata.dependencies.Items.Count |should be 2
     $result[0].metadata.dependencies.Items[0].id |should be 'Bidule'
     $result[0].metadata.dependencies.Items[0].version |should be '1.2'
     $result[0].metadata.dependencies.Items[1].id |should be 'Pester'
     $result[0].metadata.dependencies.Items[1].version |should be '3.9'        
     
     $result[1].metadata.dependencies.Items[0].id |should be 'machin'
     $result[1].metadata.dependencies.Items[0].version |should be  '1.0'
     $result[1].metadata.dependencies.Items[1].id |should be 'Truc'
     $result[1].metadata.dependencies.Items[1].version |should be '2.0'      
    }

    it "Create two nuspec as dependency.ps1" {
     $result=.\"Two Nested nuspec as dependency.ps1"
     $result.count |Should be 3
     $result[0].metadata.version |should be '0.8' 
     $result[0].metadata.id |should be 'Module two'
     $result[1].metadata.version |should be '2.5' 
     $result[1].metadata.id |should be 'Module three'
     $result[2].metadata.version |should be '1.0' 
     $result[2].metadata.id |should be 'Module one'
 

     $result[0].metadata.dependencies.Items.Count |should be 2
     $result[0].metadata.dependencies.Items[0].id |should be 'Bidule'
     $result[0].metadata.dependencies.Items[0].version |should be '1.2'
     $result[0].metadata.dependencies.Items[1].id |should be 'Pester'
     $result[0].metadata.dependencies.Items[1].version |should be '3.9'

     $result[1].metadata.dependencies.Items.Count |should be 0
     
     $result[2].metadata.dependencies.Items.Count |should be 4
     $result[2].metadata.dependencies.Items[0].id |should be 'machin'
     $result[2].metadata.dependencies.Items[0].version |should be  '1.0'
     $result[2].metadata.dependencies.Items[1].id |should be 'Truc'
     $result[2].metadata.dependencies.Items[1].version |should be '2.0'
     $result[2].metadata.dependencies.Items[2].id |should be 'Module two'
     $result[2].metadata.dependencies.Items[2].version |should be '0.8'         
     $result[2].metadata.dependencies.Items[3].id |should be 'Module three'
     $result[2].metadata.dependencies.Items[3].version |should be '2.5'
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

# }
