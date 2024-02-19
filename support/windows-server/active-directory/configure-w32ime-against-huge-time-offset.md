---
title: Configure W32Time against huge time offset
description: Discusses how to configure W32Time to help prevent large time offsets in the domain.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, yizhao
ms.custom: sap:windows-time-service, csstroubleshoot
---
# How to configure the Windows Time service against a large time offset

This article describes how to configure the Windows Time service against a large time offset.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 884776

## Introduction

Windows operating systems include the Time Service tool (W32Time service) that is used by the Kerberos authentication protocol. Kerberos authentication will work if the time interval between the relevant computers is within the maximum enabled time skew. The default is 5 minutes. You can also turn off the Time Service tool. Then, you can install a third-party time service.

The purpose of the Time Service tool is to make sure that all the computers in an organization that are running Microsoft Windows 2000 or later versions of Windows operating systems use a common time. To make sure that there's an appropriate common time usage, the Time Service uses a hierarchical relationship that controls authority. By default, Windows-based computers use the following hierarchy:

- All the client desktop computers nominate the authenticating domain controller as their authoritative time source.
- In a domain, all the servers follow the same process that client desktop computers follow.
- All domain controllers in a domain nominate the primary domain controller (PDC) operations master as their time source.
- All PDC operations masters follow the hierarchy of domains in the selection of their time source. However, the PDC operations masters may use a parent domain controller that is based on stratum numbering.

    > [!NOTE]
    > A stratum number defines how close a time server is to the primary reference source.

The smaller the number, the closer the server is to the primary time source. In this hierarchy, the PDC operations master at the root of the forest becomes the authoritative time server for the organization. We highly recommend that you configure the authoritative time server to collect the time from a hardware source. When you try to configure the authoritative time server to sync with an Internet time source, there's no authentication. We also recommend that you reduce your time correction settings for the servers and for the stand-alone clients. When you follow these recommendations, more accurate time is provided to the domain.

## More information

A review of time rollbacks has shown that computers can adopt time that can be days, months, years, or even tens of years in the future or in the past. The following issues can occur when computers roll forward or roll backward in time:

- Passwords on computer accounts, on user accounts, and on trust relationships can be prematurely updated.
- Quarantines can be identified by NTDS Replication Event 2042 in Active Directory directory service replication.
- The mismatch of passwords is authoritatively restored for computer accounts, for user accounts, or for trust relationships. The recovery from such mismatches may require manual password resets on all accounts and trusts that are affected.

## How to protect against time that rolls forward and time rollbacks

When computers and power cycles are restarted, the BIOS maintains time in the local EPROM that is located on the computer's motherboard. When Windows starts, the kernel pulls the current time from the BIOS. This current time is used as the initial time until the W32Time service can sync up with another time source.

The Windows 32 time service supports two registry entries, the `MaxPosPhaseCorrection` and the `MaxNegPhaseCorrection`. These entries restrict the samples that the time service accepts on a local computer when those samples are sent from a remote computer.

When a computer that is running in a steady state receives a time sample from its time source, the sample is checked against the phase correction boundaries that the `MaxPosPhaseCorrection` and `MaxNegPhaseCorrection` registry entries impose. If the time sample falls within the limits that the two registry entries enforce, this sample is accepted for additional processing. If the time sample doesn't fall within these limits, the time sample is ignored, and the time service logs the following message in the W32Time private log file:

> TOO BIG

If administrators reduce the value for positive and negative phase corrections, administrators can reduce the threat that computers will receive time from invalid time samples for a Windows-based computer. On the other hand, if administrators reduce the value, administrators may prevent computers from being ahead or behind the current time by more than the limits these values impose.

> [!NOTE]
> If the registry entry values for positive and negative corrections are reduced, time will be increased or decreased.

The default value for the `MaxPosPhaseCorrection` and `MaxNegPhaseCorrection` registry entries in Windows 2000, in Windows XP, in Windows Server 2003, and in Windows Vista is the following value:  
0xFFFFFFF

This value enables the computer to receive the time that is contained in any time sample, whatever inaccuracy.

