## Get-ProcessPipeline

### Before (basic code)

```powershell
$procs = Get-Process
$procs = $procs | Where-Object {$_.ProcessName -like "A*"}
$procs = $procs | Sort-Object ProcessName -Descending
```

### After (converted into a pipeline)

```powershell
Get-Process | 
    Where-Object {$_.ProcessName -like "A*"} | 
        Sort-Object ProcessName -Descending | 
            Select -First 3
```
