---
title: ConflictAndDeleted folder size exceeds
description: Describes how to reduce the sizes of the ConflictAndDeleted folder and the ConflictandDeletedManifest.xml when using Windows Server DFSR.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, clandis, cdan
ms.custom: sap:dfsr, csstroubleshoot
ms.technology: networking
---
# The ConflictAndDeleted folder size may exceed its configured limitation

This article provides a resolution for the issue that the ConflictAndDeleted folder size may exceed its configured limitation.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 951010

## Symptoms

In Windows Server, the size of the ConflictAndDeleted folder may exceed its configured limitation. By default, the limitation of the ConflictAndDeleted folder is 660 megabytes (MB). When this problem occurs, the ConflictAndDeleted folder may exhaust available disk space on the volume on which the folder resides. Additionally, the Distributed File System (DFS) Replication service cannot replicate any files.

## Cause

This problem occurs because the ConflictAndDeletedManifest.xml file is corrupted. This file stores information about the current contents of the ConflictAndDeleted folder. The DFS Replication service writes to the ConflictAndDeletedManifest.xml file when files are added or removed from the ConflictAndDeleted folder.

## Resolution

To resolve this problem, use WMIC commands to delete the contents of the ConflictAndDeleted folder and the ConflictAndDeletedManifest.xml file.
Run the WMIC commands in a Command Prompt window (cmd.exe).
To clean up the ConflictAndDeleted folder content of a replicated folder, run the following command:  

```console
wmic /namespace:\\root\microsoftdfs path dfsrreplicatedfolderinfo where "replicatedfoldername='<ReplicatedFolderName>'" call cleanupconflictdirectory
```

> [!Note]
> In this command, \<ReplicatedFolderName> represents the name of the replicated folder.

To clean up the ConflictAndDeleted folder content of all of the replicated folders in a replication group, enter the following command:  

```console
wmic /namespace:\\root\microsoftdfs path dfsrreplicatedfolderinfo where "replicationgroupname='<ReplicationGroupName>'" call cleanupconflictdirectory
```

> [!Note]
> In this command,\<ReplicationGroupName> represents the name of the replication group.

> [!Note]
> If you have not run a WMIC command on the computer before, a short pause occurs while the computer installs WMIC.

Depending on the size of the ConflictAndDeleted folder, this process may take a few minutes. The process empties the ConflictAndDeleted folder and reduces or deletes the ConflictAndDeletedManifest.xml file.  

> [!Note]
> If any conflicts or deletions occur while **cleanupconflictdirectory** runs, the information that is related to those conflicts or deletions remains in the ConflictAndDeleted folder and the ConflictAndDeletedManifest.xml file when the process finishes.  After the cleanup, the file is much smaller, and the total size of the ConflictAndDeleted folder is less than the quota maximum mark.

## Status

Microsoft has confirmed that it is a problem in the Microsoft products that are listed in the "Applies to" section.
