---
title: Troubleshoot Windows Update download errors
description: Learn how to troubleshoot Windows Update download error codes 0x80D02002, 0x80072EFD, and 0x80072EFE in Windows.
manager: dcscontentpm
audience: itpro
ms.date: 02/12/2026
ms.topic: troubleshooting
ms.reviewer: scotro, mwesley, jarretr, v-ryanberg, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\Windows Update - Install errors starting with 0x8024 (WU E Setup)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update download errors

**Applies to:** :heavy_check_mark: Windows VMs

## Summary 

During a scan for updates on Windows Virtual Machines (VMs), you might encounter error codes such as 0x80072EFD, 0x80072EFE, and 0x80D02002. These errors indicate issues that affect server connections or download progress. Understanding the symptoms and root causes can help you to resolve these errors effectively.

:::image type="content" source="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-errormessage80072efd.png" alt-text="Error message 80072EFD" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-errormessage80072efd.png":::

## Prerequisites

For Microsoft Azure virtual machines (VMs) that run Windows, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

### Symptom 1: Error messages during scanning

When you scan for updates on a Windows VM, you receive the following error message or a similar message that indicates a server connection issue:

> Windows could not search for new updates
   
   :::image type="content" source="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-event16.png" alt-text="System event log 16 indicating connection issue" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-event16.png":::

   :::image type="content" source="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-event25.png" alt-text="Windows Update client Operational event 25" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-event25.png":::

   Check the Windows Update logs for error codes at the following location:
   
   `%windir%\logs\windowsupdate`

   :::image type="content" source="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-windowsupdatelogs.png" alt-text="Windows Update logs" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-windowsupdatelogs.png":::

### Symptom 2: Windows Updates error code indicates no internet access

When you scan for updates, Windows Updates shows an error code that indicates that you have no internet access. External sites load, but Microsoft links fail and return a TLS error message.

   :::image type="content" source="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-errormessage80072efe.png" alt-text="Error message 80072EFE" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-errormessage80072efe.png":::

   :::image type="content" source="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-tlserror.png" alt-text="TLS error accessing Microsoft update site" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024a000/cant-install-updates-error-code-8024a000-80072efd-80072efe-tlserror.png":::

## Cause

**Error code 0x80072EFD**: This error occurs when firewall rules or proxies block Microsoft download URLs and prevent a server connection.

**Error code 0x80072EFE**: This error is caused by issues that affect TLS ciphers. This error disrupts connections to Microsoft sites.

## Resolution or troubleshooting steps

### Resolution 1: Check network configurations

   - Verify that traffic is routed through a Network Virtual Appliance (NVA).
   - Make sure that the NVA allows the following Windows Update URLs:

     ```console
     http://windowsupdate.microsoft.com
     http://*.windowsupdate.microsoft.com
     https://*.windowsupdate.microsoft.com
     http://*.update.microsoft.com
     https://*.update.microsoft.com
     http://*.windowsupdate.com
     http://download.windowsupdate.com
     https://download.microsoft.com
     http://*.download.windowsupdate.com
     http://wustat.windows.com
     http://ntservicepack.microsoft.com
     http://go.microsoft.com
     http://dl.delivery.mp.microsoft.com
     https://dl.delivery.mp.microsoft.com
     ```

   - Make sure that ports 80 and 443 are open for communication.

### Resolution 2: Verify TLS settings

   - Open an elevated Command Prompt window, and run the following command to check whether TLS 1.2 is enabled:

     ```shell
     reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server
     ```

     Make sure that the values are set as follows:

     ```output
     Enabled    REG_DWORD    0x1
     DisabledByDefault    REG_DWORD    0x0
     ```

   - If `TLS 1.2` is disabled, change it to `0x1`.

### Resolution 2.1: Fix Group Policy Object (GPO)-related issues

   - If external site connectivity is working as expected, and previous mitigations don't work, check for the following registry subkey:

     ```shell
     reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\XXXXXXXX"
     ```

   - Delete all content that's inside the `XXXXXXXX` hive or folder to test whether a GPO is causing the issue.

   - If the issue persists, remove the computer object from the Organizational Unit (OU) with SSL cipher configurations.
