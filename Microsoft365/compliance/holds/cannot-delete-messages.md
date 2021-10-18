---
title: Litigation Hold users cannot delete messages in Office 365 Dedicated
description: Describes mailbox performance issues that occur when the Litigation Hold feature is enabled for users in Office 365 Dedicated who are in an Exchange Online environment. Provides resolutions.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- CSSTroubleshoot
- 'Associated content asset: 4555317'
ms.reviewer: benjak
appliesto: 
- Microsoft Business Productivity Online Dedicated
- Microsoft Business Productivity Online Suite Federal
- Exchange Online
search.appverid: MET150
---

# Litigation Hold users cannot delete messages in Office 365 Dedicated

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;2617079

## Symptoms

When the Litigation Hold feature is enabled for users in Microsoft Office 365 Dedicated in a Microsoft Exchange Online environment, users may experience performance issues. For example, a user may be unable to empty the Deleted Items folder, delete mailbox items, or create copies of changed items.

## Cause

This issue occurs when the Litigation Hold feature prevents email messages in the Recoverable Items folder from being deleted. When the Recoverable Items folder reaches the set quota, the customer receives a report of the user who is on litigation hold and the status of the Recoverable Items folder storage.

This issue may also occur if a request has been made to archive mailboxes for electronic discovery purposes.

## Resolution

To resolve this issue, follow these steps:

1. To review per-folder statistics for an affected mailbox, including a basic analysis of duplicate items, use the *-* IncludeAnalysis switch with the Get-MailboxFolderStatistics cmdlet. For example:

    ```powershell
    Get-MailboxFolderStatistics <UserIdentity> -IncludeAnalysis | ? {$_.name -like "Deletions" -or $_.name -like "Purges" -or $_.name -like "Versions" -or $_.name -like "Recoverable Items"} | FL Name,ItemsInFolder,FolderSize,*Subject*
    ```

    > [!NOTE]
    > This analysis includes a simple comparison of the message subject (non-normalized). Therefore, the more sophisticated de-duplication process may not eliminate all reported duplicates.

1. If the total size of the Recoverable Items folder is more than 30 gigabytes (GB), the HoldCleanup parameter in the Start-ManagedFolderAssistant  cmdlet should be run to delete possible duplicated content. Customer administrators who are members of the User MRM Management (Exchange Server 2010) or SSA-Records Management (Exchange Server 2013) can run this command, as follows:

    ```powershell
    Start-ManagedFolderAssistant <UserIdentity> -HoldCleanup
    ```

If neither of these options addresses the problem, a customer can increase the recoverable items quota of a mailbox as follows.

Exchange 2013

Administrators can update the provisioning attribute to one of the available EP1DA or EP2D plans for increased dumpster/recoverable items quotas of 200 GB:

```console
MBX=5GB;TYPE=EP1DA_Dumpster
MBX=25GB;TYPE=EP1DA_Dumpster
MBX=50GB;TYPE=EP1DA_Dumpster
MBX=5GB;TYPE=EP2D_Dumpster
MBX=25GB;TYPE=EP2D_Dumpster
MBX=50GB;TYPE=EP2D_Dumpster
```

For more information about mailbox plans and quotas, see [Mailbox is over the size limit or is not configured to use the appropriate mailbox quotas in Office 365 Dedicated](https://support.microsoft.com/help/2673366).

Exchange 2010

Please escalate the case to Microsoft.
