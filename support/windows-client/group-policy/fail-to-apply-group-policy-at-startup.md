---
title: Clients fail to apply group policy at startup
description: Helps fix an issue where Windows 7 Clients intermittently fail to apply group policy at startup.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Windows 7 Clients intermittently fail to apply group policy at startup

This article provides a solution to an issue where Windows 7 Clients intermittently fail to apply group policy at startup.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2421599

## Symptoms

Windows 7 clients intermittently fail group policy processing at startup or reboot. The following events are logged in the System event log:

> Error 9/9/2010 2:43:29 PM NETLOGON 5719 Error 9/9/2010 2:43:31 PM GroupPolicy 1055

## Cause

The behavior is caused by a race condition between network initialization, locating a Domain Controller and processing Group Policy. If the network isn't available, a Domain Controller won't be located, and Group Policy processing will fail. Once the operating system has loaded and a network link is negotiated and established, background refresh of Group Policy will succeed.

The following sequence of events reflects the condition:

> Information \<DateTime> EventLog 6006 indicates system shutdown  
Information \<DateTime> e1kexpress 33 indicates that your network connection link has been established with \<speed/duplex>  
Information \<DateTime> EventLog 6005 indicates event log service has started  
Information \<DateTime> Dhcp-Client 50036 indicates dhcp client service has started  
Error \<DateTime> NETLOGON 5719 indicates netlogon unable to reach any of the domain controllers  
Error \<DateTime> GroupPolicy 1055 indicates group policy processing failed  
Information \<DateTime> GroupPolicy 1503 indicates group policy processing succeeded  

It can be confirmed via the `netlogon` logs as well:

>\<DateTime> [SESSION] \Device\NetBT_Tcpip_{53267BA1-EB8C-4348-BD81-41C3FF162EE9}: Transport Added (\<IP Address>) \<DateTime> [SESSION] Winsock Addrs: \<IP Address> (1) Address changed. \<DateTime> [CRITICAL] NetpDcGetDcNext: _ldap._tcp.dc._msdcs.contoso.com.: Cannot Query DNS. 1460 0x5b4 \<DateTime> [CRITICAL] NetpDcGetNameIp: `contoso.com`.: No data returned from DnsQuery. \<DateTime> [CRITICAL] DBG: NlDiscoverDc: Cannot find DC. \<DateTime> [CRITICAL] DBG: NlSessionSetup: Session setup: cannot pick trusted DC \<DateTime> [SESSION] DBG: NlSetStatusClientSession: Set connection status to c000005e \<DateTime> [SESSION] DBG: NlSessionSetup: Session setup Failed

## Resolution

To work around the issue, you can set a registry value to delay the application of Group Policy:

1. Open Registry Editor.

2. Expand the following subkey:
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`  

3. Right-click `Winlogon`, point to **New**, and then select **DWORD Value**.  

4. To name the new entry, type `GpNetworkStartTimeoutPolicyValue`, and then press ENTER.  

5. Right-click `GpNetworkStartTimeoutPolicyValue`, and then select **Modify**.  

6. Under **Base**, select **Decimal**.  

7. In the Value data box, type **60**, and then select **OK**.  

8. Quit Registry Editor, and then restart the computer.  

9. If the Group Policy startup script doesn't run, increase the value of the `GpNetworkStartTimeoutPolicyValue` registry entry.  

## More information

The value specified should be sufficiently long enough to ensure that the connection is made. During the timeout period, Windows will check the connection status every two seconds and will continue with system startup as soon as the connection is confirmed. Therefore, erring on the high side is recommended. If the system is legitimately disconnected (for example, disconnected network cable, off-line server, and so on), Windows will stall for the entire timeout period.

It can also be defined via a Group Policy:

Policy Location: Computer Configuration > Policies > Admin Templates > System > Group Policy
Setting Name: Startup policy processing wait time
Registry Key: `HKLM\Software\Policies\Microsoft\Windows\System!GpNetworkStartTimeoutPolicyValue`

If you define the Group policy setting, it would override the manual setting. When manual and Group Policy setting aren't defined, the value is picked from the following registry location:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\History`

Since there's no time-out period defined, the system uses its own algorithm to calculate and arrive at an Average time-out period. This value is stored in the above registry location. It could vary system to system, and depends on various factors, such as previous login attempts.

> [!Note]
> The Group Policy description for "Startup Policy processing wait time" is not verbose and doesn't cover all scenarios. Just because we don't have the policy configured currently doesn't mean that we are going to use a default time-out value of 30 seconds.
