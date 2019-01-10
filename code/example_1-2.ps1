# 1.2 - unexpected inputs

### human error / manual entry: enforce strong data types & naming conventions

### example: Update a database record to link a user to their roaming profile folder share

function Set-UserProfileLink {
    param (
        $Type,
        $UN,
        $Path
    )
    Write-Host "Type: $Type"
    Write-Host "User Name: $UN"
    Write-Host "Profile: $Path"
}

<# concerns:

1. Confusing parameter names
2. No data types
3. No constraints
4. No explanation
5. No assistance

#>

<#
# a little better

function Set-UserProfileLink {
    param (
        [parameter(Mandatory=$True)]
            [string] $EmployeeType,
        [parameter(Mandatory=$False)]
            [string] $UserName = "",
        [parameter(Mandatory=$False)]
            [string] $ProfilePath = ""
    )
    Write-Host "Type: $EmployeeType"
    Write-Host "User Name: $UserName"
    Write-Host "Profile: $ProfilePath"
}
#>

<#
# even mo-better

function Set-UserProfileLink {
    param (
        [parameter(Mandatory=$True)]
            [ValidateSet('Manager','Staff')]
            [string] $EmployeeType,
        [parameter(Mandatory=$True)]
            [ValidateLength(1,15)]
            [ValidateNotNullOrEmpty()]
            [string] $UserName,
        [parameter(Mandatory=$False)]
            [ValidateNotNullOrEmpty()]
            [string] $ProfilePath = "\\server123\users`$\$UserName"
    )
    Write-Host "Type: $EmployeeType"
    Write-Host "User Name: $UserName"
    Write-Host "Profile: $ProfilePath"
}
#>

<#
# even mo-better better

function Set-UserProfileLink {
    <#
    .DESCRIPTION
    This does cool stuff
    .PARAMETER EMployeeType
    Type of employee is Manager or Staff
    #>
    param (
        [parameter(Mandatory=$True, HelpMessage="Employee Type")]
            [ValidateSet('Manager','Staff')]
            [string] $EmployeeType,
        [parameter(Mandatory=$True, HelpMessage="AD UserName")]
            [ValidateLength(1,15)]
            [ValidateNotNullOrEmpty()]
            [string] $UserName,
        [parameter(Mandatory=$False, HelpMessage="User Profile Path")]
            [ValidateNotNullOrEmpty()]
            [string] $ProfilePath = "\\server123\users`$\$UserName"
    )
    Write-Host "Type: $EmployeeType"
    Write-Host "User Name: $UserName"
    Write-Host "Profile: $ProfilePath"
}
#>

<#
# leverage integration options

param (
    [parameter(Mandatory=$False)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(12,15)]
        [string] $ServerName = $env:COMPUTERNAME
)

$DCName = $($env:LOGONSERVER).TrimStart('\\')
#>