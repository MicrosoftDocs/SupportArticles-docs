---
title: Windows Deployment Services (WDS) support for UEFI
description: Discusses the support for deploying to UEFI-based systems from Windows Deployment Services (WDS).
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: scottmca, kaushika, scottmca
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Windows Deployment Services (WDS) support for UEFI

This article discusses the support for deploying to UEFI-based systems from Windows Deployment Services (WDS).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2938884

## More information

| Scenario| Minimum WDS Server Version| Minimum WinPE Version(boot.wim)| Notes |
|---|---|---|---|
|X64|Windows Server 2008|Windows PE 2.0(Windows Server 2008)|X64 UEFI introduced in Windows Server 2008. Prior to 2012 WDS supported UEFI 2.1 for X64 and IA64 only|
|x64 UEFI 2.3.1|Windows Server 2008 R2|Windows PE 4.0(Windows Server 2012)|2.3.1 support added in Windows Server 2012|
|x86 UEFI|Windows Server 2012|Windows PE 4.0(Windows Server 2012)|Support for x86 UEFI added in Windows Server 2012|
|UEFI PXE IPv6|Windows Server 2012|Windows PE 4.0(Windows Server 2012)|Support for IPv6 added in Windows Server 2012|
  
For more information on Windows Deployment Services versions and the operating systems they support deploying, see the following article:

[What's New in Windows Deployment Services in Windows Server 2012](https://technet.microsoft.com/library/hh974416.aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
