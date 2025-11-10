---
title: Troubleshoot Windows Update download error codes associated with error 8024A000
description: Learn how to troubleshoot Windows Update download error codes 0x80D02002, 0x80072EFD, and 0x80072EFE in Windows.
manager: dcscontentpm
audience: itpro
ms.date: 11/10/2025
ms.topic: troubleshooting
ms.reviewer: scotro, mwesley, jarretr, v-ryanberg, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\Windows Update - Install errors starting with 0x8024 (WU E Setup)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update download error codes associated with error code 8024A000

**Applies to:** :heavy_check_mark: Windows VMs

## Summary 

When scanning for updates on Windows Virtual Machines (VMs), you might encounter error codes such as 0x80072EFD, 0x80072EFE, and 0x80D02002. These errors indicate issues with server connections or download progress. Understanding the symptoms and root causes can help in resolving these errors effectively.

:::image type="content" source="./media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024a000-80072efd-80072efe-errormessage80072efd-.png" alt-text="Error message 80072EFD" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024a000-80072efd-80072efe-errormessage80072efd-.png":::

## Prerequisites

For virtual machines (VMs) running Windows in Azure, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

### Symptom 1: While scanning for updates, you see error messages indicating a connection issue with the server

   :::image type="content" source="./media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024a000-80072efd-80072efe-event16.png" alt-text="System event log 16 indicating connection issue" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024A000-80072EFD-80072EFE-event16.png":::

   :::image type="content" source="./media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024a000-80072efd-80072efe-event25.png" alt-text="Windows Update client Operational event 25" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024A000-80072EFD-80072EFE-event25.png":::

   Check the Windows Update logs for error codes at the path: `%windir%\logs\windowsupdate`.

   :::image type="content" source="./media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024a000-80072efd-80072efe-windowsupdatelogs.png" alt-text="Windows Update logs" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024A000-80072EFD-80072EFE-windowsupdatelogs.png":::

### Symptom 2: Control Panel > System and Security > Windows Updates shows an error code indicating no Internet access to download updates - external sites load, but Microsoft links fail with a TLS error

   :::image type="content" source="./media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024a000-80072efd-80072efe-errormessage80072efe.png" alt-text="Error message 80072EFE" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024a000-80072efd-80072efe-errormessage80072efe.png":::
   
   :::image type="content" source="./media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024a000-80072efd-80072efe-tlserror.png" alt-text="TLS error accessing Microsoft update site" lightbox="media/troubleshoot-windows-update-download-error-codes-associated-with-error-8024A000/cant-install-updates-error-code-8024A000-80072EFD-80072EFE-TLSerror.png":::

## Root cause for Windows Update download error codes

**Error code 0x80072EFD**: This error occurs when firewall rules or proxies block Microsoft download URLs, preventing a connection with the server.

**Error code 0x80072EFE**: This error is caused by issues with TLS ciphers, which disrupt connections to Microsoft sites.

## Resolution or troubleshooting steps

### Mitigation 1: Check network configurations

   - Confirm if traffic is routed through a Network Virtual Appliance (NVA).
   - Ensure the NVA allows the following Windows Update URLs:

     ```plaintext
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

   - Ensure ports 80 and 443 are open for communication.

### Mitigation 2: Verify TLS settings.

   - Open Command Prompt as an admin and run the following command to check if TLS 1.2 is enabled:

     ```shell
     reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server
     ```

     Ensure the values are set as follows:

     ```output
     Enabled    REG_DWORD    0x1
     DisabledByDefault    REG_DWORD    0x0
     ```

   - If `TLS 1.2` is disabled, modify it to `0x1`.

### Mitigation 2.1: Address Group Policy Object (GPO)-related issues

   - If external site connectivity is working as expected and previous mitigations don't work, check for the following registry key:

     ```shell
     reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\XXXXXXXX"
     ```

   - Delete all content inside the `XXXXXXXX` hive or folder to test if a GPO is causing the issue.

   - If the issue persists, remove the computer object from the Organizational Unit (OU) with SSL cipher configurations.

