---
title: NDR error 554 5.2.2 mailbox full when sending email to mail-enabled public folders
description: Email is not able to be delivered to mail-enabled public folders in Microsoft 365 with error 554 5.2.2 mailbox full. This article provides three resolutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 123399
  - CSSTroubleshoot
  - CI 167832
ms.reviewer: haembab, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# "554 5.2.2 mailbox full" when sending emails to a mail-enabled public folder

## Symptoms

A non-delivery report (NDR) is returned with error code 554 5.2.2 when sending emails to a mail-enabled public folder:  

> The recipient's mailbox is full and can't accept messages now. Please try resending this message later or contact the recipient directly.  
>
> Diagnostic information for administrators  
> Remote Server returned '554 5.2.2 mailbox full;  
STOREDRV.Deliver.Exception:QuotaExceededException.MapiExceptionQuotaExceeded'

## Cause

This issue occurs when any of these conditions is met:

- The organization's default public folder post quota (`DefaultPublicFolderProhibitPostQuota`) has been reached.
- The individual public folder post quota (`PublicFolderProhibitPostQuota`) has been reached.
- The Content Public Folder mailbox hosting the mail-enabled public folder has reached its quota.

## Resolution

Here's how to identify which quota has been reached and take corrective steps:

### Step 1: Check individual public folder quota

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Check the value of `TotalItemSize` for the affected mail-enabled public folder:

    ```powershell
    Get-PublicFolderStatistics \pfname | FL TotalItemSize
    ```

3. Check if the value of `TotalItemSize` has reached or exceeded the value of `ProhibitPostQuota`.

    ```powershell
    Get-PublicFolder \pfname | FL *quota*
    ```

    If that's the case, increase the `ProhibitPostQuota` value of that mail-enabled public folder or set it to **Unlimited**.

    > [!NOTE]
    > If the default value of `prohibitpostquota` is set to **Unlimited**, the value that was configured for `DefaultPublicFolderProhibitPostQuota` at the organization level applies. If the `PublicFolderProhibitPostQuota` value has been configured on the public folder, this value will take precedence over the value set at the organization level.

    For more information, read [Understanding modern public folder quotas](https://techcommunity.microsoft.com/t5/Exchange-Team-Blog/Understanding-modern-public-folder-quotas/ba-p/607463).

4. Check if the value of `TotalItemSize` has exceeded the value of `DefaultPublicFolderProhibitPostQuota`:

    ```powershell
    Get-OrganizationConfig | FL *quota*
    ```

    A `TotalItemSize` larger than `DefaultPublicFolderProhibitPostQuota` prevents mail-enabled public folders from accepting new emails.

Here are two ways to resolve this issue:

1. Increase the `ProhibitPostQuota` of the public folder at the user level if there are only a few affected public folders.

    ```powershell
    Set-PublicFolder \pfname -ProhibitPostQuota 5GB -IssueWarningQuota 4GB
    ```

2. Increase the `DefaultPublicFolderProhibitPostQuota` for all public folders at the organization level.

    ```powershell
    Set-OrganizationConfig -DefaultPublicFolderProhibitPostQuota 5GB -DefaultPublicFolderIssueWarningQuota 4GB
    ```

> [!NOTE]
> Avoid a large increase of the individual public folder `Prohibitpostquota`. Setting this value too high will impact the auto-split process negatively.

If this quota hasn't been exceeded, proceed to the next step.

### Step 2: Check the content public folder mailbox quota

If the public folder hasn't exceeded the individual or organizational quota as shown in Step 1, check if the public folder mailbox hosting the public folder content has exceeded its quota.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Find the content public folder mailbox's name for the mail-enabled public folder:

    ```powershell
    Get-PublicFolder \pfname |FL name, *content*
    ```

3. Check the value of `TotalItemSize` for the content public folder mailbox:

    ```powershell
    Get-MailboxStatistics pfmbx | FL TotalItemSize
    ```

4. Check if the value of `TotalItemSize` has exceeded the value of `ProhibitSendRecieveQuota`:

    ```powershell
    Get-Mailbox -PublicFolder pfmbx | FL *quota*
    ```

When a quota is reached, the auto-split process should create a new public folder mailbox and move some of that content to a newly created auto-split mailbox. To check that, run this command:

```powershell
Get-PublicFolder \pfname |Ft name, *content*
```

For more information, read the following Blog articles:

- [How Exchange Online automatically cares for your public folder mailboxes (via AutoSplit)](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-exchange-online-automatically-cares-for-your-public-folder/bc-p/2157425/emcs_t)
- [Public Folders and Exchange Online](https://techcommunity.microsoft.com/t5/exchange-team-blog/public-folders-and-exchange-online/ba-p/594318)

If the auto-split process failed to create a new mailbox, please submit a support request to Microsoft Support for further assistance.
