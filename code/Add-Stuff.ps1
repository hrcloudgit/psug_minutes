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
