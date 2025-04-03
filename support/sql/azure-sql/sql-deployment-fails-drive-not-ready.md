---
title: SQL Server Azure VM Deployment Fails with Drive Not Ready Error
description: Resolves an issue that occurs when you try to deploy a SQL Server on Azure VM image in Azure Marketplace. 
ms.date: 04/02/2025
ms.author: mathoma
author: MashaMSFT
ms.reviewer: mathoma, v-sidong
ms.custom: sap:SQL Licensing, Installation and Patching
---
# "System Drive returned status not ready for use" error and Azure SQL Server VM deployment fails

This article helps you resolve a failed deployment of a SQL Server on Azure Virtual Machine (VM) image in Azure Marketplace. 

_Applies to:_ &nbsp;SQL Server on Azure VMs

> [!NOTE]
> The investigation of this issue is actively ongoing. The information in this article is subject to change as new details become available.

## Symptoms

When you try to deploy a SQL Server on Azure VM image in Azure Marketplace, the deployment fails with a status of `Conflict` and the following error: 

> System Drive returned status not ready for use.

:::image type="content" source="media/sql-deployment-fails-drive-not-ready/sql-deployment-error.png" alt-text="Screenshot of the deployment error in the Azure portal." lightbox="media/sql-deployment-fails-drive-not-ready/sql-deployment-error.png":::

## Cause

Some of the newest Azure VM sizes present a RAW Local SSD volume for ephemeral storage configured with the Non-Volatile Memory Express (NVMe) interface. This configuration might cause the deployment of a SQL Server on Azure VM image to fail because it attempts to place `tempdb` data files on the local SSD volume.  

The deployment fails because the RAW Local SSD volume isn't formatted or initialized, which makes the ephemeral storage unavailable and prevents SQL Server from accessing it during the installation process of SQL Server during the deployment of the virtual machine. 

## Resolution

This issue occurs because of the selected Azure VM size. To solve the issue, use one of the following methods:

- If possible, use another VM SKU, such as those listed in the [VM size best practices](/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-vm-size#checklist). 
- If you can't use another VM SKU, deploy the VM using a Windows Server-only image, [format and initialize the temporary NVMe drive](/azure/virtual-machines/enable-nvme-temp-faqs#how-can-i-format-and-initialize-temp-nvme-disks-in-windows-when-i-create-a-vm-), and then manually install SQL Server. Additionally, make sure that the VM isn't configured using a [sector size greater than 4 KB](sql-installation-fails-sector-size-error-azure-vm.md#resolution) before installing SQL Server. 

## Impacted VMs

This issue occurs with VMs that are deployed with an uninitialized temporary drive, such as the following VM sizes: 

|Intel Gen 10.2|AMD Gen 9.1|
|-|-|
|[Dldsv6](/azure/virtual-machines/sizes/general-purpose/dldsv6-series#sizes-in-series)|[Daldsv6](/azure/virtual-machines/sizes/general-purpose/daldsv6-series#sizes-in-series)|
|[Ddsv6](/azure/virtual-machines/sizes/general-purpose/ddsv6-series#sizes-in-series)|[Dadsv6](/azure/virtual-machines/sizes/general-purpose/dadsv6-series#sizes-in-series)|
|[Edsv6](/azure/virtual-machines/sizes/memory-optimized/edsv6-series#sizes-in-series)|[Eadsv6](/azure/virtual-machines/sizes/memory-optimized/eadsv6-series#sizes-in-series)|
|[Edsv6](/azure/virtual-machines/sizes/memory-optimized/edsv6-series#sizes-in-series)||
|[Lsv3](/azure/virtual-machines/sizes/storage-optimized/lsv3-series#sizes-in-series) - All Azure VMs||



