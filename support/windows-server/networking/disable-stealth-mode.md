---
title: How to disable stealth mode
description: Discusses how to disable stealth mode (a Windows filtering platform feature) for a given profile.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-firewall-with-advanced-security-wfas, csstroubleshoot
ms.subservice: networking
---
# Disable stealth mode in Windows

This article discusses how to disable stealth mode (a Windows filtering platform feature).

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2586744

## Introduction

Windows Server or Windows client computers do not send Transmission Control Protocol (TCP) reset (RST) messages or Internet Control Message Protocol (ICMP) unreachable packets across a port that does not have a listening application.
Several applications rely on the behavior that is described in [RFC 793](https://tools.ietf.org/html/rfc793#section-3.4), "Reset Generation," Page 35f. These applications require the TCP RST packet or ICMP unreachable packet as a response if they knock on a port that has no listener. If they don't receive this response, the applications might not be able to run correctly on Windows.
Typically, the effect of this dependency is that stealth mode may cause a 20-second delay for regular TCP applications to reconnect if the remote peer loses the connection state and that notification packet doesn't reach the client.
One example of this behavior is Lotus Notes Client. The client can be configured to use different Lotus Notes servers. If the service is not running on the first configured server, the client switches immediately to the second server if it receives a TCP RESET command. If stealth mode is enabled, no TCP RESET is received by the client. The client then waits for the last SYN retransmit to time out before it tries the next server in the list.

## Cause

For ports on which no application listens, the stealth mode feature blocks the outgoing ICMP unreachable packet and TCP RST messages.  
Stealth mode also applies to the endpoints that are in a paused state because of an overrun in the listen backlog parameter.  

## Resolution

Warning
Stealth mode is an important security feature. Disabling it can make the computer vulnerable to attack, even in managed corporate domain networks and behind edge firewalls. Therefore, we strongly recommend that you keep stealth mode active, and disable it only if it is required.

> [!Caution]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.  

Stealth mode is a core security feature. For any given configuration, stealth mode should stay enabled unless there is a strong, valid argument for disabling it.  
Stealth mode can be disabled by using any of the following methods:  

- You can set the **DisableStealthMode** keyword in the Firewall configuration service provider CSP) by using Microsoft Intune or another Mobile Device Management system.
- An Independent software vendor (ISV) can use the Windows Filtering Platform (WFP) API to replace the stealth filters with proprietary filters.
- You can disable the firewall for all profiles. (We do NOT recommend this method.)
- You can add a "disable" value to either of the following sets of registry subkeys:  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\PublicProfile HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\StandardProfile
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile`  

> [!Note]
> In the Software hive "Policy" section, the **StandardProfile** entry is used only if a legacy firewall GPO still exists.  

In either set of subkeys, add the following value:  
Value: **DisableStealthMode**  
Type:  **REG_DWORD**  
Data: **0x00000000 (default - StealthMode enabled) 0x00000001 (StealthMode disabled)**  

> [!Caution]
> Stealth mode cannot be deactivated by disabling the firewall service (MpsSvc). This is an unsupported configuration. For more information, see the "[Disable Windows Defender Firewall with Advanced Security](/windows/security/threat-protection/windows-firewall/windows-firewall-with-advanced-security-administration-with-windows-powershell#disable-windows-defender-firewall-with-advanced-security)" section of "Windows Defender Firewall with Advanced Security Administration with Windows PowerShell."

## More information

[Stealth Mode in Windows Firewall with Advanced Security](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd448557%28v=ws.10%29)  
[Disable Stealth Mode](/openspecs/windows_protocols/ms-gpfas/e0e681d3-0468-4796-b541-c5f9945041d8)  in the "[MS-GPFAS]: Group Policy: Firewall and Advanced Security Data Structure" specification  
[Appendix B: Product Behavior](/openspecs/windows_protocols/ms-fasp/1da2ee70-a6ae-4f76-b08f-fdc25c77d8a0) in "[MS-FASP]: Firewall and Advanced Security Protocol" specification (look for FW_PROFILE_CONFIG_DISABLE_STEALTH_MODE in this appendix)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
