---
title: Use BurFlags to reinitialize File Replication Service (FRS)
description: This article talks about using the BurFlags registry key to reinitialize FRS.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:frs, csstroubleshoot
---
# Use the BurFlags registry key to reinitialize File Replication Service

This article discusses the FRS `BurFlags` registry key that the Microsoft Windows File Replication service (FRS) uses.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 290762

## Overview

FRS is a multi-threaded, multi-master replication engine that Windows Server domain controllers use to replicate system policies and logon scripts. You can also use FRS to replicate content between Windows Servers that host the same fault-tolerant Distributed File System (DFS) roots or child node replicas. In Windows Server 2008 R2 and newer, FRS can only be used to replicate the Domain `SYSVOL` replica set.

When you deploy Windows-based domain controllers or member servers that use FRS to replicate files in `SYSVOL` or DFS shares, you may have to restore or reinitialize individual members of a replica set if replication has stopped or is inconsistent. In some scenarios, you may have to rebuild the whole replica set from scratch.

The FRS `BurFlags` registry key is used to perform authoritative or nonauthoritative restores on FRS members of DFS or `SYSVOL` replica sets.

> [!NOTE]
> System state backups of Windows member servers and domain controllers do not include the FRS database that maintains a mapping of files that are held in local FRS trees and a master list of FRS files.

## Restore FRS replicas

The global `BurFlags` registry key contains `REG_DWORD` values, and is located in the following location in the registry:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Backup/Restore\Process at Startup`

The most common values for the `BurFlags` registry key are:

- D2, also known as a nonauthoritative mode restore.
- D4, also known as an authoritative mode restore.

You can also perform `BurFlags` restores at the same time as you restore data from backup or from any other known good source, and then restart the service.

### Nonauthoritative restore

Nonauthoritative restores are the most common way to reinitialize individual members of FRS replica sets that are having difficulty. These difficulties may include:

- Assertions in the FRS service
- Corruption of the local jet database
- Journal wrap errors
- FRS replication failures

Attempt nonauthoritative restores only after you discover FRS dependencies and you understand and resolve the root cause. For more information about how to discover FRS dependencies, see the [Considerations before you configure authoritative or nonauthoritative restores of FRS members](#considerations-before-you-configure-authoritative-or-nonauthoritative-restores-of-frs-members) section later in this article.

Members who are nonauthoritatively restored must have inbound connections from operational upstream partners where you're performing Active Directory and FRS replication. In a large replica set that has at least one known good replica member, you can recover all the remaining replica members by using a nonauthoritative mode restore if you reinitialize the computers in direct replication partner order.

If you must complete a nonauthoritative restore to return a member back into service, save as much state from that member and from the direct replication partner in the direction that replication is not working. It permits you to review the problem later. You can obtain state information from the FRS and System logs in the Event Viewer.

> [!NOTE]
> You can configure the FRS logs to record detailed debugging entries.

To perform a nonauthoritative restore, stop the FRS service, configure the `BurFlags` registry key, and then restart the FRS service. Follow these steps:

1. Select **Start**, and then select **Run**.
2. In the **Open** box, type *cmd* and then press ENTER.
3. In the **Command** box, type `net stop ntfrs`.
4. Select **Start**, and then select **Run**.
5. In the **Open** box, type `regedit` and then press ENTER.
6. Locate the following subkey in the registry:  
   `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NtFrs\Parameters\Backup/Restore\Process at Startup`

7. In the right pane, double-click **BurFlags**.
8. In the **Edit DWORD Value** dialog box, type *D2* and then select **OK**.
9. Quit Registry Editor, and then switch to the **Command** box.
10. In the **Command** box, type *net start ntfrs*.
11. Quit the **Command** box.

When the FRS service restarts, the following actions occur:

- The value for `BurFlags` registry key returns to **0**.
- Files in the reinitialized FRS folders are moved to a *Pre-existing* folder.
- An event 13565 is logged to signal that a nonauthoritative restore is started.
- The FRS database is rebuilt.
- The member performs an initial join of the replica set from an upstream partner or from the computer that is specified in the Replica Set Parent registry key if a parent has been specified for SYSVOL replica sets.
- The reinitialized computer runs a full replication of the affected replica sets when the relevant replication schedule begins.
- When the process is complete, an event 13516 is logged to signal that FRS is operational. If the event is not logged, there is a problem with the FRS configuration.

> [!NOTE]
> The placement of files in the *Pre-existing* folder on reinitialized members is a safeguard in FRS designed to prevent accidental data loss. Any files destined for the replica that exist only in the local *Pre-existing* folder and did not replicate in after the initial replication may then be copied to the appropriate folder. When outbound replication has occurred, delete files in the *Pre-existing* folder to free up additional drive space.

### Authoritative FRS restore

Use authoritative restores only as a final option, such as if there are directory collisions.

For example, you may require an authoritative restore if you must recover an FRS replica set where replication has completely stopped and requires a rebuild from scratch.

The following list of requirements must be met before you perform an authoritative FRS restore:

1. The FRS service must be disabled on all downstream partners (direct and transitive) for the reinitialized replica sets before you restart the FRS service when the authoritative restore has been configured to occur.

2. Events 13553 and 13516 have been logged in the FRS event log. These events indicate that the membership to the replica set has been established on the computer that is configured for the authoritative restore.

3. The computer configured for the authoritative restore is configured to be authoritative for all the data that you want to replicate to replica set members. It isn't the case if you are performing a join on an empty directory.

4. All other partners in the replica set must be reinitialized with a nonauthoritative restore.

To complete an authoritative restore, stop the FRS service, configure the `BurFlags` registry key, and then restart the FRS service. To do so:

1. Select **Start**, and then select **Run**.
2. In the **Open** box, type *cmd* and then press ENTER.
3. In the **Command** box, type *net stop ntfrs*.
4. Select **Start**, and then select **Run**.
5. In the **Open** box, type `regedit` and then press ENTER.
6. Locate the following subkey in the registry:  
   `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NtFrs\Parameters\Backup/Restore\Process at Startup`
7. In the right pane, double select **BurFlags**.
8. In the **Edit DWORD Value** dialog box, type *D4* and then select **OK**.
9. Quit Registry Editor, and then switch to the **Command** box.
10. In the **Command** box, type `net start ntfrs`.
11. Quit the **Command** box.

When the FRS service is restarted, the following actions occur:

- The value for the BurFlags registry key is set back to **0**.
- An event 13566 is logged to signal that an authoritative restore is started.
- Files in the reinitialized FRS replicated directories remain unchanged and become authoritative on direct replication. Additionally, the files become indirect replication partners through transitive replication.
- The FRS database is rebuilt based on current file inventory.
- When the process is complete, an event 13516 is logged to signal that FRS is operational. If the event isn't logged, there's a problem with the FRS configuration.

## Global vs. replica set specific reinitialization

There are both global and replica set-specific `BurFlags` registry keys. Setting the global `BurFlags` registry key reinitializes all replica sets that the member holds. Do it only when the computer holds only one replica set, or when the replica sets that it holds are relatively small.

In contrast to configuring the global `BurFlags` key, the replica set `BurFlags` key permits you to reinitializes discrete, individual replica sets, allowing healthy replication sets to be left intact.

The global `BurFlags` registry key is found in the following location in the registry:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NtFrs\Parameters\Backup / Restore\Process At Startup`.

