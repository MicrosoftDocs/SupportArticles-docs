---
title: GPO processing failures across multiple forests
description: Discusses how to troubleshoot Group Policy object processing failures that occur across multiple forests. Provides three scenarios.
ms.date: 10/15/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User, computer, group, and object management
ms.technology: windows-server-active-directory
---
# Troubleshoot Group Policy object processing failures that occur across multiple forests

This article describes how to troubleshoot Group Policy object (GPO) processing failures that occur across multiple forests.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 910206

## Summary

This article discusses the following scenarios:

- [Scenario 1: A GPO does not apply when a user logs on in a trusted domain](#symptoms-for-scenario-1).
- [Scenario 2: A cross-forest GPO application fails if Internet Control Message Protocol (ICMP) is not enabled](#symptoms-for-scenario-2).
- [Scenario 3: Resultant Set of Policy (RSoP) Planning mode is not supported in a cross-forest scenario](#symptoms-for-scenario-3).

## Symptoms for Scenario 1

This problem occurs even though the **Allow Cross-Forest User Policy and Roaming User Profiles** Group Policy setting is enabled. An external trust exists between the domain in which the user is logging on and the user's domain.

For example, this problem occurs in the following scenario:

- A Microsoft Windows Server 2003 Terminal Server belongs to the Terminal Server organizational unit (OU) in a Windows Server 2003-based domain.
- A user who belongs to a Microsoft Windows 2000 Server Service Pack 4 (SP4)-based domain logs on to the Windows Server 2003 Terminal Server.
- The Windows Server 2003-based domain and the Windows 2000-based domain are in separate forests.
- Two external trusts exist between the Windows Server 2000 SP4-based domain in Forest 1 and the Windows Server 2003-based domain in Forest 2.
- A GPO that is linked to the Terminal Server OU has the following settings:

  - The **Allow Cross-Forest User Policy and Roaming User Profiles policy** is enabled. For more information, see [User policies are not applied when you log on to a computer that is running Windows 2000 SP4](https://support.microsoft.com/help/823862).
  - The **User Group Policy loopback processing mode** policy is set to **Merge Mode**.
  - User-based policy settings are configured to hide the **Search**, **Run**, and **Help** commands on the **Start** menu.

This scenario is specific to external trusts between domains in separate forests. This scenario does not apply to forest trusts. Forest trusts and external trusts differ as follows:

- External trusts are used in Windows 2000 to enable trust relationships between two domains that are in different forests.

- Forest trusts resemble external trusts between the root domains of two forests. However, a forest trust encompasses all the domains in each forest. Forest trusts require that all the domain controllers in both forests be running Windows Server 2003.

## Cause for Scenario 1

The problem occurs because the security context of the computer account is being used. Therefore, NTLM cannot be used. Kerberos authentication is required.

## Troubleshooting steps for Scenario 1

To troubleshoot this problem, follow these steps:

1. Use Network Monitor to take simultaneous traces from the client computer in Forest 1 and from the logon domain controller in Forest 2.
2. Enable USERENV logging. For more information about how to do this, see [How to enable user environment debug logging in retail builds of Windows](https://support.microsoft.com/help/221833).

The Network Monitor trace shows that Kerberos authentication fails and that NTLM authentication is not used.

The following information is logged in the Userenv.log file:

> USERENV(ec0.86c) *\<DateTime>* ProcessGPO: Deferring search for \<LDAP://CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=nils,DC=com>  
USERENV(ec0.86c) *\<DateTime>* GetMachineDomainDS: ldap_bind_s failed with 82  
USERENV(ec0.86c) *\<DateTime>* GetGPOInfo: Leaving with 0

## Resolution for Scenario 1

To resolve this problem, apply hotfix 896683 to the Windows Server 2003-based domain controller in Forest 2.

A user in a trusted external domain cannot log on to a Windows Server 2003-based domain even though the **Allow Cross-Forest User Policy and Roaming User Profiles** Group Policy setting is enabled  

This hotfix enables the GPO without requiring Kerberos authentication.

> [!NOTE]
> This problem does not apply to forest trusts between two Windows 2003-based forests that provide full Kerberos support.

## Symptoms for Scenario 2

Cross-forest GPOs are not applied if ICMP is not enabled. Group Policy processing stops if large fragmented ICMP packets are not allowed on the network because of slow link detection. When this occurs, Microsoft Windows XP does not detect a fast link or a slow link. Instead Windows XP fails out of Group Policy processing. Only a generic USERENV 1054 event is logged in the Application event log. This problem affects both computer and user policies.

In this scenario, the following information is logged in the Userenv.log file:

> USERENV(22c.91c) *\<DateTime>* ProcessGPOs:  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs:  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs: Starting user Group Policy (Background) processing...  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs:  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs:  
USERENV(22c.91c) *\<DateTime>* EnterCriticalPolicySectionEx: Entering with timeout 600000 and flags 0x0  
USERENV(22c.91c) *\<DateTime>* EnterCriticalPolicySectionEx: User critical section has been claimed. Handle = 0x734  
USERENV(22c.91c) *\<DateTime>* EnterCriticalPolicySectionEx: Leaving successfully.  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs: Machine role is 2.  
USERENV(22c.91c) *\<DateTime>* PingComputer: Adapter speed 10000000 bps  
USERENV(22c.91c) *\<DateTime>* PingComputer: First time: 76  
USERENV(22c.91c) *\<DateTime>* PingComputer: Second send failed with 11010  
USERENV(22c.91c) *\<DateTime>* PingComputer: First time: 73  
USERENV(22c.91c) *\<DateTime>* PingComputer: Second send failed with 11010  
USERENV(22c.91c) *\<DateTime>* PingComputer: First time: 73  
USERENV(22c.91c) *\<DateTime>* PingComputer: Second send failed with 11010  
USERENV(22c.91c) *\<DateTime>* PingComputer: No data available  
USERENV(22c.91c) *\<DateTime>* PingComputer: Adapter speed 10000000 bps  
USERENV(22c.91c) *\<DateTime>* PingComputer: First time: 75  
USERENV(958.95c) *\<DateTime>* LibMain: Process Name: C:\WINDOWS\system32\userinit.exe  
USERENV(22c.91c) *\<DateTime>* PingComputer: Second send failed with 11010  
USERENV(22c.91c) *\<DateTime>* PingComputer: First time: 77  
USERENV(22c.91c) *\<DateTime>* PingComputer: Second send failed with 11010  
USERENV(22c.91c) *\<DateTime>* PingComputer: First time: 159  
USERENV(22c.91c) *\<DateTime>* PingComputer: Second send failed with 11010  
USERENV(22c.91c) *\<DateTime>* PingComputer: No data available  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs: DSGetDCName failed with 59.  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs: No WMI logging done in this policy cycle.  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs: Processing failed with error 59.  
USERENV(22c.91c) *\<DateTime>* LeaveCriticalPolicySection: Critical section 0x734 has been released.  
USERENV(22c.91c) *\<DateTime>* ProcessGPOs: User Group Policy has been applied.

## Cause for Scenario 2

This problem can occur when clients authenticate and pull Group Policy settings across a wide area network (WAN) link. The process that is used to detect link speed involves sending a large ICMP ping request. For example, a ping request is sent that is larger than 2 KB. The ICMP echo request is fragmented into separate IP packets by the client's own network interface, by a WAN router, or by both the interface and the router. Because some IP attacks involve malformed ICMP packets, many routers are configured to discard fragmented ICMP packets.

## Resolution for Scenario 2

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To disable slow link detection on the Windows XP client computer, set the following registry values:

- Registry 1:

  - Registry subkey: `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System`
  - Value name: GroupPolicyMinTransferRate
  - Value type: DWORD
  - Value Data: 0

- Registry 2:

  - Registry subkey: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System`
  - Value name: GroupPolicyMinTransferRate
  - Value type: DWORD
  - Value Data: 0

These registry settings must be configured manually because Group Policy is not applied in this scenario. These registry settings are otherwise set by the following Group Policy settings:

- Group Policy setting 1:

  - Policy location: Computer Configuration\Administrative Templates\System\Group Policy
  - Policy name: Group Policy slow link detection
  - Policy setting: Enabled with a value of 0

- Group Policy setting 2:

  - Policy location: User Configuration\Administrative Templates\System\Group Policy
  - Policy name: Group Policy slow link detection
  - Policy setting: Enabled with a value of 0

These registry changes can be scripted by using the Reg.ini file if you must apply the changes to many computers. Then, you can create a GPO that applies these settings to make sure that the settings are retained after this problem is resolved.

You mught also want to modify the Default User profile so that it contains the user-side settings. Therefore, all new profiles will successfully apply Group Policy settings. After you implement these settings, the Userenv.log file shows correct Group Policy processing. The following information is logged in the Userenv.log file:

> USERENV(21c.6f4) 17:09:54:872 ProcessGPOs:  
  USERENV(21c.6f4) 17:09:54:872 ProcessGPOs:  
  USERENV(21c.6f4) 17:09:54:872 ProcessGPOs: Starting computer Group Policy (Background) processing...  
  USERENV(21c.944) 17:09:54:872 ProcessGPOs:  
  USERENV(21c.944) 17:09:54:882 ProcessGPOs:  
  USERENV(21c.944) 17:09:54:882 EnterCriticalPolicySectionEx: Entering with timeout 600000 and flags 0x0  
  USERENV(21c.944) 17:09:54:882 EnterCriticalPolicySectionEx: User critical section has been claimed. Handle = 0xa4c  
  USERENV(21c.6f4) 17:09:54:882 EnterCriticalPolicySectionEx: Entering with timeout 600000 and flags 0x0  
  USERENV(21c.6f4) 17:09:54:892 EnterCriticalPolicySectionEx: Machine critical section has been claimed. Handle = 0xa44  
  USERENV(21c.944) 17:09:54:892 EnterCriticalPolicySectionEx: Leaving successfully.  
  USERENV(21c.944) 17:09:54:902 ProcessGPOs: Machine role is 2.  
  USERENV(21c.6f4) 17:09:54:892 EnterCriticalPolicySectionEx: Leaving successfully.  
  USERENV(21c.6f4) 17:09:54:912 ProcessGPOs: Machine role is 2.  
  USERENV(21c.944) 17:09:54:902 IsSlowLink: Slow link transfer rate is 0. Always download policy.

## Symptoms for Scenario 3

Administrators cannot use the RSoP Planning mode to plan for scenarios that span forests in Windows Server 2003. For example, you cannot plan for a scenario where a user logs on to a workstation in Forest 1 from Forest 2. When you try to run RSoP Planning mode in a cross-forest environment, you might receive the following Group Policy error message:

> Cross forest planning mode scenarios are not currently supported.

## Cause for Scenario 3

This problem occurs because RSoP Planning mode does not support cross-forest scenarios. In many scenarios, RSoP cannot validate the information that is returned from a domain controller that is located in another forest. The Authenticated Users group must have read permissions for relevant policies to successfully read a particular policy in a cross-forest environment.
