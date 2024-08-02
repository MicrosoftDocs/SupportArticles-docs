---
title: Mandatory update for Microsoft Azure Recovery Services Agent November 2017
description: Describes update and new features in Azure Recovery Services Agent update 2.0.9099.0.
ms.date: 08/14/2020
author: genlin
ms.author: genli
ms.service: azure-site-recovery
ms.custom: sap:I need help getting started with Site Recovery
---
# Mandatory update for Microsoft Azure Recovery Services Agent: November 2017

This article describes key updates, new features, improvements, and fixes for Azure Backup for Microsoft Azure Recovery Services (MARS) Agent version 2.0.9099.0, which is used by Microsoft Azure Backup and Microsoft Azure Site Recovery (ASR) for transferring data to Azure.

_Original product version:_ &nbsp; Azure Site Recovery  
_Original KB number:_ &nbsp; 4048992

## Key update

### System State Backup is generally available

System State backup with MARS Agent is now [generally available](https://aka.ms/azure-backup-system-state-ga) in all Azure regions. With this release, the MARS Agent has full production support for protecting data and operating system configuration on Windows file servers, Active Directory, and IIS web servers that are hosted on any Windows Server version from Windows Server 2008 R2 to Windows Server 2016.

:::image type="content" source="media/ars-agent-update-november-2017/system-state-backup.png" alt-text="Screenshot of the MARS Agent user interface.":::

:::image type="content" source="media/ars-agent-update-november-2017/backup-wizard.png" alt-text="Screenshot of the System State backup wizard.":::

By using System State Backup, you can protect your Active Directory servers, file servers, and IIS web servers for comprehensive disaster recovery. If you already back up files and folders, you can easily add System State to your policy without much effect on the size of backups that you send to Azure. Learn more about how you can [get started backing up](/azure/backup/backup-azure-system-state#back-up-windows-server-system-state-preview) and [recovering system state](/azure/backup/backup-azure-restore-system-state) by using MARS Agent.

## New features

### Flexible backup schedule and retention policy for System State

Now you can configure daily backups for System State at a preferred time directly from the Mars Agent. You can also set retention ranges for your daily, weekly, and monthly system state backups.

:::image type="content" source="media/ars-agent-update-november-2017/backup-schedule.png" alt-text="Screenshot of the System State backup user interface.":::

:::image type="content" source="media/ars-agent-update-november-2017/backup-retention-policy.png" alt-text="Screenshot of the System State backup retention policy.":::

### PowerShell support for System State backups

[PowerShell support](https://aka.ms/azure-backup-windows-server-powershell) is available for configuration, backup, and recovery of System State so that you can automate protection of Windows Server configuration at scale.

## Improvement and issues fixed in this update

- Fixes an issue that leads to backup failure in Windows 10 clients that have the RS3 Fall Creators Update installed. In this case, you receive the following error message: "The backup could not be started because of an unexpected error in the virtual disk service. Restart the virtual disk service and try the backup operation again. If the issue persists, check the system event log for virtual disk service events. (0x086C6)".
- Fixes an issue that leads to failure in the backup of compressed or encrypted files. In this case, you receive the following error message:
"Microsoft Azure Recovery Services Agent has detected inconsistencies while verifying the latest backup. A new recovery point could not be created. The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft support (0x086D5)".
- Fixes an issue that prevents users of Offline backup in System Center Data Protection Manager and Azure Backup Server from modifying offline backup parameters after an offline backup job is configured.
- Includes several accessibility fixes and improvements.

## Update information

To apply this update, install the latest version of the Microsoft Azure Recovery Services Agent.

The following file is available for download from the Microsoft Download Center:

[Download the Azure Recovery Services agent update package now](https://download.microsoft.com/download/3/4/4/344E6A78-5894-423B-A52B-04018A043C6E/MARSAgentInstaller.exe).

The version number for this update of Microsoft Azure Recovery Services Agent is 2.0.9099.0.

**Virus-scan claim**

Microsoft scanned this file for viruses, using the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to it.

### Applying the update to multiple servers

If your servers are registered to one or more Recovery Services Vaults, you can update your servers directly from Azure portal. To update multiple servers from the Azure portal, follow these steps:

1. Download the installer package from the Download Center.

1. Navigate to the Recovery Services Vault where your servers are registered.

1. On the **Settings** blade, click **Backup Infrastructure** in the **Manage** section.

1. Click **Protected Servers** under **Management Servers**, and then select **Azure Backup Agent** as the **Backup Management Type**.

    :::image type="content" source="media/ars-agent-update-november-2017/protected-servers.png" alt-text="Screenshot of Backup Infrastructure in Azure portal." lightbox="media/ars-agent-update-november-2017/protected-servers.png":::

1. On the blade that appears, select a server for which the Agent version number is earlier than **2.0.9099.0**. On the server's detail blade, click **Connect**. A Remote Desktop Connection file is downloaded that you can use to connect to the server, copy the update installer, and then run the installer to update the MARS Agent on the server.

    :::image type="content" source="media/ars-agent-update-november-2017/server-detail-blade.png" alt-text="Screenshot shows how to update the MARS Agent on the server." lightbox="media/ars-agent-update-november-2017/server-detail-blade.png":::

1. When you're done updating, you can select other servers that have Agent versions that are earlier than _2.0.9099.0_*, and then update the Agents on those servers in the same manner.

### Restart information

If you are using Windows Server 2008 (SP2 and R2 SP1, any version), you must restart the computer after you apply this update. Users who installed MARS Agent on other Windows Server versions don't have to restart the computer after applying this update.

### Replacement information

This update replaces previously released update [KB 4041236](https://support.microsoft.com/help/4041236).

### Prerequisites

If you use System Center 2016 Data Protection Manager (SC DPM), Microsoft recommends that you apply [Update Rollup 1](https://support.microsoft.com/help/3190600) for System Center 2016 Data Protection Manager or a later version.

If you use System Center 2012 R2 Data Protection Manager (SC DPM), apply [Update Rollup 12](https://support.microsoft.com/help/3209592/) for System Center 2012 R2 Data Protection Manager or a later version.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
