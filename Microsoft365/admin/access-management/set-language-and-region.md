---
title: Set language and region settings for Microsoft 365
description: Describes how to set language and region settings for Microsoft 365 by using Microsoft 365 PowerShell.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: v-maqiu
ms.custom: CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 3/31/2022
---

# How to set language and region settings for Microsoft 365

## Summary

This article explains how to set the language and region settings for all Microsoft 365 services (including OneDrive For Business, Delve, and SharePoint Online) by using Microsoft 365 PowerShell centrally for all users.

## More Information

For all Microsoft 365 services (including OneDrive For Business, Delve, and SharePoint Online), you can change the language and region settings at the user level in a Cloud identity or Synchronized identity model by using Microsoft 365 PowerShell.

**Note** Before you sync the settings, you should configure the alternative language settings on your SharePoint Online site. To do this, follow these steps:

1. On your team site, select **Settings** > **Site settings**.   
2. In **Site Administration**, select **Language settings**.   
3. On the **Language Settings** page, select the alternative languages that your site should support.   
4. Click **OK**.   

### For all Microsoft 365 services except Exchange Online

#### Cloud identity model

To sync the settings by using a user ID, run the following example cmdlets after you substitute the actual values:

```powershell
Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser -PreferredLanguage "it-it"
Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser –UsageLocation IT
```

#### Synchronized identity model

To sync the settings by using an on-premises instance of Active Directory, run the following example cmdlets after you substitute the actual values:

```powershell
Get-ADUser -SearchBase "OU=Italy,OU=Countries,DC=contoso,DC=com" -Filter * | Set-ADUser –replace @{PreferredLanguage="it-it"}

Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser –UsageLocation IT
```

Then, force the settings to sync through Azure AD Connect.

### For Exchange Online

To sync the settings for Exchange Online, run the following example cmdlet after you substitute the actual values:

```powershell
Get-Mailbox user1@contoso.com | Get-MailboxRegionalConfiguration | Set-MailboxRegionalConfiguration -Language it-it -DateFormat "dd/MM/yyyy" -TimeFormat "HH:mm" -TimeZone "W. Europe Standard Time"
```

**Note** It will take from one to two hours for the changes to be reflected on all services.
