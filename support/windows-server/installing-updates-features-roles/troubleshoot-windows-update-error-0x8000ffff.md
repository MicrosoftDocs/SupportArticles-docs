---
title: Troubleshoot Windows Update Error 0x8000FFFF
description: Learn how to resolve the Windows update installation error 0x8000FFFF on Windows.
manager: dcscontentpm
audience: itpro
ms.date: 11/6/2025
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

You encounter the error code 0x8000FFFF during a Windows Update installation. This error is usually related to `CryptCATAdminAddCatalog`.

## Prerequisites

For virtual machines (VMs) running Windows in Azure, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

 This error is visible in the `Event Setup` and `CBS` logs following a failed update.

:::image type="content" source="./media/troubleshoot-windows-update-error-0x8000ffff/0x8000ffff-1.png" alt-text="Example of Windows Update error 0x8000FFFF in the Event Setup log" lightbox="../../../../../../GitHub/SupportArticles-docs-pr/support/windows-server/installing-updates-features-roles/media/troubleshoot-windows-update-error-0x8000ffff/0x8000ffff-1.png":::

Although this error occurs without store corruption, it usually indicates corruption in *C:\Windows\System32\catroot2*.

## Root cause 

This is considered an unexpected error, usually seen as a catastrophic failure. It's related to the `CryptCATAdminAddCatalog` process which can be affected by corruption in the system files or directories, like the *catroot2* folder.

## Resolution

For Windows-based computers, perform an [in-place upgrade](/windows-server/get-started/perform-in-place-upgrade#perform-the-in-place-upgrade). 

For VMs running Windows in Azure, see [in-place upgrade on the Windows virtual machine](/azure/virtual-machines/windows-in-place-upgrade).