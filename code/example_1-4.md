# Example 1.4 - Defensive Coding

## Execution Policy
   * see = https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-6

### Example 1

```powershell
$currentPolicy = Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
```

### Example 2 - ExecutionPolicy types

#### Restricted. 

    Does not load configuration files or run scripts. 
    Restricted is the default execution policy.

#### AllSigned. 
    
    Requires that all scripts and configuration files be signed by a trusted publisher, 
    including scripts that you write on the local computer.

#### RemoteSigned. 

    Requires that all scripts and configuration files downloaded from 
    the Internet be signed by a trusted publisher.

#### Unrestricted. 

    Loads all configuration files and runs all scripts. 
    If you run an unsigned script that was downloaded from the Internet, 
    you are prompted for permission before it runs.

#### Bypass. 
    
    Nothing is blocked and there are no warnings or prompts.

#### Undefined. 

    Removes the currently assigned execution policy from the current scope. 
    This parameter will not remove an execution policy that is set in a Group Policy scope.

## Scopes

#### Process

    Affects only the current powershell process (goes away when process terminates)

#### CurrentUser

    Affects only the current user (user context)

#### LocalMachine (default)

    Affects all users of the computer
