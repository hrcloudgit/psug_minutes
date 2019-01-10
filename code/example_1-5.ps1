# 1.5 - modular coding

### inline mess of code

# form a SOAP request for an authentication session token

$SOAPurl = "https://www.contoso.local/services/fubar/v2/users.svc"
$xmlAuth = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
xmlns:tem="http://temp.org/" xmlns:mes="http://contoso.local/Services/MessagesAPI">
<soapenv:Header/>
	<soapenv:Body>
		<tem:Login>
			<tem:request>
				<mes:Password>P@ssw0rd123!!</mes:Password>
				<mes:Username>apiuser100</mes:Username>
			</tem:request>
		</tem:Login>
	</soapenv:Body>
</soapenv:Envelope>'

# send the request

$Headers   = @{SOAPAction = "http://temp.org/IAuthenticationService/Login"}
$response  = Invoke-WebRequest -Uri $SOAPurl -Body $xmlAuth -Method Post -ContentType "text/xml" -UseBasicParsing -Headers $Headers
$SessionID = ([xml]$Response.Content).Envelope.Body.LoginResponse.LoginResult.SessionId
if ([string]::IsNullOrEmpty($SessionID)) {
	Write-Error "failed to get authentication token!"
    break
}

# form SOAP request to get all user accounts from the root-level group

$SOAPurl = "https://services09.contoso.local/services/fubar/UserService/v2/UserService.svc"
$xmlUsers = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
xmlns:tem="http://temp.org/" xmlns:mes="http://contoso.local/services/MessagesAPI">
<soapenv:Header/>
    <soapenv:Body>
        <tem:GetUsers>
	        <tem:request>
	            <mes:SessionId>'+$SessionID+'</mes:SessionId>
	            <mes:GroupId>12345678-abcd-0321-4567-abcd123456ef</mes:GroupId>
	            <mes:IncludeSubGroups>true</mes:IncludeSubGroups>
	        </tem:request>
        </tem:GetUsers>
    </soapenv:Body>
</soapenv:Envelope>'

# submit the request for all users
	    
$Headers  = @{SOAPAction = "http://temp.org/IUserService/GetUsers"}
$response = Invoke-WebRequest -Uri $SOAPurl -Body $xmlUsers -Method Post -ContentType "text/xml" -UseBasicParsing -Headers $Headers -ErrorAction Stop
$rspData  = @(([xml]$response.Content).Envelope.Body.GetUsersResponse.GetUsersResult.Users.UserSummary)
if ($rspData.Count -gt 0) {
    $allusers = $rspData
}
else {
    Write-Warning "no users were found"
    break
}

### --------------------------------------------------------------------------------
## FIRST REFACTOR
##
## refactor into functions, so we can move them to a separate file to make
## the processing script less cluttered and easier to read

function Get-SessionID {
    param()
    try {
        $SOAPurl = "https://www.contoso.local/services/fubar/v2/users.svc"
        $xmlAuth = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
xmlns:tem="http://temp.org/" xmlns:mes="http://contoso.local/Services/MessagesAPI">
<soapenv:Header/>
	<soapenv:Body>
		<tem:Login>
			<tem:request>
				<mes:Password>P@ssw0rd123!!</mes:Password>
				<mes:Username>apiuser100</mes:Username>
			</tem:request>
		</tem:Login>
	</soapenv:Body>
</soapenv:Envelope>'
        $Headers  = @{SOAPAction = "http://temp.org/IAuthenticationService/Login"}
        $response = Invoke-WebRequest -Uri $SOAPurl -Body $xmlAuth -Method Post -ContentType "text/xml" -UseBasicParsing -Headers $Headers
        $result   = ([xml]$Response.Content).Envelope.Body.LoginResponse.LoginResult.SessionId
        if (![string]::IsNullOrEmpty($SessionID)) {
	        return $result
        }
    }
    catch {
        Write-Error "Error: $($Error[0].Exception.Message)"
    }
}

function Get-ApiUsers {
    param (
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $SID,
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $GroupNumber
    )
    try {
        $SOAPurl = "https://services09.contoso.local/services/fubar/UserService/v2/UserService.svc"
        $xmlUsers = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
xmlns:tem="http://temp.org/" xmlns:mes="http://contoso.local/services/MessagesAPI">
<soapenv:Header/>
    <soapenv:Body>
        <tem:GetUsers>
	        <tem:request>
	            <mes:SessionId>'+$SID+'</mes:SessionId>
	            <mes:GroupId>'+$GroupNumber+'</mes:GroupId>
	            <mes:IncludeSubGroups>true</mes:IncludeSubGroups>
	        </tem:request>
        </tem:GetUsers>
    </soapenv:Body>
</soapenv:Envelope>'
        $Headers  = @{SOAPAction = "http://temp.org/IUserService/GetUsers"}
        $response = Invoke-WebRequest -Uri $SOAPurl -Body $xmlUsers -Method Post -ContentType "text/xml" -UseBasicParsing -Headers $Headers -ErrorAction Stop
        $rspData  = @(([xml]$response.Content).Envelope.Body.GetUsersResponse.GetUsersResult.Users.UserSummary)
        if ($rspData.Count -gt 0) {
            Write-Output $rspData -NoEnumerate
        }
    }
    catch {
        Write-Error "Error: $($Error[0].Exception.Message)"
    }
}

