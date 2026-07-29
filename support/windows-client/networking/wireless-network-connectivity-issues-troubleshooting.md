---
title: Wireless network connectivity issues troubleshooting
description: Learn how to troubleshoot Wi-Fi adapter, discovery, connection, authentication, roaming, and intermittent connectivity issues on Windows 11.
ms.date: 07/27/2026
manager: dcscontentpm
ms.topic: troubleshooting
ms.custom:
- sap:network connectivity and file sharing\wireless (802.1x,bluetooth,miracast,mobile broadband)
- pcy:WinComm Networking
ms.reviewer: anupamk
audience: itpro
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Advanced troubleshooting wireless network connectivity

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806441" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Wireless technology issues.

> [!NOTE]
> Home users: This article is intended for support agents and IT professionals. For general troubleshooting, see [Fix Wi-Fi connection issues in Windows](https://support.microsoft.com/windows/fix-wi-fi-connection-issues-in-windows-9424a1f7-6a3b-65a6-4d78-7f07eee84d2c).

_Applies to:_ &nbsp; Windows 11 and supported versions of Windows 10

## Overview

Use this guide to diagnose and resolve Wi-Fi connectivity problems on Windows clients. The guide covers the most common scenarios, including a missing Wi-Fi adapter or control, networks that don't appear in the connection list, failed connections, authentication errors, intermittent disconnects, and unreliable roaming.

The guide follows a symptom-first approach. Start by identifying your scenario, collect baseline evidence, and then use the Wi-Fi autoconnect state machine and Event Tracing for Windows (ETW) analysis to isolate the component and connection stage where the problem occurs. The end of this guide includes examples of the output of various diagnostic tools.

> [!IMPORTANT]
> Before you reset the network stack, delete wireless profiles, remove the adapter or driver, or restart the device, collect the baseline state and record the reproduction time. These actions can remove evidence or temporarily change the behavior.

## Scenarios

Use this article for the following scenarios:

- The Wi-Fi adapter or Wi-Fi control is missing.
- Windows doesn't display expected wireless networks.
- A connection attempt fails during association or authentication.
- The device connects but disconnects intermittently.
- Roaming between access points is slow or unreliable.
- The issue starts after an operating system, driver, firmware, policy, sleep, or resume event.

> [!NOTE]
> The ETW examples demonstrate a general strategy for navigating wireless component events. Event text and component behavior can differ by Windows version, wireless adapter, driver model, access point, and authentication method.

### Start with the reported symptom

| Symptom | Start with | Evidence to collect |
| --- | --- | --- |
| Wi-Fi adapter or Wi-Fi control is missing | Confirm whether the adapter is present and enabled, and whether the WLAN AutoConfig (WlanSvc) service is running. If WlanSvc is stopped, the Wi-Fi control is hidden and the `netsh wlan` commands report that the service isn't running. Record recent operating system, driver, firmware, BIOS, sleep, or resume changes. | Device Manager status, WlanSvc service state, `netsh wlan show drivers`, `netsh wlan show interfaces`, and relevant System events. |
| Expected networks aren't displayed | Confirm the hardware and software radio state, WLAN AutoConfig service state, supported bands, and whether other clients can see the same network. | `netsh wlan show interfaces`, `netsh wlan show networks mode=bssid`, and the WLAN AutoConfig operational log. |
| Connection or authentication fails | Determine whether the failure occurs during association or authentication. For enterprise authentication, also use [Advanced troubleshooting 802.1X authentication](802-1x-authentication-issues-troubleshooting.md). | Wireless network report, WLAN AutoConfig operational log, profile and policy details, and the failure timestamp. |
| Connection drops or roaming is unreliable | Record the time, network name, access point, signal conditions, and whether the device roamed before the disconnect. Correlate the client trace with access point or controller logs. | Wireless network report, ETW trace, adapter and driver details, and infrastructure logs. |
| Issue started after an update or resume | Compare the current driver and firmware versions with the versions recommended by the device or adapter manufacturer. Determine whether the behavior reproduces before making further changes. | Update history, driver version and date, firmware or BIOS version, power-state transition, and ETW trace. |
| Wi-Fi remains associated but network access fails | Verify that Wi-Fi association completed successfully, and then continue with TCP/IP, DHCP, DNS, proxy, or firewall troubleshooting. | IP configuration, route, DNS, and network connectivity evidence. |

### Check for known issues and recent changes

Before you collect an advanced trace:

- Review [Windows release health](/windows/release-health/) for known issues that affect the installed Windows version.
- Review the device manufacturer's support information for wireless driver, firmware, and BIOS updates or known compatibility issues.
- Record changes to Windows, the wireless driver, firmware, security software, VPN software, wireless profiles, authentication policy, and access point configuration.
- If the issue affects multiple clients, compare affected and unaffected devices before changing client configuration.

## Data collection

### Collect baseline information

Run the following commands from an elevated command prompt:

```cmd
netsh wlan show drivers
netsh wlan show interfaces
netsh wlan show networks mode=bssid
netsh wlan show profiles
netsh wlan show wlanreport
```

The `mode=bssid` option adds the BSSID, signal strength, channel, and radio type for each visible network, which helps identify band, channel, and coverage problems.

The `wlanreport` command generates an HTML report that summarizes recent wireless sessions, disconnect reasons, adapter information, and related events. The command displays the report location when it completes.

Also collect the following information:

- The exact date and time of each connection attempt or disconnect.
- The wireless adapter model, driver version, and driver date.
- The Windows build and recent update history.
- The network name, authentication method, and whether the profile comes from Group Policy, mobile device management, or the user.
- Events from **Event Viewer** > **Applications and Services Logs** > **Microsoft** > **Windows** > **WLAN-AutoConfig** > **Operational**.

> [!NOTE]
> Wireless reports and traces can contain device, adapter, and network identifiers. Handle the files according to your organization's privacy and data-handling requirements.

### Collect support diagnostics

If you plan to contact Microsoft Support, use the TroubleShootingScript (TSS) wireless scenario. Download and extract the toolset, open an elevated PowerShell session in the TSS folder, and then run:

```powershell
.\TSS.ps1 -Scenario NET_WLAN
```

The first run prompts you to accept the End User License Agreement. If the script is blocked from running, set the execution policy for the current process by running `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process`.

For download instructions and requirements, see [Introduction to TroubleShootingScript toolset (TSS)](../windows-tss/introduction-to-troubleshootingscript-toolset-tss.md#prerequisites). For other networking scenarios, see [Collect data to analyze and troubleshoot Windows networking scenarios](../windows-tss/collect-data-analyze-troubleshoot-windows-networking-scenarios.md).

### Collect an ETW trace

For a reproducible issue that requires advanced analysis, enter the following commands at an elevated command prompt. The trace doesn't start if the output folder doesn't exist, so create the folder first:

```cmd
if not exist c:\tmp md c:\tmp
netsh trace start wireless_dbg capture=yes overwrite=yes maxsize=4096 tracefile=c:\tmp\wireless.etl
```

> [!NOTE]
> `wireless_dbg` is a legacy scenario that `netsh trace show scenarios` doesn't list, but it remains available. To review the providers that it enables, run `netsh trace show scenario name=wireless_dbg`. For new support cases, prefer the TSS `NET_WLAN` scenario.

1. Reproduce the issue and record the time of the connection attempt or disconnect.
1. Stop the trace:

   ```cmd
   netsh trace stop
   ```

1. Convert the trace to text if required:

   ```cmd
   netsh trace convert c:\tmp\wireless.etl
   ```

The collection creates `wireless.cab`, `wireless.etl`, and, after conversion, `wireless.txt`. See the [example ETW capture](#etw-capture-example).

## Troubleshooting

The following table provides a high-level view of the main Wi-Fi components in Windows.

| Wi-Fi component | Description |
| --- | --- |
| :::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/windows-connection-manager.png" alt-text="Windows Connection Manager icon." border="false"::: | Windows Connection Manager (Wcmsvc) processes user connection requests and coordinates connectivity across available network interfaces. |
| :::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/wlan-autoconfig-service.png" alt-text="WLAN AutoConfig service icon." border="false"::: | The WLAN AutoConfig service (WlanSvc) scans for wireless networks and manages wireless profiles and connectivity. |
| :::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/media-specific-module.png" alt-text="Media Specific Module icon." border="false"::: | The Media Specific Module (MSM) manages connection security, association, and authentication state. |
| :::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/native-wifi-stack.png" alt-text="Native Wi-Fi stack icon." border="false"::: | The Native Wi-Fi stack consists of drivers and wireless APIs that interact with wireless miniports and the user-mode WLAN AutoConfig service. |
| :::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/wireless-miniport.png" alt-text="Wireless miniport icon." border="false"::: | The wireless miniport driver communicates between the Windows wireless stack and the adapter hardware. |

The Wi-Fi connection state machine has the following states:

- Reset
- Ihv_Configuring
- Configuring
- Associating
- Authenticating
- Connected
- Roaming
- Wait_For_Disconnected
- Disconnected

Standard Wi-Fi connections tend to transition between states such as:

- Connecting

  Reset --> Ihv_Configuring --> Configuring --> Associating --> Authenticating --> Connected

- Disconnecting

  Connected --> Roaming --> Wait_For_Disconnected --> Disconnected --> Reset

Filtering the ETW trace with the [TextAnalysisTool](https://github.com/TextAnalysisTool/Releases) (TAT) is an easy first step to determine where a failed connection setup is breaking down. A useful [Wi-Fi filter file](#wi-fi-filter-file-example) is included at the bottom of this article.

Use the **FSM transition** trace filter to see the connection state machine. You can see [an example](#textanalysistool-example) of this filter applied in the TAT at the bottom of this page.

An example of a good connection setup is:

```output
44676 [2]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.658 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Disconnected to State: Reset
45473 [1]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.667 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Reset to State: Ihv_Configuring
45597 [3]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.708 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Ihv_Configuring to State: Configuring
46085 [2]0F24.17E0::‎2018‎-‎09‎-‎17 10:22:14.710 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Configuring to State: Associating
47393 [1]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.879 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Associating to State: Authenticating
49465 [2]0F24.17E0::‎2018‎-‎09‎-‎17 10:22:14.990 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Authenticating to State: Connected
```

An example of a failed connection setup is:

```output
44676 [2]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.658 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Disconnected to State: Reset
45473 [1]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.667 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Reset to State: Ihv_Configuring
45597 [3]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.708 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Ihv_Configuring to State: Configuring
46085 [2]0F24.17E0::‎2018‎-‎09‎-‎17 10:22:14.710 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Configuring to State: Associating
47393 [1]0F24.1020::‎2018‎-‎09‎-‎17 10:22:14.879 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Associating to State: Authenticating
49465 [2]0F24.17E0::‎2018‎-‎09‎-‎17 10:22:14.990 [Microsoft-Windows-WLAN-AutoConfig]FSM Transition from State: Authenticating to State: Roaming
```

By identifying the state at which the connection fails, you can focus more specifically in the trace on logs prior to the last known good state.

Examining \[Microsoft-Windows-WLAN-AutoConfig\] logs prior to the bad state change should show evidence of error. Often, however, the error is propagated up through other wireless components.
In many cases the next component of interest is the MSM, which lies just below Wlansvc.

The important components of the MSM include:

- Security Manager (SecMgr) - handles all pre and post-connection security operations.
- Authentication Engine (AuthMgr) – Manages 802.1x auth requests

  :::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/msm-details.png" alt-text="Screenshot of MSM details showing Security Manager and Authentication Manager." border="false":::

Each of these components has its own individual state machines that follow specific transitions.
Enable the `FSM transition`, `SecMgr Transition`, and `AuthMgr Transition` filters in TextAnalysisTool for more detail.

Further to the preceding example, the combined filters look like the following command example:

```output
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
> In the next to last line, the SecMgr transition suddenly deactivates:<br>
>\[2\] 0C34.2FF0::08/28/17-13:24:29.7512788 \[Microsoft-Windows-WLAN-AutoConfig\]Port\[13\] Peer 8A:15:14:B6:25:10 SecMgr Transition DEACTIVATE (11) --> INACTIVE (1)
>
> This transition eventually propagates to the main connection state machine and causes the Authenticating phase to devolve to Roaming state. As before, focus on tracing prior to this SecMgr behavior to determine the reason for the deactivation.

Enabling the `Microsoft-Windows-WLAN-AutoConfig` filter shows more detail leading to the DEACTIVATE transition:

```output
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

Port events indicate changes closer to the wireless hardware. You can follow the trail by continuing to see the origin of this indication.

Continuing down from the MSM, the Native Wi-Fi stack passes requests to the wireless miniport driver. The stack presents the wireless adapter to TCP/IP and other protocols as an Ethernet (802.3) interface, so 802.11 frames are translated to 802.3 packets before they reach the protocol stack.

> [!NOTE]
> The `[Microsoft-Windows-NWiFi]` events in this example come from the legacy Native 802.11 miniport driver model. Current adapters use the WLAN Device Driver Interface (WDI) or, on Windows 11, the Wi-Fi Class Extension (WiFiCx) driver model. The connection stages are equivalent, but driver-level event names and provider details differ.

Enable trace filter for `[Microsoft-Windows-NWifi]`:

```output
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

In the trace, you see the line:

```output
[0]0000.0000::‎08/28/17-13:24:29.127 [Microsoft-Windows-NWiFi]DisAssoc: 0x8A1514B62510 Reason: 0x4
```

This line is followed by `PHY_STATE_CHANGE` and `PORT_DOWN` events after the access point (AP) at `8A:15:14:B6:25:10` sends a disassociation.

Decode the `Reason` value before you form a theory. The value comes from the IEEE 802.11 disassociation frame that the AP sent, so it identifies the condition that the AP reported. In this example, `Reason: 0x4` means *disassociated due to inactivity*, so the investigation should focus on AP or controller inactivity and session timers, client power-saving behavior, and whether client traffic stopped reaching the AP. Other reason codes indicate different conditions, such as invalid credentials, incompatible connection parameters, or an AP that can't accept more clients.

Because the AP supplies the reason code, correlate it with logging from the indicated AP or wireless controller before you change the client configuration.

### More information

- [netsh wlan](/windows-server/administration/windows-commands/netsh-wlan)
- [Advanced troubleshooting 802.1X authentication](802-1x-authentication-issues-troubleshooting.md)
- [Data collection for troubleshooting 802.1X authentication](data-collection-for-troubleshooting-802-1x-authentication-issues.md)
- [Collect data to analyze and troubleshoot Windows networking scenarios](../windows-tss/collect-data-analyze-troubleshoot-windows-networking-scenarios.md)
- [Windows release health](/windows/release-health/)

## ETW capture example

> [!NOTE]
> The following capture is a historical example that illustrates the collection output and state transitions. Timestamps, adapter names, and individual event text differ on current Windows 11 devices.

```output
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

## Wi-Fi filter file example

Copy and paste all the lines in the following code block, and save them into a text file named wifi.tat. Load the filter file into TextAnalysisTool by selecting **File** > **Load Filters**.

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

:::image type="content" source="media/wireless-network-connectivity-issues-troubleshooting/text-analysis-tool.png" alt-text="Screenshot of a TAT filter example in TextAnalysisTool." border="false" lightbox="media/wireless-network-connectivity-issues-troubleshooting/text-analysis-tool.png":::
