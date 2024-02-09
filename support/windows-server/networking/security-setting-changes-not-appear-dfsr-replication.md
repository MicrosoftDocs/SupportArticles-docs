---
title: Security setting changes on folders don't appear immediately on replication partners
description: Describes the delays on DFSR replication partners after security setting changes on folders.
ms.date: 06/27/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dfsr, csstroubleshoot
---
# Security setting changes on folders don't appear immediately on DFSR replication partners

This article provides a workaround for the delays on DFSR replication partners after security setting changes on folders.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3212430

## Symptoms

Assume that you have the Distributed File System (DFS) Replication role service installed in Windows Server 2012 R2, Windows Server 2016 or Windows Server, version 1709, Windows Server Standard, version 1803 or Windows Server Datacenter, version 1803. When you change the security settings of a folder through Windows Explorer, the change appears only on replication partners for subordinate files but not immediately on the folder itself or its subfolders.

For example, if you grant a user Modify permissions to a folder on a domain controller, the user can access the files on a replication partner only under the folder. The user does not immediately have permissions to access the folders (parent folder and subfolders).

> [!NOTE]
> The changes appear on replication partners for the folders after 7 to 10 minutes.

## Cause

This issue occurs because when you make folder security changes remotely or locally, there's a delay before the redirector sends the **Close** statement for the parent folder. Therefore, the receiving NTFS driver doesn't immediately stamp the change with a USN Close statement in the NTFS Journal for the DFSR USN consumer.

## Workaround

To work around this issue, use one of the following methods:

- Avoid changing folder permissions remotely even if you use Windows Server Core Edition. Instead, make security changes on the target itself. You may also consider having at least two domain controllers with GUI implemented one with the primary domain controller (PDC) emulator operations master (also known as flexible single master operations or FSMO) role for introducing the changes locally, and one as potential backup for this operations master role.
- On the server on which you use Windows Explorer to make security setting changes, create the **NoRemoteRecursiveEvents** and the **NoRemoteChangeNotify** registry entries, and set the registry value to **1** in one of the following registry subkeys:
  - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`
  - `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`

    > [!NOTE]
    > You must restart the computer to make these registry entries work.
