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
        [parameter(Mandatory=$True)]  # <-- require this parameter to be specified
        [ValidateRange(2,100)]  # <-- restrict input to numbers from 2 to 100 only
        [int] $Number1,  # <-- only allow integer values (no decimals, strings, dates, etc.)
        [parameter(Mandatory=$True)]  # <-- require this parameter to be specified
        [ValidateSet(1,5,10)]  # <-- restrict input to numbers 1, 5 or 10 only
        [int] $Number2  # <-- only allow integer values (no decimals, strings, dates, etc.)
    )
    $Number1 + $Number2
}
```

## Examples

```powershell
Add-Stuff -Number1 1 -Number2 5

# throws an error because [Number1] is out of the allowed range (2-100)
```
