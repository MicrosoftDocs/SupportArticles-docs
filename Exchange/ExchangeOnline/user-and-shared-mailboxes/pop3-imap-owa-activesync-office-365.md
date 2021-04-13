---
title: Enable or disable POP3, IMAP, MAPI, Outlook Web App or ActiveSync in Office 365
description: Describes how to enable or disable POP3, IMAP, MAPI, Outlook Web App or ActiveSync in Office 365.
author: Norman-sun
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-swei
manager: dcscontentpm
ms.custom: 
- Exchange Online
- CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---
# Enable or disable POP3, IMAP, MAPI, Outlook Web App or Exchange ActiveSync in Office 365

## Summary

This article identifies the commands to use to enable or disable the following items for a mailbox in Exchange Online in Office 365:

- Post Office Protocol (POP)
- Internet Message Access Protocol (IMAP)
- Messaging Application Programming Interface (MAPI)
- Outlook Web App
- Microsoft Exchange ActiveSync

## More information

> [!NOTE]
> Before you run any of the commands in the following steps, you have to first connect to Exchange Online by using remote PowerShell. For more info about how to do this, see [Connect to Exchange Online Using Remote PowerShell](/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell).

### Enable or disable POP3 for an Exchange Online mailbox

To enable POP3 for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias,Primary SMTP, or UPN> -PopEnabled $True
```

To disable POP3 for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -PopEnabled $False
```

### Enable or disable IMAP for an Exchange Online mailbox

To enable IMAP for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -ImapEnabled $True
```

To disable IMAP for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -ImapEnabled $False
```

### Enable or disable MAPI for an Exchange Online mailbox

To enable MAPI for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -MAPIEnabled $True
```

To disable MAPI for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -MAPIEnabled $False
```

### Enable or disable Outlook Web App for an Exchange Online mailbox

To enable Outlook Web App for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -OWAEnabled $True
```

To disable Outlook Web App for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -OWAEnabled $False
```

### Enable or disable Exchange ActiveSync for an Exchange Online mailbox

To enable Exchange ActiveSync for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -ActiveSyncEnabled $True
```

To disable Exchange ActiveSync  for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -ActiveSyncEnabled $False
```

### Enable or disable Exchange Web Services (EWS) for an Exchange Online mailbox

To enable EWS for an Exchange Online mailbox, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -EWSEnabled $True
```

To disable EWS for an Exchange Online mailbox, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -EWSEnabled $False
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).