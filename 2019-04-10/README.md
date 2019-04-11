# Meeting Minutes
* April 10, 2019

## Topics

  * SQL queries using dbatools and building a query library with PowerShell module dbatools
    * Example 1 - https://github.com/hrcloudgit/psug_minutes/blob/master/2019-04-10/example1.md
  * ADSI queries using PowerShell with module AdsiPS
    * Example 2 - https://github.com/hrcloudgit/psug_minutes/blob/master/2019-04-10/example2.md
  * AzureAD queries using PowerShell module AzureAD and MSOnline, and HaveIBeenPwned :)
    * Example 3 - https://github.com/hrcloudgit/psug_minutes/blob/master/2019-04-10/example3.md

## Notes / Links

  * DbaTools - ```Find-Module dbatools```
  * AdsiPS - ```Find-Module adsips```
    * https://www.powershellgallery.com/packages/AdsiPS/1.0.0.3
  * HaveIBeenPwned - ```Find-Module HaveIBeenPwned```
  * Get-PwnedUsers - https://github.com/Skatterbrainz/Intune/blob/master/Get-PwnedUsers.ps1
  * Get-CmQueryData - https://github.com/Skatterbrainz/sccm/blob/master/demo/Get-CmQueryData.ps1

## Miscellaneous

  ```powershell
  # 2 ways to use a foreach loop...
  
  $users = Get-ADSIUser
  $users | Foreach-Object {
    $_.distinguishedName
  }
  
  foreach ($user in $users) {
    $user.distinguishedName
  }
  ```
