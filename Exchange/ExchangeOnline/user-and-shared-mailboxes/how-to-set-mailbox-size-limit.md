---
title: How to increase and set Exchange Online mailbox sizes and limits in Microsoft 365
description: Describes how to use Exchange Online PowerShell to increase and set mailbox sizes and limits in the Microsoft 365 environment.
manager: dcscontentpm
audience: ITPro
ms.topic: how-to
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto: Exchange Online
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six; jhayes
ms.service: exchange-online 
---

# How to increase and set Exchange Online mailbox sizes in Microsoft 365

_Original KB number:_ &nbsp; 2490230

## Introduction

This article describes how to increase mailbox sizes and use Exchange Online PowerShell to set Exchange Online mailbox sizes and limits in the Microsoft 365 environment.

The size of the Exchange Online mailbox is determined by the mailbox type and the user's subscription license. See [Mailbox Storage Limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#mailbox-storage-limits) for more information. To permanently increase the mailbox size, a user should be assigned an Exchange Online license that includes larger mailbox size. Microsoft has created an automated diagnostic that will guide you in what you need to do for a particular user to increase their mailbox size. Select the following button to populate the diagnostic in the Microsoft 365 admin center.

>[!div class="nextstepaction"]
>[Diag: Mailbox or Message Size](https://aka.ms/PillarMailboxSize)

As an administrator, you also have an option to set mailbox sizes (also known as quotas) to a lower value than the assigned user license allows. So, for example, if your users are licensed for a 50 gigabytes (GB) mailbox size, you can set a custom limit of 20 GB if your business requires it.

## Set custom mailbox size limits

To set custom mailbox size limits for Exchange Online mailboxes, use one of the following methods.

### Set mailbox size limits for a single user

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following PowerShell cmdlet to set the mailbox size for a single user:  

    ```powershell
    Set-Mailbox <UserID> -ProhibitSendQuota < Value > -ProhibitSendReceiveQuota < Value > -IssueWarningQuota <Value>
    ```

    > [!NOTE]
    > In this cmdlet, the \<User ID\> placeholder represents a mailbox user's UPN, email address, or GUID, and the \<Value\> placeholder represents a number in megabytes (MB), kilobytes (KB), or gigabytes (GB).

    For example, to set a mailbox size to 20 GB, to set the send limit at 19 GB, and to issue a warning at 18 GB, run the following cmdlet:

    ```powershell
    Set-Mailbox JDoe@contoso.com -ProhibitSendQuota 19GB -ProhibitSendReceiveQuota 20GB -IssueWarningQuota 18GB
    ```

3. To check that the current list of quotas is attached to the mailbox, run the following cmdlet:

    ```powershell
    Get-Mailbox <User ID> | Select *quota*
    ```

### Set mailbox size limits for multiple users

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following PowerShell cmdlet to set the mailbox size for all the users in an organization:  

    ```powershell
    Get-Mailbox | Set-Mailbox -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```

    Additional filters can be applied to the `Get-Mailbox` cmdlet or to the `Get-User` cmdlet to control the users for whom the change is applied. The following is an example in which three parameters are used to filter the cmdlet to the sales department of an organization:

    ```powershell
    Get-User | where {$_.Department -eq "Sales"} | Get-Mailbox | Set-Mailbox -ProhibitSendQuota <Value> -ProhibitSendReceiveQuota <Value> -IssueWarningQuota <Value>
    ```

## Set Microsoft 365 group mailbox quota

To view the current size of a Microsoft 365 group mailbox and increase its quota, follow these steps:

### View Microsoft 365 group mailbox size

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following PowerShell cmdlet to view the current size of the Microsoft 365 Group mailbox.

    - To view a specific group mailbox:

        ```powershell
         Get-Mailbox -GroupMailbox <name of the group> | Get-MailboxStatistics | fl TotalDeletedItemSize,TotalItemSize
        ```

    - To view all group mailboxes:

        ```powershell
         Get-Mailbox -GroupMailbox -ResultSize unlimited | Get-MailboxStatistics | ft DisplayName,TotalDeletedItemSize,TotalItemSize
        ```

### Increase Microsoft 365 group mailbox quota

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following PowerShell cmdlet to change the Microsoft 365 Group mailbox's quota to 100 GB.

    ```powershell
     Set-Mailbox <group mailbox name> -GroupMailbox -ProhibitSendReceiveQuota 100GB -ProhibitSendQuota 95GB
    ```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
