# Sample Module

## Process Outline

  1. Created a folder path (e.g. c:\scripts\TestModule)
  2. Created a file named "TestModule.psm1" in the above path
  3. Created a file named "Get-MyTestModule.ps1" in the same path
  4. Created the module manifest "TestModule.psd1" in the same path
  5. Import the module to test and validate
  6. Publish the module to the PowerShell Gallery
  
## Files

### TestModule.psm1

```powershell
try {
	Get-ChildItem -Path $PSScriptRoot -Filter "*.ps1" -Recurse -ErrorAction Stop | %{ . $_.FullName }
}
catch {
    Write-Error "Failed to import: $($Error[0].Exception.Message)"
}
```

### Get-MyTestModule.ps1

```powershell
<#
.SYNOPSIS
 This displays stuff
.PARAMETER Arg1
 Sample string data input, must be 3 characters in length
.EXAMPLE
  Get-MyTestModule -Arg1 "ABC"
  _prints "foo: ABC"_
#>

function Get-MyTestModule {
	param (
		[parameter(Mandatory=$True)]
		[ValidateLength(3,3)]
		[string] $Arg1
	)
	Write-Host "foo: $Arg1"
}
```

### Create Manifest

```powershell
New-ModuleManifest -Path "c:\scripts\TestModule\TestModule.psd1"
```

(Edit the .psd1 file to fill-in missing properties)

### Test the Module
```powershell
Import-Module "c:\scripts\TestModule\TestModule.psd1"

Get-MyTestModule -Arg1 "FOO"
```

### Publish the Module

```powershell
Publish-Module -Path "c:\scripts\TestModule\TestModule.psd1" -NuGetApiKey "<yourkey>"
```

Note: Remember that once a module has been published, any changes/updates to the module require you to update
the ModuleVersion property in the .psd1 file before re-publishing.  For example, if current published version is 1.0, 
then change to 1.0.1 or 1.1 before publishing the updated content.

Note: During testing of module changes, be sure to re-import with -Force to insure you have the latest-saved version 
running in memory.
