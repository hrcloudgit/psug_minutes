function Get-AdsAccounts {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$True)]
        [ValidateSet('computer','user')]
        [string] $AccountType
    )
    try {
        $as = [adsisearcher]"(objectCategory=$AccountType)"
        $props = @("name","distinguishedName","lastLogonTimeStamp","samAccountName","displayName")
        $props | %{ $as.PropertiesToLoad.Add($_) | Out-Null }
        $as.PageSize = 2000
        $accounts = $as.FindAll()
        foreach ($account in $accounts) {
            if ($AccountType -eq 'computer') {
                $name = ($account.Properties.item('samAccountName') | Out-String).Trim()
                $disp = ($account.Properties.item('name') | Out-String).Trim()
            }
            else {
                $name = ($account.Properties.item('samAccountName') | Out-String).Trim()
                $disp = ($account.Properties.item('displayName') | Out-String).Trim()
            }
            $dn   = ($account.Properties.item('distinguishedName') | Out-String).Trim()
            $lts  = ($account.Properties.item('lastLogonTimeStamp') | Out-String).Trim()
            $lts  = ([datetime]::FromFileTime($lts))
            $age  = (New-TimeSpan -Start (Get-Date $lts) -End (Get-Date)).Days
            $params = [ordered]@{
                SamAccount  = $name
                DisplayName = $disp
                Type        = $AccountType
                LastLogon   = $lts
                LogonAge    = $age
                DN          = $dn
            }
            New-Object PSObject -Property $params
        }
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}
