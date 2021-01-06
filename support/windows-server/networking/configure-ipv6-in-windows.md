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

It is common for IT administrators to disable IPv6 to troubleshoot networking-related issues such as name resolution issues.

> [!IMPORTANT]
> IPv6 is a mandatory part of Windows Vista and Windows Server 2008 and newer versions. We don't recommend disabling IPv6 or its components. If you do, some Windows components may not function.
>
> We recommend using **Prefer IPv4 over IPv6** in prefix policies instead of disabling IPV6.

## Registry key for IPv6 configuration

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

The IPv6 functionality can be configured by modifying the following registry key:

**Location**: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\`  
**Name**: DisabledComponents  
**Type**: REG_DWORD  
**Min Value**: 0x00 (default value)  
**Max Value**: 0xFF (IPv6 disabled)

Windows uses bitmasks to check the **DisabledComponents** values and determine whether a component should be disabled. For more information on how to calculate the registry value, see [How to calculate the registry value](#how-to-calculate-the-registry-value).

The following lists the values for some common settings:

- Prefer IPv4 over IPv6

  |Dec|Hex|
  |---|---|
  |32|0x20|
  
  This functionality is recommended instead of disabling IPv6.

- Disable IPv6

  |Dec|Hex|
  |---|---|
  |255|0xFF|

  > [!NOTE]
  > You cannot completely disable IPv6 as IPv6 is used internally on the system for many TCPIP tasks.
  > For example, you will still be able to run `ping ::1` after configuring this setting.

  See [startup delay occurs after you disable IPv6 in Windows](https://support.microsoft.com/help/3014406) if you encounter startup delay after disabling IPv6 in Windows 7 SP1 or Windows Server 2008 R2 SP1.

  Additionally, system startup will be delayed for five seconds if IPv6 is disabled incorrectly by setting the DisabledComponents registry setting to a value of 0xffffffff. The correct value should be 0xff. For more information, see [Internet Protocol Version 6 (IPv6) Overview](/previous-versions/windows/it-pro/windows-8.1-and-8/hh831730(v=ws.11)).

  The DisabledComponents registry value doesn't affect the state of the check box. Even if the DisabledComponents registry key is set to disable IPv6, the check box in the Networking tab for each interface can be checked. This is an expected behavior.

- Disable IPv6 on all nontunnel interfaces

  |Dec|Hex|
  |---|---|
  |16|0x10|

- Disable IPv6 on all tunnel interfaces

  |Dec|Hex|
  |---|---|
  |1|0x01|

- Disable IPv6 on all nontunnel interfaces (except the loopback) and on IPv6 tunnel interface

  |Dec|Hex|
  |---|---|
  |17|0x11|

> [!NOTE]
>
> - Administrators must create an .admx file to expose these settings in a Group Policy setting.
> - You must restart your computer for these changes to take effect.
> - Values other than 0 or 32 causes the Routing and Remote Access service to fail after this change takes effect.

By default, the 6to4 tunneling protocol is enabled in Windows when an interface is assigned a public IPv4 address (Public IPv4 address means any IPv4 address that isn’t in the ranges 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16).

6to4 automatically assigns an IPv6 address to the 6to4 tunneling interface for each address, and 6to4 dynamically registers these IPv6 addresses on the assigned DNS server. If this behavior isn’t desired, we recommend disabling the IPv6 tunnel interfaces on the affected hosts.

### Use Command Prompt to configure IPv6

You can also follow these steps to modify the registry key:

1. Open an administrative **Command Prompt** window.
2. Run the following command:

    ```console
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d <value> /f
    ```

    > [!NOTE]
    > Replace the \<value> with the corresponding value.

### Using the network properties GUI to disable IPv6 is not supported

This registry value doesn't affect the state of the following check box. Even if the registry key is set to disable IPv6, the check box in the **Networking** tab for each interface can be selected. This is an expected behavior.

:::image type="content" source="./media/configure-ipv6-in-windows/network-properties.png" alt-text="Network properties":::

## How to calculate the registry value

The registry value is a 32-bit (REG_DWORD type) value. Each bit of the lowest eight bits of the value is a switch of a functionality.

From low to high, this table lists the component each bit controls:

|Index|Functionality|
|---|---|---|
|0|Disable tunnel interfaces|
|1|Disable 6to4 interfaces|
|2|Disable Isatap interfaces|
|3|Disable Teredo interfaces|
|4|Disable native interfaces (also PPP)|
|5|Prefer IPv4 in default prefix policy|
|6|Disable CP interfaces|
|7|Disable IP-TLS interfaces|
|||

For each bit, set it to 0 to turn off the switch, or set it to 1 to turn the switch on. To calculate the value, set 0 or 1 for each bit of a eight-bit binary number, and then convert it to a hexadecimal or decimal number.

Here are some examples:

|Setting\\Index|7|6|5|4|3|2|1|0|===|Bin|Value|
|---|---|---|---|---|---|---|---|---|---|---|---|
|Prefer IPv4 over IPv6 in prefix policies|0|0|1|0|0|0|0|0|===|00100000|0x20|
|Disable IPv6 on all nontunnel interfaces|0|0|0|1|0|0|0|0|===|00010000|0x10|
|Disable IPv6 on all tunnel interfaces|0|0|0|0|0|0|0|1|===|00000001|0x01|
|Disable IPv6 on nontunnel interfaces (except the loopback) and on IPv6 tunnel interface|0|0|0|1|0|0|0|1|===|00010001|0x11|
||||||||||||

Here are some common settings which require to set the related bits to 0:

- Prefer IPv6 over IPv4  
  From the current value, set the sixth bit (Prefer IPv4 in default prefix policy) to 0. (xx0x xxxx)

- Re-enable IPv6 on all nontunnel interfaces  
  From the current value, set the fifth bit (Disable native interfaces (also PPP)) to 0. (xxx0 xxxx)

- Re-enable IPv6 on all tunnel interfaces  
  From the current value, set the first bit (Disable tunnel interfaces) to 0. (xxxx xxx0)

- Re-enable IPv6 on nontunnel interfaces and on IPv6 tunnel interfaces
  From the current value, set the first and the fifth bits to 0. (xxx0 xxx0)

## Reference

For more information about IPv6, see [Internet Protocol Version 6 (IPv6) Overview
](/previous-versions/windows/it-pro/windows-8.1-and-8/hh831730(v=ws.11)).

For more information about how to manage Group Policy settings by using ADMX files, see [Managing Group Policy ADMX Files Step-by-Step Guide](/previous-versions/windows/it-pro/windows-vista/cc709647(v=ws.10)).

For more information about RFC 3484, see [Default Address Selection for Internet Protocol version 6 (IPv6)](https://tools.ietf.org/html/rfc3484).

For more information about how to set IPv4 precedence over IPv6, see [Using SIO_ADDRESS_LIST_SORT](/windows/win32/winsock/using-sio-address-list-sort).

For information about RFC 4291, see [IP Version 6 Addressing Architecture](https://tools.ietf.org/html/rfc4291).

For more information about related issues, see:

- On Domain Controllers, LDAP over UDP 389 stops working. See [How to use Portqry to troubleshoot Active Directory connectivity issues](https://support.microsoft.com/help/816103).
- Exchange Server 2010 stops working. See [Arguments against disabling IPv6](/archive/blogs/netro/arguments-against-disabling-ipv6) and [Disabling IPv6 And Exchange - Going All The Way](https://blog.rmilne.ca/2014/10/29/disabling-ipv6-and-exchange-going-all-the-way/).
- Failover Clusters. See [What is a Microsoft Failover Cluster Virtual Adapter anyway?](/archive/blogs/askcore/what-is-a-microsoft-failover-cluster-virtual-adapter-anyway) and [Failover Clustering and IPv6 in Windows Server 2012 R2](https://techcommunity.microsoft.com/t5/failover-clustering/failover-clustering-and-ipv6-in-windows-server-2012-r2/ba-p/371912).

For more information about network trace tools, see:

- [Microsoft Message Analyzer Operating Guide](/message-analyzer/microsoft-message-analyzer-operating-guide)
- [Microsoft Network Monitor 3.4 (archive)](/windows/client-management/troubleshoot-tcpip-netmon)

    > [!WARNING]
    > Netmon 3.4 isn't compatible with Windows Server 2012 or newer OS when LBFO NIC teaming is enabled. Use **Message Analyzer** instead.
