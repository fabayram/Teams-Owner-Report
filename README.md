📝 Teams Without Owners Report

📌 Overview

This PowerShell script connects to Microsoft Graph, retrieves all Microsoft Teams without owners, generates an HTML report using an XML template, and sends it via email.

The script is modular, configurable, and follows best practices for maintainability and scalability.

⚡ Features

✅ Automated Microsoft Graph Connection using credentials from config.json✅ Retrieves Teams without Owners efficiently✅ Generates an HTML report using a customizable EmailTemplate.xml✅ Sends an email report using SMTP settings from config.json✅ Structured in multiple files for clean and maintainable code

📂 Project Structure

```
📂 TeamsOwnerReport
│── 📄 TeamsOwnerReport.ps1  # Main script
│── 📄 Functions.ps1         # Contains all PowerShell functions
│── 📄 config.json           # Configuration file (credentials & settings)
│── 📄 EmailTemplate.xml     # HTML email template
│── 📄 README.md             # Documentation
```

🔧 Prerequisites

🛠 System Requirements

PowerShell 7+ (Recommended)

Microsoft Graph PowerShell SDKInstall with:```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

🔑 Microsoft Graph API Permissions

The App Registration in Azure AD must have the following permissions:

`Directory.Read.All`

`Group.Read.All`

`TeamMember.Read.All`

`Team.ReadBasic.All`

⚙️ Configuration (`config.json`)

The script uses a JSON configuration file (`config.json`) to store all settings:

```json
{
"MicrosoftGraph": {
"ClientId": "your-client-id",
"TenantId": "your-tenant-id",
"ClientSecret": "your-client-secret",
"AppName": "your-app-name"
},
"SMTP": {
"Server": "smtp.yourdomain.com",
"From": "noreply@yourcompany.com",
"Recipients": [
"user1@example.com",
"user2@example.com"
]
}
}
```

📌 Modify this file with your actual credentials before running the script.

📜 Email Template (`EmailTemplate.xml`)

The script loads the HTML email content from an external XML file (`EmailTemplate.xml`).You can customize it without modifying the script.

```xml

[$Date] Report: Teams Without Owners




```

The `$TableHTML` placeholder is dynamically replaced with the Teams data.

🔍 Functions Overview (`Functions.ps1`)

Function

Description

`Get-Config`

Loads and parses the `config.json` file.

`Connect-MicrosoftGraph`

Authenticates to Microsoft Graph using credentials from `config.json`.

`Get-TeamsWithoutOwners`

Fetches all Teams and identifies those without an owner.

`Generate-HTMLReport`

Reads the `EmailTemplate.xml` file and injects the Teams data.

`Send-Email`

Sends the report via SMTP using the settings from `config.json`.

🚀 Usage

1️⃣ Setup

Make sure `config.json` is properly configured.

Ensure `EmailTemplate.xml` contains the correct HTML structure.

2️⃣ Run the Script

Run the following command in PowerShell:

```powershell
.\TeamsOwnerReport.ps1
```

3️⃣ Expected Behavior

✅ The script will:

Connect to Microsoft Graph

Retrieve Teams without owners

Generate an HTML email

Send the report to the recipients in `config.json`

Skip sending the email if no Teams are missing owners

📌 Example Output (Email Report)

Team Without Owner

Members

Marketing Team

John Doe, Jane Smith

HR Team

Alice Brown, Bob White

🛠 Troubleshooting

❌ `Connect-MicrosoftGraph` fails

Check if your Client ID, Tenant ID, and Client Secret are correct.

Ensure the Azure AD App has the required Graph API permissions.

❌ `Send-Email` fails

Check if your SMTP server is correct in `config.json`.

Verify if your email address has permissions to send emails.

📜 License

This script is open-source and licensed under the MIT License.

👨‍💻 Author

Fatih BAYRAMFeel free to contribute or report issues!

⭐ Contributions & Feedback

💡 Found a bug? Have a suggestion?Create an Issue or open a Pull Request on GitHub! 🚀
