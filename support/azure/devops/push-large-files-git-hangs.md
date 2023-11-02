---
title: Pushing large files by Git client hangs
description: This article provides resolutions for the problem that hangs when you use Git push to push large files to Team Foundation Server on Windows Server 2008 R2.
ms.date: 08/14/2020
ms.custom: sap:Repos
ms.reviewer: Matt Cooper
ms.service: azure-devops
ms.subservice: ts-repos
---
# Pushing large files to Team Foundation Server by Git client hangs

This article helps you resolve the problem that hangs when you use Git push to push large files to Team Foundation Server on Windows Server 2008 R2.

_Original product version:_ &nbsp; Team Foundation Server 2013, Team Foundation Server 2015, Team Foundation Server 2017, Windows Server 2008 R2  
_Original KB number:_ &nbsp; 4017691

## Symptoms

When you use the Git client to push 5 MB or larger files over HTTPS to Microsoft Visual Studio Team Foundation Server 2013, 2015, or 2017, the operation may hang.

> [!NOTE]
> This issue only occurs on Team Foundation Server that is installed on Windows Server 2008 R2.

## Cause

This issue occurs because Transport Layer Security (TLS) 1.0 is enabled in Windows Server 2008 R2by default. However, Git push operation requests TLS 1.1 and TLS 1.2. This causes Git pushes over HTTPS to use TLS 1.0 and to hang when you push files larger than 5 MB.

## Resolution

To fix this problem, enable TLS 1.1 and TLS 1.2 on Windows Server 2008 R2. To do this, install the [Update to enable TLS 1.1 and TLS 1.2 as a default secure protocols in WinHTTP in Windows](https://support.microsoft.com/help/3140245/update-to-enable-tls-1.1-and-tls-1.2-as-a-default-secure-protocols-in-winhttp-in-windows).

## Applies to

- Team Foundation Server 2013
- Team Foundation Server 2015 Express
- Team Foundation Server 2015
- Team Foundation Server 2017
- Windows Server 2008 R2 Enterprise
- Windows Server 2008 R2 Datacenter
- Windows Server 2008 R2 Standard
- Windows Server 2008 R2 Foundation

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
