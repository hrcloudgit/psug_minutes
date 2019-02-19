# Project 1: Code Outline

This is pseudo-code, provided as a general roadmap or outline of the steps required to complete this exercise.

## Workflow Outline

Copy the following block of code comments to the Clipboard.  You will paste it into the script file to use as a roadmap for filling in the code to make this all work.

```powershell
[CmdletBinding(SupportsShouldProcess=$True)]
param (
    [string] $ou = "OU=Graveyard,DC=contoso,DC=local",
    [string] $logfile = "adcleanup.log",
    [int] $maxage = 90
)

<# functions #>
# --- insert functions here ---

<# workflow #>

```

## Building the Script File

For this exercise, functions will be used to group code into reusable units, with a central "control script" that will invoke the functions, to complete the tasks in the order above.  All of the following functions can be entered and saved into a single file.

1. Open PowerShell ISE or Visual Studio Code

2. Create a new File and save it as "Invoke-ADCleanup.ps1"

3. Copy the Workflow Outline above into the script file.  Edit the $ou path to suit your test environment.  Save the file.

4. Copy and paste the function **Get-AdsAccounts** into the script file just below the <# functions #> line (replace the "# --- insert functions here ---" line).
   
   This function will fetch all user or computer accounts from AD.  Then we can filter them based on whatever criteria is needed.

5. Copy and paste the function **Move-AdsAccountOU** just below the previous function in your script file.

   This function will move an AD account to a specified OU.

6. Copy and paste the function **Disable-AdsAccount** just below the previous function.

   This function will disable a specified AD account.

7. Copy and paste the function **Update-AdsAccountDescription** just below the previous function.

   Thsi function will modify the description attribute of an AD account object.

8. Copy and paste the function **Write-LogFile** just below the previous function.

   This function will write information to a specified log file.

### Script File Contents

At this point, your script file should contain the following code (summarized):

```
[CmdletBinding(SupportsShouldProcess=$True)]
param (
    [string] $ou = "OU=Graveyard,DC=contoso,DC=local",
    [string] $logfile = "adcleanup.log",
    [int] $maxage = 90
)

<# functions #>
function Get-AdsAccounts {...}
function Move-AdsAccountOU {...}
function Disable-AdsAccount {...}
function Update-AdsAccountDescription {...}
function Write-LogFile {...}

<# workflow #>
```

9. Just below the ```<# workflow #>``` section of the script, make the following change:

```powershell
<# workflow #>
$comps = Get-AdsAccounts -AccountType computer | Where {$_.LogonAge -gt $maxage}
```
This will retrieve all computer accounts in AD which haven't authenticated within the last 30 days.  Save the script, and run it (press F5).  Check the contents of **$comps**.  Adjust $maxage if needed, and re-run until you get satisfactory results.

10. Just below the $comps = line, make the following change to insert a 

```powershell
<# workflow #>
$comps = Get-AdsAccounts -AccountType computer | Where {$_.LogonAge -gt 30}
foreach ($comp in $comps) {
  # leave a blank line here
}
```

11. Inside the foreach() section, replace ```# leave a blank line``` with the following...

```powershell
foreach ($comp in $comps) {
  Disable-AdsAccount -AccountDN $comp.DN
}
```

12. Just below the Disable-AdsAccount line, insert the following...

```powershell
foreach ($comp in $comps) {
  Disable-AdsAccount -AccountDN $comp.DN
  Update-AdsAccountDescription -AccountDN $comp.DN
}
```

13. Just below the Update-AdsAccountDescription line, insert the following...

```powershell
foreach ($comp in $comps) {
  Disable-AdsAccount -AccountDN $comp.DN
  Update-AdsAccountDescription -AccountDN $comp.DN -Description "disabled $(Get-Date) by $($env:USERNAME)"
  Move-AdsAccountOU -AccountDN $comp.DN -TargetOU $ou
}
```

14. Just below the Move-AdsAccountOU line, insert the following change...

```powershell
foreach ($comp in $comps) {
  Disable-AdsAccount -AccountDN $comp.DN
  Update-AdsAccountDescription -AccountDN $comp.DN -Description "disabled $(Get-Date) by $($env:USERNAME)"
  Move-AdsAccountOU -AccountDN $comp.DN -TargetOU $ou
  Write-LogFile
}
```

15. 
