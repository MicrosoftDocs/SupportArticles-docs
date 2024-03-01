---
title: Error (BlInitializeLibrary failed XXX) when you install or start an operating system on a 64-bit UEFI-based computer
description: Works around a problem that occurs when you install or start an operating system on a 64-bit UEFI-based computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Error (BlInitializeLibrary failed XXX) when you install or start an operating system on a 64-bit UEFI-based computer

This article provides a workaround for an issue where an error (BlInitializeLibrary failed XXX) occurs when you install or start an operating system on a 64-bit UEFI-based computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4020050

## Symptoms

When you try to install or start an operating system on a 64-bit UEFI-based computer, the system does not start, and you receive the following error message:

> BlInitializeLibrary failed XXX

> [!NOTE]
> The error code could also be 0xc000009a or 0xc0000001.

## Cause

This problem occurs because the boot firmware on the computer generates lots of memory fragmentation.

> [!NOTE]
> Not all "BlInitializeLibrary failed XXX" errors are caused by this issue.

## Workaround

We recommend that you do not let boot firmware create large amounts of fragmentation. Large memory fragmentation degrades the overall startup performance and causes problems.

## More information

At the pre-boot stage, Windows Boot Manager sets the maximum number of global memory descriptor for a 64-bit UEFI system at 512. If the boot firmware creates a large amount of memory fragmentation, the memory descriptor count may exceed the set limit. This causes the "BlInitializeLibrary failed XXX" error.

> [!NOTE]
> This design applies only to the current operating system releases, including Windows 10, Windows Server 2016, and Windows Server 2012 R2. We do not guarantee that this design will apply to future versions.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
