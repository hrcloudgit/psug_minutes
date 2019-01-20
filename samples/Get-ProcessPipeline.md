## Get-ProcessPipeline

### Structure

The following is pseudo-code where ">>" denotes a "pipe into" or "|"

#### GET-OBJECT >> FILTER >> SORT >> SELECT (>> ... >> ...)

Step by step...

  * Get all processes (then...)
  * Filter out all processes except for those with "ProcessName" that begins with "A" (then...)
  * Sort the list by ProcessName in descending order (Z to A) (then...)
  * Fetch the top 5 rows from the list 
  
### Converted into PowerShell syntax

```powershell
Get-Process | 
    Where-Object {$_.ProcessName -like "A*"} | 
        Sort-Object ProcessName -Descending | 
            Select -First 5
```
