---
title: Domain-joined machines can't detect the domain profile
description: Helps troubleshoot a scenario where a domain-joined machine can't detect the domain profile. 
ms.date: 08/21/2024
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
ms.reviewer: kaushika, warrenw, shpune, v-lianna
audience: itpro
---
# Domain-joined machines can't detect the domain profile

This guidance helps troubleshoot a scenario where a domain-joined machine can't detect the domain profile.

A machine is joined to a domain network but can't detect the domain profile for this network, and you might notice the following issues or symptoms:

- The network status shows as "Unidentified network" in the system tray.
- An incorrect firewall profile is applied on the machine. For example, the public profile is applied even though the machine is joined to the domain.
- Firewall rules configured under the domain profile aren't applied, leading to connectivity issues.
- The connectivity to internal applications might fail because the domain profile isn't active.

## Overview of Network Location Awareness (NLA)

The Network Location Awareness (NLA) service performs network location detection for any of the following network changes:

- Adding or removing any IP route.
- Adding or removing any IP address.
- Disconnecting or reconnecting the network adapter.
- Disabling or re-enabling the network adapter.
- Dynamic Host Configuration Protocol (DHCP) events (lease renewals, Domain Name System (DNS) server addition or removal, and so on).
- Any changes to the Network Connectivity Status Indicator (NCSI) settings, such as the [DomainLocationDeterminationUrl](https://gpsearch.azurewebsites.net/Default.aspx?PolicyID=2583#1993) setting.

## Domain authentication for NLA

When a domain-joined machine is connected to a new network, it performs the following checks to identify if it's in the domain network. NCSI determines the internet connectivity, and NLA performs the domain authentication for the network profile.

Any network change triggers NCSI detection, and NLA tries to authenticate to the domain controller (DC) to assign the correct profile to the Windows firewall.

Here are the authentication steps:

1. The NLA service calls the `DsGetDcName` function to retrieve the DC name. This is done through DNS name resolution, such as `_ldap._tcp.<SiteName>._sites.dc._msdcs.<DomainName>`.
2. After the DNS name resolution is successful and returns the DC name, a Lightweight Directory Access Protocol (LDAP) connection happens on port 389 to the DC retrieved in the preceding step.
3. The machine establishes a TCP connection with the DC over TCP port 389 and sends an LDAP bind request. Once this LDAP bind is successful, the machine will identify itself in the domain network.

Based on whether the domain detection process is successful, the firewall profile is applied accordingly.

Computers that are running Windows 7, Windows Server 2008 R2, and later operating systems can detect the following network location types:

- Public

    By default, the public network location type is assigned to any new network when the computers are first connected. The public profile is used to designate public networks, such as Wi-Fi hotspots in coffee shops, airports, and other locations.

- Private

    Local administrators can manually select the private network location type for a connection to a network that isn't directly accessible to the public. This connection can be linked to a home or office network that is isolated from publicly accessible networks by using a firewall device or a device that performs network address translation (NAT).

- Domain

    The domain network location type is detected when the local computer is a member of an Active Directory domain, and the local computer can authenticate to a DC for that domain through one of its network connections. An administrator can't manually assign this network location type.

When multiple network adapters are attached to your computer, you can connect to different types of networks. Computers that are running Windows 7, Windows Server 2008 R2, and later operating systems support different network location types.

The function of the NLA service is to collect and store configuration information for the network and notify programs when that information is modified.

The information gathered by NLA is curated by the Network List Service (NLS) service and stored under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList`.

Starting from Windows 11, the NLA service is no longer responsible for detecting the domain profile. Instead, the Network List Manager does this job, and it runs in the system context.

Here are some important registries to help diagnose the current profile, network, or adapter state:

|Location  |Usage  |
|---------|---------|
|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Managed`     |This registry key shows the managed network profiles stored in the Windows registry.         |
|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Unmanaged`     |This registry key shows the unmanaged network profiles stored in the Windows registry.         |
|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\{985EE69C-23B4-4D38-AC66-5F0D6AD8A128}`     |This registry key contains information about network profiles in Windows and the current category of the network profile.<br><br>A value of `0` means the network isn't an Active Directory network.<br><br>A value of `1` means the network is an Active Directory network, but this machine isn't authenticated against it.<br><br>A value of `2` means the network is an Active Directory network, and this machine is authenticated against it.        |

## Check the currently applied network profile

You can verify if the domain-joined machine can successfully detect the domain network profile by using the following PowerShell cmdlet:

```PowerShell
PS C:\Users\admin> Get-NetConnectionProfile
Name             : contoso.com
InterfaceAlias   : Contoso
InterfaceIndex   : 13
NetworkCategory  : DomainAuthenticated
IPv4Connectivity : Internet
IPv6Connectivity : NoTraffic
```

## Troubleshoot domain detection issues

1. Check if the machine can identify an LDAP server or DC by resolving the name `_ldap._tcp.<SiteName>._sites.dc._msdcs.<DomainName>`.

    From an administrative command prompt or PowerShell window, run the following command to force DC discovery:

    ```console
    Nltest /dsgetdc:<DomainName> /force
    ```

    Ensure that you can list the DC name in the output of the command, for example:

    ```output
    PS C:\tss> nltest /dsgetdc:contoso.com /force
               DC: \\DC.contoso.com
          Address: \\10.0.1.2
         Dom Guid: <GUID>
         Dom Name: contoso.com
      Forest Name: contoso.com
     Dc Site Name: Default-First-Site-Name
    Our Site Name: Default-First-Site-Name
            Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE FULL_SECRET WS DS_8 DS_9 DS_10 KEYLIST
    The command completed successfully
    ```

    If the DNS name resolution fails and returns `DsGetDcName function Failed with ERROR_NO_SUCH_DOMAIN`, the machine doesn't identify itself in the domain network, even though it's inside the corporate network.

2. Check if the machine can establish a TCP port 389 connection to the DC identified in the preceding step.

    Ensure that TCP port 389 is allowed in Windows Firewall.

    From an administrative command prompt or PowerShell window, run the following command to check if the TCP connection to the DC is successful:

    ```console
    Telnet <DCName or IP> 389
    ```

    If a blank window opens, that means the TCP connection can be successfully established.

    If it fails, the NLA domain detection process can't proceed further, and the machine can't identify the domain network.

3. Check if the machine can perform an LDAP bind with the DC inside the established TCP port 389 connection.

    LDAP bind requests and responses can be seen in the TCP port 389 session in a network trace collected during the NLA domain detection process.

    If the LDAP bind fails, you'll see 'Unauthenticated" on the network adapter in *ncpa.cpl*. It will show up as "Contoso.com (Unauthenticated)."

4. Check the Microsoft-Windows-NetworkProfile/Operational event logs for any errors.

    Here's an example of a successful domain detection.

    Network identification in progress:

    :::image type="content" source="media/domain-joined-machines-cannot-detect-domain-profile/network-identification-progress.png" alt-text="Screenshot of the event log showing the network identification in progress.":::

    Domain network identified:

    :::image type="content" source="media/domain-joined-machines-cannot-detect-domain-profile/domain-network-identified.png" alt-text="Screenshot of the event log showing the domain network identified.":::

## Network capture analysis

To troubleshoot the scenario, you can collect a network capture using [Wireshark](https://www.wireshark.org/download.html) while disabling and re-enabling the network adapter or restarting the NLS service (which triggers the NLA domain detection process).

> [!NOTE]
> In some scenarios, the issue might be resolved by disabling and re-enabling the adapter or restarting the NLS service. You can collect a network trace while doing this only if the issue persists.
>
> To download Wireshark, see [Download Wireshark](https://www.wireshark.org/download.html).
>
> To capture a Wireshark trace, see the steps in [Start Capturing](https://www.wireshark.org/docs/wsug_html_chunked/ChCapCapturingSection.html).

Once a network trace is collected, you can follow these steps to perform the basic analysis to identify the root cause.

Open the network capture in Wireshark. In the "Apply a display filter" space, type *dns* and apply the filter.

Look for the DNS query sent for the name "_ldap" to identify a DC in the domain.

A successful name resolution should resemble this example:

```output
292 <DateTime>  10.0.1.10   10.0.1.2    DNS 130         Standard query 0x9022 SRV _ldap._tcp.Default-First-Site-Name._sites.dc._msdcs.contoso.com
293 <DateTime>  10.0.1.2    10.0.1.10   DNS 173         Standard query response 0x9022 SRV _ldap._tcp.Default-First-Site-Name._sites.dc._msdcs.contoso.com SRV 0 100 389 dc.contoso.com A 10.0.1.2
```

The next step is to successfully establish an LDAP connection over TCP port 389 with the identified DC as the destination.

Apply the filter "ip.addr==10.0.1.2 and tcp.port==389" in the display filter space to identify this TCP session.

> [!NOTE]
> The value `10.0.1.2` in the filter needs to be replaced with the IP address of the DC obtained in your environment.

A successful LDAP connection and bind should look like:

TCP connection established:

```output
298 <DateTime>  10.0.1.10   10.0.1.2    TCP 66  1521521070  0   59506 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
299 <DateTime>  10.0.1.2    10.0.1.10   TCP 66  690649648   1521521071  389 → 59506 [SYN, ACK, ECE] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
300 <DateTime>  10.0.1.10   10.0.1.2    TCP 54  1521521071  690649649   59506 → 389 [ACK] Seq=1 Ack=1 Win=2097920 Len=0
```

LDAP bind successfully completed:

```output
316 <DateTime>  10.0.1.10   10.0.1.2    LDAP    1912    1521521422  690652335   bindRequest(267) "<ROOT>" sasl 
318 <DateTime>  10.0.1.2    10.0.1.10   LDAP    266 690652335   1521523280  bindResponse(267) success
```

For further troubleshooting, contact Microsoft Support.

## Data collection

Before contacting Microsoft Support, you can gather information about your issue.

Download and collect logs using the [TSS toolset](../windows-tss/introduction-to-troubleshootingscript-toolset-tss.md), and then enable log collection on the impacted machine by using the following cmdlet:

```PowerShell
.\TSS.ps1 -Scenario NET_NCSI
```

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
