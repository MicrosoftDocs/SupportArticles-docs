---
title: Performance degradation - misaligned I/O sector size error
description: This article describes how to resolve misaligned I/O operations due to sector size mismatch in SQL Server.
ms.author: dpless
author: dplessMSFT
ms.reviewer: mathoma
ms.date: 03/20/2025
ms.custom:
---
# Performance degradation from misaligned I/O sector size error in SQL Server

_Original product version:_ &nbsp; SQL Server  

This article introduces how to resolve performance degradation due to misaligned I/O operations in SQL Server when the physical sector size differs between disk drives. 

## Overview

SQL Server can encounter misaligned I/O operations when the physical sector size of disk drives differs between servers or storage systems. This condition can degrade performance and is particularly common in environments where sector size mismatches are evident, such as: 
- Virtual machines with attached storage
- Always On availability groups
- Log shipping
- Hardware migrations 

For instance, a common issue arises when the primary server uses a 4-KB sector size, while the secondary uses 512 bytes, leading to misaligned I/O operations during log synchronization or restore processes. This misalignment can result in performance degradation, manifesting as slow restores or synchronization delays.

Trace Flag 1800 ensures that SQL Server uses a consistent 4-KB sector size for transaction log I/O operations, regardless of the underlying disk's physical sector size. This trace flag is designed to maintain performance in mixed environments, where servers might have been upgraded or migrated to hardware with different storage specifications.

For databases with write-intensive workloads, aligning I/O operations can lead to substantial performance gains, whereas the benefits may be negligible in read-intensive environments.

## Symptoms

You could be experiencing performance degradation in SQL Server due to misaligned I/O operations if you observe any of the following symptoms:
- **Slow synchronization or restore times**: Misaligned I/O operations can result in slower synchronization or restore times, especially in distributed SQL Server environments, such as Always On availability groups or log shipping. 
- **Error messages in the SQL Server error log**: Error messages related to I/O operations can indicate misalignment issues, such as: 
    
   `There have been # misaligned log IOs which required falling back to synchronous IO`


- **Performance bottle necks during write-intensive operations**: Write-intensive operations, such as log backups or database restores, can experience high disk latency and increased I/O wait times due to misaligned I/O operations, leading to performance bottlenecks and slow response times.

## Verify sector size 

To avoid misaligned I/O operations, it's important to ensure that the physical sector size of the disk drives is consistent across all servers and storage systems.

You can verify the [sector size](../../azure-sql/sql-installation-fails-sector-size-error-azure-vm.md) by running the following command in an elevated command prompt:   
`fsutil fsinfo sectorinfo <volume pathname>`

The following screenshot shows the output of the `fsutil fsinfo sectorinfo` command for the `E:` drive, which has a sector size of 8 KB, but a physical sector size of 4 KB causing misaligned I/O operations: 

:::image type="content" source="../../azure-sql/media/sql-installation-fails-error-azure-vm/8k-sector-size-example.png" alt-text="Screenshot of command prompt output of 8k sector size.":::

## Resolution 

If you are experiencing performance degradation due to misaligned I/O operations, and you're unable to [modify your sector size](../database-file-operations/troubleshoot-os-4kb-disk-sector-size.md#resolutions), you can use [Trace Flag 1800](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql) as a global startup parameter to force SQL Server to use a consistent 4-KB sector size for transaction log I/O operations.

To enable Trace Flag 1800 as a startup parameter, follow these steps:
1. On the system where SQL Server is installed, open [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager). 
1. Expand **SQL Server Configuration Configuration Manager (Local**), and select **SQL Server Services**. 
1. Right-click the SQL Server instance you want to configure, and select **Properties**: 

   :::image type="content" source="media/performance-degradation-misaligned-io-sector-error/sql-server-configuration-manager-properties.png" alt-text="Screenshot of the SQL Server service right-click menu, with properties highlighted.":::

1. In **SQL Server properties**, select the **Startup Parameters** tab, and enter `-T1800` i the **Specify a startup parameter** field. Select **Add** to add the parameter to the list. 

   :::image type="content" source="media/performance-degradation-misaligned-io-sector-error/add-1800-trace-flag.png" alt-text="Screenshot adding the trace flag as a startup parameter in SQL Server properties. ":::

1. Confirm your trace flag has been added to the list of startup parameters. Select **OK** to save your changes: 

   :::image type="content" source="media/performance-degradation-misaligned-io-sector-error/trace-flag-1800.png" alt-text="Screenshot of the SQL Server properties window, with startup parameters highlighted.":::

1. Restart the SQL Server service so the trace flag is enabled when your instance starts. 

## References

[KB3009974 - FIX: Slow synchronization when disks have different sector sizes](https://support.microsoft.com/topic/kb3009974-fix-slow-synchronization-when-disks-have-different-sector-sizes-for-primary-and-secondary-replica-log-files-in-sql-server-ag-and-logshipping-environments-ed181bf3-ce80-b6d0-f268-34135711043c)
