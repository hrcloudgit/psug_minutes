# Project 1: Code Outline

This is pseudo-code, provided as a general roadmap or outline of the steps required to complete this exercise.

```
1. Get all accounts where LastLogon > 90 days
2. Foreach account:**
   * Move account to the "graveyard" OU
   * Disable the account
   * Modify the account description
   * Update the log file
```

## Functions and Script Files

For this exercise, functions will be used to group code into reusable units, with a central "control script" that will invoke the functions, to complete the tasks in the order above.  All of the following functions can be entered and saved into a single file.

**1. Open PowerShell ISE or Visual Studio Code**

**2. Create a new File and save it as "Invoke-ADCleanup.ps1"**

**3. Enter the following code into the file and save it.**

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
            $age  = (New-TimeSpan -Start (Get-Date $lts) -End (Get-Date)).Days
            $params = [ordered]@{
                Name      = $name
                Type      = $AccountType
                LastLogon = $lts
                LogonAge  = $age
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
Note: Each line of the code above will be explained during a live session.

**4. Test the code:**

Press F5 to run the script.  Nothing happens.  This is because the function is simply loaded into memory, rather than executed.  You will need to explicitly invoke the function to make it do something...

```powershell
Get-AdsAccounts -AccountType user
```
Review the output and notice the property names and values that are returned.  The _LogonAge_ value indicates the number of days since the _LastLogon_ value occurred.

**5. Repeat the function call, but...**

This time, append the following filter before you execute it...**

```powershell
Get-AdsAccounts -AccountType user | ?{$_.LogonAge -gt 30}
```
You may need to play around with the number (30) if you don't have any accounts that haven't authenticated for that many days.  Once you get some results, you should see how this adds to your building blocks to make this project successful.  Save one of the accounts to a variable, so we can use that for testing the following steps more easily.

```powershell
$x = Get-AdsAccounts -AccountType user | ?{$_.LogonAge -gt 30}
$test = $x[0]
```
Now ```$test``` holds a reference to the first account in the dataset.  If you type $test and press Enter, you should see the properties displayed: Name, Type, LastLogon, LogonAge, and DN.

**6. Moving an account to a different OU**

```powershell
TBD
```

**7. Disable an account**

```powershell
TBD
```

**8. Modify an account description**

```powershell
TBD
```

**9. Update a log file**

```powershell
function Write-LogFile {
    param (
        [parameter(Mandatory=$False)]
            [string] $FilePath = (Join-Path -Path $env:USERPROFILE -ChildPath "Documents"),
        [parameter(Mandatory=$False)]
            [string] $LogName = "adcleanup.log",
        [parameter(Mandatory=$True)]
            [ValidateSet('computer','user')]
            [string] $AccountType,
        [parameter(Mandatory=$True)]
            [ValidateNotNullOrEmpty()]
            [string] $AccountName,
        [parameter(Mandatory=$True)]
            [ValidateNotNullOrEmpty()]
            [string] $Message,
        [parameter(Mandatory=$False)]
            [string] $Delimiter = ","
    )
    try {
        $LogPath = Join-Path -Path $FilePath -ChildPath $LogName
        $Entry = @(
            (Get-Date).ToShortDateString(),
            (Get-Date).ToLongTimeString(),
            "RunAs=$($env:USERNAME)",
            $AccountType,
            $AccountName,
            $Message
        )
        $Entry -join $Delimiter | Out-File -FilePath $LogPath -Append
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}
```

**10. Putting it all together**

```powershell
TBD
```

## Summary

xxxx
