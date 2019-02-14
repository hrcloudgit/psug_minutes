# Using PlatyPS to Generate Documentation

PlatyPS is a PowerShell module that provides functions to automate the creation of markdown files from comments embedded in module script files.  For this example, we are going to generate markdown files for the embedded help content within the Write-Stuff function in the HRPSUG1 module.  The function is shown below for reference purposes.

## Example: Write-Stuff.ps1

This function is part of a sample module called HRPSUG1. 

```powershell
<#
.SYNOPSIS
	This displays stuff
.PARAMETER Arg1
	Sample string data input, must be 3 characters in length
.EXAMPLE
	Write-Stuff -Arg1 "ABC" (returns "foo: ABC")
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
## Import the Module you wish to Document

```powershell
Import-Module HRPSUG1

Get-Command -Module HRPSUG1

CommandType		Name												Version		Source
-----------		----												-------		------
Function		Write-Stuff											1.0			HRPSUG1
```

## Install the PlatyPS Module

```powershell
Install-Module PlatyPS
```

Review commands provided from the module...

```powershell
Get-Command -Module PlatyPS

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Get-HelpPreview                                    0.11.0     platyps
Function        Get-MarkdownMetadata                               0.11.0     platyps
Function        Merge-MarkdownHelp                                 0.11.0     platyps
Function        New-ExternalHelp                                   0.11.0     platyps
Function        New-ExternalHelpCab                                0.11.0     platyps
Function        New-MarkdownAboutHelp                              0.11.0     platyps
Function        New-MarkdownHelp                                   0.11.0     platyps
Function        New-YamlHelp                                       0.11.0     platyps
Function        Update-MarkdownHelp                                0.11.0     platyps
Function        Update-MarkdownHelpModule                          0.11.0     platyps
```

We will use the **New-MarkdownHelp** function for this example.

```powershell
New-MarkdownHelp -Module HRPSUG1 -OutputFolder "c:\scripts\HRPSUG1"

    Directory: C:\SCRIPTS\HRPSUG1

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/14/2019  10:38 AM           1038 Write-Stuff.md
```

Open the Write-Stuff.md markdown file in a text editor and review the source content.  You should see that the ##DESCRIPTION section has "{{Fill in the Description}}", indicating it didn't find that field within the comments.

Open the Write-Stuff.ps1 file again and modify the comment section to show the following...

```powershell
<#
.SYNOPSIS
	This displays stuff
.DESCRIPTION
	Returns a concatenated string value
.PARAMETER Arg1
	Sample string data input, must be 3 characters in length
.EXAMPLE
	Write-Stuff -Arg1 "ABC" (returns "writing: ABC")
#>
```
Save the .ps1 file and re-import the module...

```powershell
Import-Module c:\scripts\HRPSUG1\HRPSUG1.psd1 -Force
```
Re-Run the **New-MarkdownHelp** function to rebuild the markdown file...
```powershell
New-MarkdownHelp -Module HRPSUG1 -OutputFolder "c:\scripts\HRPSUG1" -Force
```

Open the same Write-Stuff.md markdown file and review the DESCRIPTION section changes.
