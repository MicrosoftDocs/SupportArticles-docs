---
title: How to set Exchange Online mailbox sizes
description: Describes how to use Exchange Online PowerShell to increase and set mailbox sizes and limits in the Microsoft 365 environment.
manager: dcscontentpm
audience: ITPro
ms.topic: how-to
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto: 
- Exchange Online
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.service: exchange-online
---

# How to set Exchange Online mailbox sizes

_Original KB number:_ &nbsp; 2490230

## Introduction

This article describes how to increase mailbox sizes and use Exchange Online PowerShell to set Exchange Online mailbox sizes in the Microsoft 365 environment.

Exchange Online mailbox sizes are determined by the subscription license. To permanently increase a user's mailbox size, the user should be assigned an Exchange Online license that has a larger mailbox size. For more information, see [Mailbox Storage Limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#mailbox-storage-limits). In the Microsoft 365 admin center, an [automated diagnostic](https://aka.ms/PillarMailboxSize) is available to help increase a user's mailbox size.

Administrator also has an option to set a lower mailbox size (also known as quota) than the assigned license allows. For example, if a user is licensed for a 50 gigabytes (GB) mailbox size, the size can be set to a custom quota of 20 GB.

## Set a custom mailbox size

To set a custom mailbox size for Exchange Online mailboxes, use one of the following methods.

### Set mailbox size for a single user

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. To set the mailbox size for a single user, run the following PowerShell cmdlet:  

    ```powershell
    Set-Mailbox <UserID> -ProhibitSendQuota < Value > -ProhibitSendReceiveQuota < Value > -IssueWarningQuota <Value>
    ```

    > [!NOTE]
    > In this cmdlet, the \<User ID\> placeholder represents a mailbox user's UPN, email address, or GUID, and the \<Value\> placeholder represents a number in megabytes (MB), kilobytes (KB), or gigabytes (GB).

    For example, run the following cmdlet to set the prohibit send, prohibit send and receive, and custom warning quotas to 19 GB, 20 GB, and 18 GB respectively for a mailbox:

    ```powershell
    Set-Mailbox JDoe@contoso.com -ProhibitSendQuota 19GB -ProhibitSendReceiveQuota 20GB -IssueWarningQuota 18GB
    ```

To check the quota of a mailbox, run the following cmdlet:

```powershell
Get-Mailbox <User ID> | Select *quota*
```

### Set mailbox size for multiple users

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. To set the mailbox size for all the users in an organization, run the following PowerShell cmdlet:  

    ```powershell
    Get-Mailbox | Set-Mailbox -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```

    You can set the mailbox size for filtered users. For example, set the mailbox size for the users in the sales department:

    ```powershell
    Get-User | where {$_.Department -eq "Sales"} | Get-Mailbox | Set-Mailbox -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```

## Set a Microsoft 365 group mailbox size

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. To set the Microsoft 365 group mailbox's size, run the following PowerShell cmdlet:

    ```powershell
    Set-Mailbox <group mailbox name> -GroupMailbox -ProhibitSendReceiveQuota <Value> -ProhibitSendQuota <Value>
    ```

    For example, set the group mailbox's prohibit send and receive, and prohibit send quotas to 100 GB and 95 GB.

    ```powershell
    Set-Mailbox <group mailbox name> -GroupMailbox -ProhibitSendReceiveQuota 100GB -ProhibitSendQuota 95GB
    ```

To check the size of a group mailbox or group mailboxes, run the following PowerShell cmdlet:

- To view a specific group mailbox:

    ```powershell
    Get-Mailbox -GroupMailbox <name of the group> | Get-MailboxStatistics | fl TotalDeletedItemSize,TotalItemSize
    ```

- To view all group mailboxes:

    ```powershell
    Get-Mailbox -GroupMailbox -ResultSize unlimited | Get-MailboxStatistics | ft DisplayName,TotalDeletedItemSize,TotalItemSize
    ```
