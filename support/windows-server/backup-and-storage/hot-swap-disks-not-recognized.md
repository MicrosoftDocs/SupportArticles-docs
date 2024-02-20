---
title: Hot-swap disks are not recognized
description: Fixes an issue in which Windows Disk Management does not show hot-swap drives
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, aamelt, delhan
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# Hot-swap disks are not recognized

This article provides some workarounds for the issue where Hot-swap disks are not recognized.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2992869

## Symptoms

Assume that you have a computer that supports hot-swap SATA disks and is running Windows Server 2012 R2. For some system configurations, when you insert one or more drives into the computer, Windows cannot detect all the inserted drives. Therefore, you cannot see the drives in **This PC** or the Windows Disk Management snap-in.  

## Cause

This issue occurs because of a communication error that occurs between the affected drives and Windows.

## Workaround

To work around this issue, you can use one of the following methods.

- Method 1

    Remove and reinsert the affected drives.

- Method 2

    Use the Windows Disk Management snap-in tool, and then rescan for disks.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products at the beginning of this article.  

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
