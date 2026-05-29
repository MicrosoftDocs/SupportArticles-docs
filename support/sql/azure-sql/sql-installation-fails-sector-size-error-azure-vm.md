---
title: SQL Server Installation Fails with Sector Size Error on Azure VM
description: Fixes the error (Cannot use file master.mdf because it was originally formatted with sector size 4096) when you install SQL Server on an Azure VM that uses an NVMe disk with an 8-KB sector size.
ms.date: 05/20/2026
ms.reviewer: mathoma, v-sidong, v-shaywood
ms.custom: sap:SQL Licensing, Installation and Patching
---
# SQL Server installation fails with sector size error on a Windows Server Azure virtual machine

_Applies to:_ &nbsp; SQL Server, SQL Server on Azure VM - Windows

## Summary

This article helps you fix a problem that occurs when you manually install a SQL Server instance on a Microsoft Azure virtual machine (VM) that runs Windows. When you install SQL Server on an Azure VM that uses an NVMe disk with a native sector size larger than 4 KB, setup fails because SQL Server data files like `master.mdf` can't be hosted on a volume with an 8-KB sector size. This article explains why the sector size mismatch occurs on newer Azure VM series, and how to force a 4-KB sector size so that SQL Server installation succeeds on the disk.

## Symptoms

When you install a SQL Server instance on an Azure VM that runs Windows, the installation fails and the SQL Server error log shows the following message when the engine tries to start:

> Cannot use file '...\master.mdf' because it was originally formatted with sector size 4096 and is now on a volume with sector size 8192. Move the file to a volume with a sector size that is the same as or smaller than the original sector size.

The **Summary.txt** log file in the SQL Server setup folder also shows entries like the following:

```output
Detailed results:
  Feature:                       Database Engine Services
  Status:                        Failed
  Reason for failure:            An error occurred during the setup process of the feature.
  Next Step:                     Use the following information to resolve the error, uninstall this feature, and then run the setup process again.
  Component name:                SQL Server Database Engine Services Instance Features
  Component error code:          0x851A0019
  Error description:             Could not find the Database Engine startup handle.
```

This issue can occur with on-premises installations, but you're more likely to see it when you install SQL Server on an Azure VM.

## Cause

This issue occurs because of the sector size of the disk on some Azure VM sizes. Newer Azure VM series like Dadsv6, Eadsv6, and Fasv6 use an NVMe-only storage interface and require an OS image that supports NVMe. These VM series expose disks with a default native sector size of 8 KB, which SQL Server doesn't support for database files. SQL Server supports disks with native sector sizes of 512 bytes and 4 KB. If an Azure VM is deployed with an 8-KB sector size and you then install SQL Server, the installation can fail. For more information, see [Storage types for SQL Server](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022#StorageTypes).

> [!NOTE]
> This scenario applies only when you manually install SQL Server on an Azure VM. It doesn't apply when you deploy a SQL Server VM image from Azure Marketplace, because those images are preconfigured to use a 4-KB sector size.

### Impacted disk and VM types

You most commonly see the sector size mismatch in these scenarios:

- **Local NVMe disks** on v6 VM series (for example, Dadsv6, Eadsv6, Easv6, and Fasv6), which expose an 8-KB native sector size.
- **Premium SSD v2** and **Ultra Disk** when you create the disk with a logical sector size of 4096 bytes but present it through a host that reports an 8-KB physical sector size.

Standard HDD, Standard SSD, and Premium SSD (v1) data disks that you attach to earlier VM series typically present a 4-KB sector size and aren't affected.

## Solution

To fix this problem, force the Azure VM to use a 4-KB sector size, and then reinstall SQL Server.

1. If SQL Server is already installed, uninstall it. Otherwise, skip to the next step.
1. Add the [ForcedPhysicalSectorSizeInBytes](../database-engine/database-file-operations/troubleshoot-os-4kb-disk-sector-size.md#resolution-steps-for-disk-sector-size-errors-in-sql-server) registry key.
1. Check that the sector size is 4 KB by running the following command at an elevated command prompt:

   ```cmd
   fsutil fsinfo sectorinfo <volume pathname>
   ```

1. Restart the Azure VM.
1. Reinstall SQL Server.

The following screenshot shows the output of the `fsutil fsinfo sectorinfo` command for the `E:` drive, which has an 8-KB sector size:

:::image type="content" source="media/sql-installation-fails-error-azure-vm/8k-sector-size-example.png" alt-text="Screenshot of command prompt output of 8-KB sector size.":::

The following screenshot shows the output of the same command for the `E:` drive after the registry key is added to use a 4-KB sector size:

:::image type="content" source="media/sql-installation-fails-error-azure-vm/4k-sector-size-example.png" alt-text="Screenshot of command prompt output of 4-KB sector size.":::

The `ForcedPhysicalSectorSizeInBytes` registry key is an OS-level setting. All drives that are currently attached, and any drives that are attached later, use a 4-KB sector size until you remove this registry key.

## Related content

- [Troubleshoot OS 4-KB disk sector size errors in SQL Server](../database-engine/database-file-operations/troubleshoot-os-4kb-disk-sector-size.md)
- [Hardware and software requirements for installing SQL Server](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022)
- [Storage configuration for SQL Server on Azure Virtual Machines](/azure/azure-sql/virtual-machines/windows/storage-configuration)
