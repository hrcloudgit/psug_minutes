Get-Process | 
    Where-Object {$_.ProcessName -like "A*"} | 
        Sort-Object ProcessName -Descending | 
            Select -First 3
