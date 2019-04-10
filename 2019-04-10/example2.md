# Example 2 - AD Queries

  * Run: 
    ```powershell
    Install-Module AdsiPS
    ```
  * Run: 
    ```powershell
    Get-Command -Module AdsiPS
    ```
  * Run: 
    ```powershell
    $users = Get-ADSIUser
    ```
  * Run: 
    ```powershell
    $users | 
      foreach-object {
        if (![string]::IsNullOrEmpty($_.LastPasswordSet)) {
          $age = New-TimeSpan -Start $_.LastPasswordSet -End (Get-Date)
          New-Object PSObject -Property @{UserName = $_.SamAccountName; PasswordAge = $age}
        }
      }
    ```
  * Iterate user accounts to check [mail] attribute values against HaveIBeenPwned database (fun!)
  * ```PLACEHOLDER FOR CODE EXAMPLES```
  
## Notes:
  * Discuss [ordered] vs. not-ordered hash tables
  * Review Module: 
    * PSGallery page
    * GitHub repo
    * https://github.com/lazywinadmin/AdsiPS/blob/master/AdsiPS/Public/Get-ADSIUser.ps1
