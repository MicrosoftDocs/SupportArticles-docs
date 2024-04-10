---
title: Network Connection Status Indicator (NCSI) troubleshooting guidance
description: Provides guidance to help troubleshoot NCSI issues.
ms.date: 04/10/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, anupamk, asvaidya, hichauhan, v-lianna
ms.custom: sap: Network Connectivity and File Sharing\NCSI, csstroubleshoot
---
# Network Connection Status Indicator (NCSI) troubleshooting guidance

This guidance is designed to help troubleshoot NCSI issues.

## Basics of NCSI

The Network Location Awareness (NLA) service determines what type of network connectivity Windows has.

Until the NLA service loads the *ncsi.dll* file in Windows 10, it performs operations and receives notifications and status information regarding the network. The connectivity status evaluated by NCSI is used by various applications, such as Microsoft Outlook, Microsoft Teams, Skype, Windows Update, Microsoft DirectAccess, and some third-party software.

Starting with Windows 11, the job is performed by the Network List Service (netprofm) service.

NCSI primarily operates through network probes, which involve sending a simple network request to an endpoint and awaiting a response.

### Active probes

An active probe can involve a Domain Name System (DNS) lookup of a specific NCSI address or a request directed to a web probe server. While the server is hosted by Microsoft on the internet, it can also be a customer's private probe server within their enterprise, although this is uncommon.

If NCSI sends a probe and receives a valid response, the machine is connected to the internet.

> [!NOTE]
> Don't disable active probing to resolve an issue.

### Passive probes

While active probing explicitly performs a network-related action to acquire information about the network status, passive probing uses information learned from received data to achieve the same purpose.

It relies on network statistics such as recently sent or received packets, the Time To Live (TTL) values of these frames, and notifications from other components.

## Troubleshooting checklist

### 1. The network status taskbar icon

The network status taskbar icon is a fundamental indication of the network connectivity. It informs the user whether the network is fully available or if there's some degree of network problem.

- Full internet access over Wi-Fi: :::image type="icon" source="media/troubleshoot-ncsi-guidance/full-internet-access-wi-fi.png":::
- Full internet access over Ethernet: :::image type="icon" source="media/troubleshoot-ncsi-guidance/full-internet-access-ethernet-10.png"::: or :::image type="icon" source="media/troubleshoot-ncsi-guidance/full-internet-access-ethernet-11.png":::
- Some degree of network outage:

  - **Not connected - Connections are available**: :::image type="icon" source="media/troubleshoot-ncsi-guidance/not-connected.png":::
  - **Identifying… No Internet access**: :::image type="icon" source="media/troubleshoot-ncsi-guidance/no-internet-access-a.png":::, :::image type="icon" source="media/troubleshoot-ncsi-guidance/no-internet-access-b.png":::, or :::image type="icon" source="media/troubleshoot-ncsi-guidance/no-internet-access-c.png":::

> [!NOTE]
> It's beneficial not to solely depend on the indicator. The inability of NCSI to complete a probe doesn't necessarily imply that the client machine can't access the internet.

To resolve NCSI issues, ensure that NCSI can send an active probe to the internet and receive a response successfully.

### 2. NCSI browser test