This key can contain the same values as those values discussed earlier in this article for authoritative and nonauthoritative restores.

You can locate the replica set specific `BurFlags` registry key by determining the GUID for the replica set that you want to configure. To determine which GUID corresponds to which replica set and configure a restore, follow these steps:

1. Select **Start**, and then select **Run**.
2. In the **Open** box, type *cmd* and then press ENTER.
3. In the **Command** box, type *net stop ntfrs*.
4. Select **Start**, and then select **Run**.
5. In the **Open** box, type *regedit* and then press ENTER.
6. To determine the GUID that represents the replica set that you want to configure, follow these steps:

   1. Locate the following key in the registry:  
      `KEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NtFrs\Parameters\Replica Sets`

   2. Below the `Replica Sets` subkey, there are one or more subkeys that are identified by a GUID. In the left pane, select the GUID, and then in the right pane note the **Data** that is listed for the **Replica Set Root** value. This file system path will indicate which replica set is represented by this GUID.
   3. Repeat step 4 for each GUID that is listed below the `Replica Sets` subkey until you locate the replica set that you want to configure. Note the GUID.

7. Locate the following key in the registry:  
   `KEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NtFrs\Parameters\Cumulative Replica Sets`

8. Below the `Cumulative Replica Sets` subkey, locate the GUID you noted in step 6c.
9. In the right pane, double select **BurFlags**.
10. In the **Edit DWORD Value** dialog box, type *D2* to complete a nonauthoritative restore. Or type D4 to complete an authoritative restore. Then select **OK**.
11. Quit Registry Editor, and then switch to the **Command** box.
12. In the **Command** box, type `net start ntfrs`.
13. Quit the **Command** box.

## Considerations before you configure authoritative or nonauthoritative restores of FRS members

If you configure an FRS member to complete an authoritative or nonauthoritative restore by using the `BurFlags` registry subkey, you don't resolve the issues that initially caused the replication problem. If you can't determine the cause of the replication difficulties, the members will typically revert back to the problematic situation as replication continues.

A detailed breakdown on FRS interdependencies is beyond the scope of this article, but your troubleshooting should include the following actions:

- Verify that Active Directory replication is successful. Resolve Active Directory replication issues before further FRS troubleshooting. Use the `Repadmin /showreps` command to verify that Active Directory replication is occurring successfully. The Repadmin.exe tool is located in the Support\Tools folder on the Windows 2000 CD-ROM.
- Verify that inbound and outbound Active Directory replication occurs between all domain controllers that host `SYSVOL` replica sets, and between all domain controllers that host computer accounts for servers that participate in DFS replica sets.
- Verify that FRS member objects, subscriber objects, and connection objects exist in the Active Directory for all computers that participate in FRS replication.
- Verify that inbound and outbound connection objects exist for all domain controllers in the domain for `SYSVOL` replica sets.
- Verify that all the members of DFS replica sets have at least inbound connection objects in a topology to avoid islands of replication.
- Review the FRS and SYSTEM event logs on direct replication partners that are having difficulty.
- Review the FRS debug logs in the %SYSTEMROOT%\DEBUG\NTFRS_*.LOG between the direct replication partners that are having replication problems.

## More information

For more information, see [How to rebuild the `SYSVOL` tree and its content in a domain](https://support.microsoft.com/help/315457).
