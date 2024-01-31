---
title: Network connectivity is lost
description: Information about Microsoft Defender Antivirus antimalware platform update to solve problem of vpn users losing network connectivity.
ms.date: 09/25/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, yongrhee, ksarens, alexsc, niwelton
ms.custom: sap:windows-defender-exploit-guard, csstroubleshoot
ms.subservice: networking
---
# Lost internet connectivity using VPN in Windows Defender Exploit Guard - Network Protection

This article provides a solution to an error that occurs when you use the Network Protection feature in Windows Defender Exploit Guard in Audit or Block mode and a virtual private network (VPN).

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4560203

## Symptoms

When using the Network Protection feature in Windows Defender Exploit Guard in Audit or Block mode and a virtual private network (VPN), you lose network connectivity and receive the **General Failure** error message when pinging an IP address.

## Cause

This issue occurs because the current (4.12.x.x) antimalware platform update supporting the Network Protection feature is missing.

## Solution

Install the latest (4.18.x.x) antimalware platform update as described here:

- [Update for Windows Defender antimalware platform](https://support.microsoft.com/help/4052623).
- [Manage Windows Defender Antivirus updates and apply baselines](/windows/security/threat-protection/windows-defender-antivirus/manage-updates-baselines-windows-defender-antivirus#released-platform-and-engine-versions).
- [SCCM-Endpoint Protection: Enabling "Platform Update" for Microsoft Defender AV via SCCM ADR (Part 4)](https://yongrhee.wordpress.com/2020/02/22/sccm-endpoint-protection-enabling-platform-update-for-microsoft-defender-av-via-sccm-adr-part-4/).

## Workaround

Set the following  Group Policy to **Not Configured**:

Computer Configuration > Administrative Templates > Windows components > Windows Defender Antivirus > Windows Defender Exploit Guard > Network protection > Prevent users and apps from accessing dangerous websites
