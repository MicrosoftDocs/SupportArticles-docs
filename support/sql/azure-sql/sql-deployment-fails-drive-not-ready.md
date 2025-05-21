---
title: SQL VM Fails to Deploy or SQL Server Instance Can't Come Online
description: Addresses a failure when you deploy a SQL Server on Azure VM image in Azure Marketplace or when a manually installed SQL Server instance fails to come online after an Azure VM is restarted or deallocated.
ms.date: 04/16/2025
ms.author: mathoma
author: MashaMSFT
ms.reviewer: mathoma, v-sidong
ms.custom: sap:SQL Licensing, Installation and Patching
---
# SQL Server on Azure VM fails to deploy or SQL Server instance fails to come online

This article helps you resolve the following scenarios:

- A SQL Server on Azure virtual machine (VM) Azure Marketplace image fails to deploy.
- A SQL Server instance fails to come online after an Azure VM is restarted or deallocated.

_Applies to:_ &nbsp;SQL Server on Azure VMs

> [!NOTE]
> The investigation of this issue is actively ongoing. The information in this article is subject to change as new details become available.

## Symptoms

If you encounter this issue, you're likely to see:

- SQL Server on Azure VM deployments failing when using an Azure Marketplace image.
- SQL Server failing to come online after an Azure VM is restarted for manually installed instances of SQL Server.

### SQL Server on Azure VM deployment fails 

When you try to deploy a SQL Server on Azure VM image from Azure Marketplace, the deployment fails with a status of `Conflict` and the following error: 

> System Drive returned status not ready for use.

For example, if you're deploying an image from the Azure portal, you might see the following error for the deployment in **Activity log**: 

:::image type="content" source="media/sql-deployment-fails-drive-not-ready/sql-deployment-error.png" alt-text="Screenshot of the deployment error in the Azure portal." lightbox="media/sql-deployment-fails-drive-not-ready/sql-deployment-error.png":::

### SQL Server fails to come online after the VM is restarted

You might see this issue after following this sequence of events: 

1. You deploy an Azure VM from the [impacted VM](#impacted-vms) list.
1. You manually install an instance of SQL Server to the Azure VM. 
1. You configure your SQL Server `tempdb` database to use the local SSD ephemeral storage (typically, the `D:` drive).
1. Your VM is restarted or deallocated.
1. Your SQL Server instance fails to come online.

If you encounter this issue, you might see the following error in the SQL Server error log: 

```output
CREATE FILE encountered operating system error 3(The system cannot find the path specified.) 
while attempting to open or create the physical file 'D:\SQLTemp\tempdb.mdf'.
Error: 17204, Severity: 16, State: 1. FCB::Open failed: Could not open 
file D:\SQLTemp\tempdb.mdf for file number 1. OS error: 
3(The system cannot find the path specified.).
Error: 5120, Severity: 16, State: 101.
Unable to open the physical file "D:\SQLTemp\tempdb.mdf". Operating system error 3:
"3(The system cannot find the path specified.)".
Error: 1802, Severity: 16, State: 4 CREATE DATABASE failed. 
Some file names listed could not be created. Check related errors.
Could not create tempdb. You may not have enough disk space available.
Free additional disk space by deleting other files on the tempdb drive and then restart SQL Server. 
Check for additional errors in the event log that may indicate why the 
tempdb files could not be initialized.
```

## Cause

Some of the newest Azure VM sizes present a RAW local SSD volume for ephemeral storage configured with the Non-Volatile Memory Express (NVMe) interface. This configuration results in failures because SQL Server attempts to place the `tempdb` database on the ephemeral storage and fails as the local SSD volume isn't available. Additionally, the ephemeral storage shows as RAW after the machine is deallocated. 

The RAW local SSD volume causes the SQL VM deployment to fail, and prevents manually installed SQL Server instances from coming online after the VM is restarted. In both cases, SQL Server is trying to initialize the `tempdb` database on the ephemeral storage, which isn't available. The deployment fails because SQL Server is installed during the deployment of the Azure VM, and the ephemeral storage isn't available. Likewise, manually installed instances of SQL Server fail to come online after the VM is restarted because the ephemeral storage isn't available when SQL Server tries to create the `tempdb` database.

## Resolution

This issue occurs because of the selected Azure VM size. To solve the issue, use one of the following methods:

- If possible, use another VM SKU, such as those listed in the [VM size best practices](/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-vm-size#checklist). 
- If you want to use a particular VM that is on the [impacted VMs](#impacted-vms) list, use a machine without the lowercase `d` in the name, which places `tempdb` on the same storage as the SQL Server data files. For example, use the `FXmsv2` VM size instead of `FXmdsv2`. The latter has uninitialized ephemeral storage, as indicated by `d` in the name.
- If you can't use another VM SKU without a RAW local SSD, deploy the VM using a Windows Server-only image, [format and initialize the temporary NVMe drive](/azure/virtual-machines/enable-nvme-temp-faqs#how-can-i-format-and-initialize-temp-nvme-disks-in-windows-when-i-create-a-vm-), and then manually install SQL Server. *You must reinitialize the disk before starting SQL Server every time the VM is restarted or deallocated.*

> [!NOTE]
> Make sure the VM isn't configured using a [sector size greater than 4 KB](sql-installation-fails-sector-size-error-azure-vm.md#resolution) before installing SQL Server. 

## Impacted VMs

This issue occurs with VMs that are deployed with an uninitialized temporary drive, such as the following VM sizes: 

|Intel Gen 10.2|AMD Gen 9.1|
|-|-|
|[Dldsv6](/azure/virtual-machines/sizes/general-purpose/dldsv6-series#sizes-in-series)|[Daldsv6](/azure/virtual-machines/sizes/general-purpose/daldsv6-series#sizes-in-series)|
|[Ddsv6](/azure/virtual-machines/sizes/general-purpose/ddsv6-series#sizes-in-series)|[Dadsv6](/azure/virtual-machines/sizes/general-purpose/dadsv6-series#sizes-in-series)|
|[Edsv6](/azure/virtual-machines/sizes/memory-optimized/edsv6-series#sizes-in-series)|[Eadsv6](/azure/virtual-machines/sizes/memory-optimized/eadsv6-series#sizes-in-series)|
|[Lsv3](/azure/virtual-machines/sizes/storage-optimized/lsv3-series#sizes-in-series) - All Azure VMs||
|[Fxmdsv2](/azure/virtual-machines/sizes/compute-optimized/fxmdsv2-series#sizes-in-series)||



