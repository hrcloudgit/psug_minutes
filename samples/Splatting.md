# Example: Splatting with PowerShell

## What is it?

## Example 1

```powershell
$events = Get-EventLog -LogName System -Newest 100 -EntryType Error -ComputerName "server123"
```

Moving the parameters into a "splatted" hash table...

```powershell
$params = @{
  LogName = "System"
  Newest  = 100
  EntryType = "Error"
  ComputerName = "server123"
}
$events = Get-EventLog @params
```
