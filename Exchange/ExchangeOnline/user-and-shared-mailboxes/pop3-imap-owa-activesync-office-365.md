---
title: Enable or disable POP3, IMAP, MAPI, Outlook Web App or ActiveSync in Microsoft 365
description: Describes how to enable or disable POP3, IMAP, MAPI, Outlook Web App or ActiveSync in Microsoft 365.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Enable or disable POP3, IMAP, MAPI, Outlook Web App or Exchange ActiveSync in Microsoft 365

This article introduces the PowerShell commands that you can use to enable or disable the following items for a mailbox in Exchange Online:

- Post Office Protocol (POP)
- Internet Message Access Protocol (IMAP)
- Messaging Application Programming Interface (MAPI)
- Outlook on the web
- Microsoft Exchange ActiveSync

> [!NOTE]
> Before you run any of the commands in the following steps, first [connect to Exchange Online by using remote PowerShell](/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell).

> [!CAUTION]
> Protocol access follows the authenticated user not the mailbox.  Therefore, disabling any protocol on a shared mailbox will not prevent users that have that protocol enabled from accessing the shared mailbox.
## Enable or disable POP3 for an Exchange Online mailbox

To enable POP3 for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias,Primary SMTP, or UPN> -PopEnabled $True
```

To disable POP3 for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -PopEnabled $False
```

## Enable or disable IMAP for an Exchange Online mailbox

To enable IMAP for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -ImapEnabled $True
```

To disable IMAP for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -ImapEnabled $False
```

## Enable or disable MAPI for an Exchange Online mailbox

To enable MAPI for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -MAPIEnabled $True
```

To disable MAPI for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -MAPIEnabled $False
```

To use the Exchange admin center, see [Enable or disable MAPI for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/enable-or-disable-mapi).

## Enable or disable Outlook on the web for an Exchange Online mailbox

To enable Outlook on the web for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -OWAEnabled $True
```

To disable Outlook on the web for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -OWAEnabled $False
```

To use the Exchange admin center, see [Enable or disable Outlook on the web for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/enable-or-disable-outlook-web-app).

## Enable or disable Exchange ActiveSync for an Exchange Online mailbox

To enable Exchange ActiveSync for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -ActiveSyncEnabled $True
```

To disable Exchange ActiveSync  for a specific user, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -ActiveSyncEnabled $False
```

To use the Exchange admin center, see [Enable or disable Exchange ActiveSync for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/enable-or-disable-exchange-activesync).

## Enable or disable Exchange Web Services (EWS) for an Exchange Online mailbox

To enable EWS for an Exchange Online mailbox, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -EWSEnabled $True
```

To disable EWS for an Exchange Online mailbox, run the following cmdlet:

```powershell
Set-CASMailbox <Alias, Primary SMTP, or UPN> -EWSEnabled $False
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
