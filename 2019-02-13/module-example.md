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

