---
title: Can't extend volume on a SQL Server-based standalone server virtual machine from Azure Marketplace
description: Troubleshoot an issue that prevents you from extending the volume on a SQL Server-based standalone server virtual machine that was deployed from Azure Marketplace.
ms.reviewer: kirangowda, shasankp, glimoli, clandis, tatec, v-leedennis
ms.date: 12/12/2022
ms.service: virtual-machines
ms.subservice: vm-disk
---

# Can't extend the volume on a SQL Server-based standalone server virtual machine from Azure Marketplace

This article discusses how to troubleshoot an issue that prevents you from extending the volume on a Microsoft SQL Server-based standalone server virtual machine (VM) that's deployed from Azure Marketplace.

## Symptoms

You can't manually configure the volume of your SQL Server standalone server VM that's deployed from Azure Marketplace.

## Cause

A storage pool that has DATA and LOG volumes was already created when the SQL Server-based server was deployed.

## Solution

You can extend these volumes from the Azure portal through the SQL Server configuration menu. Follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com), and then select your VM. 
1. In the left pane of the **Virtual Machine Overview** tab, select **SQL Server configuration** under **Settings**.
1. Select **Manage SQL virtual machine**.
1. In the left pane, select **Storage Configuration** under **Settings**.
1. Select **Configure** under **Configure drive**, and then extend the Data, Log, and temporary db (database) volume.

   :::image type="content" source="./media/cannot-extend-volume-sql-server/sql-server-storage-configuration-ui.png" alt-text="Azure portal screenshot of the SQL Server Configuration page. Storage Configuration is highlighted in the navigation pane." lightbox="./media/cannot-extend-volume-sql-server/sql-server-storage-configuration-ui.png":::

1. Select the disk size, enter the number of new disks that have to be added to the existing storage pool, and then select **Apply**.

   :::image type="content" source="./media/cannot-extend-volume-sql-server/extend-data-drive-ui.png" alt-text="Azure portal screenshot of the Extend Data Drive page for a SQL virtual machine.":::

> [!IMPORTANT]
> Extending the disk volume will add disks on the VM. It will also extend the storage pool (and the volume that's created from that storage pool) without any user input from within the VM. 
>
> Extending the disk volume won't extend the existing disks. Therefore, it's important to add the disks carefully based on the VM size requirements so that you don't exceed the total number of disks that can be added. If you exhaust the total number of data disks, you'll have to upgrade the VM size to extend the volume and storage pool.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
