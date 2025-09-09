---
title: Configure IPv6 for advanced users
description: Provides step-by-step guidance for how to use the Windows registry to disable IPv6 or certain IPv6 components in Windows.
ms.date: 1/20/2025
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, dbansal, tayasuta
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
adobe-target: true
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "aartigoyle" for triage before making the further changes to the screenshots.
--->

# Guidance for configuring IPv6 in Windows for advanced users

Windows Vista, Windows Server 2008, and later versions of Windows implement RFC 3484 and use a prefix table to determine which address to use when multiple addresses are available for a Domain Name System (DNS) name.

By default, Windows favors IPv6 global unicast addresses over IPv4 addresses.

_Original KB number:_ &nbsp; 929852

## Summary

It's common for IT administrators to disable IPv6 to troubleshoot networking-related issues such as name resolution issues.

> [!IMPORTANT]
> Internet Protocol version 6 (IPv6) is a mandatory part of Windows Vista and Windows Server 2008 and newer versions.
>
> We don't recommend that you disable IPv6 or IPv6 components or unbind IPv6 from interfaces. If you do, some Windows components might not function.
>
> We recommend using **Prefer IPv4 over IPv6** in prefix policies instead of disabling IPV6.

## Use registry key to configure IPv6

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

> [!NOTE]
>
> - You must restart your computer for these changes to take effect.
> - Values other than 0 or 32 causes the Routing and Remote Access service to fail after this change takes effect.

The IPv6 functionality can be configured by modifying the following registry key:

