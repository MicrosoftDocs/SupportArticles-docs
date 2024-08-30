---
title: How to troubleshoot Azure Recovery Services
description: Describes how to troubleshoot Azure Recovery Services (ASR).
ms.date: 11/01/2023
ms.service: azure-site-recovery
ms.author: genli
author: genlin
ms.reviewer: markstan
ms.custom: sap:I need help getting started with Site Recovery
---
# How to troubleshoot Azure Recovery Services

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 3005185

## Introduction

This article describes information on general troubleshooting techniques and the locations of logs for Microsoft Azure Recovery Services (ASR). Due to the distributed nature of this service, files must be collected from different locations. Generally, the most common issues can be identified by inspecting the Virtual Machine Manager (VMM) job data, VMM debug logs, and Azure SQL Reporting service (SRS) logs from the Azure Site Recovery portal.

> [!NOTE]
> In some cases, you may have to contact Microsoft Support to collect additional logs from Azure Services.

## More information

Collect logs from the following locations:

- VMM server
- Azure Site Recovery Portal in Microsoft Azure
- Hyper-V host

For best results, collect a VMM debug trace when you reproduce this issue, and then collect event and trace logs together with the Microsoft Azure logs.

### How to troubleshoot on VMM server

- Collect the VMM debug logs (event trace log) and SRS logs that are additional information to this channel. See the [detail of how to enable debug logging in Virtual Machine Manager](../../../system-center/vmm/enable-debug-logging.md). For Branch to Azure ASR installations, refer to [KB 3033922](https://support.microsoft.com/help/3033922) instead.
- Run the following Windows PowerShell commands to filter and therefore narrow the scope of the investigation:

    Get-SCVirtualMachine  
    Get-SCVMHost  
    Get-VMReplication  
    Get-SCJob  
- Collect Disaster Recovery Adapter (DRA) logs in the following location:
 _%System Root%\ProgramData\VMMLogs\DRALogs_.

### How to troubleshoot on Microsoft Azure

Follow these steps to collect SRS logs from the Azure Site Recovery portal:

1. Log on to the [Azure portal](https://portal.azure.com).
2. Select **Recovery Services vaults**.
3. Select the vault that hosts your ASR data.
4. Select **Site Recovery jobs**.
5. Locate your job, and then select it.
6. Select **ExportJob** to begin the export process.
7. Select **Export**.
8. Specify a file location, and then select **Save** to export the job details to an .xlsx file.

### How to troubleshoot on Hyper-V hosts

#### For On-premises to On-premises protection

Run the following PowerShell command to collect Hyper-V logs:

```powershell
wevtutil el | findstr /i hyper-v-vmms | % { wevtutil qe $_ /f:text}  
```

#### For On-premises to Azure protection

1. Run the following PowerShell command to collect Hyper-V logs:

    ```powershell
    wevtutil el | findstr /i microsoftazurerecoveryservices-replication | % { wevtutil qe $_ /f:text}  
    ```

2. Collect all the log files in the following location:
_C:\Program Files\Microsoft Azure Recovery Services Agent\Temp_

> [!NOTE]
> These files may be opened in any plain Text Editor.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
