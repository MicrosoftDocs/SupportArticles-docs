---
title: NTFRS_xxxxxxxx is added to a folder name
description: Helps fix an issue where File Replication service (FRS) adds "NTFRS_xxxxxxxx" to a folder name.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:frs, csstroubleshoot
---
# Folder name is changed to "FolderName_NTFRS_\<xxxxxxxx>"

This article provides help to fix an issue where File Replication service (FRS) adds "NTFRS_**xxxxxxxx**" to a folder name.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016  
_Original KB number:_ &nbsp; 328492

## Symptoms

File Replication service (FRS) might change the name of a folder by adding "NTFRS_ **xxxxxxxx**" to the folder name.

> [!NOTE]
> In this example, **xxxxxxxx** represents eight random hexadecimal digits.

The following table shows how FRS might change the names of two folders:

| Original filename | New filename |
| --- | --- |
| `07/29/2002 09:58a Policies` | `07/29/2002 09:58a Policies_NTFRS_000add30` |
| `07/29/2002 10:18a scripts` | `07/29/2002 10:02p scripts_NTFRS_000874bb` |

> [!NOTE]  
> FRS has been deprecated in newer versions of Windows Server. For more information about moving to a newer solution, see the following articles:
>  
> - [Windows Server version 1709 no longer supports FRS](windows-server-version-1709-no-longer-supports-frs.md)
> - [Migrate SYSVOL replication to DFS Replication](/windows-server/storage/dfs-replication/migrate-sysvol-to-dfsr)

## Cause

When two users each create a folder on a separate replica, and the folders have the same name, File Replication service (FRS) detects a name conflict during replication.

One of the create operations takes precedence, and that folder retains the name. FRS changes the name of the other folder.

There are two common causes of this problem:

- A folder is created on multiple members of the replica set before the folder can replicate. The administrator or program might create duplicate folders on multiple FRS members. This might occur, for example, if the administrator tries to make data consistent among all members by copying folders manually.

- You initiate an authoritative restore (D4) on one server and don't perform the following preparations:  

  - Stop the service on all other members of the reinitialized replica set before the NTFRS service restarts after the authoritative restore.

  - Set the D2 registry key on all other members of the reinitialized replica set before such a server replicated outbound changes to reinitialized members of the replica set.

## Resolution

> [!NOTE]  
> Group policy processing for affected folders doesn't work during the clean-up process. This is because the UNC path in the policy doesn't match the folder name.

To resolve this problem, follow these steps:

1. Rename the original folders and the changed folders to different names, and then wait for the new names to propagate through the system.

    This makes sure the folder then has a common name throughout the SYSVOL, and that the names and GUIDs match on all members.

    > [!NOTE]
    > Do not delete the undesirable folder and rename the other one. This can lead to even more naming conflicts.

2. After the rename propagates, choose the folder that you want to keep, and then rename it back to the original name. Then you can safely delete the other changed folders.

    > [!NOTE]
    > Before you delete any of the folders, it is a best practice to make sure that you have a backup of the original (and complete) data.

## More information

All files and folders that FRS manages are uniquely identified by a special file ID that's called a file GUID. FRS uses file GUIDs as the canonical identifiers of files and folders that are being replicated.

FRS tries to make sure that the GUID for each file or folder is exactly the same on all members of the replica set. To FRS, the file or folder name that's visible in Windows Explorer or in the output of the `DIR` command is just a property of a file or folder. The name and path don't identify the file. The GUID identifies the file.

If an FRS member receives a change order to create a folder whose name already exists but has a different file GUID than the pre-existing folder, FRS detects a naming conflict. Because the file GUIDs for the two folders are different, it can't be a change to the existing folder. In this case, the conflicting folder is given a new name of the form **FolderName** _NTFRS_ **GUIDname**.

> [!NOTE]
> In this example, **FolderName** is the original name of the folder and **GUIDname** is a unique XX character string such as "001a84b2."
