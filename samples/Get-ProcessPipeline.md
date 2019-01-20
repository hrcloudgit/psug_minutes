## Get-ProcessPipeline

### Structure

The following is pseudo-code where ">>" denotes a "pipe into" or "|"

#### GET-OBJECT >> FILTER >> SORT >> SELECT (>> ... >> ...)

### After (converted into a pipeline)

```powershell
Get-Process | 
    Where-Object {$_.ProcessName -like "A*"} | 
        Sort-Object ProcessName -Descending | 
            Select -First 5
```
