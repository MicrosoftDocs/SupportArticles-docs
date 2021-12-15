---
title: How to increase or customize Exchange Online mailbox size
description: Describes how to increase Exchange Online mailbox size and use PowerShell to customize mailbox size in the Microsoft 365 environment.
manager: dcscontentpm
audience: ITPro
ms.topic: how-to
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto: 
- Exchange Online
search.appverid: MET150
ms.reviewer: meerak
author: simonxjx
ms.author: v-six
ms.service: exchange-online
---

# Increase or customize Exchange Online mailbox size

_Original KB number:_ &nbsp; 2490230

As a tenant administrator, if a user who you're supporting runs out of storage space in their Exchange Online mailbox and would like to increase its size, you'll need to assign them a different subscription license. This is because the size of an Exchange Online mailbox is determined by the subscription license associated with it. For more information about the mailbox size for different types of licenses, see [Mailbox Storage Limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#mailbox-storage-limits).

## Increase mailbox size

To increase a specific user's mailbox size, select **Diag: Mailbox or message size** to launch a diagnostic in the Microsoft 365 admin center, which will guide you through the process to assign a different subscription license for the user.

>[!div class="nextstepaction"]
>[Diag: Mailbox or message size](https://aka.ms/PillarMailboxSize)

## Customize mailbox size

Sometimes you might have a requirement to limit the size of a mailbox (also known as quota) even if the user's license allows for a larger size. For example, if a user is licensed for a mailbox size of 50 gigabytes (GB), you might need to limit its use to a quota of 20 GB.

To set a custom mailbox quota for Exchange Online mailboxes, use one of the following methods.

### Set mailbox quota for a single user

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Run the following PowerShell cmdlet:  

    ```powershell
    Set-Mailbox <UserID> -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```

    In this cmdlet, the \<User ID\> placeholder represents a mailbox user's UPN, email address, or GUID, and the \<Value\> placeholder represents a number in megabytes (MB), kilobytes (KB), or gigabytes (GB) for the custom size or quota you want to use.

    For example, to set the values for the `ProhibitSend`, `ProhibitSendReceive`, and `IssueWarningQuota` parameters to 19 GB, 20 GB, and 18 GB respectively for a mailbox, the syntax of the cmdlet will be:

    ```powershell
    Set-Mailbox JDoe@contoso.com -ProhibitSendQuota 19GB -ProhibitSendReceiveQuota 20GB -IssueWarningQuota 18GB
    ```

1. Check that the current list of quotas is attached to the mailbox by running the following PowerShell cmdlet:

    ```powershell
    Get-Mailbox <User ID> | Select *quota*
    ```

### Set mailbox quota for all users in an organization

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Run the following PowerShell cmdlet:  

    ```powershell
    Get-Mailbox | Set-Mailbox -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```

    You can apply filters to the `Get-Mailbox` cmdlet or to the `Get-User` cmdlet to specify a subset of users for whom the change needs to be applied. In the following example, three cmdlets are used to filter the command to set a quota only for users in the Sales department of an organization:

    ```powershell
    Get-User | where {$_.Department -eq "Sales"} | Get-Mailbox | Set-Mailbox -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```
