﻿# 1.3 - what happened?

### prudent output (write-host vs write-verbose)

[CmdletBinding()]
param ()

Write-Verbose "this is hidden unless -Verbose is used"
Write-Host "this is just in your face no matter what. but it can only display"
Write-Output "this is an actual output that can be used afterwards"

### focus language on target user level

param (
    [parameter(Mandatory=$True, HelpMessage="Recipient email")]
    [string] $RecipientExpert,
    [parameter(Mandatory=$True, HelpMessage="This is the Email address of the user you wish to notify")]
    [string] $RecipientBasic
)


### exception handling with clear explanations
# see = https://devops-collective-inc.gitbook.io/the-big-book-of-powershell-error-handling/powershell-error-handling-basics 

# example 2

try {
    $num1 = 0
    $num2 = 3
    $result = $num2 / $num0
    Write-Output $result
}
catch [System.IO.IOException] {
    Write-Output "an IO exception occurred"
}
catch [System.DivideByZeroException] {
    Write-Warning "you can't divide a number by zero, you idiot"
}
catch {
    Write-Error $Error[0].Exception
}

### example 3

try {
    $baseNumber = 100
    for ($i = 10; $i -ge 0; $i--) {
        $result = $baseNumber / $i
        Write-Host "$baseNumber / $i = $result"
    }
}
catch [System.DivideByZeroException] {
    Write-Warning "another divide-by-zero goof?!  really?!"
}
finally {
    Write-Host "index made it down to $i"
}


## Decide if exception should stop everything or keep going

$Servers = @('server1','server2')

foreach ($Server in $Servers) {
    try {
        $files = Get-ChildItem -Path "\\$server\c$\windows\temp" -Filter "*.log" -ErrorAction SilentlyContinue
    }
    catch {
        Write-Warning "$Server path not accessible"
    }
}