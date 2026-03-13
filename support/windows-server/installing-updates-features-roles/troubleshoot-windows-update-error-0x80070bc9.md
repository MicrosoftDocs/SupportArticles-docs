---
title: Troubleshoot Windows Update Error 0x80070bc9
description: Learn how to resolve the Windows Update error 0x80070bc9 on Windows.
manager: dcscontentpm
audience: itpro
ms.date: 02/12/2026
ms.topic: troubleshooting
ms.reviewer: scotro, mwesley, jarretr, v-ryanberg, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update Error 0x80070bc9

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

The Windows Update error 0x80070bc9 occurs when the OS is stuck in a pending servicing state and the TrustedInstaller service can't clear it due to corruption in the *Transactional Entries* folder.

## Prerequisites

For virtual machines (VMs) running Windows in Azure, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

Check the `CBS.log` file located at *C:\Windows\Logs\CBS\CBS.log* for entries indicating this error (0x80070bc9) similar to the following one:

```output
2025-04-02 07:15:53, Info  CBS    Session: 31171520_2564643148 initialized by client DISM Package Manager Provider.
2025-04-02 07:15:53, Info  CBS    Enumerating Foundation package: Microsoft-Windows-ServerCore-Package~31bf3856ad364e35~amd64~~6.2.9200.16384, this could be slow
2025-04-02 07:15:55, Info  CSI    00000003 CSI Store 616570675040 (0x0000008f8e79df60) initialized
2025-04-02 07:15:55, Info  CSI    00000004 Transaction merge required, do-not-merge flag passed.
2025-04-02 07:15:55, Info  CSI    00000005@2025/4/2:11:15:55.656 CSI Transaction @0x8f8fa30210 initialized for deployment engine {d16d444c-56d8-11d5-882d-0080c847b195} with flags 00000002 and client id [26]"TI5.31171520_2564643148:1/"
2025-04-02 07:15:55, Info  CSI    00000006 Pending transaction content must be resolved, cannot begin another transaction yet
2025-04-02 07:15:55, Info  CBS    <span style="color:red"><b>Failed to get transaction analysis because of pending operations. Disposition from Analyze: 0x1 [HRESULT = 0x80070bc9 - ERROR_FAIL_REBOOT_REQUIRED]</b></span>
2025-04-02 07:15:55, Info  CBS    Failed to get inventory. [HRESULT = 0x80070bc9 - ERROR_FAIL_REBOOT_REQUIRED]
2025-04-02 07:15:55, Info  CSI    00000007@2025/4/2:11:15:55.658 CSI Transaction @0x8f8fa30210 destroyed
2025-04-02 07:15:55, Info  CBS    <span style="color:red"><b>Failed to get CSI Inventory [HRESULT = 0x80070bc9 - ERROR_FAIL_REBOOT_REQUIRED]</b></span>
2025-04-02 07:15:55, Info  CBS    Failed to get component state. [HRESULT = 0x80070bc9 - ERROR_FAIL_REBOOT_REQUIRED]
2025-04-02 07:15:55, Info  CBS    Failed to get current state of the deployment [HRESULT = 0x80070bc9 - ERROR_FAIL_REBOOT_REQUIRED]
2025-04-02 07:15:55, Info  CBS    <span style="color:red"><b>Failed to get Transaction State for package: Microsoft-Windows-NetFx3-Server-OC-Package~31bf3856ad364e35~amd64~~6.2.9200.16384, update: NetFx3 [HRESULT = 0x80070bc9 - ERROR_FAIL_REBOOT_REQUIRED]</b></span>
2025-04-02 07:15:55, Error CBS    Failed to get store state [HRESULT = 0x80070bc9 - ERROR_FAIL_REBOOT_REQUIRED]
2025-04-02 07:17:55, Info  CBS    Trusted Installer successfully registered to be restarted for pre-shutdown
2025-04-02 07:17:55, Info  CBS    Trusted Installer is shutting down because: SHUTDOWN_REASON_AUTOSTOP
2025-04-02 07:17:55, Info  CBS    Stopping Winlogon CreateSession notifications
2025-04-02 07:17:55, Info  CBS    Unloading SysNotify DLL
```

## Root cause 

This error occurs because the OS is in a pending servicing state and the TrustedInstaller service can't clear it due to corruption in the *Transactional Entries* folder. This corruption prevents the completion of update installations and requires a system reboot to roll changes back.

## Resolution

For Windows-based computers, perform an [in-place upgrade](/windows-server/get-started/perform-in-place-upgrade#perform-the-in-place-upgrade). 

For VMs running Windows in Azure, see [in-place upgrade on the Windows virtual machine](/azure/virtual-machines/windows-in-place-upgrade).