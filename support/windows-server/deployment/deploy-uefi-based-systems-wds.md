---
title: Windows Deployment Services (WDS) support for UEFI
description: Discusses the support for deploying to UEFI-based systems from Windows Deployment Services (WDS).
ms.date: 09/07/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: scottmca, kaushika, scottmca
ms.prod-support-area-path: Devices and Drivers
ms.technology: windows-server-deployment
---
# Windows Deployment Services (WDS) support for UEFI

This article discusses the support for deploying to UEFI-based systems from Windows Deployment Services (WDS).

_Original product version:_ &nbsp;Windows Server 2012 R2  
_Original KB number:_ &nbsp;2938884

## More information

| Scenario| Minimum WDS Server Version| Minimum WinPE Version(boot.wim)| Notes |
|---|---|---|---|
|X64|Windows Server 2008|Windows PE 2.0(Windows Server 2008)|X64 UEFI introduced in Windows Server 2008. Prior to 2012 WDS supported UEFI 2.1 for X64 and IA64 only|
|x64 UEFI 2.3.1|Windows Server 2008 R2|Windows PE 4.0(Windows Server 2012)|2.3.1 support added in Windows Server 2012|
|x86 UEFI|Windows Server 2012|Windows PE 4.0(Windows Server 2012)|Support for x86 UEFI added in Windows Server 2012|
|UEFI PXE IPv6|Windows Server 2012|Windows PE 4.0(Windows Server 2012)|Support for IPv6 added in Windows Server 2012|
|||||

For more information on Windows Deployment Services versions and the operating systems they support deploying, see the following article:

[What's New in Windows Deployment Services in Windows Server 2012](https://technet.microsoft.com/library/hh974416.aspx)
