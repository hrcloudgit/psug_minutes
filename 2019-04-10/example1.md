# Example 1 - SQL Queries

  * Connect to SQL Host, open SSMS
  * Create a query, save to file (e.g. "cm-clients.sql" under \Documents)
  * Open PowerShell console
  * Run: 
    ```powershell 
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    ```
  * Run: 
    ```powershell 
    Install-Module dbatools
    ```
  * Run: 
    ```powershell 
    $rows = Invoke-DbaQuery -SqlInstance 'cm01' -Database 'CM_P01' -Query 'select * from v_R_System'
    $rows  #dump results
    ```
  * Run: 
    ```powershell 
    $rows = Invoke-DbaQuery -SqlInstance 'cm01' -Database 'CM_P01' -File .\documents\cm-clients.sql
    $rows  #dump results
    ```
  * Run: 
    ```powershell 
    $rows | where {$_.DiskUsed -gt 0.70}
    ```
  * Example: 
  ```powershell
  $rows | 
    where {$_.DiskUsed -gt 0.70} | 
      foreach-object { Create-SupportRequest -Type 'HW' -Resource $_.Name -Summary 'Low disk space`}
  ```
