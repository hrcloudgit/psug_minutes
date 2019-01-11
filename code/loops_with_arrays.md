``` $servers = ('cm02','fs01','dc01')```

# Using _foreach_

foreach ($server in $servers) {
    Write-Host "checking $server"
    # ...
}

# using pipeline iteration...

$servers | ForEach-Object {
    Write-Host "checking $_"
    # ...
}

# using for...

for ($i = 0; $i -lt $servers.Count; $i++) {
    Write-Host "checking $($servers[$i])..."
    # ...
}

# using while...

$i = 0
while ($i -lt $servers.Count) {
    Write-Host "checking $($servers[$i])..."
    #...
    $i++
}
