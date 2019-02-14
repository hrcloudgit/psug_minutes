# Using PlatyPS to Generate Documentation

PlatyPS is a PowerShell module that provides functions to automate the creation of markdown files.

## Example: Get-MyTestModule.ps1

This function is part of a sample module called HRPSUG1.

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
