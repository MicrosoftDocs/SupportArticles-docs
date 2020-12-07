---
title: Recommended antivirus exclusions for Azure Recovery Services
description: Describes recommended antivirus (AV) settings for servers that have Microsoft Azure Recovery Services (ASR) software installed. The various exclusion sets for each role are described.
ms.date: 10/10/2020
ms.prod-support-area-path: 
ms.service: backup
ms.author: genli
author: genli
ms.reviewer: markstan
---
# Recommended antivirus exclusions for Azure Recovery Services

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 3186955

## Summary

This article describes recommended antivirus (AV) settings for servers that have Microsoft Azure Recovery Services (ASR) software installed. The various exclusion sets for each role are described.

## More information

### Azure Site recovery (ASR) SCVMM to Azure Deployment: Antivirus exclusion guidance

#### System Center 2012 R2 Virtual Machine Manager (SC 2012 R2 VMM) servers 

VMM servers should include all exclusions that are detailed in the following Microsoft Knowledge Base (KB) article:

[3119208](https://support.microsoft.com/help/3119208) Recommended antivirus exclusions for System Center Virtual Machine Manager and managed hosts

Additionally, exclude items from the following location:

`%ProgramData%\ASRLogs`

#### Clustered Services (VMM and ASR Agent installed on Hyper-V clusters) 

For information about recommended exclusions for Cluster Services, see the following KB article:

[250355](https://support.microsoft.com/help/250355) Antivirus software that is not cluster-aware may cause problems with Cluster Services

#### Azure Site recovery (ASR) Hyper-V to Azure deployment: Antivirus exclusion guidance

#### Hyper-V Servers (ASR Agent) 

Exclude all items that are listed in the following KB article:

[3105657](https://support.microsoft.com/help/3105657) Recommended antivirus exclusions for Hyper-V hosts

Additionally, exclude all items from the following locations:

`%ProgramFiles%\Microsoft Azure Recovery Services Agent\Scratch`  
`%ProgramFiles%\Microsoft Azure Recovery Services Agent\Temp`

### Azure Site recovery (ASR) VMware to VMware deployment: Antivirus exclusion guidance

#### Source servers 

Exclude the following situation:

- The installation path of the Scout agent; by default, this location is `C:\Program Files (x86)\InMage Systems`.
- The Application cache directory; by default, it goes under the installation path. If configured separately, check here. By default, the path is `C:\Program Files (x86)\InMage Systems\hostconfigwxcommon.exe`. Check the Application cache on the **Agent** tab.
- In case of MSCS cluster volumes, exclude the InMageClusterLog folder under every cluster volume.

#### Master-target (MT) servers 

Exclude the following situation:

- The installation path of Scout MT; by default, this location is `C:\Program Files (x86)\InMage Systems`.
- The target cache directory; by default, it goes under the installation path. If configured separately, check here. By default, the path is `C:\Program Files (x86)\InMage Systems\hostconfigwxcommon.exe`. Check the Application cache on the **Agent** tab.
- All Retention log volumes.
- The `C:\SRV` path and all subfolders.

### Azure Site recovery (ASR) VMware to Azure deployment: Antivirus exclusion guidance

#### Source servers (Configuration Server, Process Server, Master Target) 

Exclude the installation path of the Azure Site Recovery agent; by default, this location is `C:\Program Files(x86)\Azure Site Recovery`.

Exclude the installation path of the Recovery Services agent; by default, this location is `C:\Program Files\Microsoft Azure Recovery Services Agent`.

#### Protected VMs  

Guest virtual machines (VMs) that are protected by ASR should exclude the installation folder where the guest agent is installed. By default, it is `C:\Program Files (x86)\Azure Site Recovery`.
