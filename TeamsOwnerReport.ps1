# -----------------------------------------------------------------------------------------------------------------------
# SCRIPT:        Teams Without Owners Report
# VERSION:       1.2
# AUTHOR:        Fatih BAYRAM
# LAST UPDATED:  29/01/2025
# -----------------------------------------------------------------------------------------------------------------------
# .SYNOPSIS
#   This script connects to Microsoft Graph, retrieves all Teams without owners, generates an HTML report, 
#   and sends it via email.
#
# .DESCRIPTION
#   - Connects automatically to Microsoft Graph using credentials from `config.json`
#   - Retrieves all Teams from the tenant
#   - Checks if a Team has no owner
#   - Generates an HTML report using a predefined template (`EmailTemplate.xml`)
#   - Sends the report via email using SMTP settings from `config.json`
#   - If no Teams without owners are found, no email is sent
#
# .REQUIREMENTS
#   - Microsoft Graph PowerShell SDK installed (`Install-Module Microsoft.Graph -Scope CurrentUser`)
#   - Valid API credentials (Client ID, Tenant ID, Client Secret)
#   - SMTP server access for sending emails
# -----------------------------------------------------------------------------------------------------------------------

# Import the functions file
. .\Functions.ps1

# Load configuration from JSON file
$ConfigPath = ".\config.json"
$Config = Get-Config -ConfigPath $ConfigPath

# Connect to Microsoft Graph using credentials from config.json
Connect-MicrosoftGraph -ClientId $Config.MicrosoftGraph.ClientId `
                       -TenantId $Config.MicrosoftGraph.TenantId `
                       -ClientSecret $Config.MicrosoftGraph.ClientSecret `
                       -AppName $Config.MicrosoftGraph.AppName

# Retrieve Teams without owners
$Results = Get-TeamsWithoutOwners

# Check if there are any results
if ($Results.Count -eq 0) {
    Write-Host "âœ… No Teams without owners found. No report will be sent." -ForegroundColor Green
    exit
}

# Generate the HTML email body using the XML template
$EmailTemplatePath = ".\EmailTemplate.xml"
$HtmlBody = Generate-HTMLReport -Results $Results -TemplatePath $EmailTemplatePath

# Set the email subject with the current date
$Date = Get-Date -Format "dd/MM/yyyy"
$Subject = "[${Date}] Report: Teams Without Owners"

# Send the email
Send-Email -Recipients $Config.SMTP.Recipients `
           -From $Config.SMTP.From `
           -Subject $Subject `
           -Body $HtmlBody `
           -SmtpServer $Config.SMTP.Server

Write-Host "¤ Report sent successfully!" -ForegroundColor Cyan
