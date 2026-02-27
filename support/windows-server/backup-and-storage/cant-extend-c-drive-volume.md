---
title: Can't extend the C: drive because the "Extend" option isn't available
description: Discusses an issue where you cannot extend the C: drive in Windows because the **Extend Volume** option isn't available in the Disk Management tool.
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

# Can't extend the C: drive because the "Extend" option isn't available in Disk Management

## Summary

This article describes how to fix an issue in which you cannot extend the C: drive in Windows because the **Extend Volume** command isn't available in the Disk Management tool. This issue usually occurs because unallocated space is not immediately adjacent to the partition that you want to expand. The steps explain how to verify the layout of the partitions, make the required unallocated space contiguous, and then safely extend C:.

## Symptoms

In the Disk Management tool, you right-click the C: drive to try to extend it. However, the **Extend Volume** command is grayed out (unavailable). You might also see error messages that indicate that the drive can't be extended.

## Cause

This issue occurs when the unallocated space on the disk is not located directly next to the C: drive partition. In the Disk Management tool, you can only extend a volume into unallocated space that's immediately adjacent to the volume. If the unallocated space is on another part of the disk or if it isn't properly assigned, the extension command is disabled.

## Resolution

To resolve this issue, make sure that the unallocated space is directly adjacent to the C: drive. Then extend the C: drive.

> [IMPORTANT]  
> Always back up your data before making changes to disk partitions.

1. Use Disk Management (in the Search bar, type *disk management* and then in the search results, select **Disk Management**) to review the partition map of the disk that hosts the C: drive volume.

1. Notice any partitions that appear between the C: drive and the unallocated space on the drive.

1. Move or remove the partitions that you noticed in the previous step. You can use a third-party partition management tool, or you can simply back up the partitions and then delete them. You can restore them later, after you extend the C: drive.

1. In Disk Management, right-click the C: drive, and then select **Extend Volume**. Follow the instructions in the wizard.

## Data collection

If you need assistance from Microsoft Support, first gather the following information before you create a support request.

- A screenshot of the Disk Management tool that shows all the partitions and unallocated space.
- The version of Windows you are using. To find this, go to **Settings** > **System** > **About**.
- Any error messages you encountered when you tried to extend the C: drive.
