---
title: Hyper-V virtual machine can't start when System Guard Secure Launch is enabled
description: Discusses the issue in which a Hyper-V virtual machine can't start in Windows Server 2019, or Windows 10, version 1809 and earlier versions, and provides the resolution and the workaround.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, marcush
ms.custom: sap:virtual-machine-will-not-boot, csstroubleshoot
---
# Hyper-V virtual machine can't start when System Guard Secure Launch is enabled

This article helps fix the issue in which a Hyper-V virtual machine can't start.

You have a Hyper-V virtual machine that is running Windows Server 2019, or Windows 10, version 1809 and earlier versions. When System Guard Secure Launch is enabled, the virtual machine can't start. This issue occurs mostly in Windows Server 2019.

To resolve this issue in Windows 10, version 1809 and earlier versions, we recommend you upgrade to the latest Windows version.

## System Guard Secure Launch prerequisites aren't met

System Guard Secure Launch has many prerequisites, which depend on the underlying hardware capabilities. No server hardware is available yet that meets the prerequisites to use the System Guard Secure Launch technology. In addition, the Hyper-V hypervisor doesn't expose these prerequisites to its guests. The virtual machines can't use the System Guard Secure Launch technology.

When System Guard Secure Launch is enabled, the system will be checked whether it can use this technology. If certain prerequisites aren't met during the checking process, System Guard Secure Launch won't be enabled, and the system will boot without a Dynamic Root of Trust. However, this check may cause startup failure, bug checks or malfunctioning Trusted Platform Modules.

## Disable System Guard Secure Launch in Windows Server 2019

To work around this issue, disable System Guard Secure Launch in Windows Server 2019.

> [!NOTE]
> As System Guard Secure Launch might get enabled through [security baselines](/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines), adjust or not apply these baselines.

## More information about System Guard Secure Launch

System Guard Secure Launch is a technology to increase protection from advanced boot attacks. It uses the principle of DRTM, and built-in silicon instructions or firmware enclaves. System Guard Secure Launch allows a system to freely boot into untrusted code initially. However, shortly after that, System Guard Secure Launch launches the system into a trusted state by taking control of the CPUs and forcing any untrusted code down a well-known and measured code path. This action verifies that the untrusted code isn't malicious. By removing early Unified Extensible Firmware Interface (UEFI) code from the trust boundary, System Guard Secure Launch protects systems against bugs or exploits in UEFI. For more information, see [System Guard Secure Launch and SMM protection](/windows/security/threat-protection/windows-defender-system-guard/system-guard-secure-launch-and-smm-protection).
