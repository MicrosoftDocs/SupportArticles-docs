---
title: Hyper-V virtual machine can't start when System Guard Secure Launch is enabled
description: Discusses that a Hyper-V virtual machine can't start in Windows Server 2019, or Windows 10, version 1809 and earlier versions, and provides the resolution and the workaround.
ms.date: 03/30/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, marcush
ms.custom: sap:virtual-machine-will-not-boot, csstroubleshoot
ms.technology: hyper-v
---
# Hyper-V virtual machine can't start when System Guard Secure Launch is enabled

This article helps fix the issue in which a Hyper-V virtual machine can't start.

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

You have a Hyper-V virtual machine that is running Windows Server 2019, or Windows 10, version 1809 and earlier versions. When System Guard Secure Launch is enabled, the virtual machine can't start. This issue occurs mostly in Windows Server 2019. For Windows 10, version 1809 and earlier versions, upgrade the system to Windows 10, version 1903 and later versions to resolve this issue.

## System Guard Secure Launch prerequisites aren't met

System Guard Secure Launch has many prerequisites, which depend on the underlying hardware capabilities. As the Hyper-V hypervisor doesn't expose these prerequisites to its guests, the virtual machines can't use the System Guard Secure Launch technology.

When System Guard Secure Launch is enabled, the system will be checked if it can use this technology. If certain prerequisites aren't met during the checking, System Guard Secure Launch won't be enabled, and the system will boot without a Dynamic Root of Trust. However, this check may cause startup failure, bugchecks or malfunctioning Trusted Platform Modules.

## Disable System Guard Secure Launch in Windows Server 2019

No server hardware is available yet to use the System Guard Secure Launch technology, and Dynamic Root of Trust for Measurement (DRTM) doesn't expose the required hardware features. To work around this issue, disable System Guard Secure Launch in Windows Server 2019.

> [!NOTE]
> As System Guard Secure Launch might get enabled through [security baselines](/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines), adjust or not apply these baselines.

## More information about System Guard Secure Launch

System Guard Secure Launch is a technology to increase protection from advanced boot attacks. It leverages the principle of DRTM, and built-in silicon instructions or firmware enclaves. System Guard Secure Launch allows a system to freely boot into untrusted code initially, but shortly after launches the system into a trusted state by taking control of the CPUs and forcing any untrusted code down a well-known and measured code path. This action verifies that the untrusted code isn't malicious. By removing early Unified Extensible Firmware Interface (UEFI) code from the trust boundary, System Guard Secure Launch protects systems against bugs or exploits in UEFI.
