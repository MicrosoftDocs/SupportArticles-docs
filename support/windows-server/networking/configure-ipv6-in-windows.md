---
title: Configure IPv6 for advanced users
description: Provides step-by-step guidance for how to use the Windows registry to disable IPv6 or certain IPv6 components in Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, dbansal
ms.prod-support-area-path: TCP/IP communications
ms.technology: Networking
---
# Guidance for configuring IPv6 in Windows for advanced users

This article provides solutions to configure Internet Protocol version 6 (IPv6) for advanced users in Windows.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 929852

## Summary

A prefix table is used to determine which address to use when multiple addresses are available for a Domain Name System (DNS) name.

By default, Windows favors IPv6 global unicast addresses over IPv4 addresses.

It is common for IT administrators to want to disable IPv6. This is often because of some unknown, networking-related issue, such as a name resolution issue.

> [!IMPORTANT]
> IPv6 is a mandatory part of Windows Vista and Windows Server 2008 and newer versions. We do not recommend that you disable IPv6 or its components. If you do, some Windows components may not function.

We recommend that you use **Prefer IPv4 over IPv6** in prefix policies instead of disabling IPV6. By default, the 6to4 tunneling protocol is enabled in Windows Vista, Windows Server 2008, or later versions when an interface is assigned a public IPv4 address (that is, an IPv4 address that is not in the ranges 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16). 6to4 automatically assigns an IPv6 address to the 6to4 tunneling interface for each such address that is assigned, and 6to4 dynamically registers these IPv6 addresses on the assigned DNS server. If this behavior is not desired, we recommend that you disable IPv6 tunnel interfaces on the affected hosts.

## Use registry key to configure IPv6

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### Method 1: Use registry value to configure IPv6

To configure IPv6, modify the following registry value based on the following table.

> **Location**: HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters\\  
**Name**:        DisabledComponents  
**Type**:        REG_DWORD  
**Min Value**:   0x00  
**Max Value**:   0xFF (IPv6 disabled)

