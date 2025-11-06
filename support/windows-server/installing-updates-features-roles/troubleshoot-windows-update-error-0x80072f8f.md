---
title: Troubleshoot Windows Update Error 0x80072f8f
description: Learn how to resolve Windows Update error 0x80072f8f on Windows.
manager: dcscontentpm
audience: itpro
ms.date: 01/15/2025
ms.topic: troubleshooting
ms.reviewer: kaushika, maeltedebay, v-lianna
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80072f8f

## Summary

When attempting to connect to Windows Update, you might encounter error 0x80072f8f. This error usually indicates issues with SSL negotiation due to out-of-sync clock settings or untrusted SSL certificates. 

:::image type="content" source="./media/troubleshoot-windows-update-error-0x80072f8f/updateerror0x80072f8f-wusaerror.png" alt-text="Windows Update error 0x80072f8f" lightbox="media/troubleshoot-windows-update-error-0x80072f8f/updateerror0x80072f8f_wusaerror.png":::

## Prerequisites

Ensure you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

### Symptom 1

Windows Update fails with error 0x80072f8f. Check the `WindowsUpdate.log` located at *C:\Windows\Logs\WindowsUpdate* for entries similar to the following one:

```output
03E4 1668 SLS Making request with URL HTTPS://sls.update.microsoft.com/SLS/{9482F4B4-E343-43B6-B170-9A65BC822C77}/x64/10.0.14393.0/0?CH=531&L=en-US&P=&PT=0x7&WUA=10.0.14393.1794
03E4 1668 Misc Send request failed, hr:0x80072f8f
03E4 1668 Misc WinHttp: SendRequestToServerForFileInformation failed with 0x80072f8f; retrying with default proxy.
03E4 1668 Misc Send request failed, hr:0x80072f8f
03E4 1668 Misc Library download error. Error 0x80072f8f. Will retry. Retry Counter:0
```

### Symptom 2

When you download updates from Windows Update, there's no progress. The `WindowsUpdate.log` shows failures on WinHTTP requests to `SLS.Update.Microsoft.com`:

```output
2032 2248 ComApi * START * Federated Search ClientId = Device Driver Retrieval Client (cV: xXbBtDYuUUOnH3AK.1.0)
4744 4120 Misc *FAILED* [80072F8F] Send request
4744 4120 Misc *FAILED* [80072F8F] WinHttp: SendRequestToServerForFileInformation (retrying with default proxy)
4744 4120 Misc *FAILED* [80072F8F] Library download error. Will retry. Retry Counter:0
```

### Symptom 3

When you check for updates from Windows Update, there's no progress. The `WindowsUpdate.log` indicates `HTTP Send Request failed with 0x80072f8f (WININET_E_DECODING_FAILED)`:

```output
7452 3228 Misc *FAILED* [80072F8F] Send request
7452 3228 Misc *FAILED* [80072F8F] WinHttp: SendRequestToServerForFileInformation (retrying with default proxy)
7452 3228 Misc *FAILED* [80072F8F] Library download error. Will retry. Retry Counter:0
```

## Root cause

The error 0x80072f8f is usually caused by one of the following issues:

- **Out-of-sync clock**: If the clock settings on the computer are incorrect, SSL negotiation fails. You can quickly verify clock accuracy from `WindowsUpdate.log` that always prints traces in local time.
- **Untrusted SSL certificate**: In managed scenarios with Windows Server Update Services (WSUS) or Configuration Manager configured over SSL with self-generated or signed SSL certificates, if the client doesn't trust the certificate chain, the scan fails.

## Resolution

Perform an [in-place upgrade](/azure/virtual-machines/windows-in-place-upgrade) on the Windows virtual machine.