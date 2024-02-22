---
title: Increase or customize Exchange Online mailbox size
description: Describes how to make space in an Exchange Online mailbox that is full.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.reviewer: meerak, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---

# Increase or customize Exchange Online mailbox size

_Original KB number:_ &nbsp; 2490230

As a tenant administrator, if one of your users runs out of storage space in their Exchange Online mailbox, and they want to increase its size, you'll have to assign a different subscription license to them. This is because the size of an Exchange Online mailbox is determined by the subscription license that's associated with it. For more information about the mailbox size for different types of licenses, see [Mailbox Storage Limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#mailbox-storage-limits).

## Increase mailbox size

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

To increase a specific user's mailbox size, select the button below to launch a diagnostic in the Microsoft 365 admin center. The diagnostic will guide you through the process of assigning a different subscription license to the user.

>[!div class="nextstepaction"]
>[Run Tests: Mailbox or message size](https://aka.ms/PillarMailboxSize)

## Customize mailbox size

You might have a requirement to limit the size of a specific mailbox (also known as assigning a quota) even if the user's license allows a larger size. For example, if a user is licensed for a mailbox that's 50 gigabytes (GB), you might have to assign a quota of 20 GB to that mailbox.

To set a custom mailbox quota for Exchange Online mailboxes, use one of the following methods.

### Set mailbox quota for a single user

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Run the following PowerShell cmdlet:

    ```powershell
    Set-Mailbox <UserID> -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```

    In this cmdlet, the \<User ID\> placeholder represents a mailbox user's UPN, email address, or GUID, and the \<Value\> placeholder represents a number in megabytes (MB), kilobytes (KB), or gigabytes (GB) for the custom size or quota that you want to use.

    For example, to set the values for the `ProhibitSend`, `ProhibitSendReceive`, and `IssueWarningQuota` parameters to 19 GB, 20 GB, and 18 GB, respectively, for a mailbox, the syntax of the cmdlet will be as follows:

    ```powershell
    Set-Mailbox JDoe@contoso.com -ProhibitSendQuota 19GB -ProhibitSendReceiveQuota 20GB -IssueWarningQuota 18GB
    ```

1. Check whether the current list of quotas is attached to the mailbox. To do this, run the following PowerShell cmdlet:

    ```powershell
    Get-Mailbox <User ID> | Select *quota*
    ```

### Set mailbox quota for all users in an organization

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Run the following PowerShell cmdlet:  

    ```powershell
    Get-Mailbox | Set-Mailbox -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```

    You can apply filters to the `Get-Mailbox` cmdlet or `Get-User` cmdlet to specify a subset of users for whom the change has to be applied. In the following example, three cmdlets are used to filter the command to set a quota for only users in the Sales department of an organization:

    ```powershell
    Get-User | where {$_.Department -eq "Sales"} | Get-Mailbox | Set-Mailbox -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```
