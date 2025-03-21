---
title: SQL Server Azure VM Deployment Fails with Drive Not Ready Error
description: Resolves an issue that occurs when you try to deploy a SQL Server instance on an Azure VM image in Azure Marketplace. 
ms.date: 03/22/2025
ms.author: dpless
author: dplessMSFT
ms.reviewer: mathoma, v-sidong
ms.custom: sap:SQL Licensing, Installation and Patching
---
# Error (System Drive returned status not ready for use) and Azure SQL Server VM deployment fails

This article helps you resolve a failed deployment of a SQL Server instance on an Azure VM image in Azure Marketplace. 

_Applies to:_ &nbsp;SQL Server on Azure VMs

## Symptoms

When you try to deploy a SQL Server instance on an Azure VM image in Azure Marketplace, the deployment fails with the following error message:

> System Drive returned status not ready for use.

## Cause

Some of the newest Azure VM sizes present a RAW Local SSD volume for ephemeral storage configured with the NVMe interface. This configuration might cause the deployment of a SQL Server instance on an Azure VM to fail because it attempts to place tempdb data files on the local SSD volume.  

The deployment fails because the RAW Local SSD volume isn't formatted or initialized, which makes the ephemeral storage unavailable and prevents SQL Server from accessing it during installation. 

## Resolution

This issue occurs because of the selected Azure VM size. To solve the issue, use one of the following methods:

- If it's possible, use another VM SKU instead, such as the ones listed in the [VM size best practices](/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-vm-size#checklist). 
- If it's not possible to use another VM SKU, deploy the VM using a Windows Server only image, [format and initialize the temporary NVMe drive](/azure/virtual-machines/enable-nvme-temp-faqs#how-can-i-format-and-initialize-temp-nvme-disks-in-windows-when-i-create-a-vm-), and then manually install SQL Server. Additionally, make sure that the VM isn't configured using a [sector size greater than 4 KB](sql-installation-fails-sector-size-error-azure-vm.md#resolution) before installing SQL Server. 

## Impacted VMs

This issue occurs with virtual machines that deploy with an uninitialized temporary drive, such as the following VM sizes: 

|Intel Gen 10.2|AMD Gen 9.1|
|-|-|
|Dlsv6|Dalsv6|
|Dldsv6|Daldsv6|
|Ddsv6|Dasv6|
|Esv6|Dadsv6|
|Edsv6|Easv6|
|Esv6 constrained core sizes|Eadsv6|
|Edsv6 constrained core sizes|Falsv6|
|Lsv3 - All Azure VMs|Fasv6|
|M-series VMs|Famsv6|

