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

Add-Stuff : Cannot validate argument on parameter 'Number1'. 
The 1 argument is less than the minimum allowed range of 2. 
Supply an argument that is greater than or equal to 2 and then try the command again.
At line:1 char:20
+ Add-Stuff -Number1 1 -Number2 5
+                    ~
    + CategoryInfo          : InvalidData: (:) [Add-Stuff], ParameterBindingValidationException
    + FullyQualifiedErrorId : ParameterArgumentValidationError,Add-Stuff

```

```powershell
Add-Stuff -Number1 2 -Number2 51

Add-Stuff : Cannot validate argument on parameter 'Number2'. 
The argument "51" does not belong to the set "1,5,10" specified by the ValidateSet attribute. 
Supply an argument that is in the set and then try the command again.
At line:1 char:31
+ Add-Stuff -Number1 2 -Number2 51
+                               ~~
    + CategoryInfo          : InvalidData: (:) [Add-Stuff], ParameterBindingValidationException
    + FullyQualifiedErrorId : ParameterArgumentValidationError,Add-Stuff
```
