---
title: SQL Server Installation Fails with Sector Size Error on Azure VM
description: This article provides a resolution for the error (Cannot use file 'master.mdf' because it was originally formatted with sector size 4096) that occurs when you try to install a SQL Server instance on an Azure virtual machine (VM) running Windows.
ms.date: 03/20/2025
ms.author: dpless
author: dplessMSFT
ms.reviewer: mathoma
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
---
# SQL Server installation fails with sector size error on a Windows Server 2022 Azure virtual machine

This article helps you resolve a problem that occurs when you try to manually install a SQL Server instance on a Microsoft Azure virtual machine (VM) running Windows.

_Applies to:_ &nbsp; SQL Server, SQL Server on Azure VM - Windows

## Symptoms

When you try to install a SQL Server instance on an Azure virtual machine (VM) running Windows, the installation fails, and you receive the following error message in the SQL Server error log when the engine tries to start during the installation:

> Cannot use file '...\master.mdf' because it was originally formatted with sector size 4096 and is now on a volume with sector size 8192. Move the file to a volume with a sector size that is the same as or smaller than the original sector size.

Additionally, you can see the following information in the **Summary.txt** log file in the SQL Server setup folder:

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

This issue can occur for on-premises installations but is more likely to be encountered when installing SQL Server on Microsoft Azure virtual machine (VM).

## Cause

This issue occurs due to the sector size configuration of the disk on certain Azure virtual machines. Some of the latest Azure VM generations (such as Da/Ea/Fav6) have an NVMe-only storage interface and require an OS image that supports NVMe. However, these latest Azure VM generations deploy with a default sector size of 8 KB, which isn't currently supported by SQL Server. SQL Server currently supports disks with a standard native [sector sizes of 512 bytes and 4 KB](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2022#StorageTypes). 

> [!NOTE]
> NVMe is a communication protocol that facilitates faster and more efficient data transfer between servers and storage systems by using nonvolatile memory (NVMe). With NVMe, data can be transferred at the highest throughput and with the fastest response times. 

If an Azure virtual machine was deployed using the 8 KB sector size, and you attempt to install SQL Server after deployment, the installation can fail. 

> [!NOTE]
> This scenario only occurs when you manually install SQL Server on an Azure VM, and not when you deploy a SQL Server VM from Azure Marketplace. The Azure Marketplace images are preconfigured to use the 4 KB sector size.

## Resolution

To resolve this problem, you need to reinstall SQL Server after forcing the Azure VM to use the 4 KB sector size.  

To successfully install SQL Server on your Azure VM, follow these steps:

1. If you've already installed SQL Server, uninstall SQL Server. Otherwise, skip to the next step. 
1. Add the [ForcedPhysicalSectorSizeInBytes](../database-engine/database-file-operations/troubleshoot-os-4kb-disk-sector-size.md#resolutions) registry key. 
1. Verify the sector size is 4 KB by running the following command in an elevated command prompt:

   `fsutil fsinfo sectorinfo <volume pathname>`

1. Restart the Azure VM.
1. Reinstall SQL Server. 

The following screenshot shows the output of the `fsutil fsinfo sectorinfo` command for the `E:` drive, which has a sector size of 8 KB: 

:::image type="content" source="media/sql-installation-fails-error-azure-vm/8k-sector-size-example.png" alt-text="Screenshot of command prompt output of 8k sector size.":::

The following screenshot shows the output of the `fsutil fsinfo sectorinfo` command for the `E:` drive after updating the registry key to use the 4 KB sector size:

:::image type="content" source="media/sql-installation-fails-error-azure-vm/4k-sector-size-example.png" alt-text="Screenshot of command prompt output of 4 KB sector size.":::

The `ForcedPhysicalSectorSizeInBytes` registry key is an OS-level setting, meaning that all drives currently attached, and those attached in the future, use the 4 KB sector size unless this registry key is removed. 
