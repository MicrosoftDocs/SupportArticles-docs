---
title: Troubleshoot Windows Update Error 0x8000FFFF
description: Learn how to resolve Windows Update installation error 0x8000FFFF on Windows.
manager: dcscontentpm
audience: itpro
ms.date: 02/12/2026
ms.topic: troubleshooting
ms.reviewer: scotro, mwesley, jarretr, v-ryanberg, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - Install errors starting with 0x800F (CBS E)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

#  Troubleshoot Windows Update error 0x8000FFFF

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

During a Windows Update installation, you receive error code 0x8000FFFF. This error is usually related to the`CryptCATAdminAddCatalog` function.

## Prerequisites

For Microsoft Azure virtual machines (VMs) that are running Windows, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

 This error is visible in the `Event Setup` and `CBS` logs after a failed update occurs.

:::image type="content" source="./media/troubleshoot-windows-update-error-0x8000ffff/0x8000ffff-1.png" alt-text="Example of Windows Update error 0x8000FFFF in the Event Setup log" lightbox="media/troubleshoot-windows-update-error-0x8000ffff/0x8000ffff-1.png":::

Although this error occurs without store corruption, it usually indicates corruption in *C:\Windows\System32\catroot2*.

## Cause 

This error is generally unexpected, and is usually considered to indicate a catastrophic failure. The `CryptCATAdminAddCatalog` process can be affected by corruption in the system files or folders, such as the *catroot2* folder.

## Resolution

For Windows-based computers, perform an [in-place upgrade](/windows-server/get-started/perform-in-place-upgrade#perform-the-in-place-upgrade). 

For VMs that are running Windows in Azure, see [in-place upgrade on the Windows virtual machine](/azure/virtual-machines/windows-in-place-upgrade).
