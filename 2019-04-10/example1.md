# Example 1 - SQL Queries

  * Connect to SQL Host, open SSMS
  * Create a query, save to file (e.g. "cm-clients.sql" under \Documents)
  * Open PowerShell console
  * Insure PSGallery is a trusted repository source. Run: 
    ```powershell 
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    ```
  * Install module (dbatools) if needed. Run: 
    ```powershell 
    Install-Module dbatools
    ```
  * Demonstrate a basic direct query. Run: 
    ```powershell 
    $rows = Invoke-DbaQuery -SqlInstance 'cm01' -Database 'CM_P01' -Query 'select * from v_R_System'
    $rows  #dump results
    ```
  * Demonstrate a basic file-based query. Run: 
    ```powershell 
    $rows = Invoke-DbaQuery -SqlInstance 'cm01' -Database 'CM_P01' -File .\documents\cm-clients.sql
    $rows  #dump results
    ```
  * Find results where computers with C: disk more than 70% full. Run: 
    ```powershell 
    $rows | where {$_.DiskUsed -gt 0.70}
    ```
  * Example of potential use in a production environment: 
  ```powershell
  $rows | 
    where {$_.DiskUsed -gt 0.70} | 
      foreach-object { Create-SupportRequest -Type 'HW' -Resource $_.Name -Summary 'Low disk space`}
  ```
## Example 1A - Build a Library

 * Create several .sql files in a common folder
 * Import the list using Get-ChildItem, pipe to Out-GridView for user selection
