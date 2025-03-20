---
title: SQL Server Azure VM deployment fails with drive not ready error
description: This article provides a resolution for the failure that can occur when you try to deploy certain SQL Server on Azure VM images from Azure Marketplace. 
ms.date: 03/22/2025
ms.author: dpless
author: dplessMSFT
ms.reviewer: mathoma
ms.custom: sap:Azure SQL virtual machine
ms.topic: troubleshooting
---
# Error (System Drive returned status not ready for use) and Azure SQL Server VM deployment fails

This article helps you resolve a failed deployment of a SQL Server on Azure VM image from Azure Marketplace. 

_Applies to:_ &nbsp; SQL Server on Azure VMs

## Symptoms

When you try to deploy a SQL Server on Azure VM image from Azure Marketplace, the deployment fails with the following error message:

`System Drive returned status not ready for use.`

## Cause

Some of the newest Azure VM sizes present a RAW Local SSD volume for ephemeral storage prepared with the NVMe interface. This configuration can cause a SQL Server on Azure VM deployment to fail because it attempts to place tempdb data files on the local SSD volume.  

The deployment fails because the RAW Local SSD volume is not formatted and initialized, making the ephemeral storage unavailable, which prevents SQL Server from accessing it during installation. 

## Resolution

This issue occurs because of the selected Azure VM size. If it is not possible to use another VM SKU, deploy the VM using a Windows Server only image, then manually install SQL Server after you [format and initialize the temporary NVMe drive](/azure/virtual-machines/enable-nvme-temp-faqs#how-can-i-format-and-initialize-temp-nvme-disks-in-windows-when-i-create-a-vm-). Additionally, be sure to check that the VM isn't configured using a [sector size greater than 4 KB](sql-installation-fails-sector-size-error-azure-vm.md#resolution) before installing SQL Server. 

If it is possible, use another VM SKU instead, such as the ones listed in the [VM size best practices](/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-vm-size#checklist). 


 ## Impacted VMs

This issue occurs with virtual machines that deploy with an uninitialized temporary drive, such as the following VM sizes: 

:::row:::
    :::column:::
        <br /> Intel Gen 10.2
        <br />- Dlsv6
        <br />- Dldsv6
        <br />- Ddsv6
        <br />- Esv6
        <br />- Edsv6
        <br />- Esv6 constrained core sizes
        <br />- Edsv6 constrained core sizes
        <br />- Lsv3 – All Azure VMs
        <br />- M-series VMs
    :::column-end:::
    :::column:::
        <br /> AMD Gen 9.1:
        <br />- Dalsv6
        <br />- Daldsv6
        <br />- Dasv6
        <br />- Dadsv6
        <br />- Easv6
        <br />- Eadsv6
        <br />- Falsv6
        <br />- Fasv6
        <br />- Famsv6
:::row-end:::

