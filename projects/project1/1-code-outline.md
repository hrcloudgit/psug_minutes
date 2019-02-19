# Project 1: Code Outline

This is pseudo-code, provided as a general roadmap or outline of the steps required to complete this exercise.

```
1. Get all accounts where LastLogon > 90 days
2. Foreach account:
   * Move account to the "graveyard" OU
   * Disable the account
   * Modify the account description
   * Update the log file
```

## Functions and Script Files

For this exercise, functions will be used to group code into reusable units, with a central "control script" that will invoke the functions, to complete the tasks in the order above.  All of the following functions can be entered and saved into a single file.

1. Open PowerShell ISE or Visual Studio Code
2. Create a new File and save it as **Invoke-ADCleanup.ps1**
3. Enter the following code into the file and save it.  

```powershell
function Get-AdsAccounts {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$True)]
        [ValidateSet('computer','user')]
        [string] $AccountType
    )
    try {
        $as = [adsisearcher]"(objectCategory=$AccountType)"
        $props = @("name","distinguishedName","lastLogonTimeStamp")
        $props | %{ $as.PropertiesToLoad.Add($_) | Out-Null }
        $as.PageSize = 2000
        $accounts = $as.FindAll()
        foreach ($account in $accounts) {
            $name = ($account.Properties.item('name') | Out-String).Trim()
            $dn   = ($account.Properties.item('distinguishedName') | Out-String).Trim()
            $lts  = ($account.Properties.item('lastLogonTimeStamp') | Out-String).Trim()
            $lts  = ([datetime]::FromFileTime($lts))
            $params = [ordered]@{
                Name      = $name
                Type      = $AccountType
                LastLogon = $lts
                DN        = $dn
            }
            New-Object PSObject -Property $params
        }
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}
```
4. Test the code:

Press F5 to run the script.  Nothing happens.  This is because the function is simply loaded into memory, rather than executed.  You will need to explicitly invoke the function to make it do something...

```powershell
Get-AdsAccounts -AccountType computers
```
