function Write-LogFile {
    param (
        [parameter(Mandatory=$False)]
            [string] $FilePath = (Join-Path -Path $env:USERPROFILE -ChildPath "Documents"),
        [parameter(Mandatory=$False)]
            [string] $LogName = $logfile,
        [parameter(Mandatory=$True)]
            [ValidateSet('computer','user')]
            [string] $AccountType,
        [parameter(Mandatory=$True)]
            [ValidateNotNullOrEmpty()]
            [string] $AccountName,
        [parameter(Mandatory=$True)]
            [ValidateNotNullOrEmpty()]
            [string] $Message,
        [parameter(Mandatory=$False)]
            [string] $Delimiter = ","
    )
    if ([string]::IsNullOrEmpty($LogName)) { $LogName = "adcleanup.log" }
    try {
        $LogPath = Join-Path -Path $FilePath -ChildPath $LogName
        # build an array of column values for a new row in the log file
        # format: (date,time,runas,type,account,message)
        $Entry = @(
            (Get-Date).ToShortDateString(),
            (Get-Date).ToLongTimeString(),
            "RunAs=$($env:USERNAME)",
            $AccountType,
            $AccountName,
            $Message
        )
        # concatenate values and write to output file
        $Entry -join $Delimiter | Out-File -FilePath $LogPath -Append
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}
