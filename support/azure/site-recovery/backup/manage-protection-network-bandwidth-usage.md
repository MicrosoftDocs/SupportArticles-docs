---
title: How to manage on-premises to Azure protection network bandwidth usage
description: Describes the steps that administrators can take to limit network bandwidth usage while using Azure Site Recovery on-premises to Microsoft Azure protection.
ms.date: 05/23/2025
ms.service: azure-site-recovery
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: anbacker, markstan
ms.custom: sap:I need help with Azure Backup
---
# How to manage on-premises to Azure protection network bandwidth usage

When you enable on-premises to Microsoft Azure protection by using [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/)(ASR), the network bandwidth can be managed by using the methods in this article.

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 3056159

## Manage the network bandwidth for on-premises virtual machines

[The Microsoft Azure Recovery Services Agent](https://go.microsoft.com/fwlink/?linkid=399336) that's installed on the Hyper-V host for on-premises VMM site to Azure or on-premises Hyper-V site to Azure is configured to use the default internet bandwidth usage settings.

An administrator can configure individual Hyper-V hosts to use different network bandwidth settings. After these configurations are implemented, you should monitor network bandwidth usage for several days to make sure that the configured settings optimize your usage.

## Step 1: Increase the bandwidth usage for replicating into Azure

Use Registry Editor to locate the following registry key, and then add the following registry entry, or change it if the value already exists:

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Azure Backup\Replication  
Value Name: UploadThreadsPerVM  
Value Type: REG_DWORD  
Value Data: 8  
```

> [!NOTE]
> The default value with which the agent is configured is 4, and the maximum supported value is 32.

## Step 2: Increase bandwidth usage during Azure to On-premises failover

Use Registry Editor to locate the following registry key, and then add the following registry entry, or change it if the value already exists:

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Azure Backup\Replication
Value Name: DownloadThreadsPerVM 
Value Type: REG_DWORD 
Value Data: 8 
```

> [!NOTE]
> The default value with which the agent is configured is 4 and the maximum supported value is 32.

## Step 3: Throttling bandwidth usage for replication

Use one of the following methods to configure the Throttling settings.  

### Method 1: Use the MMC snap-in management console

1. Open the MMC. On the **File** menu, select **Add/Remove Snap-in**, and then add **Windows Server Backup** for **Local computer**.
2. Expand the **Windows Server Backup**  tree, and then select **Backup**. In the **Actions**  pane (on the right), select **Change Properties**.
3. There are three tabs with settings that you can change as necessary. Select the **Throttling** tab.

    :::image type="content" source="media/manage-on-premises-azure-protection-network-bandwidth-usage/throttling-tab.png" alt-text="Screenshot of the Throttling tab in the Microsoft Azure Backup Properties window.":::

The **Throttling** tab allows for control of network usage during specific day and time intervals. After you select the **Enable internet bandwidth usage throttling for backup operations**  check box, you can configure how the agent uses the network bandwidth when it's backing up or restoring information.

Throttling uses two settings, work hours and nonwork hours, to regulate the use of the network bandwidth during backup operations. You can define the range of work days and work hours during which the work hours bandwidth limit should be applied. The nonwork hours limit will be used at all other times. Valid bandwidth ranges from 512 kilobytes per second (Kbps) to 1023 megabytes per second (Mbps) for both limits.  

### Method 2: Use Windows PowerShell cmdlets

The [Set-OBMachineSetting](https://technet.microsoft.com/library/hh770409.aspx) cmdlet configures settings for the server that include proxy settings for accessing the Internet and network bandwidth throttling settings.

Examples:

The following sample cmdlet throttles bandwidth on Mondays and Tuesdays from 9:00 AM to 6:00 PM:

```powershell
$mon = [System.DayOfWeek]::Monday 

$tue = [System.DayOfWeek]::Tuesday

Set-OBMachineSetting -WorkDay $mon, $tue -StartWorkHour "9:00:00" -EndWorkHour "18:00:00" -WorkHourBandwidth (512*1024) -NonWorkHourBandwidth (2048*1024)
```

The following cmdlet specifies that network bandwidth throttling will not be used by this server.

```powershell
Set-OBMachineSetting -NoThrottle
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
