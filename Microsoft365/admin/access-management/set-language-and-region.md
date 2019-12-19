---
title: Set language and region settings for Office 365
description: Describes how to set language and region settings for Office 365 by using Office 365 PowerShell.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Office 365
---

# How to set language and region settings for Office 365

## Summary

This article explains how to set the language and region settings for all Office 365 services (including OneDrive For Business, Delve, and SharePoint Online) by using Office 365 PowerShell centrally for all users.

## More Information

For all Office 365 services (including OneDrive For Business, Delve, and SharePoint Online), you can change the language and region settings at the user level in a Cloud identity or Synchronized identity model by using Office 365 PowerShell.

**Note** Before you sync the settings, you should configure the alternative language settings on your SharePoint Online site. To do this, follow these steps:

1. On your team site, select **Settings** > **Site settings**.   
2. In **Site Administration**, select **Language settings**.   
3. On the **Language Settings** page, select the alternative languages that your site should support.   
4. Click **OK**.   

### For all Office 365 services except Exchange Online

Cloud identity model

To sync the settings by using a user ID, run the following example cmdlets after you substitute the actual values:

```powershell
Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser -PreferredLanguage "it-it"
Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser – UsageLocation IT
```

Synchronized identity model

To sync the settings by using an on-premises instance of Azure AD, run the following example cmdlets after you substitute the actual values:

```powershell
Get-ADUser -SearchBase "OU=Italy,OU=Countries,DC=contoso,DC=com" -Filter * -Properties PreferredLanguage | ForEach-Object {Set-ADUser $_.SAMAccountName –replace @{PreferredLanguage="it-it"}}

Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser – UsageLocation IT
```

Then, force the settings to sync through Azure AD Connect.

### For Exchange Online

To sync the settings for Exchange Online, run the following example cmdlet after you substitute the actual values:

```powershell
Get-Mailbox user1@contoso.com | Get-MailboxRegionalConfiguration | Set-MailboxRegionalConfiguration -Language it-it -DateFormat "dd/MM/yyyy" -TimeFormat "HH.mm" -TimeZone "W. Europe Standard Time"
```

**Note** It will take from one to two hours for the changes to be reflected on all services.
