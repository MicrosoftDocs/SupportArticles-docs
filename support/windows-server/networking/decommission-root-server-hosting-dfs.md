---
title: Decommission root server hosting domain-based DFS root
description: Explains how to manually decommission a root server that hosts a domain-based DFS root in Windows Server 2003.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Manually decommission a root server that hosts a domain-based DFS root in Windows Server 2003

This article discusses how to decommission a root server that hosts a domain-based Microsoft Distributed File System (DFS) root in Microsoft Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 842218

## More information

To decommission a root server that hosts a domain-based DFS root, follow these steps:  

1. Remove the root server from the DFS namespace. To do this:  

   - Use the Distributed File System snap-in to remove the root server from the DFS namespace. To do this:
     1. Click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **Distributed File System**.

     2. In the left pane, click the DFS root that is to be removed.
     3. In the right pane, right-click the root target that you want to remove, and then click **Remove Target**.

     4. Click **Yes**.
     5. Close the DFS snap-in.

   - Use the version of the DFS utility (Dfsutil.exe) that is included in the Windows Server 2003 Support Tools to remove the root server from the DFS namespace. To do this, follow these steps.

        > [!NOTE]
        > To install the DFS utility that is included in the Windows Server 2003 Support Tools, right-click **Suptools.msi** in the Support\Tools folder on the Windows Server 2003 CD-ROM, and then click **Install**.

        1. Click **Start**, click **Run**, type cmd in the **Open** box, and then click **OK**.
        2. Type the following command, and then press ENTER:  
        `Dfsutil /UnmapFtRoot /Root:DFS root /Server: RootTargetServer /Share:DFS share name`

        > [!NOTE]
        > **RootTargetServer** refers to the root server that is to be decommissioned. Also, **DFS root** must be of the following form: **\\\DomainOrServer\RootName**.  

2. On the decommissioned root target, remove DFS information from the registry by using the following Dfsutil.exe command:  
`Dfsutil /Clean /Server:RootTargetServer /Share:DFS share name`

3. On the decommissioned root server, at a command prompt, type net stop dfs, and then press ENTER.
4. On the decommissioned root server, at a command prompt, type net start dfs, and then press ENTER.

    > [!NOTE]
    > After you remove a DFS root target, DFS stops giving referrals to the decommissioned server within 15 minutes of the update to the DFS Active Directory directory service object. The DFS Active Directory object resides on the local domain controller and is issued by the PDC emulator master. The time that the update can take depends on Active Directory replication schedules.
