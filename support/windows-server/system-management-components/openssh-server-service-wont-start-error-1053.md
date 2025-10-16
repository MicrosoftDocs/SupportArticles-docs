---
title: OpenSSH Server Service Doesn't Start and Generates Error 1053
description: Discusses an issue where you install OpenSSH Server, but afterwards you can't start the OpenSSH Server service.
ms.date: 10/28/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: warrenw, kaushika, v-appelgatet
ms.custom:
- sap:system management components\openssh (including sftp)
- pcy:WinComm User Experience
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# OpenSSH Server service doesn't start and generates error 1053

This article discusses an issue where you install OpenSSH Server, but after the component installs you can't start the OpenSSH Server service.

## Symptoms

You might see this issue in situations that resemble the following scenarios:

- Scenario 1:

  - You install Windows Server 2019 by using an image that includes the [January 14, 2025-https://support.microsoft.com/en-us/topic/january-14-2025-kb5050008-os-build-17763-6775-9a174725-a7ea-4e37-a6f8-e86f7c4d3f31 (OS Build 17763.6775)](https://support.microsoft.com/topic/january-14-2025-kb5050008-os-build-17763-6775-9a174725-a7ea-4e37-a6f8-e86f7c4d3f31) cumulative Windows update, or a later cumulative update.
  - After setup finishes, you install OpenSSH Server, which is a Feature on Demand (FOD). You *don't* install OpenSSH Client at this time.

- Scenario 2:

  - You have a computer that runs Windows Server 2022, Windows Server 2019, Windows 11, or Windows 10.
  - You install OpenSSH Server from the GitHub repository at [PowerShell/openssh-portable](https://github.com/PowerShell/openssh-portable) or [Win32-OpenSSH GitHub Releases](https://github.com/PowerShell/Win32-OpenSSH/releases). You *don't* install OpenSSH Client from this location.

In either scenario, when you try to start the OpenSSH Server service the service doesn't start. You receive the following message:

> Error 1053: The server did not respond to the start or control request in a timely fashion.

## Cause

This issue occurs because the versions of OpenSSH Client, OpenSSH Server, and libcrypto.dll don't match. In these scenarios, the following events lead to this mismatch:

- Scenario 1:

  1. You install Windows Server, which includes OpenSSH Client and libcrypto.dll.
  1. The update that you installed along with Windows Server included updates for OpenSSH. At the time of installation, Windows Update detects OpenSSH Client and libcrypto.dll, and updates them. Because OpenSSH Server isn't installed, Windows Update doesn't install that part of the update.
  1. You install OpenSSH Server from Windows Update or from an offline image. The version that installs doesn't have the update, and the update is not available on the computer to apply retroactively.

- Scenario 2:

  1. You install Windows or Windows Server, both of which include OpenSSH Client and libcrypto.dll.
  1. Microsoft publises a preview version of OpenSSH to the GitHub repositories at [PowerShell/openssh-portable](https://github.com/PowerShell/openssh-portable) or [Win32-OpenSSH GitHub Releases](https://github.com/PowerShell/Win32-OpenSSH/releases).
  1. You install OpenSSH Server from one of the GitHub repositories. This action installs the preview version.

In both scenarios, the OpenSSH Server version doesn't match the OpenSSH Client and libcrypto.dll versions. As a result, OpenSSH Server can't start.

## Resolution

Select the method that's appropriate for your environment.

### Method 1: Installing OpenSSH Server as a Feature on Demand by using Windows Update or an offline Windows image

> [!IMPORTANT]  
> If you build or modify your own Windows images, make sure that you add any Language Packs first, then any Features on Demand. Afterward, you can add applications and updates as described in [Add updates to a Windows image](/windows-hardware/manufacture/desktop/servicing-the-image-with-windows-updates-sxs?view=windows-11).

After you install OpenSSH Server as a Feature on Demand, reinstall the most recent cumulative Windows update on that computer.

### Method 2: Installing OpenSSH Server by using package files from a GitHub repository

Install both the OpenSSH Server *and* the OpenSSH Client packages together, even if one of the OpenSSH components is already installed.
