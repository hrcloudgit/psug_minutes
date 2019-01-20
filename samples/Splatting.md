# Example: Splatting with PowerShell

## What is it?

Splatting is simply constructing a list of parameters to provide to a function using a hash table.  There are a few advantages:

* Easier to read the code (usually)
* Allows for "forming" the parameter set incrementally, such as by way of conditional statements or iterations (foreach, etc.)

## Example 1

### Standard request

```powershell
$events = Get-EventLog -LogName System -Newest 100 -EntryType Error -ComputerName "server123"
```

### Splatted request

Parameters are moved into a "splatted" hash table...

```powershell
$params = @{
  LogName      = "System"
  Newest       = 100
  EntryType    = "Error"
  ComputerName = "server123"
}

$events = Get-EventLog @params

```

### Forming the splatted parameter set

Configure the parameter set from conditional statements.  For this example, the request parameters will be 
formed by whether or not each server name is in a list of Application Servers (e.g. "$appserverlist").

```powershell

$params = @{
  LogName = "System"
  Newest  = 100
  EntryType = "Error"
}

$servers = Get-MyServerList

$servers | Foreach-Object {
  if ($_ -in $appserverlist) {
    $params.Add("ComputerName", $_)
    $params.Add("Source", "WinRM")
  }
  else {
    $params.Add("Source", "DCOM")
  }
  $events = Get-EventLog @params
}
```
