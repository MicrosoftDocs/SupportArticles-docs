---
title: Settings for minimizing periodic WAN traffic
description: Describes the problem that occurs when a dial-on-demand link is activated by periodic WAN traffic. Includes suggested settings to help prevent or minimize this behavior.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, WalterE
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Settings for minimizing periodic WAN traffic

This article provides some suggested settings for the problem that occurs when a dial-on-demand link is activated by periodic WAN traffic.  

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 819108

## Summary

This article describes the registry settings and the Group Policy settings that affect periodic wide area network (WAN) traffic and metered link costs. If you have a dial-on-demand link, it might be unexpectedly enabled by periodic WAN traffic. You can configure the system's components and services to minimize periodic WAN traffic and to reduce metered link costs.

## Symptoms

Your dial-on-demand link activates while the computer is idle if the following conditions are true:

- You are using a Microsoft Windows-based computer that's connected to a remote network and is a member of an Active Directory Domain Services (AD DS) domain.
- You are connected to the domain controllers over a dial-on-demand or otherwise metered link.

## Resolution

The following sections contain a comprehensive summary of registry settings and Group Policy settings that you can add or modify to minimize WAN traffic. Some of these settings depend on the operating system version that the computer is running.

## Part 1: A description of relevant settings

The following registry settings affect WAN traffic and metered-link costs. To minimize periodic WAN traffic and to reduce metered link costs, configure these settings as appropriate.

### The Browser service

In Windows Server 2016, Windows 10, and later versions, the Browser service is generally no longer used. We recommend that you disable the service on all computers in your enterprise, if it is possible. If you can't do this, we recommend you turn down the communication intervals of the service.

#### The domain master browser periodicity

The primary domain controller (PDC) is always the domain master browser. Therefore, a master browser on a network that does not host the PDC for the domain activates dial-on-demand links when it tries to locate the PDC. By default, the attempt interval is five minutes. You can create a **MasterPeriodicity** registry entry that instructs the Browser service to adjust its default interval for contacting a domain master browser. By default, the **MasterPeriodicity** entry is not present. The recommended default for dial-on-demand deployments is **86,400** seconds (one day).

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Browser\Parameters`  
Entry: MasterPeriodicity  
Type: DWORD  
Recommended value (seconds): 86,400  

#### Server list maintenance

If you enable a server to participate as a browser and to potentially be elected as a master browser for its network, the server periodically contacts the PDC for its domain. By default, the **MaintainServerList** registry entry is set to **Auto**. The recommended value is **No** unless you must have browser functionality on the network. If you must have browser functionality, set this value to **Yes**. However, make sure to configure the **MasterPeriodicity** interval to a large enough interval to reduce the number of PDC contacts.  

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Browser\Parameters`  
Entry: MaintainServerList  
Type: String
Default value: Auto  
Recommended value: No  

#### The expected dial-up delay

The **ExpectedDialupDelay** entry specifies the time that is required for a dial-up router to dial when it sends a message from a client computer to a domain across a slow link. In this scenario, the domain is trusted by the client computer. Typically, the Net Logon service assumes that it can quickly reach a domain controller. By setting the **ExpectedDialupDelay** entry, you inform the Net Logon service to expect an additional delay. The recommended value for this setting is the average time in seconds that is required for the dial-on-demand link to be established, plus a constant of five seconds to account for variance.  

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
Entry: ExpectedDialupDelay  
Type: DWORD  
Recommended value (seconds): 90  

### The AvoidPdcOnWan entry

The **AvoidPdcOnWan** entry instructs the domain controller that is running the Net Logon service to avoid contacting the PDC operations master roles as much as it can. (The operations master roles are also known as flexible single master operations roles or FSMO roles.) The **AvoidPdcOnWan** entry also instructs other components, such as the Security Account Manager (SAM), that use this information. For example, assume that this entry is enabled on a domain controller in a remote site. In this scenario, the remote domain controller will not try to verify a password with the PDC operations master roles if the client does not authenticate with the local domain controller.  

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
Entry: AvoidPdcOnWan  
Type: DWORD  
Recommended value: 1 (enabled)

### Directory service client queries

In Windows 2000 Service Pack 2 and in later Windows 2000 service packs, in Windows XP, and in Windows Server 2003, the Directory service client queries are issued one time per hour. You can adjust the following registry entries to extend this query time beyond one hour.

#### The negative cache period

