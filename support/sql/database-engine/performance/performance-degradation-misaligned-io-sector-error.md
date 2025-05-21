---
title: Performance Degradation from Misaligned I/O Sector Size Error
description: This article describes how to resolve misaligned I/O operations due to sector size mismatches in SQL Server.
ms.author: dpless
author: dplessMSFT
ms.reviewer: mathoma, dpless, v-sidong
ms.date: 04/15/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
---
# Performance degradation caused by misaligned I/O sector size errors in SQL Server

_Applies to:_ &nbsp; SQL Server  

This article introduces how to resolve performance degradation due to misaligned I/O operations in SQL Server when the physical sector size differs between disk drives. 

## Overview

SQL Server can encounter misaligned I/O operations when the physical sector size of disk drives differs between servers or storage systems. This condition can degrade performance and is particularly common in environments where sector size mismatches are evident, such as:

- Virtual machines with attached storage
- Always On availability groups
- Log shipping
- Hardware migrations 

For instance, a common issue occurs when the primary server uses a 4-KB sector size while the secondary server uses 512 bytes. This issue causes misaligned I/O operations during log synchronization or restore processes. This misalignment can result in performance degradation, such as slow restores or synchronization delays.

[Trace Flag 1800](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf1800) ensures that SQL Server uses a consistent 4-KB sector size for transaction log I/O operations, regardless of the underlying disk's physical sector size. This trace flag is designed to maintain performance in mixed environments where servers might have been upgraded or migrated to hardware with different storage specifications.

For databases with write-intensive workloads, aligning I/O operations can significantly improve performance, whereas the benefits might be negligible in read-intensive environments.

## Symptoms

You might experience performance degradation in SQL Server due to misaligned I/O operations if you encounter any of the following symptoms:

- **Slow synchronization or restore times**: Misaligned I/O operations can result in slow synchronization or restore times, especially in distributed SQL Server environments, such as Always On availability groups or log shipping. 
- **Error messages in the SQL Server error log**: Error messages related to I/O operations can indicate misalignment issues, such as: 
    
   `There have been # misaligned log IOs which required falling back to synchronous IO.`

- **Performance bottlenecks during write-intensive operations**: Write-intensive operations, such as log backups or database restores, might experience high disk latency and increased I/O wait times due to misaligned I/O operations, leading to performance bottlenecks and slow response times.

## Verify the sector size 

To avoid misaligned I/O operations, it's important to ensure that the physical sector size of the disk drives is consistent across all servers and storage systems.

You can verify the [sector size](../../azure-sql/sql-installation-fails-sector-size-error-azure-vm.md) by running the following command in an elevated command prompt:

```cmd
fsutil fsinfo sectorinfo <volume path name>
```

The following screenshot shows the output of the `fsutil fsinfo sectorinfo` command for the `E:` drive, which has a sector size of 8 KB but a physical sector size of 4 KB, causing misaligned I/O operations: 

:::image type="content" source="../../azure-sql/media/sql-installation-fails-error-azure-vm/8k-sector-size-example.png" alt-text="Screenshot of the command prompt output of the 8-KB sector size.":::

## Resolution 

If you're experiencing performance degradation due to misaligned I/O operations and can't [modify your sector size](../database-file-operations/troubleshoot-os-4kb-disk-sector-size.md#resolutions), you can use [Trace Flag 1800](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf1800) as a global startup parameter to force SQL Server to use a consistent 4-KB sector size for transaction log I/O operations.

To enable Trace Flag 1800 as a startup parameter, follow these steps:

1. On the system where SQL Server is installed and there's a physical sector size mismatch, open [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager). 
1. Expand **SQL Server Configuration Manager (Local**) and select **SQL Server Services**. 
1. Right-click the SQL Server instance you want to configure and select **Properties**: 

   :::image type="content" source="media/performance-degradation-misaligned-io-sector-error/sql-server-configuration-manager-properties.png" alt-text="Screenshot of the SQL Server service right-click menu with Properties highlighted.":::

1. In **SQL Server Properties**, select the **Startup Parameters** tab, enter `-T1800` in the **Specify a startup parameter** field, and select **Add** to add the parameter to the list. 

   :::image type="content" source="media/performance-degradation-misaligned-io-sector-error/add-1800-trace-flag.png" alt-text="Screenshot of adding the trace flag as a startup parameter in SQL Server Properties.":::

1. Confirm your trace flag has been added to the list of startup parameters. Select **OK** to save your changes: 

   :::image type="content" source="media/performance-degradation-misaligned-io-sector-error/trace-flag-1800.png" alt-text="Screenshot of the SQL Server properties window with startup parameters highlighted.":::

1. Restart the SQL Server service to enable the trace flag when your instance starts. 

> [!NOTE]
> Trace Flag 1800 can also be enabled on systems with a 4-KB sector size without any adverse performance impact.

## References

[KB3009974 - FIX: Slow synchronization when disks have different sector sizes](https://support.microsoft.com/topic/kb3009974-fix-slow-synchronization-when-disks-have-different-sector-sizes-for-primary-and-secondary-replica-log-files-in-sql-server-ag-and-logshipping-environments-ed181bf3-ce80-b6d0-f268-34135711043c)
