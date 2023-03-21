---
title: Wireless network connectivity issues troubleshooting
description: Learn how to troubleshoot Wi-Fi connections. Troubleshooting Wi-Fi connections requires understanding the basic flow of the Wi-Fi autoconnect state machine.
ms.date: 03/10/2023
manager: dcscontentpm
ms.prod: windows-client
author: aczechowski
ms.author: aaroncz
ms.topic: troubleshooting
ms.technology: windows-client-networking
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
ms.reviewer: dougeby
audience: itpro
localization_priority: medium
---
# Advanced troubleshooting wireless network connectivity

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806441" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Wireless technology issues.

> [!NOTE]
> Home users: This article is intended for use by support agents and IT professionals. If you're looking for more general information about Wi-Fi problems in Windows 10, check out this [Windows 10 Wi-Fi fix article](https://support.microsoft.com/windows/fix-wi-fi-connection-issues-in-windows-9424a1f7-6a3b-65a6-4d78-7f07eee84d2c).

_Applies to:_ &nbsp; Windows 10

## Overview

This overview describes the general troubleshooting of establishing Wi-Fi connections from Windows clients.
Troubleshooting Wi-Fi connections requires understanding the basic flow of the Wi-Fi autoconnect state machine. Understanding this flow makes it easier to determine the starting point in a repro scenario in which a different behavior is found.