The **NegativeCachePeriod** entry specifies the time that a client will remember that a domain controller could not be found in a domain. If a program tries again within this time, the client call immediately fails without trying to find a domain controller again, so the metered link is not activated.  

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
Entry: NegativeCachePeriod  
Type: DWORD  
Default value (seconds): 45  
Recommended value: 84,600  

#### The background retry initial period

Some programs periodically try to find a domain controller. If the domain controller is not available, these periodic retries can be costly in dial-on-demand scenarios. The **BackgroundRetryInitialPeriod** entry defines the minimum amount of elapsed time before the first retry occurs. If the value is smaller than the value set in the **NegativeCachePeriod** entry, the **NegativeCachePeriod** value is used.  

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
Entry: BackgroundRetryInitialPeriod  
Type: DWORD  
Recommended value (seconds): 84,600  

#### The background retry back-off period

The **BackgroundRetryMaximumPeriod** entry defines the maximum interval that the retries will be backed off. For example, if the first retry is after 10 minutes, the second retry will be after 20 minutes, and the next retry will be after 30 minutes. This continues until the value in the **BackgroundRetryMaximumPeriod** entry is reached. Then, the **BackgroundRetryBackoffPeriod** value is used for the retry interval until the value in the **BackgroundRetryQuitTime** entry is reached.  

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
Entry: BackgroundRetryMaximumPeriod  
Type: DWORD  
Recommended value (seconds): 84,600 seconds  

#### The background retry quit time

When a program runs a periodic search for domain controllers and cannot find a domain controller, the value that is set in this entry determines when retries are no longer possible.  
Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
Entry: BackgroundRetryQuitTime  
Type: DWORD  
Recommended value (seconds): 600  

#### The maximum password age

Specifies how frequently the system changes the computer account password of the local computer. This entry is used only when the system is configured to change the computer password automatically at set intervals. That is, this entry is used only when the value of the **DisablePasswordChange** entry is **0**. For more information, see [Domain member: Disable machine account password changes](/windows/security/threat-protection/security-policy-settings/domain-member-disable-machine-account-password-changes).
  
Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
Entry: MaximumPasswordAge  
Type: DWORD  
Default value (decimal, number of days): 7 (in Windows NT), 30 (Windows 2000/XP/2003)
Recommended range: 42 to 70  

### DFS registry settings

The frequency of domain controller queries by DFS the **DfsDcNameDelay** entry can reduce the frequency of domain controller queries by Distributed File System (DFS). Modify this entry on the client computer.  

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters`  
Entry: DfsDcNameDelay  
Type: DWORD  
Default value (minutes): 15  

The valid range for **DfsDcNameDelay** is from **15**  to **360** minutes. No restart is required for the new settings to take effect.

#### The frequency of PDC queries by DFS

Description: Every DFS server that has a domain-based DFS root polls the PDC for changes on the root object. You can control the interval between pollings by setting the **SyncIntervalInSeconds** registry entry on the DFS root server or servers. By setting this entry, you can control when DFS returns referrals that are based on cached data. If you increase this value, DFS caches namespaces and referrals for a longer duration.  

Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DFS`  
Entry: SyncIntervalInSeconds  
Type: DWORD  
Default value (seconds): 3,600 (1 hour)

Also review the following technical article on DFS volume settings:

- [Change the amount of time that clients cache referrals](/windows-server/storage/dfs-namespaces/change-the-amount-of-time-that-clients-cache-referrals)

### The Knowledge Consistency Checker (KCC) replication topology update

The Knowledge Consistency Checker (KCC) replication topology update may cause WAN traffic to create or verify replication links. For domain controllers that are separated by metered links, it makes sense to reduce the frequency at which KCC runs.

**Description**: The Repl topology update period (secs) value defines the number of seconds between intervals.  

Subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`  
Entry: Repl topology update period (secs)  
Type: DWORD  
Default value (seconds): 900 (15 minutes)

### Group Policy settings

The following policy settings control the frequency of Net Logon-based traffic and of DFS-based traffic. To locate these settings, click **Start**, click **Run**, type _gpedit.msc_, and then click **OK**. Or, edit them in a domain-based Group Policy Object.

#### Computer Configuration/Administrative Templates/System/Net Logon

- **Scavenge Interval**  
- **Positive Periodic DC Cache Refresh for Non-Background Callers**  
- **Positive Periodic DC Cache Refresh for Background Callers**  
- **Final DC Discovery Retry Settings for Background Callers**  
- **Maximum DC Discovery Retry Interval Settings for Background Callers**  
- **Initial DC Discovery Retry Settings for Background Callers**  
- **Negative DC Discovery Cache Settings**  
- **Contact PDC on logon failure**  
- **Expected dial-up delay on logon**  

#### Computer Configuration/Administrative Templates/Network

Sets how often a DFS Client discovers DCs

By default, a DFS client tries to discover domain controllers every 15 minutes. If you enable the **Sets how often a DFS Client discovers DCs** setting, you can change the interval. This value is specified in minutes. If you disable this setting or do not configure it, the default value of 15 minutes applies. The corresponding registry subkey is as follows: `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\System\DFSClient\DfsDcNameDelay`

## Part 2: Default values

### Default values for packet types

The following table shows the packet types and their default send intervals.

|Packet type|Protocol|Transport|Interval|Notes|
|---|---|---|---|---|
|NetLogon|Server message block (SMB)|TCP/IP|300 seconds| |
|Browse|SMB|TCP/IP|720 seconds| |
|KeepAlive|Network basic input/output system (NetBIOS)|TCP/IP|3,600 seconds (60 minutes)| |
|Echo NetBIOS over TCP/IP (NetBT)|NetBIOS|TCP/IP|120 seconds|If a session is idle, the file server sends an SMB echo frame at the specified interval.|
|Windows Explorer|SMB|TCP/IP|32 seconds|This value controls the frequency that the file server sends an SMB echo frame to the client as long as the client has an outstanding long-term request open.|
|KeepAlive|NetBIOS|TCP/IP|300 seconds (5 minutes)|This entry corresponds to<br/> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlServices\NetBT\parameters\SessionKeepAlive` |
|KeepAlive|TCP|TCP/IP|1 second|This entry corresponds to<br/> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters\KeepAliveTime` |

> [!Note]
>
> - The Browse packet type in this table indicates network traffic between a PDC (Domain Master Browser) and master browsers.
> - The Windows LAN Manager redirector echoes an SMB echo frame every 30 seconds or 32 seconds to each file server that has an associated long-term request that is outstanding. For example, a file server might have a **NotifyChange** request in Microsoft Internet Explorer. To avoid these packets, you can set the **NoRemoteChangeNotify** key.

For more information, see the following Knowledge Base article:
[3212430](https://support.microsoft.com/help/3212430) Security setting changes on folders don't appear immediately on DFSR replication partners in Windows Server

- If there is no data transfer between the client and the server for the KeepAlive interval (120 seconds), the server sends the first keep-alive probe. After two minutes of inactivity (idle tree connects), the file server sends a 1-byte session message. The TCP payload is "02." The TCP sequence number starts in the last received acknowledgment (ACK) minus 1 and ends in the current acknowledgment.
- If the connection against the server is made by using named pipes, the server sends a "NetBT: SS - Session Keep Alive" message to the client approximately every 300 seconds.

    The "NetBT SessionKeepAlive" entry is in the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters`

- A Common Internet File System (CIFS) TCP session keep-alive message includes a byte that has a 0x85 value, followed by three bytes that have a 0 (zero) value in the NetBT header. The keep-alive message may be sent if no messages have been sent for a client-configurable interval.

### Default values for services

|Component|Default interval setting|Notes|
|---|---|---|
|The Net Logon domain controller discovery|3,600 seconds (60 minutes)| |
|DFS queries for domain controllers|900 seconds (15 minutes)| |
|GPO refresh interval|90 minutes|See Group Policy Description: [Group Policy Search](https://gpsearch.azurewebsites.net/#341) |
|Time service (W32time)|17 minutes|This value is found in the following registry subkeys:<br/><br/> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32time\Config\MaxPollInterval` `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32time\Config\MinPollInterval` <br/><br/>Also see the Group Policy settings for Windows Time Service: [Global Configuration Settings](https://gpsearch.azurewebsites.net/#2612) [Configure Windows NTP Client](https://gpsearch.azurewebsites.net/#2613) |
  
## References

For more information, see the following Knowledge Base articles:

- [314053](https://support.microsoft.com/help/314053)  TCP/IP and NBT configuration parameters for Windows XP
- [3212430](https://support.microsoft.com/help/3212430)  Security setting changes on folders don't appear immediately on DFSR replication partners in Windows Server
