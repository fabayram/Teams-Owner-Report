# Teams Owner Report Generator

Automatically monitor and report Microsoft Teams without owners through PowerShell automation.

## 📌 Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Core Functions](#core-functions)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)
- [Acknowledgments](#acknowledgments)

---

## ✨ Features
- 🔐 Secure Microsoft Graph authentication
- 🔍 Teams ownership monitoring
- 📊 Customizable HTML reporting
- 📧 Automated email notifications
- 📦 Modular architecture

---

## 📋 Prerequisites
### Required Components
- PowerShell 5.1 or higher
- Microsoft Graph PowerShell SDK
- Azure AD App Registration with appropriate permissions

### 🔑 Required Permissions
Your Azure AD App needs the following Microsoft Graph API permissions:
- `Directory.Read.All`
- `Group.Read.All`
- `TeamMember.Read.All`
- `Team.ReadBasic.All`

---

## 🚀 Installation
### Install Microsoft Graph PowerShell SDK
```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

### Clone the Repository
```bash
git clone https://github.com/yourusername/teams-owner-report.git
cd teams-owner-report
```

### Configure Settings
Edit `config.json` to match your environment:
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
        "Recipients": ["user1@example.com"]
    }
}
```

### Run the Script
```powershell
.\TeamsOwnerReport.ps1
```

---

## 📁 Project Structure
```
.
└── src/
    ├── TeamsOwnerReport.ps1   # Main script
    ├──  Functions.ps1         # Core functions
    ├── config.json            # Configuration
    ├── EmailTemplate.xml      # Email template
    └── README.md              # Documentation
```

---

## 🛠️ Core Functions
| Function | Description |
|----------|-------------|
| `Get-Config` | Configuration manager |
| `Connect-MicrosoftGraph` | Graph authentication |
| `Get-TeamsWithoutOwners` | Teams monitoring |
| `Generate-HTMLReport` | Report generation |
| `Send-Email` | Email distribution |

---

## ❓ Troubleshooting
### Authentication Issues
```powershell
# Verify connection
Connect-MgGraph -ClientId $config.ClientId -TenantId $config.TenantId
```

### Email Configuration
```powershell
# Test email settings
Send-MailMessage -SmtpServer $config.SmtpServer -From $config.From -To $config.Recipients -Subject "Test"
```

---

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

---

## 👨‍💻 Author
**Fatih BAYRAM**  
GitHub: [@fabayram](https://github.com/fabayram?tab=repositories)  
LinkedIn: [@yourprofile](https://www.linkedin.com/in/fbayram/)

---

## 🙏 Acknowledgments
- Microsoft Graph Team
- PowerShell Community
- All Contributors

---

<p align="center">Made with ❤️ for the community</p>

If you like this project, please consider giving it a ⭐!
