---
title: Fix SQL Server on Azure VM Deployment and Startup Failures
description: Resolve SQL Server on Azure VM deployment and startup failures caused by unavailable ephemeral storage that prevents tempdb initialization.
ms.date: 09/17/2026
ms.reviewer: mathoma, pamela, v-sidong, v-shaywood
ms.custom: sap:SQL Licensing, Installation and Patching
ai-usage: ai-assisted
---
# SQL Server on Azure VM fails to deploy or come online

_Applies to:_ &nbsp;SQL Server on Azure VMs

## Summary

SQL Server on an Azure virtual machine (VM) can fail to deploy from an Azure Marketplace image with the error "System Drive returned status not ready for use." A manually installed SQL Server instance can also fail to come online after the VM is restarted or deallocated. These failures occur when SQL Server can't initialize the `tempdb` database on unavailable local ephemeral storage. This article helps you resolve or work around these failures.

> [!NOTE]
> The investigation of this issue is actively ongoing. The information in this article is subject to change as new details become available.

## Symptoms

If you encounter this issue, you likely see:

- SQL Server on Azure VM deployments failing when using an Azure Marketplace image.
- SQL Server failing to come online after an Azure VM is restarted for manually installed instances of SQL Server.

### SQL Server on Azure VM deployment fails 

When you try to deploy a SQL Server on Azure VM image from Azure Marketplace, the deployment fails with a status of `Conflict` and the following error: 

> System Drive returned status not ready for use.

For example, if you're deploying an image from the Azure portal, you might see the following error for the deployment in **Activity log**: 

```json
{
    "status": "Failed",
    "error": {
        "code": "Ext_StorageConfigurationSettings_ApplyNewTempDbSettingsError",
        "message": "Error: 'System Drive returned status not ready for use '"
    }
}
```

:::image type="content" source="media/sql-deployment-fails-drive-not-ready/sql-deployment-error.png" alt-text="Screenshot of the Azure portal deployment failure with the error System Drive returned status not ready for use." lightbox="media/sql-deployment-fails-drive-not-ready/sql-deployment-error.png":::

> [!WARNING]
> When this failure happens, the Azure VM deployment succeeds, but the SQL Server installation fails. You must delete the VM to avoid incurring charges. Redeploy the VM by using one of the methods described in the [Resolution](#resolution) or [Workarounds](#workaround) sections.

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

The RAW local SSD volume causes the SQL VM deployment to fail, and prevents manually installed SQL Server instances from coming online after the VM is restarted. In both cases, SQL Server tries to initialize the `tempdb` database on the ephemeral storage, which isn't available. The deployment fails because SQL Server is installed during the deployment of the Azure VM, and the ephemeral storage isn't available. Likewise, manually installed instances of SQL Server fail to come online after the VM is restarted because the ephemeral storage isn't available when SQL Server tries to create the `tempdb` database.

## Resolution

This issue occurs because of the selected Azure VM size. To solve the issue, use one of the following methods:

- Deploy your SQL Server VM through the Azure portal on Windows Server 2022 or later.
  - Scripted solutions such as ARM or BICEP templates don't currently resolve this issue.
  - Windows Server 2019 and earlier images continue experiencing this issue.
- If possible, use another VM SKU, such as the SKUs listed in the [VM size best practices](/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-vm-size#checklist). 
- If you want to use a particular VM that is on the [impacted VMs](#impacted-vms) list, use a machine without the lowercase `d` in the name, which places `tempdb` on the same storage as the SQL Server data files. For example, use the `FXmsv2` VM size instead of `FXmdsv2`. The latter uses uninitialized ephemeral storage, as indicated by `d` in the name.

## Workaround

If you can't use another VM SKU without a RAW local SSD, consider the following workarounds:

- Deploy the VM by using a Windows Server-only image, use a script to [format and initialize the temporary NVMe drive](https://github.com/Azure-Samples/azuresandbox/tree/main/extras/scripts/vm-mssql-win/NVMe), and then manually install SQL Server.
  
  - **If you choose to put `tempdb` on the local SSD, you must reinitialize the disk before starting SQL Server every time the VM restarts or deallocates.** 

- Deploy the SQL Server VM image, but configure `tempdb` to use a different drive than the ephemeral storage during the deployment. For example, you can configure `tempdb` to use the `C:` drive or remote storage drive.
  
  1. You can configure this setting on the **SQL Server settings** page in the Azure portal when [deploying the SQL Server VM image](https://portal.azure.com/#view/HubsExtension/ServiceMenuBlade/~/SqlVirtualMachine/extension/SqlAzureExtension/menuId/AzureSqlHub/itemId/SqlVirtualMachine).
  
  1. Under **Storage configuration**, select **Change configuration** to open the **Configure storage** pane.
  
  1. Expand **tempdb storage** and choose _any option other than_ `Use local SSD drive`:

     :::image type="content" source="media/sql-deployment-fails-drive-not-ready/change-tempdb-location.png" alt-text="Screenshot of the Configure storage pane with the Use a separate drive for tempdb option selected." lightbox="media/sql-deployment-fails-drive-not-ready/change-tempdb-location.png":::

## Impacted VMs

This issue occurs with VMs that deploy an uninitialized temporary drive, such as the following VM sizes:

|Intel Gen 10.2|AMD Gen 9.1|
|-|-|
|[Ddsv6 series](/azure/virtual-machines/sizes/general-purpose/ddsv6-series#sizes-in-series)|[Dadsv6 series](/azure/virtual-machines/sizes/general-purpose/dadsv6-series#sizes-in-series)|
|[Dndsv6 series](/azure/virtual-machines/sizes/memory-optimized/dndsv6-series#sizes-in-series)|[Dadsv7 series](/azure/virtual-machines/sizes/general-purpose/dadsv7-series#sizes-in-series)|
|[Ebdsv6 series](/azure/virtual-machines/sizes/memory-optimized/ebdsv6-series#sizes-in-series)|[DCadsv6 series](/azure/virtual-machines/sizes/general-purpose/dcadsv6-series#sizes-in-series)|
|[Edsv6 series](/azure/virtual-machines/sizes/memory-optimized/edsv6-series#sizes-in-series)|[Eadsv6 series](/azure/virtual-machines/sizes/memory-optimized/eadsv6-series#sizes-in-series)|
|[Endsv6 series](/azure/virtual-machines/sizes/memory-optimized/endsv6-series#sizes-in-series)|[Eadsv7 series](/azure/virtual-machines/sizes/memory-optimized/eadsv7-series#sizes-in-series)|
|[FXmdsv2 series](/azure/virtual-machines/sizes/compute-optimized/fxmdsv2-series#sizes-in-series)|[ECadsv6 series](/azure/virtual-machines/sizes/memory-optimized/ecadsv6-series#sizes-in-series)|
||[Fadsv7 series](/azure/virtual-machines/sizes/compute-optimized/fadsv7-series#sizes-in-series)|
||[Famdsv7 series](/azure/virtual-machines/sizes/compute-optimized/famdsv7-series#sizes-in-series)|

> [!NOTE]
> Before you install SQL Server, ensure the VM isn't configured with a [sector size greater than 4 KB](sql-installation-fails-sector-size-error-azure-vm.md#solution). 
