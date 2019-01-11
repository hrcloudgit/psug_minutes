# Add-Stuff (example function)

## Before - No input constraints or validation

```powershell
function Add-Stuff {
    param ($Number1, $Number2)
    $Number1 + $Number2
}
```

## After Adding Constraints and Validation

```powershell
function Add-Stuff {
    param (
        [parameter(Mandatory=$True)]
        [int] $Number1,
        [parameter(Mandatory=$True)]
        [ValidateSet(1,5,10)]
        [int] $Number2
    )
    $Number1 + $Number2
}
```
