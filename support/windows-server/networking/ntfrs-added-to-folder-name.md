---
title: NTFRS_xxxxxxxx is added to a folder name
description: Helps fix an issue in which File Replication Service (FRS) adds "NTFRS_xxxxxxxx" to a folder name.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:frs, csstroubleshoot
---
# Folder names are changed to "FolderName_NTFRS_\<xxxxxxxx>"

This article help you fix an issue in which File Replication Service (FRS) adds "NTFRS_**xxxxxxxx**" to folder names.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016  
_Original KB number:_ &nbsp; 328492

## Symptoms

When File Replication Service (FRS) is used to distribute shared files, FRS appends "NTFRS_ **xxxxxxxx**" to the folder names.

> [!NOTE]
> In this example, **xxxxxxxx** represents eight random hexadecimal digits.

The following table shows how FRS might change the names of two folders.

| Original folder name | New folder name |
| --- | --- |
| `07/29/2002 09:58a Policies` | `07/29/2002 09:58a Policies_NTFRS_000add30` |
| `07/29/2002 10:18a scripts` | `07/29/2002 10:02p scripts_NTFRS_000874bb` |

> [!NOTE]  
> FRS has been deprecated in newer versions of Windows Server. For more information about how to move to a newer solution, see the following articles:
>  
> - [Windows Server version 1709 no longer supports FRS](windows-server-version-1709-no-longer-supports-frs.md)
> - [Migrate SYSVOL replication to DFS Replication](/windows-server/storage/dfs-replication/migrate-sysvol-to-dfsr)

## Cause

If two users each create a folder on separate replicas, and the folders have the same name, FRS detects a name conflict during replication.

One of the create operations takes precedence, and that folder retains the original name. FRS changes the name of the other folder.

There are two common causes of this problem:

- A folder is created on multiple members of the replica set before the folder can replicate. The administrator or program might create duplicate folders on multiple FRS members. This might occur, for example, if the administrator tries to make data consistent among all members by copying folders manually.

- You initiate an authoritative restore (D4) on one server but you don't perform the following preparations:  

  - Stop the service on all other members of the reinitialized replica set before the NTFRS service restarts after the authoritative restore.

  - Set the D2 registry key on all other members of the reinitialized replica set before any server can replicate outbound changes to reinitialized members of the replica set.

## Resolution

> [!NOTE]  
> Group Policy processing for affected folders doesn't work during the clean-up process. This is because the UNC path in the policy doesn't match the folder name.

To resolve this problem, follow these steps:

1. Rename the original folders and the changed folders, and then wait for the new names to propagate throughout the system.

    This makes sure that the folder has a common name throughout the SYSVOL, and that the names and GUIDs match on all members.

    > [!NOTE]
    > Don't delete the undesired folder and then rename the other one. This can cause even more naming conflicts.

2. After the renaming propagates, choose the folder that you want to keep, and revert the name to the original name. Then, you can safely delete the other renamed folders.

    > [!NOTE]
    > Before you delete any folders, it's a best practice to make sure that you have a backup of the original (and complete) data.

## More information

All files and folders that FRS manages are uniquely identified by a file GUID. FRS uses file GUIDs as the canonical identifiers of files and folders that are being replicated.

FRS tries to make sure that the GUID for each file or folder is exactly the same on all members of the replica set. To FRS, the file or folder name that's visible in Windows Explorer or in the output of the `DIR` command is just a property of a file or folder. The name and path don't identify the file. The GUID identifies the file.

If an FRS member receives a change order to create a folder by using the name of an existing folder that has a different file GUID, FRS detects a naming conflict. Because the file GUIDs for the two folders differ, the existing folder name can't be changed. In this situation, the new folder is given a new name in the form of **FolderName** _NTFRS_ **GUIDname**.

> [!NOTE]
> In this example, **FolderName** is the original name and **GUIDname** is a unique XX character string, such as "001a84b2."