**Location**: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\`  
**Name**: DisabledComponents  
**Type**: REG_DWORD  
**Min Value**: 0x00 (default value)  
**Max Value**: 0xFF (IPv6 disabled)

|IPv6 Functionality|Registry value and comments|
|---|---|
|Prefer IPv4 over IPv6|Decimal 32<br/>Hexadecimal 0x20<br/>Binary xx1x xxxx<br/><br/>Recommended instead of disabling IPv6.<br/><br/>To confirm preference of IPv4 over IPv6, perform the following commands:<br/><br/>- Open the command prompt or PowerShell.<br/>- Use the 'ping' command to check the preferred IP version. For example, "ping bing.com". <br/>- If IPv4 is preferred, you should see an IPv4 address being returned in the response.<br/><br/>Network Connections:<br/><br/>- Open the command prompt or PowerShell.<br/>- Use 'netsh interface ipv6 show prefixpolicies<br/>- Check if the 'Prefix' policies have been modified to prioritize IPv4.<br/>- The '::ffff:0:0/96' prefix should have a higher precedence than the '::/0' prefix.<br/><br/>For Example, if you have two entries, one with precedence 35 and another with precedence 40, the one with precedence 40 will be preferred.|
|Disable IPv6|Decimal 255<br/>Hexadecimal 0xFF<br/>Binary 1111 1111<br/><br/>See [startup delay occurs after you disable IPv6 in Windows](https://support.microsoft.com/help/3014406) if you encounter startup delay after disabling IPv6 in Windows 7 SP1 or Windows Server 2008 R2 SP1. <br/><br/> Additionally, system startup will be delayed for five seconds if IPv6 is disabled by incorrectly, setting the **DisabledComponents** registry setting to a value of 0xffffffff. The correct value should be 0xff. For more information, see [Internet Protocol Version 6 (IPv6) Overview](/previous-versions/windows/it-pro/windows-8.1-and-8/hh831730(v=ws.11)). <br/><br/>  The **DisabledComponents** registry value doesn't affect the state of the check box. Even if the **DisabledComponents** registry key is set to disable IPv6, the check box in the Networking tab for each interface can be checked. This is an expected behavior.<br/><br/> You cannot completely disable IPv6 as IPv6 is used internally on the system for many TCPIP tasks. For example, you will still be able to run ping `::1` after configuring this setting.|
|Disable IPv6 on all nontunnel interfaces|Decimal 16<br/>Hexadecimal 0x10<br/>Binary xxx1 xxxx|
|Disable IPv6 on all tunnel interfaces|Decimal 1<br/>Hexadecimal 0x01<br/>Binary xxxx xxx1|
|Disable IPv6 on all nontunnel interfaces (except the loopback) and on IPv6 tunnel interface|Decimal 17<br/>Hexadecimal 0x11<br/>Binary xxx1 xxx1|
|Prefer IPv6 over IPv4|Binary xx0x xxxx|
|Re-enable IPv6 on all nontunnel interfaces|Binary xxx0 xxxx|
|Re-enable IPv6 on all tunnel interfaces|Binary xxx xxx0|
|Re-enable IPv6 on nontunnel interfaces and on IPv6 tunnel interfaces|Binary xxx0 xxx0|
  
You can follow these steps to modify the registry key:

1. Open an administrative **Command Prompt** window.
2. Run the following command:

    ```console
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d <value> /f
    ```

    > [!NOTE]
    > Replace the \<value> with the corresponding value.

## How to calculate the registry value

Windows use bitmasks to check the **DisabledComponents** values and determine whether a component should be disabled.

To learn which component each bit (from low to high) controls, refer to the following table.

|Name|Setting|
|---|---|
|Tunnel|Disable tunnel interfaces|
|Tunnel6to4|Disable 6to4 interfaces|
|TunnelIsatap|Disable Isatap interfaces|
|Tunnel Teredo|Disable Teredo interfaces|
|Native|Disable native interfaces (also PPP)|
|PreferIpv4|Prefer IPv4 in default prefix policy|
|TunnelCp|Disable CP interfaces|
|TunnelIpTls|Disable IP-TLS interfaces|
  
For each bit, **0** means false and **1** means true. Refer to the following table for an example.

|Setting|Prefer IPv4 over IPv6 in prefix policies|Disable IPv6 on all nontunnel interfaces|Disable IPv6 on all tunnel interfaces|Disable IPv6 on nontunnel interfaces (except the loopback) and on IPv6 tunnel interface|
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

This registry value doesn't affect the state of the following check box. Even if the registry key is set to disable IPv6, the check box in the **Networking** tab for each interface can be selected. This is an expected behavior.

:::image type="content" source="./media/configure-ipv6-in-windows/network-properties.svg" alt-text="The Internet Protocol Version 6 (TCP/IPv6) option in Network properties." border="false":::

## Unbind IPv6 from an interface

> [!CAUTION]  
> We don't recommend unbinding IPv6 from an Ethernet or WiFi network adapter without a justifiable need. Windows is tested with, and some products and features expect, IPv6 to be bound and functional.
>
> Unbinding IPv6 from a network adapter can result in an unsupported Windows configuration.
>
> When unbinding a protocol from a network adapter, we highly recommend using a WMI-based method, such as, `Disable-NetAdapterBinding`.

You can unbind IPv6 from a network interface by using one of the following methods:

- Unselect **Internet Protocol Version 6 (TCP/IPv6)** in the network properties GUI. See the previous screenshot.
- Run the PowerShell command `Disable-NetAdapterBinding -Name "<MyAdapter>" -ComponentID ms_tcpip[6]`

## IPv6 tunnel interfaces

By default, the 6to4 tunneling protocol is enabled in Windows when an interface is assigned a public IPv4 address (Public IPv4 address means any IPv4 address that isn't in the ranges 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16). 6to4 automatically assigns an IPv6 address to the 6to4 tunneling interface for each address, and 6to4 dynamically registers these IPv6 addresses on the assigned DNS server.

If this behavior isn't desired, we recommend disabling the IPv6 tunnel interfaces on the affected hosts.

You can disable the 6to4 tunneling protocol and other IPv6 transition Technologies by using one of the following methods:

- Set the `DisabledComponents` registry key to 0x01.
- Set the following Group Policy:  
  **Computer Configuration**\\**Administrative Templates**\\**Network**\\**TCPIP Settings**\\**IPv6 Transition Technologies**

  - Set **6to4 State** to **Disabled**  
  - Set **ISATAP Sate** to **Disabled**  
  - Set **Teredo State** to **Disabled**  

> [!NOTE]  
> ISATAP and Teredo are disabled by default in Windows.

## Reference

For more information about RFC 3484, see [Default Address Selection for Internet Protocol version 6 (IPv6)](https://tools.ietf.org/html/rfc3484).

For more information about how to set IPv4 precedence over IPv6, see [Using SIO_ADDRESS_LIST_SORT](/windows/win32/winsock/using-sio-address-list-sort).

For information about RFC 4291, see [IP Version 6 Addressing Architecture](https://tools.ietf.org/html/rfc4291).

For more information about the related issues, see the articles below:

- Example 1: On Domain Controllers, you might run into where LDAP over UDP 389 will stop working.
  See [How to use Portqry to troubleshoot Active Directory connectivity issues](use-portqry-verify-active-directory-tcp-ip-connectivity.md)
- Example 2: Exchange Server 2010, you might run into problems where Exchange stops working.
  See [Arguments against disabling IPv6](/archive/blogs/netro/arguments-against-disabling-ipv6) and [Disabling IPv6 And Exchange – Going All The Way](https://blog.rmilne.ca/2014/10/29/disabling-ipv6-and-exchange-going-all-the-way/).
- Example 3: Failover Clusters
  See [What is a Microsoft Failover Cluster Virtual Adapter anyway?](/archive/blogs/askcore/what-is-a-microsoft-failover-cluster-virtual-adapter-anyway) and [Failover Clustering and IPv6 in Windows Server 2012 R2](https://techcommunity.microsoft.com/t5/failover-clustering/bg-p/FailoverClustering).

Tools to help with network trace: [Microsoft Network Monitor 3.4 (archive)](https://www.microsoft.com/download/details.aspx?id=4865)

> [!WARNING]
> Netmon 3.4 isn't compatible with Windows Server 2012 or newer OS when LBFO NIC teaming is enabled.
