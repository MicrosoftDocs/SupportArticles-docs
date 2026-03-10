---
title: Disk corrupted after high utilization when attached to Windows Server 2019 VM
description: This article discusses an issue in which a disk that's attached to a Windows Server 2019 virtual machine (VM) becomes corrupted after operating at high utilization levels.
ms.date: 03/10/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:backup,recovery,disk,and storage\data corruption and disk errors
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Disk corrupted after high utilization when attached to Windows Server 2019 VM

## Summary

This article discusses an issue in which a disk that's attached to a Windows Server 2019 virtual machine (VM) becomes corrupted after it operates at high utilization levels. The issue can cause the disk to become missing or inaccessible. This issue can also trigger an unexpected conversion from a basic disk to a dynamic disk. This conversion might affect backup coverage and raise concerns about data loss. This article discusses how to fix this issue and how to configure disk volumes to avoid this issue in the future.

## Symptoms

You run a disk at 95 percent utilization while the disk is attached to a Windows Server 2019 VM. Then, you experience one or more of the following symptoms:

- The disk appears to be missing.
  - You can't access the disk from within the VM.
  - You can't reactivate or restore the missing disk.
- The volume configuration changes without a clear cause.
- If the disk is a basic disk, a data volume unexpectedly converts to a dynamic disk.
  - Backups of the VM don't include the dynamic disk. This condition raises concerns about potential data loss.
  - The affected volume spans multiple disks.

## Cause

This issue can occur if you extend a basic disk volume by adding unallocated space from a different physical or virtual disk. In such cases, Windows might accommodate the spanned volume by automatically converting the basic disk to a dynamic disk. Backup configurations that don't account for dynamic disks might not capture the affected volume, especially if the volume is offline or in an altered state during the backup process.

In a high-utilization scenario, the risk of such a disk volume becoming unstable increases. Such instability can contribute to the disk becoming corrupted.

## Resolution

To fix this issue and prevent it from reoccurring, follow these steps:

1. Extend disk volumes in a manner that avoids the automatic conversion behavior. Use one of the following methods:

   - Make sure that all of the space that the volume needs resides on a single disk.
   - If the volume requires space from more than one disk, consider using Storage Spaces or other supported configuration that pools storage resources from multiple disks. You can use such an abstracted storage pool to create volumes that meet your performance and backup requirements.

   > [!NOTE]  
   > If you're working with a corrupted disk, and you have a backup of uncorrupted data, make sure that the disk volume is configured as described in this step before you restore the data. You can restore the data in a later step of this procedure.

1. If you use dynamic disks, or if there's a risk that your basic disks might automatically convert to dynamic disks, make sure that your VM backup solution is configured to support dynamic disks. For example, Azure Backup can back up dynamic disks if the disks are online and accessible during the backup operation.

1. If a backup is available, restore the data to the reconfigured volume.

1. Use performance monitoring tools to monitor disk utilization. Avoid sustained periods of high disk utilization (greater than 95 percent). If your system frequently reaches such high utilization rates, consider adding storage resources.

## Data collection

If the issue persists after you finish the resolution steps, collect the following data, and then contact [Microsoft Support](https://support.microsoft.com/contactus):

- VM name and resource group in Azure (if applicable).
- Windows Server 2019 version and build details
  > [!NOTE]  
  > To see the exact version and build number, run `winver` at a command prompt on the affected computer.

- Disk configuration details, including whether the disk is basic or dynamic.
- Details of recent disk management operations, such as volume extensions.
- Backup configuration and logs.
- A screenshot of the Disk Management tool that shows all the partitions and unallocated space.
- Output from the following Windows PowerShell cmdlets:
  - `Get-Disk`
  - `Get-Partition`
  - `Get-Volume`
- Azure activity logs (if applicable) that were generated near the time that the issue occurred.
