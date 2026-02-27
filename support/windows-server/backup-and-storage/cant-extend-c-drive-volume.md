---
title: Can't extend drive C because Extend Volume isn't available
description: Discusses an issue in which you can't extend drive C in Windows because the Extend Volume command isn't available in the Disk Management tool.
ms.date: 02/27/2026
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

# No Extend Volume command for drive C in Disk Management

## Summary

This article discusses how to fix an issue in which you can't extend drive C in Windows because the **Extend Volume** command isn't available in the Disk Management tool. This issue usually occurs because unallocated space isn't immediately adjacent to the partition that you want to expand. This article also explains how to verify the layout of the partitions, make the required unallocated space contiguous, and then safely extend drive C.

## Symptoms

In the Disk Management tool, you right-click drive C to try to extend the drive. However, the **Extend Volume** command is unavailable (grayed out). You might also see error messages that indicate that the drive can't be extended.

## Cause

This issue occurs if the unallocated space on the disk isn't directly adjacent to the drive C partition. In the Disk Management tool, you can extend a volume into only unallocated space that's immediately adjacent to the volume. If the unallocated space is on another part of the disk, or if it isn't correctly assigned, the extension command is disabled.

## Resolution

To resolve this issue, make sure that the unallocated space is directly adjacent to drive C. Then, extend drive C.

> [!IMPORTANT]  
> Always back up your data before making changes to disk partitions.

1. To review the partition map of the disk that hosts the drive C volume, use Disk Management. Select **Start**, enter *disk management*, and then select **Disk Management** in the search results.

1. Look for any partitions that appear between drive C and the unallocated space on the drive.

1. Move or remove the partitions that you found in the previous step. You can use a third-party partition management tool, or you can back up the partitions, and then delete them. You can restore the partitions and content after you extend drive C.

1. In Disk Management, right-click drive C, and then select **Extend Volume**. Follow the instructions in the wizard.

## Data collection

If you need assistance from Microsoft Support, gather the following information before you create a support request:

- A screenshot of the Disk Management tool that shows all the partitions and unallocated space.
- The version of Windows that you're using. To find this information, go to **Settings** > **System** > **About**.
- Any error messages that you received when you tried to extend drive C.
