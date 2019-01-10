# 1.1 - making things clearer

### self-describing elements: filenames

Get-CADFileSizes.ps1


### self-describing elements: functions

function Get-IniFiles {}


### self-describing elements: variable names

$LocalUserNames = @()


### self-describing elements: variable values

$EmployeeTypes = @('FullTime','PartTime','Temp','Contractor')


### documentation: files and functions

<#
.SYNOPSIS
Get AutoCAD Data File sizes

.DESCRIPTION
Return AutoCAD data file names, and sizes from a specified path

.PARAMETER FolderPath
Folder path to search
#>



### documentation: code blocks

# assign groupcode by checking category name

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