Open a browser and access [Microsoft Connect Test](http://www.msftconnecttest.com/connecttest.txt) (`ipv6.msftconnecttext.com` for IPv6). The expected content is "Microsoft Connect Test."

If you can't get the text file, verify the following items:

- The proxy settings are configured properly on the target client.
- The proxy server doesn't limit access to the preceding addresses.

If the client is prior to Windows 10, version 1607, use [Microsoft NCSI](http://www.msftncsi.com/ncsi.txt) (`ipv6.msftncsi.com` for IPv6). The expected content is a plain text file with the content "Microsoft NCSI."

Sometimes, a manual test on the browser succeeds while NCSI fails, as it bypasses the proxy. In such cases, tracking the traffic through a network trace can help identify abnormal behavior.

### 3. Check NCSI event logs

Check NCSI event logs in the path *Applications and Services Logs\\Microsoft\\Windows\\NCSI\\Operational*. For example:

:::image type="content" source="./media/troubleshoot-ncsi-guidance/event-4042-ncsi.png" alt-text="Screenshot of an example of Event 4042, NCSI showing the general information.":::

### 4. Check the registry location for any changes

> [!NOTE]
> Active probing must be enabled.

The HTTP web probe server, path, expected probe content, and the DNS probe host and content are predefined under the registry path:
`HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet`

The default value in Windows 10, version 1607 and later versions:

|Name  |Type  |Data  |
|---------|---------|---------|
|(Default)     |REG_SZ         |(value not set)         |
|ActiveDnsProbeContent     |REG_SZ         |131.107.255.255         |
|ActiveDnsProbeContentV6     |REG_SZ         |fd3e:4f5a:5b81::1         |
|ActiveDnsProbeHost     |REG_SZ         |dns.msftncsi.com         |
|ActiveDnsProbeHostV6     |REG_SZ         |dns.msftncsi.com         |
|ActiveWebProbeContent     |REG_SZ         |Microsoft Connect Test         |
|ActiveWebProbeContentV6     |REG_SZ         |Microsoft Connect Test         |
|ActiveWebProbeHost     |REG_SZ         |www.msftconnecttest.com         |
|ActiveWebProbeHostV6     |REG_SZ         |ipv6.msftconnecttest.com         |
|ActiveWebProbePath     |REG_SZ         |connecttest.txt         |
|ActiveWebProbePathV6     |REG_SZ         |connecttest.txt         |
|CaptivePortalTimer     |REG_DWORD         |0x00000000 (0)        |
|CaptivePortalTimerBackOffincrementsInSeconds     |REG_DWORD         |0x00000005 (5)         |
|CaptivePortalTimerMaxInSeconds     |REG_DWORD         |0x0000001e (30)         |
|EnableActiveProbing     |REG_DWORD         |0x00000001 (1)         |
|PassivePollPeriod     |REG_DWORD         |0x0000000f (15)         |
|StaleThreshold     |REG_DWORD         |0x0000001e (30)         |
|WebTimeout     |REG_DWORD         |0x00000023 (35)         |

The default value in Windows 10, version 1511, Windows 10, version 1507, Windows 8.1, and Windows 8:

|Name  |Type  |Data  |
|---------|---------|---------|
|(Default)     |REG_SZ         |(value not set)         |
|ActiveDnsProbeContent     |REG_SZ         |131.107.255.255         |
|ActiveDnsProbeContentV6     |REG_SZ         |fd3e:4f5a:5b81::1         |
|ActiveDnsProbeHost     |REG_SZ         |dns.msftncsi.com         |
|ActiveDnsProbeHostV6     |REG_SZ         |dns.msftncsi.com         |
|ActiveWebProbeContent     |REG_SZ         |Microsoft NCSI         |
|ActiveWebProbeContentV6     |REG_SZ         |Microsoft NCSI         |
|ActiveWebProbeHost     |REG_SZ         |www.msftncsi.com         |
|ActiveWebProbeHostV6     |REG_SZ         |ipv6.msftncsi.com         |
|ActiveWebProbePath     |REG_SZ         |ncsi.txt         |
|ActiveWebProbePathV6     |REG_SZ         |ncsi.txt         |
|EnableActiveProbing     |REG_DWORD         |0x00000001 (1)         |
|PassivePollPeriod     |REG_DWORD         |0x0000000f (15)         |
|StaleThreshold     |REG_DWORD         |0x0000001e (30)         |
|WebTimeout     |REG_DWORD         |0x00000023 (35)         |

Windows 7 and earlier versions don't have this feature.

Starting with Windows 10, version 1607, web probe (HTTP) requests are sent to [Microsoft Connect Test](http://www.msftconnecttest.com/connecttest.txt).
The expected response is "HTTP 200 OK," with the payload containing "Microsoft Connect Test."

> [!NOTE]
> If active probing is disabled via a local registry key, the value of `EnableActiveProbing` is *0*. Make sure to set the value to *1*.

### 5. Simple test for connectivity

Run the following PowerShell cmdlet to test the connectivity:

```powershell
Get-NetConnectionProfile
```

Here's an example of good connectivity:

```output
Name                     : XYZ
InterfaceAlias           : Ethernet
InterfaceIndex           : 5
NetworkCategory          : Private
DomainAuthenticationKind : None
IPv4Connectivity         : Internet
IPv6Connectivity         : Internet
```

If the IPv4 or IPv6 connectivity for any interfaces indicates `Internet`, the machine's connectivity is considered internet. In such cases, the issue is currently not reproducible or unrelated to NCSI.

### 6. Check which probe is used to detect the internet on the impacted machine

Depending on various factors, a machine might use a specific type of active probe to determine internet connectivity. Additionally, considering that both active and passive probes are active, the machine might fail when using an active probe, while the network status is detected with a passive probe.

### 7. Check the "MaxActiveProbes" value

The number of active probes sent by NCSI won't exceed the value set in `HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\MaxActiveProbes`.

By default, this key doesn't exist (or is set to *0*). This indicates the number of probes is unlimited, which should rarely pose an issue.

### 8. Check DNS resolution

For DNS probes, perform [nslookup](/windows-server/administration/windows-commands/nslookup) or [Resolve-DnsName](/powershell/module/dnsclient/resolve-dnsname) to `dns.msftncsi.com` to ensure that the endpoint is resolvable from the machine.

### 9. Passive probe related settings

Check the registry value of  `HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\MinimumInternetHopCount`.

A value of *3* generally suits most enterprise infrastructure. The default value is *8*.

Check the Group Policy Object (GPO) configuration:
**Computer Configuration**\\**Administrative Templates**\\**Network**\\**Network Connectivity Status Indicator**\\**Specify passive polling**.

> [!NOTE]
> When Group Policy isn't configured, it's allowed by default.

## Common issues and solutions

### DNS probe failed due to an incorrect probe server

Ensure that the DNS fully qualified domain name (FQDN) specified in the registry for active probes matches the target probe server.

We recommend not modifying the default probe data configuration unless needed. While customers can override it to direct to their privately hosted probe servers, this is rare.

### DNS probe failed due to a timeout

Find out why there's no DNS response. Possible causes include an undetected proxy and an incorrect DNS server IP address.

### HTTP probe failed due to an "HTTP 403 Forbidden" error

Check if there are any firewall or gateway blocks in your environment.

### DNS resolution failed to send HTTP probes

The DNS server should be able to respond to the `msftconnecttest.com` query or forward it to a server that can do so.

### HTTP direct probe fails but proxy exists

Ensure that the client receives a valid DNS response to the Web Proxy Auto-Discovery (WPAD) query. If the DNS server can't resolve the query, it should forward the query to a DNS server that can do so.

Other options include manually configuring proxy data (via a GPO) or allowing active probes through the upstream firewall.

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TroubleShootingScript (TSS) must be run by accounts with administrator privileges on the local system, and the end-user license agreement (EULA) must be accepted (once the EULA is accepted, TSS won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSS runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) and extract it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Start the traces on the impacted machine by using the following cmdlet:

    ```powershell
    .\TSS.ps1 -Start -Scenario NET_NCSI
    ```

4. Accept the EULA and Problem Steps Recorder (PSR) confirmation.
5. Reproduce the issue before entering *Y*.
6. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MS_DATA* folder.

## Frequently asked questions

### Q1. When are active probes sent?

Active probes are triggered by certain events. NCSI monitors or is registered to receive notifications of the events indicating that the network state may need to be refreshed.

### Q2. How does NCSI know whether to use an HTTP or DNS probe?

- When no proxy exists, NCSI probes with DNS.
- If a proxy is detected, NCSI uses HTTP probes.
- There's also a "forced" web probe when the existence of a proxy hasn't been confirmed. Sometimes, NCSI might discover a proxy. But in the meantime, if DNS probes don't work, it might suspect a proxy without clear evidence. In both cases, NCSI uses HTTP probes.
- Wi-Fi and IPv6 interfaces always use HTTP probes.

### Q3. When and how often does the passive probe run?

The passive probe will only run when these conditions are met:

- The following setting is allowed by Group Policy.
    **Computer Configuration**\\**Administrative Templates**\\**Network**\\**Network Connectivity Status Indicator**\\**Specify passive polling**

    > [!NOTE]
    > When Group Policy isn't configured, it's allowed by default.
- At least one client application or service has registered for NCSI notifications.
- A user is logged in or has logged in within the past 30 seconds.
- The system isn't running in network quiet mode.
- An IPv4/IPv6 unicast address exists on an interface, and/or packets were processed within the past 30 seconds.

### Q4. Why are both active and passive probes needed simultaneously?

Active and passive probes complement each other. They both determine the same end results (types of connectivity), but in different ways. They're both needed due to intermittent network conditions. Sometimes, these conditions prevent active probes from functioning correctly.
