---
title: Troubleshoot FRS and DFS
description: Describes how to troubleshoot the File Replication Service and the Distributed File System
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:frs, csstroubleshoot
---
# Troubleshoot the File Replication Service and the Distributed File System

This article discusses how to troubleshoot the File Replication service (FRS) and the Distributed File System (DFS). The main emphasis, however, of this article is to discuss a general procedure that can help you to troubleshoot FRS problems.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 272279

## Summary

You may observe that FRS has stopped replicating content on your system. This behavior may occur because of many potential causes.

If your system experiences FRS problems, you can perform the following general procedure to troubleshoot these problems:

## Procedure to troubleshoot FRS problems

1. Check for free disk space on Computer A (source directory, staging directory, and database partition) and Computer B (destination partition, preinstall partition, and database partition). Look for the following events in Event Viewer:

    - Event id: 13511

        Database is out of disk space.
    - Event id: 13522

        Staging directory is full. An outbound partner that has not connected for a while can cause this. Delete the connection and stop and restart FRS to force deletion of the staging files.

2. Create a test file on Computer B and verify its replication to Computer A.

3. Verify that both Computer A and Computer B are available on the network. Because FRS uses the fully qualified domain name (FQDN) of the replica members, an appropriate first check is to use a ping command specifying the fully qualified name of the problem replicas.

    From Computer A, send a ping command with Computer B's FQDN. From Computer B, send a ping command to Computer A's FQDN. Verify that the addresses returned by the ping command are the same as the addresses returned by an `ipconfig /all` command by means of the command line of the destination computer.

4. Access the Services administrative console by following these steps:

    1. Click **Start**, and then click **Run**.  
    2. In the **Open** box, type *services.msc*.

        Confirm that FRS runs on both computers. If the service is not running, review the FRS container of Event Viewer (located in the Eventvwr.msc file) on the computer experiencing the problem.

5. Verify remote procedure call (RPC) connectivity between Computer A and Computer B. An appropriate test may be to open Event Viewer on Computer B from Computer A (which uses RPC). Check FRS event logs on both computers. If Event ID 13508 is present, there may be a problem with the RPC service on either computer or with creating a secure connection between Computer A and Computer B.

6. Use the Active Directory Sites and Services console to verify the replication schedule on the Connection object. Ensure that replication is enabled between Computer A and Computer B and that the connection is enabled. The Connection object is the inbound connection under Computer A's NTFRS_MEMBER object from Computer B. For System Volume (SYSVOL), the Connection object resides in the Sites\Site_name\Servers\Server_name\Ntds Settings\Connection_name folder.

7. For Dfs, view the connection links in Active Directory (AD) Users and Computers. Open AD Users and Computer, click View from the menu and ensure that Advanced Settings are selected. Go to the System container. The location of the Connection objects are in the System\File Replication Service\DFS Volumes folder.

8. Verify whether or not the file on the originating server is locked (cannot be accessed) on either computer. If the file is locked on Computer B so that FRS cannot read the file, FRS cannot generate the staging file, which delays replication. If the file is locked on Computer A so that FRS cannot update the file, FRS continues to retry the update until it succeeds. The retry interval is 30 to 60 seconds.

9. Verify whether or not the source file had been excluded from replication. Confirm that the file is not Encrypting File System (EFS) encrypted, an NTFS file system (NTFS) junction, or excluded by a file or folder filter on the originating replica member. If any of these situations are true, FRS does not replicate the file or directory.

10. If all of the previous conditions are met, you may have to examine the log files that are created for FRS. The log files are located in the %Systemroot%\Debug folder. The file names are listed from NtFrs_001.log to NtFrs_005.log.
