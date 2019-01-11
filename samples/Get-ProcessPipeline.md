## Get-ProcessPipeline

### Before (basic code)

```powershell
$procs = Get-Process | Sort -ProcessName -Descending
foreach ($p in $procs) {
    if ($p.ProcessName -like "A*")
        $p
    }
}
```

### Structure

#### Get >> FILTER >> SORT >> SELECT

### After (converted into a pipeline)

```powershell
Get-Process | 
    Where-Object {$_.ProcessName -like "A*"} | 
        Sort-Object ProcessName -Descending | 
            Select -First 3
```
