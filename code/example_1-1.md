# 1.1 - Making Things Clearer

## Self-describing elements: filenames

```powershell 
Get-CADFileSizes.ps1
```

## Self-describing elements: functions

```powershell 
function Get-IniFiles {}
```

## Self-describing elements: variable names

```powershell 
$LocalUserNames = @()
```

## Self-describing elements: variable values

```$EmployeeTypes = @('FullTime','PartTime','Temp','Contractor')```

## Documentation: files and functions

```powershell 
<#
.SYNOPSIS
Get AutoCAD Data File sizes

.DESCRIPTION
Return AutoCAD data file names, and sizes from a specified path

.PARAMETER FolderPath
Folder path to search
#>
```

## Documentation: code blocks

```powershell 
# Assign groupcode by checking category name

switch ($CategoryName) {
    'Yellow' {
        # Yellow items belong to group code 123
        $groupcode = '123'
        break;
    }
    'Green' {
        # Green items belong to group code 456
        $groupcode = '456'
        break;
    }
    default {
        # if none of the above match, assign them to group code 001
        $groupcode = '001'
        break;
    }
} # switch
```