This workflow involves knowledge and use of [TextAnalysisTool](https://github.com/TextAnalysisTool/Releases), an extensive text filtering tool that is useful with complex traces with numerous ETW providers such as wireless_dbg trace scenario.

## Scenarios

This article applies to any scenario in which Wi-Fi connections fail to establish. The troubleshooter is developed with Windows 10 clients in focus, but also may be useful with traces as far back as Windows 7.

> [!NOTE]
> This troubleshooter uses examples that demonstrate a general strategy for navigating and interpreting wireless component [Event Tracing for Windows](/windows/desktop/etw/event-tracing-portal) (ETW). It's  not meant to be representative of every wireless problem scenario.

Wireless ETW is incredibly verbose and calls out many innocuous errors (rather flagged behaviors that have little or nothing to do with the problem scenario). Searching for or filtering on "err", "error", and "fail" will seldom lead you to the root cause of a problematic Wi-Fi scenario. Instead it will flood the screen with meaningless logs that will obfuscate the context of the actual problem.

It's important to understand the different Wi-Fi components involved, their expected behaviors, and how the problem scenario deviates from those expected behaviors.
The intention of this troubleshooter is to show how to find a starting point in the verbosity of wireless_dbg ETW and home in on the responsible components that are causing the connection problem.

### Known issues and fixes

| OS version | Fixed in |
| --- | --- |
| Windows 10, version 1803 | [KB4284848](https://support.microsoft.com/help/4284848) |
| Windows 10, version 1709 | [KB4284822](https://support.microsoft.com/help/4284822) |
| Windows 10, version 1703 | [KB4338827](https://support.microsoft.com/help/4338827) |

Make sure that you install the latest Windows updates, cumulative updates, and rollup updates. To verify the update status, refer to the appropriate update-history webpage for your system:

- [Windows 10 version 1809](https://support.microsoft.com/help/4464619)
- [Windows 10 version 1803](https://support.microsoft.com/help/4099479)
- [Windows 10 version 1709](https://support.microsoft.com/topic/windows-10-and-windows-server-update-history-8e779ac1-e840-d3b8-524e-91037bf7645a)
- [Windows 10 version 1703](https://support.microsoft.com/help/4018124)
- [Windows 10 version 1607 and Windows Server 2016](https://support.microsoft.com/help/4000825)
- [Windows 10 version 1511](https://support.microsoft.com/help/4000824)
- [Windows 8.1 and Windows Server 2012 R2](https://support.microsoft.com/help/4009470)
- [Windows Server 2012](https://support.microsoft.com/help/4009471)
- [Windows 7 SP1 and Windows Server 2008 R2 SP1](https://support.microsoft.com/help/4009469)

## Data collection

1. Network Capture with ETW. Enter the following command at an elevated command prompt:

    ```console
    netsh trace start wireless_dbg capture=yes overwrite=yes maxsize=4096 tracefile=c:\tmp\wireless.etl
    ```

2. Reproduce the issue.
    - If there's a failure to establish connection, try to manually connect.
    - If it's  intermittent but easily reproducible, try to manually connect until it fails. Record the time of each connection attempt, and whether it was a success or failure.
    - If the issue is intermittent but rare, netsh trace stop command needs to be triggered automatically (or at least alerted to admin quickly) to ensure trace doesn't overwrite the repro data.
    - If intermittent connection drops trigger stop command on a script (ping or test network constantly until fail, then netsh trace stop).
3. Stop the trace by entering the following command:

    ```console
    netsh trace stop
    ```

4. To convert the output file to text format:

    ```console
    netsh trace convert c:\tmp\wireless.etl
    ```

See the [example ETW capture](#example-etw-capture) at the bottom of this article for an example of the command output. After running these commands, you'll have three files: wireless.cab, wireless.etl, and wireless.txt.

## Troubleshooting

The following view is a high-level one of the main wifi components in Windows.

|Wi-fi Components  |Description  |
|---------|---------|
|:::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/windows-connection-manager.png" alt-text="Windows Connection Manager" border="false":::     |The Windows Connection Manager (Wcmsvc) is closely associated with the UI controls (taskbar icon) to connect to various networks, including wireless networks. It accepts and processes input from the user and feeds it to the core wireless service.         |
|:::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/wlan-autoconfig-service.png" alt-text="WLAN Autoconfig Service" border="false":::     |The WLAN Autoconfig Service (WlanSvc) handles the following core functions of wireless networks in windows:<li> Scanning for wireless networks in range<li>Managing connectivity of wireless networks         |
|:::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/media-specific-module.png" alt-text="Media Specific Module" border="false":::     |The Media Specific Module (MSM) handles security aspects of connection being established.         |
|:::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/native-wifi-stack.png" alt-text="Native WiFi stack" border="false":::     |The Native WiFi stack consists of drivers and wireless APIs to interact with wireless miniports and the supporting user-mode Wlansvc.         |
|:::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/wireless-miniport.png" alt-text="Wireless miniport" border="false":::     |Third-party wireless miniport drivers interface with the upper wireless stack to provide notifications to and receive commands from Windows.         |

The wifi connection state machine has the following states:

- Reset
- Ihv_Configuring
- Configuring
- Associating
- Authenticating
- Roaming
- Wait_For_Disconnected
- Disconnected

Standard wifi connections tend to transition between states such as:

- Connecting

  Reset --> Ihv_Configuring --> Configuring --> Associating --> Authenticating --> Connected

- Disconnecting

  Connected --> Roaming --> Wait_For_Disconnected --> Disconnected --> Reset

Filtering the ETW trace with the [TextAnalysisTool](https://github.com/TextAnalysisTool/Releases) (TAT) is an easy first step to determine where a failed connection setup is breaking down.  A useful [wifi filter file](#wifi-filter-file) is included at the bottom of this article.

Use the **FSM transition** trace filter to see the connection state machine. You can see [an example](#textanalysistool-example) of this filter applied in the TAT at the bottom of this page.

An example of a good connection setup is:

```console
44676 [2]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.658 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Disconnected to State: Reset
45473 [1]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.667 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Reset to State: Ihv_Configuring
45597 [3]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.708 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Ihv_Configuring to State: Configuring
46085 [2]0F24.17E0::‎2018‎-‎09‎-‎17 10:22:14.710 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Configuring to State: Associating
47393 [1]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.879 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Associating to State: Authenticating
49465 [2]0F24.17E0::‎2018‎-‎09‎-‎17 10:22:14.990 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Authenticating to State: Connected
```

An example of a failed connection setup is:

```console
44676 [2]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.658 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Disconnected to State: Reset
45473 [1]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.667 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Reset to State: Ihv_Configuring
45597 [3]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.708 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Ihv_Configuring to State: Configuring
46085 [2]0F24.17E0::‎2018‎-‎09‎-‎17 10:22:14.710 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Configuring to State: Associating
47393 [1]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.879 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Associating to State: Authenticating
49465 [2]0F24.17E0::‎2018‎-‎09‎-‎17 10:22:14.990 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Authenticating to State: Roaming
```

By identifying the state at which the connection fails, one can focus more specifically in the trace on logs prior to the last known good state

Examining \[Microsoft-Windows-WLAN-AutoConfig\] logs prior to the bad state change should show evidence of error. Often, however, the error is propagated up through other wireless components.
In many cases the next component of interest will be the MSM, which lies just below Wlansvc.

The important components of the MSM include:

- Security Manager (SecMgr) - handles all pre and post-connection security operations.
- Authentication Engine (AuthMgr) – Manages 802.1x auth requests

    :::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/msm-details.png" alt-text="MSM details showing Security Manager and Authentication Manager." border="false":::

Each of these components has its own individual state machines that follow specific transitions.
Enable the `FSM transition`, `SecMgr Transition`, and `AuthMgr Transition` filters in TextAnalysisTool for more detail.

Further to the preceding example, the combined filters look like the following command example:

```console
[2] 0C34.2FF0::08/28/17-13:24:28.693 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Reset to State: Ihv_Configuring
[2] 0C34.2FF0::08/28/17-13:24:28.693 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Ihv_Configuring to State: Configuring
[1] 0C34.2FE8::08/28/17-13:24:28.711 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Configuring to State: Associating
[0] 0C34.275C::08/28/17-13:24:28.902 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition INACTIVE (1) --> ACTIVE (2)
[0] 0C34.275C::08/28/17-13:24:28.902 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition ACTIVE (2) --> START AUTH (3)
[4] 0EF8.0708::08/28/17-13:24:28.928 [Microsoft-Windows-WLAN-AutoConfig]Port (14) Peer 0x186472F64FD2 AuthMgr Transition ENABLED  --> START_AUTH  
[3] 0C34.2FE8::08/28/17-13:24:28.902 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Associating to State: Authenticating
[1] 0C34.275C::08/28/17-13:24:28.960 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition START AUTH (3) --> WAIT FOR AUTH SUCCESS (4)
[4] 0EF8.0708::08/28/17-13:24:28.962 [Microsoft-Windows-WLAN-AutoConfig]Port (14) Peer 0x186472F64FD2 AuthMgr Transition START_AUTH  --> AUTHENTICATING  
[2] 0C34.2FF0::08/28/17-13:24:29.751 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition WAIT FOR AUTH SUCCESS (7) --> DEACTIVATE (11)
[2] 0C34.2FF0::08/28/17-13:24:29.7512788 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition DEACTIVATE (11) --> INACTIVE (1)
[2] 0C34.2FF0::08/28/17-13:24:29.7513404 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Authenticating to State: Roaming
```

> [!NOTE]
> In the next to last line the SecMgr transition is suddenly deactivating:<br>
>\[2\] 0C34.2FF0::08/28/17-13:24:29.7512788 \[Microsoft-Windows-WLAN-AutoConfig\]Port\[13\] Peer 8A:15:14:B6:25:10 SecMgr Transition DEACTIVATE (11) --> INACTIVE (1)<br><br>
>This transition is what eventually propagates to the main connection state machine and causes the Authenticating phase to devolve to Roaming state. As before, it makes sense to focus on tracing prior to this SecMgr behavior to determine the reason for the deactivation.

Enabling the `Microsoft-Windows-WLAN-AutoConfig` filter will show more detail leading to the DEACTIVATE transition:

```console
[3] 0C34.2FE8::08/28/17-13:24:28.902 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Associating to State: Authenticating
[1] 0C34.275C::08/28/17-13:24:28.960 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition START AUTH (3) --> WAIT FOR AUTH SUCCESS (4)
[4] 0EF8.0708::08/28/17-13:24:28.962 [Microsoft-Windows-WLAN-AutoConfig]Port (14) Peer 0x186472F64FD2 AuthMgr Transition START_AUTH  --> AUTHENTICATING  
[0]0EF8.2EF4::‎08/28/17-13:24:29.549 [Microsoft-Windows-WLAN-AutoConfig]Received Security Packet: PHY_STATE_CHANGE  
[0]0EF8.2EF4::08/28/17-13:24:29.549 [Microsoft-Windows-WLAN-AutoConfig]Change radio state for interface = Intel(R) Centrino(R) Ultimate-N 6300 AGN :  PHY = 3, software state = on , hardware state = off ) 
[0] 0EF8.1174::‎08/28/17-13:24:29.705 [Microsoft-Windows-WLAN-AutoConfig]Received Security Packet: PORT_DOWN  
[0] 0EF8.1174::‎08/28/17-13:24:29.705 [Microsoft-Windows-WLAN-AutoConfig]FSM Current state Authenticating , event Upcall_Port_Down  
[0] 0EF8.1174:: 08/28/17-13:24:29.705 [Microsoft-Windows-WLAN-AutoConfig]Received IHV PORT DOWN, peer 0x186472F64FD2 
[2] 0C34.2FF0::08/28/17-13:24:29.751 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition WAIT FOR AUTH SUCCESS (7) --> DEACTIVATE (11)
 [2] 0C34.2FF0::08/28/17-13:24:29.7512788 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition DEACTIVATE (11) --> INACTIVE (1)
[2] 0C34.2FF0::08/28/17-13:24:29.7513404 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Authenticating to State: Roaming
```

The trail backwards reveals a Port Down notification:

\[0\] 0EF8.1174:: 08/28/17-13:24:29.705 \[Microsoft-Windows-WLAN-AutoConfig\]Received IHV PORT DOWN, peer 0x186472F64FD2

Port events indicate changes closer to the wireless hardware. The trail can be followed by continuing to see the origin of this indication.

Below, the MSM is the native wifi stack. These drivers are Windows native wifi drivers that talk to the wifi miniport drivers. It's  responsible for converting Wi-Fi (802.11) packets to 802.3 (Ethernet) so that TCPIP and other protocols and can use it.

Enable trace filter for `[Microsoft-Windows-NWifi]`:

```console
[3] 0C34.2FE8::08/28/17-13:24:28.902 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Associating to State: Authenticating
[1] 0C34.275C::08/28/17-13:24:28.960 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition START AUTH (3) --> WAIT FOR AUTH SUCCESS (4)
[4] 0EF8.0708::08/28/17-13:24:28.962 [Microsoft-Windows-WLAN-AutoConfig]Port (14) Peer 0x8A1514B62510 AuthMgr Transition START_AUTH  --> AUTHENTICATING  
[0]0000.0000::‎08/28/17-13:24:29.127 [Microsoft-Windows-NWiFi]DisAssoc: 0x8A1514B62510 Reason: 0x4 
[0]0EF8.2EF4::‎08/28/17-13:24:29.549 [Microsoft-Windows-WLAN-AutoConfig]Received Security Packet: PHY_STATE_CHANGE  
[0]0EF8.2EF4::08/28/17-13:24:29.549 [Microsoft-Windows-WLAN-AutoConfig]Change radio state for interface = Intel(R) Centrino(R) Ultimate-N 6300 AGN :  PHY = 3, software state = on , hardware state = off ) 
[0] 0EF8.1174::‎08/28/17-13:24:29.705 [Microsoft-Windows-WLAN-AutoConfig]Received Security Packet: PORT_DOWN  
[0] 0EF8.1174::‎08/28/17-13:24:29.705 [Microsoft-Windows-WLAN-AutoConfig]FSM Current state Authenticating , event Upcall_Port_Down  
[0] 0EF8.1174:: 08/28/17-13:24:29.705 [Microsoft-Windows-WLAN-AutoConfig]Received IHV PORT DOWN, peer 0x186472F64FD2 
[2] 0C34.2FF0::08/28/17-13:24:29.751 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition WAIT FOR AUTH SUCCESS (7) --> DEACTIVATE (11)
 [2] 0C34.2FF0::08/28/17-13:24:29.7512788 [Microsoft-Windows-WLAN-AutoConfig]Port[13] Peer 8A:15:14:B6:25:10 SecMgr Transition DEACTIVATE (11) --> INACTIVE (1)
[2] 0C34.2FF0::08/28/17-13:24:29.7513404 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: 
Authenticating to State: Roaming
```

In the trace above, we see the line:

```console
[0]0000.0000::‎08/28/17-13:24:29.127 [Microsoft-Windows-NWiFi]DisAssoc: 0x8A1514B62510 Reason: 0x4
```

This line is followed by PHY_STATE_CHANGE and PORT_DOWN events due to a disassociate coming from the Access Point (AP), as an indication to deny the connection. This denail could be due to invalid credentials, connection parameters, loss of signal/roaming, and various other reasons for aborting a connection. The action here would be to examine the reason for the disassociate sent from the indicated AP MAC (8A:15:14:B6:25:10). This action would be done by examining internal logging/tracing from the AP.

### More information

- [802.11 Wireless Tools and Settings](/previous-versions/windows/it-pro/windows-server-2003/cc755892(v%3dws.10))
- [Understanding 802.1X authentication for wireless networks](/previous-versions/windows/it-pro/windows-server-2003/cc759077%28v%3dws.10%29)

## Example ETW capture

```console
C:\tmp>netsh trace start wireless_dbg capture=yes overwrite=yes maxsize=4096 tracefile=c:\tmp\wireless.etl

Trace configuration:
-------------------------------------------------------------------
Status:             Running
Trace File:         C:\tmp\wireless.etl
Append:             Off
Circular:           On
Max Size:           4096 MB
Report:             Off

C:\tmp>netsh trace stop
Correlating traces ... done
Merging traces ... done
Generating data collection ... done
The trace file and additional troubleshooting information have been compiled as "c:\tmp\wireless.cab".
File location = c:\tmp\wireless.etl
Tracing session was successfully stopped.

C:\tmp>netsh trace convert c:\tmp\wireless.etl

Input file:  c:\tmp\wireless.etl
Dump file:   c:\tmp\wireless.txt
Dump format: TXT
Report file: -
Generating dump ... done

C:\tmp>dir
 Volume in drive C has no label.
 Volume Serial Number is 58A8-7DE5

 Directory of C:\tmp

01/09/2019  02:59 PM    [DIR]          .
01/09/2019  02:59 PM    [DIR]          ..
01/09/2019  02:59 PM         4,855,952 wireless.cab
01/09/2019  02:56 PM         2,752,512 wireless.etl
01/09/2019  02:59 PM         2,786,540 wireless.txt
               3 File(s)     10,395,004 bytes
               2 Dir(s)  46,648,332,288 bytes free
```

## Wifi filter file

Copy and paste all the lines below and save them into a text file named *wifi.tat*. Load the filter file into the TextAnalysisTool by selecting **File** > **Load Filters**.

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<TextAnalysisTool.NET version="2018-01-03" showOnlyFilteredLines="False">
  <filters>
    <filter enabled="n" excluding="n" description="" foreColor="000000" backColor="d3d3d3" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-OneX]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Unknown]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-EapHost]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[]***" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-Winsock-AFD]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-WinHttp]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-WebIO]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-Winsock-NameResolution]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-TCPIP]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-DNS-Client]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-NlaSvc]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-Iphlpsvc-Trace]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-DHCPv6-Client]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-Dhcp-Client]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-NCSI]" />
    <filter enabled="y" excluding="n" description="" backColor="90ee90" type="matches_text" case_sensitive="n" regex="n" text="AuthMgr Transition" />
    <filter enabled="y" excluding="n" description="" foreColor="0000ff" backColor="add8e6" type="matches_text" case_sensitive="n" regex="n" text="FSM transition" />
    <filter enabled="y" excluding="n" description="" foreColor="000000" backColor="dda0dd" type="matches_text" case_sensitive="n" regex="n" text="SecMgr transition" />
    <filter enabled="y" excluding="n" description="" foreColor="000000" backColor="f08080" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-NWiFi]" />
    <filter enabled="y" excluding="n" description="" foreColor="000000" backColor="ffb6c1" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-WiFiNetworkManager]" />
    <filter enabled="y" excluding="n" description="" foreColor="000000" backColor="dda0dd" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-WLAN-AutoConfig]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-NetworkProfile]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-WFP]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[Microsoft-Windows-WinINet]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="[MSNT_SystemTrace]" />
    <filter enabled="y" excluding="y" description="" foreColor="000000" backColor="ffffff" type="matches_text" case_sensitive="n" regex="n" text="Security]Capability" />
  </filters>
</TextAnalysisTool.NET>
```

## TextAnalysisTool example

In the following example, the **View** settings are configured to **Show Only Filtered Lines**.

:::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/text-analysis-tool.png" alt-text="Screenshot of an TAT filter example." border="false" lightbox="media/wireless-network-connectivity-issues-troubleshooting/text-analysis-tool.png":::

