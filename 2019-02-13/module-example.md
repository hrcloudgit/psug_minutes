# Sample Module

## Process Outline

  1. Created a folder path (e.g. c:\scripts\HRPSUG1)
  2. Created a file named "HRPSUG1.psm1" in the above path
  3. Created a file named "Write-Stuff.ps1" in the same path
  4. Created the module manifest "HRPSUG1.psd1" in the same path
  5. Import the module to test and validate
  6. Publish the module to the PowerShell Gallery
  
## Files

### HRPSUG1.psm1

Paste the following into the file and save it.

```powershell
try {
	Get-ChildItem -Path $PSScriptRoot -Filter "*.ps1" -Recurse -ErrorAction Stop | %{ . $_.FullName }
}
catch {
    Write-Error "Failed to import: $($Error[0].Exception.Message)"
}
```

### Write-Stuff.ps1

Paste the following into the file and save it.

```powershell
<#
.SYNOPSIS
 This displays stuff
.PARAMETER Arg1
 Sample string data input, must be 3 characters in length
.EXAMPLE
 Write-Stuff -Arg1 "ABC"
 _prints "foo: ABC"_
#>

function Write-Stuff {
	param (
		[parameter(Mandatory=$True)]
		[ValidateLength(3,3)]
		[string] $Arg1
	)
	Write-Output "writing: $Arg1"
}
```

### Create Manifest

Open a PowerShell console (or ISE or VS Code) and run the following statement.

```powershell
New-ModuleManifest -Path "c:\scripts\HRPSUG1\HRPSUG1.psd1"
```

### Edit the Module Manifest

* Open the HRPSUG1.psd1 file in a text editor (Notepad, Notepad++, PowerShell ISE, VS Code, etc.)
* Change **Version** to 1.0, **Author** to your name, **CompanyName**, **Copyright**, etc.
* Remove the # prefix for PowerShellVersion and insert 3.0 between the empty quotes (e.g. PowerShellVersion = '3.0')
* Scroll further down and modify the **Tags** list to remove the # prefix and insert ('hrpsug','sample')
* Save the PSD1 file

### Test the Module

Import the module and make sure the commands work as expected.  Use the Get-Command -Module _ModuleName_.  Invoke the functions in your module and make sure they do what you want them to.

```powershell
Import-Module "c:\scripts\HRPSUG1\HRPSUG1.psd1"

# review the module details (version, etc.)...
Get-Module HRPSUG1

# test the module function...
Write-Stuff -Arg1 "FOO"
```

## Publishing a Module

Publishing a module copies all of the source files for the module up to a _repository_, in this example the repository is PowerShell Gallery.  You can use a public repository, or a private (internal) repository, if available.  The choice depends on who you wish to share the module with (just your colleagues, or the entire world).

First, you will need an API Key, which is a GUID that identifies you from everyone else.  Then you use the API Key during the publishing operation to authenticate you to your account and upload the content.

### The API Key

* If you don't already have a PowerShell Gallery account, create a new account: https://www.powershellgallery.com
* Click on your profile name (at top right) and select "API Keys"
* Read the information and click "+ Create" to make a new API key
* Copy the key to some place private and protected (KeePass, vault, cloud file, etc.)

### The Publishing Process

```powershell
Publish-Module -Path _full-path-psd1-file_ -NuGetApiKey _apikey_

# example...

Publish-Module -Path "c:\scripts\HRPSUG1\HRPSUG1.psd1" -NuGetApiKey "12345678-abcd-defg-1234-abcd1234defg"
```

## Notes

* Remember that once a module has been published, any changes/updates to the module require you to update
the ModuleVersion property in the .psd1 file before re-publishing.  For example, if current published version is 1.0, 
then change to 1.0.1 or 1.1 before publishing the updated content.

* During testing of module changes, be sure to re-import with -Force to insure you have the latest-saved version 
running in memory.

* It's usually recommended to logically group module functions with a common prefix to avoid conflicts with other module functions, identify them more easily, and find/filter them.  For example "Write-Stuff" or "Write-HrPsStuff" for module "HRPSUG1"
