---
title: Set language and region settings for Office 365
description: Describes how to set language and region settings for Office 365 by using Office 365 PowerShell.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-maqiu
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Office 365
---

# How to set language and region settings for Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

This article explains how to set the language and region settings for all Office 365 services (including OneDrive For Business, Delve, and SharePoint Online) by using Office 365 PowerShell centrally for a particular user.

## More Information

For all Office 365 services (including OneDrive For Business, Delve, and SharePoint Online), you can change the language and region settings at the user level in a [Cloud identity](https://docs.microsoft.com/en-us/office365/enterprise/about-office-365-identity) or [Hybrid identity model](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/whatis-hybrid-identity) by using Office 365 PowerShell.

**Note** Before you sync the settings, you should configure the alternative language settings on your SharePoint Online site. To do this, follow these steps:

1. On your team site, select **Settings** > **Site settings**.   
2. In **Site Administration**, select **Language settings**.   
3. On the **Language Settings** page, select the alternative languages that your site should support.   
4. Click **OK**.   

### For all Office 365 services except Exchange Online

#### Cloud identity model

To update the settings for a cloud-only user, use the [Set-MsolUser](https://docs.microsoft.com/en-us/powershell/module/msonline/set-msoluser) or [Set-AzureADUser](https://docs.microsoft.com/en-us/powershell/module/azuread/set-azureaduser) PowerShell cmdlets.

Example:

```powershell
Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser -PreferredLanguage "it-it"
Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser –UsageLocation IT
```

For more information see, [Configure user account properties with Office 365 PowerShell](https://docs.microsoft.com/en-us/office365/enterprise/powershell/configure-user-account-properties-with-office-365-powershell).

#### Hybrid identity model

To update the settings for a user in an on-premises instance of AD that is being syncronized into Azure AD, see the following example:

```powershell
Get-ADUser -SearchBase "OU=Italy,OU=Countries,DC=contoso,DC=com" -Filter * -Properties PreferredLanguage | ForEach-Object {Set-ADUser $_.SAMAccountName –replace @{PreferredLanguage="it-it"}}

Get-MsolUser -UserPrincipalName user1@contoso.com | Set-MsolUser –UsageLocation IT
```

  **Note** These settings may be synced and your changes overwritten, for more information see [Azure Active Directory Connect sync: Configure preferred data location for Office 365 resources](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-sync-feature-preferreddatalocation)

### For Exchange Online

To update the settings for a user in Exchange Online, use the [Set-MailboxRegionalConfiguration](https://docs.microsoft.com/en-us/powershell/module/exchange/set-mailboxregionalconfiguration) PowerShell cmdlet.

Example:

```powershell
Get-Mailbox user1@contoso.com | Get-MailboxRegionalConfiguration | Set-MailboxRegionalConfiguration -Language it-it -DateFormat "dd/MM/yyyy" -TimeFormat "HH:mm" -TimeZone "W. Europe Standard Time"
```

**Note** It will take from one to two hours for the changes to be reflected on all services.