|IPv6 Functionality|Registry value and comments|
|---|---|
|Prefer IPv4 over IPv6|Dec 32<br/>Hex 0x20<br/>Bin xx1x xxxx<br/><br/>Recommended instead of disabling it.|
|Disable IPv6|Dec 255<br/>Hex 0xFF<br/>Bin 1111 1111<br/><br/>See [startup delay occurs after you disable IPv6 in Windows](https://support.microsoft.com/help/3014406) if you encounter startup delay after you disable IPv6 in Windows 7 SP1 or Windows Server 2008 R2 SP1. <br/><br/> Additionally, system startup will be delayed for five seconds if IPv6 is disabled by incorrectly, setting the Disabled Components registry setting to a value of 0xfffffff. The correct value should be 0xff. For more information, see [Internet Protocol Version 6 (IPv6) Overview](/previous-versions/windows/it-pro/windows-8.1-and-8/hh831730(v=ws.11)). <br/><br/>  The Disabled Components registry value does not affect the state of the check box. Therefore, even if the Disabled Components registry key is set to disable IPv6, the check box in the Networking tab for each interface can still be checked. This is expected behavior.|
|Disable IPv6 on all nontunnel interfaces|Dec 16<br/> Hex 0x10<br/>Bin xxx1 xxxx|
|Disable IPv6 on all tunnel interfaces|Dec 1<br/> Hex 0x01<br/>Bin xxxx xxx1|
|Disable IPv6 on all nontunnel interfaces (except the loopback) and on IPv6 tunnel interface|Dec 17<br/> Hex 0x11<br/>Bin xxx1 xxx1|
|Prefer IPv6 over IPv4|Bin xx0x xxxx|
|Re-enable IPv6 on all nontunnel interfaces|Bin xxx0 xxxx|
|Re-enable IPv6 on all tunnel interfaces|Bin xxx xxx0|
|Re-enable IPv6 on nontunnel interfaces and on IPv6 tunnel interfaces|Bin xxx0 xxx0|
|||

>[!NOTE]
>
> - Administrators must create an .admx file to expose the settings in step 5 in a Group Policy setting.
> - You must restart your computer for these changes to take effect.
> - Value other than 0 or 32 causes the Routing and Remote Access service to fail after this change takes effect.

### Method 2: Use Command Prompt to configure IPv6

You can also follow these steps to modify the registry key:

1. Open an administrative **Command Prompt** window.
2. Run the following command:

    ```console
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d <value> /f
    ```

    > [!NOTE]
    > Replace the \<value> with the corresponding value in the previous table.

### How to calculate the registry value

Windows use bitmasks to check the **Disabled Components** values and determine whether a component should be disabled.

To learn which component each bit (from low to high) controls, refer to the following table.

|Tunnel|Disable tunnel interfaces|
|---|---|
|Tunnel6to4|Disable 6to4 interfaces|
|TunnelIsatap|Disable Isatap interfaces|
|Tunnel Teredo|Disable Teredo interfaces|
|Native|Disable native interfaces (also PPP)|
|PreferIpv4|Prefer IPv4 in default prefix policy|
|TunnelCp|Disable CP interfaces|
|TunnelIpTls|Disable IP-TLS interfaces|
|||

For each bit, **0** means false and **1** means true. Refer to the following table for an example.

||Prefer IPv4 over IPv6 in prefix policies|Disable IPv6 on all nontunnel interfaces|Disable IPv6 on all tunnel interfaces|Disable IPv6 on nontunnel interfaces (except the loopback) and on IPv6 tunnel interface|
|---|---|---|---|---|
|Disable tunnel interfaces|0|0|1|1|
|Disable 6to4 interfaces|0|0|0|0|
|Disable Isatap interfaces|0|0|0|0|
|Disable Teredo interfaces|0|0|0|0|
|Disable native interfaces (also PPP)|0|1|0|1|
|Prefer IPv4 in default prefix policy.|1|0|0|0|
|Disable CP interfaces|0|0|0|0|
|Disable IP-TLS interfaces|0|0|0|0|
|Binary|0010 0000|0001 0000|0000 0001|0001 0001|
|Hexadecimal|0x20|0x10|0x01|0x11|
||||||

## Reference

For information about RFC 3484, see [Default Address Selection for Internet Protocol version 6 (IPv6)](https://tools.ietf.org/html/rfc3484).

For more information about how to set IPv4 precedence over IPv6, see [Using SIO_ADDRESS_LIST_SORT](/windows/win32/winsock/using-sio-address-list-sort).

For information about RFC 4291, see [IP Version 6 Addressing Architecture](https://tools.ietf.org/html/rfc4291).

For more information about the related issues, see:

- On Domain Controllers, you might run into where LDAP over UDP 389 will stop working,
see [How to use Portqry to troubleshoot Active Directory connectivity issues](https://support.microsoft.com/help/816103).
- Exchange Server 2010, you might run into problems where Exchange will stop working,
see [Arguments against disabling IPv6](/archive/blogs/netro/arguments-against-disabling-ipv6) and [Disabling IPv6 And Exchange - Going All The Way](https://blog.rmilne.ca/2014/10/29/disabling-ipv6-and-exchange-going-all-the-way/).
- Failover Clusters, see [What is a Microsoft Failover Cluster Virtual Adapter anyway?](/archive/blogs/askcore/what-is-a-microsoft-failover-cluster-virtual-adapter-anyway) and [Failover Clustering and IPv6 in Windows Server 2012 R2](https://techcommunity.microsoft.com/t5/failover-clustering/failover-clustering-and-ipv6-in-windows-server-2012-r2/ba-p/371912).

For more information about tools to help with network trace, see:

- [Microsoft Message Analyzer Operating Guide](/message-analyzer/microsoft-message-analyzer-operating-guide)
- [Microsoft Network Monitor 3.4 (archive)](/windows/client-management/troubleshoot-tcpip-netmon)

    > [!WARNING]
    > Netmon 3.4 is not compatible with Windows Server 2012 or newer OS when LBFO NIC teaming is enabled. Instead, use **Message Analyzer**.
