---
title: Could not find database error when running cmdlets for different region mailbox
description: Discusses an issue in which you can't run cmdlets for a mailbox that's hosted in another region, and you receive a Couldn't find database error.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Exchange Online
- Exchange
- Outlook
search.appverid: MET150
ms.reviewer: kellybos, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# "Couldn't find database" error when you run cmdlets for a mailbox hosted in a different Exchange Online region

## Symptoms

Assume that you are an account administrator. When you try to run the `New-MailboxSearch`, `Search-MailboxAuditLog`, `New-MailboxImportRequest`, or `New-MailboxRestoreRequest` cmdlet for a mailbox that's hosted in a different region from your account region, you receive one of the following error messages:

> Couldn't find database "\<database>". Make sure you have typed it correctly.

> Can't connect to the mailbox of user Mailbox database guid \<GUID> because the ExchangePrincipal object contains outdated information. The mailbox may have been moved recently.

However, in this scenario, you can do the following actions:

- You can successfully run these cmdlets for a mailbox that's hosted in the same region as your account region.
- You can successfully run other cmdlets, such as `Set-CalendarProcessing` or `Get-Mailbox`, for mailboxes that are hosted in a different region.

## Cause

These cmdlets fail for mailboxes that are in a different region from the region in which the administrator account is located. An administrator account may have a mailbox in a particular region, or the account may be a mail-enabled user account that may connect to the arbitration mailboxes in the default region.

## Workaround

To work around this issue, you can force a connection to another region by changing the value of the `ConnectionUri` parameter when you use the `New-PSSession` cmdlet. For example, you can run the following cmdlet:

```ps
New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid?email=alias@contoso.com-Credential $UserCredential -Authentication Basic -AllowRedirection
```

The appended email address in the `ConnectionUri` parameter should be for a mailbox that's in the region for which you want to run the `New-MailboxSearch`, `Search-MailboxAuditLog`, `New-MailboxImportRequest`, or `New-MailboxRestoreRequest` cmdlet.

For example, if your mailbox is in the **European Union** region, and you want to run the cmdlet against a mailbox in the **United States** region, you have to locate a mailbox in the **United States** region (it can be any mailbox in that region), and then append the email address of that mailbox to the `ConnectionUri` parameter. To be able to do this, you don't have to have special permissions to the **United States** mailbox. Appending the email address forces the connection to be made in the **United States** region. This enables the cmdlets to be run successfully for a **United States** mailbox.
