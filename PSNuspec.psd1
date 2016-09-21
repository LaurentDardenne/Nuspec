﻿#
# Module manifest for module 'Nuspec'
#
# Generated by: Laurent Dardenne
#
# Generated on: 11/09/2016
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSNuspec.psm1'

# Version number of this module.
ModuleVersion = '0.4.0'

# ID used to uniquely identify this module
GUID = '35ef93fe-14de-4edd-b80d-a88db37892ea'

# Author of this module
Author = 'Laurent Dardenne'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = 'CopyLeft'

# Description of the functionality provided by this module
Description = 'This module contains a wrapper to create a nupsec file.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '4.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = '4.0'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules=@(
 @{ModuleName="XMLObject"; ModuleVersion='1.0.0'; GUID='a7f98809-b178-45fd-bca1-69a8a51352f2'}
)

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @('lib\net40\NugetSchema.dll')

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = @(
    'nuspec',
    'properties',
    'Dependencies',
    'dependency',
    'Files',
    'file',
    'Save-Nuspec',
    'Import-ManifestData',
    'Get-ScriptVersion',
    'Push-nupkg' 
)

# Cmdlets to export from this module
#CmdletsToExport = '*'

# Variables to export from this module
#VariablesToExport = '*'

# Aliases to export from this module
#AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. 
PrivateData = @{
    
     # PSData data to pass to the Publish-Module cmdlet
    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        #Tags = @('Localization','Analyzer','Rule')

        # A URL to the license for this module.
        LicenseUri = 'https://creativecommons.org/licenses/by-nc-sa/4.0'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/LaurentDardenne/Nuspec'

        # A URL to an icon representing this module.
        IconUri = 'https://github.com/LaurentDardenne/MeasureLocalizedData/blob/master/Icon/Nuspec.png'

        # ReleaseNotes of this module
        ReleaseNotes = 'Initial version.'
    } # End of PSData hashtable
} # End of PrivateData hashtable
}


