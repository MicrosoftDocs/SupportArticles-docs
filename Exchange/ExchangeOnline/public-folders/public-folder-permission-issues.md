---
title: How to diagnose and fix public folder permission issues
description: This article helps you diagnose and fix public folder permission-related issues.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 115162
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# How to diagnose and fix public folder permission issues

## Symptoms

In Exchange Online, you cannot do specific tasks such as creating or deleting items or subfolders in a public folder. Additionally, you may receive an error message that indicates this is a permission-related issue.

## Cause

This issue typically occurs because the public folder hierarchy replication isn't completed or is having problems.

## Troubleshooting steps

1. Verify the public folder mailbox that is assigned to the user. To do this, run the following command (for example):

    ```powershell
    Get-Mailbox -Identity User1 | Format-List *public*
    ```

2. Verify that the public folder permission is replicated to the public folder mailbox that is assigned to the user. To do this, follow these steps:

    a) Check permissions on primary hierarchy public folder mailbox first. To do this, run the following cmdlet (for example):

    ```powershell
    Get-PublicFolderClientPermission \puf1 -User User1 -Mailbox (Get-Mailbox -PublicFolder | ?{$_.IsRootPublicFolderMailbox -eq "True"}).Name
    ```

    b) Check the permissions on the folder for the user on the public folder mailbox that you got from step 1 (for example).

    ```powershell
    Get-PublicFolderClientPermission "\puf1" -User User1 -Mailbox pubmbx1
    ```

    This cmdlet returns the following output:

    ```output
    There is no existing permission entry found for user: user1.
        + CategoryInfo          : NotSpecified: (:) [Get-PublicFolderClientPermission], UserNotFoundInPermissionEntryExcep
       tion
        + FullyQualifiedErrorId : [Server=<*ServerName*>,RequestId=<*RequestId*>,TimeStamp=3/19/2020
        5:22:40 AM] [FailureCategory=Cmdlet-UserNotFoundInPermissionEntryException] 91D3F338,Microsoft.Exchange.Managemen
      t.StoreTasks.GetPublicFolderClientPermission
    + PSComputerName        : outlook.office365.com
    ```

    The output indicates the permissions aren't yet replicated to the public folder mailbox that's assigned to the user. In some cases, the permission may appear, but it will be different from the permission that is returned in step 2b.

## Resolution

To fix this issue, manually replicate the permissions to public folder mailbox assigned on the user by running the following cmdlet (for example):

```powershell
Update-PublicFolderMailbox pubmbx1 -InvokeSynchronizer
```

Then, verify the permissions again by repeating the cmdlet:

```powershell
Get-PublicFolderClientPermission \puf1 -User User1 -Mailbox pubmbx1
```

> [!NOTE]
> It might take several minutes to show the permission change.

## More Information

If the permissions are still not synchronized or you meet an error when you force hierarchy synchronization, follow these steps to get hierarchy synchronization logs:

1. Compare the hierarchy between public folder mailboxes:

    ```powershell
    $P=Get-PublicFolderMailboxDiagnostics <Primary_pfmailboxname> -IncludeHierarchyInfo
    $S= Get-PublicFolderMailboxDiagnostics <pfmailboxname_notreceiving_hierarchy> -IncludeHierarchyInfo
    ```

2. Compare the output of "HierarchyInfo" from both mailboxes:

    ```powershell
    $p.HierarchyInfo
    $s.HierarchyInfo
    ```

3. If you determine that the hierarchy information isn't the same, run the following command to view the time of the last sync:

    ```Powershell
    $s.SyncInfo.LastAttemptedSyncTime.LocalTime
    ```

    This command indicates the last time that the sync failed. A nonsense value indicates that sync has never failed.

    ```Powershell
    $s.SyncInfo.LastFailedSyncTime.LocalTime
    ```

    The following command provides a detailed failure message from the last sync failure. A blank output indicates that sync has never failed:

    ```Powershell
    $s.SyncInfo.LastSyncFailure
    ```

    You can also explore other values such as AssistantInfo and HierarchyInfo blocks.

If you have to contact Microsoft Support, export the report to XML format, and then send it to the Support agent. To export the report, run the following command (for example):

```powershell
Get-PublicFolderMailboxDiagnostics <pf mailbox failing to sync> -IncludeHierarchyInfo |Export-Clixml epf.xml
```