In Windows Server 2008, a new default value for the MaxPosPhaseCorrection and MaxNegPhaseCorrection registry entries has been adopted. This new default value is 48 hours. This 48-hour value can be represented as either of the following values:

- 2a300 (hexadecimal)
- 172800 (decimal)

We recommend that the `MaxPosPhaseCorrection` and `MaxNegPhaseCorrection` registry entries are set to a value that is other than the following value:  
MAX (0xFFFFFFFF)

> [!NOTE]
> When you set the value to a value other than MAX (0xFFFFFFFF), you can prevent computers from adopting time that is very inaccurate in the scenarios where the computer is restarted or the connectivity to external time sources is disrupted. For example, consider the case in which you have the MaxPosPhaseCorrection and MaxNegPhaseCorrection registry entries set for 48 hours on all domain controllers in the forest. If any single domain controller experiences an unusual time jump of more than 48 hours, the value that you set for the MaxPosPhaseCorrection and MaxNegPhaseCorrection registry entries will prevent other computers from making the same time jump. Therefore, computers that are out of sync can be kept apart from the other computers until the administrator can investigate and take corrective action.

Time accuracy is especially important on the forest root primary domain controller (PDC). Because the PDC is the root time source for the domain, inaccurate time changes on the PDC can potentially cause a domain-wide time jump. If you impose phase correction restrictions on the PDC, you can prevent other domain controllers in the forest from accepting the new time.

The default value of 48 hours instead of a default value of 5 minutes or 15 minutes is based on the following reasons:

- Output from W32TM utility is difficult to read.
- W32TM currently doesn't target time on member computers and on member servers.
- The errors and the events that the Windows operating system and stand-alone third-party applications log are highly inconsistent. Possible errors include return codes that resemble the following one:
  - access denied
  - RPC Server is unavailable
  > [!NOTE]
  > These errors have a low correlation to the time skew because the cause may prevent Windows-based computers from adopting an accurate time value.
- Daylight saving time bugs can cause 1-hour time differences.
- AM or PM misconfiguration can cause a 12-hour time difference.
- Day or date mistakes can cause a 24-hour time difference.

So 48 hours was the next obvious time offset after 25 or 36 hours. Administrators can also reduce the value with correct tools that report infrastructure and testing.

Specific recommendations according to operating system version and computer role are described in the following sections.

## Windows XP Professional and all versions of Windows Server 2003

Domain servers

### Forest root PDC (authoritative time server)

We highly recommend that you configure the authoritative time server to collect the time from a hardware source. When you configure the authoritative time server to sync with an Internet time source, there's no authentication. You must reconfigure the following registry entries:

- `MaxPosPhaseCorrection`
- `MaxNegPhaseCorrection`

The default value of these two registry entries is 0xFFFFFFFF. This default value means "Accept any time change." We recommend a value that is 48 hours. It's represented in the registry as 2a300 (hexadecimal) or 172800 (decimal). We recommend that you set the value of the MaxPollInterval registry entry to 10 or less or that you set the value of the SpecialPollInterval registry entry to 3600 (1 hour) or less.

### Domain controllers and member servers inside the domain

The `MaxPosPhaseCorrection` and `MaxNegPhaseCorrection` registry entries have a default value of 0xFFFFFFFF. This default value means "Accept any time change." We recommend setting this value to 48 hours on all domain controllers. The 48 hours value can also be set on member servers that are running time sensitive-based applications.

