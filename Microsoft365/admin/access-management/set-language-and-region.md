---
title: Set language and regional settings for Microsoft 365
description: Describes how to set language and regional settings for Microsoft 365 by using Microsoft Graph PowerShell.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 10/26/2023
---

# How to set the language and regional settings for Microsoft 365

For all Microsoft 365 services (including OneDrive For Business, Delve, and SharePoint Online), you can change the language and regional settings at the user level in a Cloud identity or Synchronized identity model by using Microsoft Graph PowerShell.

**Note** Before you sync the settings, you should configure the alternative language settings on your SharePoint Online site. To do so, follow these steps:

1. On your team site, select **Settings** > **Site settings**.   
2. In **Site Administration**, select **Language settings**.   
3. On the **Language Settings** page, select the alternative languages that your site should support.   
4. Click **OK**.   

## For all Microsoft 365 services except Exchange Online

### Cloud identity model

To sync the settings by using a user ID, run the following example cmdlets after you substitute the actual values:

```powershell
# Update the User's Preferred Language details
Import-Module Microsoft.Graph.Users

Connect-MgGraph  -Scopes 'User.ReadWrite.All'

$preferredLanguage = 'it-it'
$userId = Get-MgUser -UserId user1@contoso.com
Update-MgUser -UserId $userId.Id -PreferredLanguage $preferredLanguage
```

> [!NOTE]
> The preferred language for the user should follow ISO 639-1 Code, for example, en-US.

```powershell
# Update User's Usage Location details
Import-Module Microsoft.Graph.Users

Connect-MgGraph  -Scopes 'User.ReadWrite.All'

$usageLocation = 'IT'
$userId = Get-MgUser -UserId user1@contoso.com
Update-MgUser -UserId $userId.Id -Usagelocation $usageLocation
```

> [!NOTE] 
> The usage location is a two-letter country code (ISO standard 3166). It's required for users who will be assigned licenses due to legal requirements to check for the availability of services in countries. Examples include US, JP, and GB. Not nullable.

### Synchronized identity model

To sync the settings by using an on-premises instance of Active Directory, run the following example cmdlets after you substitute the actual values:

```powershell
Get-ADUser -SearchBase "OU=Italy,OU=Countries,DC=contoso,DC=com" -Filter * | Set-ADUser –replace @{PreferredLanguage="it-it"}
```

Then, force the settings to sync through Microsoft Entra Connect.

## For Exchange Online

To sync the settings for Exchange Online, run the following example cmdlet after you substitute the actual values:

```powershell
Get-Mailbox user1@contoso.com | Get-MailboxRegionalConfiguration | Set-MailboxRegionalConfiguration -Language it-it -DateFormat "dd/MM/yyyy" -TimeFormat "HH:mm" -TimeZone "W. Europe Standard Time"
```

**Note** It will take from one to two hours for the changes to be reflected on all services.
