``` $servers = ('cm02','fs01','dc01')```

# Using _foreach_

```powershell
foreach ($server in $servers) {
    Write-Host "checking $server"
    # ...
}
```

# Using _pipeline iteration_

```powershell
$servers | ForEach-Object {
    Write-Host "checking $_"
    # ...
}
```

# Using _for_

```powershell
for ($i = 0; $i -lt $servers.Count; $i++) {
    Write-Host "checking $($servers[$i])..."
    # ...
}
```

# Using _while_

```powershell
$i = 0
while ($i -lt $servers.Count) {
    Write-Host "checking $($servers[$i])..."
    #...
    $i++
}
```