> [!NOTE]
> For more information about these registry entries, see the [Windows Server 2003 and Windows XP Time Service registry entries](#windows-server-2003-and-windows-xp-time-service-registry-entries) section.

### Stand-alone clients

The `MaxPosPhaseCorrection` and `MaxNegPhaseCorrection` registry entries have a default value of 54,000 (15 hours). As a security best practice, we recommend that you reduce this default value. We also recommend that you set the value to 3600 (1 hour) or an even smaller value, depending on time source, on network condition, on poll interval, and on security requirements.

## Windows Server 2003 and Windows XP Time Service registry entries

|Type|Details|
|---|---|
|Registry Entry|MaxPosPhaseCorrection|
|Value Type|DWORD|
|Subkey| `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config` |
|Notes|This entry specifies the largest positive time correction in seconds that the service can make. If the service determines that a change larger than it's required, it logs an event instead. Special case: 0xFFFFFFFF means to always make the time correction. The default value for domain members is 0xFFFFFFFF. The default value for stand-alone clients and servers is 54,000 (15 hours).|
|Registry Entry|MaxNegPhaseCorrection|
|Value Type|DWORD|
|Subkey| `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config` |
|Notes|This entry specifies the largest negative time correction in seconds that the service can make. If the service determines that a change larger than this is required, it logs an event instead. Special case: -1 means always make the time correction. The default value for domain members is 0xFFFFFFFF. The default value for stand-alone clients and servers is 54,000 (15 hours).|
|Registry Entry|MaxPollInterval|
|Value Type|DWORD|
|Subkey| `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config`|
|Notes|This entry specifies the largest interval, in seconds, that is enabled for the system polling interval. Notice that, although a system must poll according to the scheduled interval, a provider can refuse to produce samples when samples are requested. The default value for domain members is 10. The default value for stand-alone clients and servers is 15.|
|Registry Entry|SpecialPollInterval|
|Value Type|DWORD|
|Subkey| `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient` |
|Notes|This entry specifies the special poll interval in seconds for manual peers. When the SpecialInterval 0x1 flag is enabled, W32Time uses this poll interval instead of a poll interval that the operating system determines. The default value on domain members is 3,600. The default value on stand-alone clients and servers is 604,800.|
  
> [!NOTE]
> We recommend that you use the Global Policy object Editor to deploy these settings. For more information about the Windows Time service in a Windows Server 2003-based forest, see [Windows Time Service (W32Time)](/windows-server/networking/windows-time-service/windows-time-service-top).

The default Windows Time service parameter values that are defined in the Group Policy object (GPO) may not match the default values that are defined in the registry of Windows Server 2003-based domain controllers. When you deploy MaxPosPhaseCorrection and MaxNegPhaseCorrection values to Windows Server 2003 domain controllers by using a GPO, make sure that the GPO isn't changing the values of other Windows Time service parameters in the registry. Other Windows Time service parameter values may also have to be changed in the GPO to match the default registry values in the domain controllers.

## All versions of Windows 2000 Service Pack 4 (SP4)

Domain servers

### Forest root PDC (authoritative time server)

We highly recommend that you configure the authoritative time server to collect the time from a hardware source. When you configure the authoritative time server to sync with an Internet time source, there's no authentication in manual mode. You can reconfigure the `MaxAllowedClockErrInSecs` registry entry. The default value is 43,200. The recommended value is 900 (15 minutes) or an even smaller value, depending on time source, on network conditions, and on security requirements. It also depends on the poll interval. We recommend that the poll interval value is set to one hour for every 24 hours.

> [!NOTE]
> For more information about this registry entry, see [Windows Server 2000 SP 4 registry entry](#windows-server-2000-sp-4-registry-entry) section.

### Domain controllers and member servers inside the domain

The synchronization type is NT5DS. The time service synchronizes from the domain hierarchy and the time service accepts all-time changes. Because NT5DS accepts any time change without considering the time offset, it's important to set up a reliable forest root time source in the time sync subnet.

> [!NOTE]
> The NT5DS value indicates that the synchronization type is obtained from a registry entry.

### Stand-alone clients

The `MaxAllowedClockErrInSecs` registry entry has a default value of 43,200 (12 hours). As a security best practice, we recommend that you reduce this default value. We recommend that you set the value to 3600 (1 hour) or to an even smaller value, depending on time source, on network conditions, on poll interval, and on security requirements.

### Windows Server 2000 SP 4 registry entry

|Type|Details|
|---|---|
|Registry Entry|MaxAllowedClockErrInSecs|
|Value Type|DWORD|
|Subkey| `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters`|
|Notes|Specifies the maximum clock change that is enabled in seconds. When the event is logged, the time isn't adjusted based on the value. This behavior occurs to help protect against any suspicious time stamp activity. The default value for domain members is 43,200.|
  
