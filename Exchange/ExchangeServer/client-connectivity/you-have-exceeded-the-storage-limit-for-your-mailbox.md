---
title: You've exceeded the storage limit for your mailbox error
description: Describes an issue in which user cannot sign in to Outlook on the in Exchange Server 2016 or 2013 when the mailbox size exceeds its quota.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: kekici, briant, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# You've exceeded the storage limit for your mailbox error when signing in to Outlook on the Web

_Original KB number:_ &nbsp; 2958940

## Summary

A user can't sign in to Outlook on the Web in Exchange Server 2016 or Exchange Server 2013 when the mailbox size exceeds its quota. During the logon attempt, the user receives the following message on the logon page:

> Something went wrong
>
> You've exceeded the storage limit for your mailbox. Delete some items from your mailbox."  
> more detail...  
> refresh the page

When the user selects the **more detail** link, the user receives the following information:

> X-OWA-Error: Microsoft.Exchange.Data.Storage.QuotaExceededException  
X-OWA-Version: 15.0.775.32  
X-FEServer: E15  
X-BEServer: E15  
Date: *DateTime*

After the user selects the refresh the page link, they can sign in to Outlook Web App successfully.

This article is intended for use by support agents and IT professionals. If you're looking for more information about Outlook.com errors, see [Frequently Asked Questions for Outlook.com](https://answers.microsoft.com/en-us/outlook_com/forum/opreview-opemail/frequently-asked-questions-for-outlookcom-preview/bfba4529-2ca3-4b50-895d-03eac9fa83bd?auth=1).

## Cause

This behavior is by design in Exchange Server 2016 and Exchange Server 2013.

This behavior may occur when the user mailbox is not configured completely at the first logon. During first logons, Exchange Server configures attributes in the database and in Active Directory for the specified mailboxes. The behavior is correct in the following scenarios:

- The mailbox moved from a legacy server and it is over the mailbox quota.
- The mailbox is a newly created mailbox and it is over the mailbox quota.

## Workaround - Method 1

Select the **refresh the page** link on the logon page.

## Workaround - Method 2

Increase the mailbox quota for first logon, and revert it if necessary.

For identifying the current size and quota size of the problematic mailbox, use the following Windows PowerShell cmdlet:

```powershell
Get-MailboxStatistics -Identity <User> |FL displayname,totalitemsize
```

For increasing the mailbox quota temporarily, use the following cmdlet. We use 2.1 gigabytes (GB) as a sample value. This value should be larger than `TotalItemSize`.

```powershell
Set-Mailbox -Identity <User> -ProhibitSendReceiveQuota 2.1GB -ProhibitSendQuota 2.1GB -IssueWarningQuota 2.1GB
```

If you are using the default quota from the database object, you have to disable the default quota for the specified mailbox. To do this, use the following cmdlet:

```powershell
Set-Mailbox -Identity <User> -ProhibitSendReceiveQuota 2.1GB -ProhibitSendQuota 2.1GB -IssueWarningQuota 2.1GB -UseDatabaseQuotaDefaults $false
```

With the `Set-Mailbox` cmdlet mentioned previously, we have configured the mailbox with additional space to establish first logons. After first logon, you can revert the settings. Setting up a default quota will be enough. You can use the following cmdlet to configure the default quota for specified mailbox:

```powershell
Set-Mailbox -Identity <User> -UseDatabaseQuotaDefaults $true
```
