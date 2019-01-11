# Examples: Looping Array Elements with PowerShell

## Example array

```powershell
$servers = ('cm02','fs01','dc01')
```

## Using _foreach_

```powershell
foreach ($server in $servers) {
    Write-Host "checking $server"
    # ...
}
```
Comment: May allow for more granular error checking per line, but not always. Just a different option from pipeline iteration (see below). To exit early, use ```break```

```powershell
foreach ($server in $servers) {
    Write-Host "checking $server"
    try {
        $files = Get-ChildItem -Path "\\$server\docs" -Filter "*.docx" -ErrorAction Stop
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}
```

## Using _pipeline iteration_

```powershell
$servers | ForEach-Object {
    Write-Host "checking $_"
    # ...
}
```
Comment: Often more compact and efficient processing. To exit early, use ```break```

```powershell
$servers | ForEach-Object {
    Write-Host "checking $_"
    try {
        ...
    }
    catch {
        ...
    }
}
```

## Using _for_

```powershell
for ($i = 0; $i -lt $servers.Count; $i++) {
    Write-Host "checking $($servers[$i])..."
    # ...
}
```
Comment: Good for limiting the loop count to a specific number or condition

## Using _while_

```powershell
$i = 0
while ($i -lt $servers.Count) {
    Write-Host "checking $($servers[$i])..."
    #...
    $i++
}
```
Comment: Often used for exiting on a specified condition
