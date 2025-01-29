# Import configuration from JSON
Function Get-Config {
    param ($ConfigPath)
    if (-Not (Test-Path $ConfigPath)) {
        Write-Host "Config file not found: $ConfigPath" -ForegroundColor Red
        exit
    }
    return Get-Content $ConfigPath | ConvertFrom-Json
}

# Connect to Microsoft Graph
Function Connect-MicrosoftGraph {
    param ($ClientId, $TenantId, $ClientSecret, $AppName)
    
    try {
        $Context = Get-MgContext
        if ($Context.AppName -ne $AppName) {
            $SecureSecret = ConvertTo-SecureString -String $ClientSecret -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ($ClientId, $SecureSecret)
            Connect-MgGraph -TenantId $TenantId -ClientSecretCredential $Credential -NoWelcome
            Write-Host "Successfully connected to Microsoft Graph as '$AppName'." -ForegroundColor Green
        } else {
            Write-Host "Already connected to Microsoft Graph as '$AppName'." -ForegroundColor Cyan
        }
    } catch {
        Write-Host "Failed to connect to Microsoft Graph: $_" -ForegroundColor Red
        exit
    }
}

# Get Teams without owners
Function Get-TeamsWithoutOwners {
    Write-Host "Fetching Teams..." -ForegroundColor Yellow
    $Teams = Get-MgTeam -All
    $Results = @()

    foreach ($Team in $Teams) {
        $Owners = Get-MgTeamMember -TeamId $Team.Id | Where-Object { $_.Roles -contains 'Owner' }

        if (-not $Owners) {
            $Members = (Get-MgTeamMember -TeamId $Team.Id).DisplayName -join "; "
            $Results += [PSCustomObject]@{
                "Team Without Owner" = $Team.DisplayName
                "Team Members"       = $Members
            }
        }
    }
    return $Results
}

# Generate HTML Report from XML Template
Function Generate-HTMLReport {
    param ($Results, $TemplatePath)
    
    if (-Not (Test-Path $TemplatePath)) {
        Write-Host "Email template not found: $TemplatePath" -ForegroundColor Red
        exit
    }

    [xml]$Template = Get-Content $TemplatePath
    $TableHTML = "<table><tr><th>Team Without Owner</th><th>Team Members</th></tr>"

    foreach ($Row in $Results) {
        $TableHTML += "<tr><td>$($Row.'Team Without Owner')</td><td>$($Row.'Team Members')</td></tr>"
    }
    $TableHTML += "</table>"

    return $Template.Email.Body.Replace('$TableHTML', $TableHTML)
}

# Send Email
Function Send-Email {
    param ($Recipients, $From, $Subject, $Body, $SmtpServer)
    
    try {
        Send-MailMessage -To $Recipients -From $From -Subject $Subject -Body $Body -SmtpServer $SmtpServer -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8)
        Write-Host "✅ Email sent successfully!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to send email: $_" -ForegroundColor Red
    }
}