# now the main script could look like this...

if ($SessionID = Get-SessionID -UserName $apiUser -Password $apiPwd) {
    $allUsers = Get-ApiUsers -SID $SessionID -Group $BaseGroupID
}


### --------------------------------------------------------------------------------
## SECOND REFACTOR
##
## further, you may find that many other tasks besides "Get-ContosoUsers" require the same SOAP URI or
## the same XML template.  Rather than repeat the same bulky lines of code, you can move them into 
## functions and request them as needed...

function Get-ApiURL {
    param (
        [parameter(Mandatory=$True, HelpMessage="Base name of SOAP service group")]
        [ValidateSet('auth','users','groups','events')]
        [string] $ServiceGroup
    )
    switch ($ServiceGroup) {
        'auth' {
            return "https://www.contoso.local/services/fubar/v2/users.svc"
            break;
        }
        'users' {
            return "https://services09.contoso.local/services/fubar/UserService/v2/UserService.svc"
            break;
        }
    } # switch
}

function Get-ApiXmlTemplate {
    param (
        [parameter(Mandatory=$True, HelpMessage="Base name of SOAP service group")]
        [ValidateSet('auth','users','groups','events')]
        [string] $ServiceGroup
    )
    switch ($ServiceGroup) {
        'auth' {
            return '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
xmlns:tem="http://temp.org/" xmlns:mes="http://contoso.local/Services/MessagesAPI">
<soapenv:Header/>
	<soapenv:Body>
		<tem:Login>
			<tem:request>
				<mes:Password>XXPASSWORD</mes:Password>
				<mes:Username>XXUSERNAME</mes:Username>
			</tem:request>
		</tem:Login>
	</soapenv:Body>
</soapenv:Envelope>'
            break;
        }
        'users' {
            # ... same kind of thing...
            break;
        }
    } # switch
}

function Get-SessionID {
    param()
    try {
        $SOAPurl = "https://www.contoso.local/services/fubar/v2/users.svc"
        $xmlAuth = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
xmlns:tem="http://temp.org/" xmlns:mes="http://contoso.local/Services/MessagesAPI">
<soapenv:Header/>
	<soapenv:Body>
		<tem:Login>
			<tem:request>
				<mes:Password>P@ssw0rd123!!</mes:Password>
				<mes:Username>apiuser100</mes:Username>
			</tem:request>
		</tem:Login>
	</soapenv:Body>
</soapenv:Envelope>'
        $Headers  = @{SOAPAction = "http://temp.org/IAuthenticationService/Login"}
        $response = Invoke-WebRequest -Uri $SOAPurl -Body $xmlAuth -Method Post -ContentType "text/xml" -UseBasicParsing -Headers $Headers
        $result   = ([xml]$Response.Content).Envelope.Body.LoginResponse.LoginResult.SessionId
        if (![string]::IsNullOrEmpty($SessionID)) {
	        return $result
        }
    }
    catch {
        Write-Error "Error: $($Error[0].Exception.Message)"
    }
}

function Get-ApiUsers {
    param (
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $SID,
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $GroupNumber
    )
    try {
        $SOAPurl  = Get-ApiURL -ServiceGroup 'users'  ## <--- Much cleaner!
        $xmlUsers = Get-ApiXmlTemplate -ServiceGroup 'users' ## <--- Much cleaner!
        $Headers  = @{SOAPAction = "http://temp.org/IUserService/GetUsers"}
        $response = Invoke-WebRequest -Uri $SOAPurl -Body $xmlUsers -Method Post -ContentType "text/xml" -UseBasicParsing -Headers $Headers -ErrorAction Stop
        $rspData  = @(([xml]$response.Content).Envelope.Body.GetUsersResponse.GetUsersResult.Users.UserSummary)
        if ($rspData.Count -gt 0) {
            Write-Output $rspData -NoEnumerate
        }
    }
    catch {
        Write-Error "Error: $($Error[0].Exception.Message)"
    }
}

function Get-UsersActive {...}

function Disable-Users {...}

function Enable-Users {...}

function Add-User {...}