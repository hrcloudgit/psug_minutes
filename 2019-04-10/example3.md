# Example 3 - O365 / AzureAD Queries

  * Run: 
    ```powershell 
    Install-Module MSOnline, AzureAD, HaveIBeenPwned
    ```
  * Run:
    ```powershell
    Connect-MSOLService
    $users = Get-MSOLUser
    ```
  * Display one row for example purposes, and use ```| select *```
  * Iterate user accounts to check UserPrincipalName against HaveIBeenPwned database (fun!)
  * ```PLACEHOLDER FOR CODE EXAMPLES```
