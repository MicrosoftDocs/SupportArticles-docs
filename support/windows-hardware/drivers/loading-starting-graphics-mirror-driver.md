---
title: Loading and starting a graphics Mirror driver
description: This article provides resolutions for the problem when a User connects to a remote computer with RDP and attempts to load a graphics mirror driver on a remote system, the mirror driver may fail to install or start.
ms.date: 09/04/2020
ms.custom: sap:Windows 7 Enterprise
ms.subservice: display-driver
---
# Loading and starting a graphics Mirror driver over RDP

This article helps you resolve the problem when a User connects to a remote computer with RDP and attempts to load a graphics mirror driver on a remote system, the mirror driver may fail to install or start.

_Original product version:_ &nbsp; Windows 7, Windows Vista  
_Original KB number:_ &nbsp; 2473255

## Symptoms

Windows 7 and Windows Server 2008 R2 include the Remote Desktop Protocol (RDP) feature which provides a user with a graphical interface to a remote computer. When a User connects to a remote computer with RDP and attempts to load a graphics mirror driver on a remote system using this remote desktop protocol, the mirror driver may fail to install or start.

## Cause

A specific flag needs to be written to the registry to enable correct function on the remote system.

## Resolution

The mirror driver's INF file must include `TSCompatible` in the `SotwareDeviceSettings` section of the INF file, for example:

```console
[mirror_SoftwareDeviceSettings]  
HKR,, TSCompatible, %REG_DWORD%, 1
```

## Applies to

- Windows 7 Enterprise
- Windows 7 Home Basic
- Windows 7 Home Premium
- Windows 7 Professional
- Windows 7 Starter
- Windows 7 Ultimate
- Windows Vista Enterprise 64-bit Edition
- Windows Vista Home Basic 64-bit Edition
- Windows Vista Home Premium 64-bit Edition
- Windows Vista Business
- Windows Vista Business 64-bit Edition
- Windows Vista Home Basic
- Windows Vista Home Premium
- Windows Vista Service Pack 2
- Windows Vista Ultimate
