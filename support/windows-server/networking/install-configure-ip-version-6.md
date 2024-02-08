---
title: Install and configure IP version 6
description: Describes how to install and configure IP version 6 (IPv6) in a Windows Server 2003 Enterprise Edition environment.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, JAMIRC
ms.custom: sap:ip-address-management-ipam, csstroubleshoot
ms.subservice: networking
---
# Install and configure IP version 6 in Windows Server 2003 Enterprise Server

This article describes how to install and configure IP version 6 (IPv6) in a Microsoft Windows Server 2003 Enterprise Edition environment.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 325449

## Summary

The current version of IP (which is known as IP version 4 or IPv4) has not been substantially changed since RFC 791 was published in 1981. IPv4 has proven to be robust, easily implemented and interoperable, and has stood the test of scaling an inter-network to a global utility the size of today's Internet. This is a tribute to its initial design.

However, the initial design did not anticipate the following variables:

- The recent exponential growth of the Internet and the lack of IPv4 address spaces.

    IPv4 addresses have become relatively scarce. As a result, some organizations are forced to use a network address translator (NAT) to map multiple private addresses to a single public IP address. While NATs promote reuse of the private address space, they do not support standards-based network layer security or the correct mapping of all higher layer protocols. NATs can also create problems when they connect two organizations that use the private address space.

    Additionally, the increasing prominence of Internet-connected devices and appliances means that the public IPv4 address space will eventually be used up.

- The growth of the Internet and the ability of Internet backbone routers to maintain large routing tables.

    Because of the way in which IPv4 network identifiers (IDs) have been and are currently allocated, there are regularly over 70,000 routes in the routing tables of Internet backbone routers. The current IPv4 Internet routing infrastructure is a combination of both flat and hierarchical routing.

- The need for simpler configuration.

    Most current IPv4 implementations must be configured either manually or through a stateful address configuration protocol such as Dynamic Host Configuration Protocol (DHCP). With more computers and devices using IP, a simpler and more automatic configuration of addresses and other configuration settings that do not rely on the administration of a DHCP infrastructure must be developed.

- The requirement for security at the IP level.

    Private communication over a public medium like the Internet requires encryption services that protect the data that is sent from being viewed or modified in transit. Although a standard now exists for providing security for IPv4 packets (known as Internet Protocol security or IPSec), this standard is optional and proprietary solutions are prevalent.

- The need for better support for real-time delivery of data (also known as quality of service [QoS]).

While standards for QoS exist for IPv4, real-time traffic support relies on the IPv4 Type of Service (TOS) field and the identification of the payload, typically by using a User Datagram Protocol (UDP) or Transmission Control Protocol (TCP) port. Unfortunately, the IPv4 TOS field has limited functionality and has different interpretations. Additionally, payload identification using a TCP and a UDP port is not possible when the IPv4 packet payload is encrypted. To address these concerns, the Internet Engineering Task Force (IETF) has developed a suite of protocols and standards known as IP version 6 (IPv6). This new version, previously named IP-The Next Generation (IPng), incorporates the concepts of many proposed methods for updating the IPv4 protocol. IPv6 is intentionally designed for minimal impact on upper and lower layer protocols by avoiding the arbitrary addition of new features.

## Install IPv6

1. Click **Start**, click **Control Panel**, and then double-click **Network Connections**.
2. Right-click any local area connection, and then click **Properties**.
3. Click **Install**.
4. Click **Protocol**, and then click **Add**.
5. Click **Microsoft TCP/IP version 6**, and then click **OK**.
6. Click **Close** to save changes to your network connection.

## Remove IPv6

1. Click **Start**, click **Control Panel**, and then double-click **Network Connections**.
2. Right-click any local area connection, and then click **Properties**.
3. Click **Microsoft TCP/IP version 6** in the list of installed components, and then click **Uninstall**.
4. Click **Yes**, and then click **Close** to save changes to your network connection.

## Configuring IPv6 with Manual Addresses

1. Click **Start**, point to **Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type `netsh`, and then press ENTER.
3. Type `interface ipv6`, and then press ENTER.
4. Type the following command, and then press ENTER:

    ```console
    add address [interface=] string [address=] ipv6address
    ```

    This command uses the following values

    - [interface =] **string**: Specifies the name for the interface.
    - [address =] **ipv6address**: Specifies the IPv6 address.

    > [!NOTE]
    > Additional parameters are available for this command. Type `add address /?` at the netsh interface ipv6 command prompt to view the additional parameters.

## Configuring Interface Attributes

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type *netsh*, and then press ENTER.
3. Type interface ipv6, and then press ENTER.
4. Type the following command, and then press ENTER:

    ```console
    set interface [interface=] string [[forwarding=]enabled|disabled] [[advertise=]enabled|disabled] [[mtu=] integer] [[siteid=] integer] [[metric=] integer] [[firewall=]{enabled | disabled}] [[siteprefixlength=] integer] [[store=]{active|persistent]}
    ```

This command uses the following values:

- [interface =] **string**: Specifies the interface name.
- [[forwarding =] enabled | disabled]: Specifies whether packets that arrive on this interface can be forwarded to other interfaces. The default setting is disabled.
- [[advertise =]enabled|disabled]: Specifies whether Router Advertisements are sent on this interface. The default setting is disabled.
- [[mtu =] **integer**]: Specifies the maximum transmission unit (MTU) of this interface. If mtu is not specified, the default MTU of the link is used.
- [[siteid =] **integer**]: Specifies the site scope zone identifier. The site identifier is used to distinguish among interfaces that belong to different administrative regions that use site-local addressing.
- [[metric =] **integer**]: Specifies the interface metric that is added to route metrics for all routes over the interface.
- [[firewall =]{ enabled | disabled }]: Specifies whether to operate in firewall mode.
- [[siteprefixlength =] **integer**]: Specifies the default length of the global prefix for the whole site.
- [[store =] active | persistent]: If you specify active, the change only lasts until the computer is restarted. If you specify persistent, the change is permanent. The default setting is persistent.

## View the IPv6 Routing Table

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type `netsh`, and then press ENTER.
3. Type `interface ipv6`, and then press ENTER.
4. Type `show routes`, and then press ENTER.

> [!NOTE]
> To view the additional parameters that are available for this command, type `show routes /?`.

## Add an IPv6 Route

1. Click **Start** , point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type `netsh`, and then press ENTER.
3. Type `interface ipv6`, and then press ENTER.
4. Type the following command, and then press ENTER:

    ```console
    add route [prefix=]ipv6address/integer [[interface=] string] [[nexthop=]ipv6address] [[siteprefixlength=] integer] [[metric=] integer] [[publish=]{no | age | yes}] [[validlifetime=]{integer | infinite}] [[preferredlifetime=]{integer | infinite}] [[store=]{active | persistent}]
    ```

    This command uses the following values:

    - [ prefix =] **ipv6address** / **integer**: This parameter is required. It specifies the prefix for which to add a route.
     **Integer** specifies the prefix length.
    - [[interface =] **string**]: Specifies an interface name or index.
    - [[nexthop =] **ipv6address**]: Specifies the gateway address if the prefix is not on-link.
    - [[siteprefixlength =] **integer**]: Specifies the prefix length for the whole site if the prefix is not on-link.
    - [[metric =] **integer**]: Specifies the route metric.
    - [[publish =]{ no | age | yes }]: Specifies whether routes are advertised in Route Advertisements with unchanging lifetimes (yes), advertised with decreasing lifetimes (age), or not advertised (no) in Route Advertisements. The default setting is no.
    - [[validlifetime =]{ **integer** | infinite }]: Specifies the lifetime over which the route is valid. The default value is infinite.
    - [[preferredlifetime =]{ **integer** | infinite }]: Specifies the lifetime over which the route is preferred. The default value is equal to the valid lifetime.
    - [[store =]{ active | persistent }]: Specifies whether the change lasts only until the next startup (active) or if it is persistent (persistent). The default setting is persistent.

> [!NOTE]
> This parameter adds a route for a specific prefix. The time value can be expressed in days, hours, minutes, and seconds (for example, 1d2h3m4s).

When publish is set to no or age, the route is deleted after the end of the valid lifetime. When publish is set to age, the Route Advertisement contains the valid lifetime remaining until deletion. When publish is set to yes, the route will never be deleted, regardless of the valid lifetime value, and every Route Advertisement contain the "same" specified valid lifetime.

## Remove an IPv6 Route

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type `netsh`, and then press ENTER.
3. Type `interface ipv6`, and then press ENTER.
4. Type show routes to obtain the route prefix and the interface index of the interface over which the addresses for the route prefix are reachable.
5. To delete a route, type the following command, and then press ENTER:

    ```console
    delete route [prefix=] ipv6address / integer [interface=] string
    ```

    This command uses the following values:

    - [prefix =] **ipv6address** / **integer: Specifies the prefix for which to delete a route.

        **Ipv6address** is an IPv6 address and **integer** is the prefix length of the route to delete.

    - [interface =] **string**: Specifies the interface name.

    > [!NOTE]
    > To see the additional parameters that are available for this command, type `delete route /?`.

## Enable IPv6 forwarding

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type `netsh`, and then press ENTER.
3. Type `interface ipv6`, and then press ENTER.
4. Type the following command, and then press ENTER:

    ```console
    set interface [interface=] string [forwarding=]enabled
    ```

    This command uses the following values:

    - [interface =] **string**: Specifies the interface name.
    - [forwarding =] enabled: Specifies whether packets that are arriving on this interface can be forwarded to other interfaces. The default setting is Disabled.

    You can also send Router Advertisement messages by adding the advertise parameter to the command, for example:

    ```console
    set interface [interface=]string [forwarding=]enabled [advertise=]enabled
    ```

    To see the additional parameters for this command, type `set interface /?`.

## Test an IPv6 configuration by using the PING command

To obtain the IPv6 configuration for a computer:

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt type, the following command, and then press ENTER:

    ```console
    netsh interface ipv6 show interface
    ```

3. At the command prompt, type `ping ::1` to locate the loopback address.

    If the ping command is not successful, verify that the ::1 address is assigned to the interface named *Loopback Pseudo-Interface*.

4. Use the following command to locate a link-local IPv6 address of the computer:

    ```console
    ping address % zone_id
    ```

    In this command, **address** is the link-local address and **zone_id** is the interface index for the interface to which the link-local address is assigned. A link-local address begins with FE80.

    If the ping command is not successful, verify the address and interface index.

5. Use the following command to locate the link-local address of another host on your link (also known as a subnet):

    ```console
    ping address % zone_id
    ```

    In this command, **address** is the link-local address of the other host and **zone_id** is the interface index for the interface from which you want to send the ping packets.

    If the ping command is not successful, verify the link-local address of the other host and the zone ID.

## Test IPv6 connectivity by using the PING command

1. Click **Start**, point to **All Programs**, **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type the following command, and then press ENTER:

    ```console
    netsh interface ipv6 show interface interface_name
    ```

    In this command, **interface_name** is the name of an interface on your computer. For example, if you have an interface named *Local Area Connection*, type the following command:

    ```console
    netsh interface ipv6 show interface "Local Area Connection"
    ```

3. Use one of the following commands to search for another IPv6 node:

    - To ping the link-local address of another node on your link (also known as a subnet), type `ping address % zone_id`, where **address** is the link-local address of the other node and **zone_id** is the interface index for the interface from which you want to send ping packets. To obtain the interface index, view the output of the `netsh interface ipv6 show interface` command.

    If the ping command is not successful, verify the link-local address of the other node and the zone ID.

   - To ping the site-local address of another node, type `ping address % zone_id`, where **address** is the site-local address of the other node and **zone_id** is the site identifier that was in the output of the `netsh interface ipv6 show interface` command. If you are not using site identifiers, you do not have to use the % **zone_id** portion of the command.

        If the ping command not successful, verify the site-local address of the other node and the zone ID.

   - To ping the global address of another node, type `ping address`, where **address** is the global address of the other node.

        If the ping command is not successful, verify the global address of the other node.

   - To ping another node by name, type `ping -6 name`, where **name** is a name that can be resolved to an IPv6 address through entries in the local hosts file or through AAAA resource records that are present in your DNS infrastructure. When you identify the target host by name instead of by IPv6 address, you must include the `-6` parameter.

        If the ping command is not successful, verify that the name can be resolved to an IPv6 address.

   - To ping the IPv4-compatible address of another node, type `ping ipv4address`, where **ipv4address** is the public IPv4 address of the other node.

        If the ping command is not successful, verify the IPv4 address of the other node.

## Trace a path by using the TRACERT command

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type either of the following commands:

    - tracert -6  
        **host_name**
    - tracert  
         **ipv6address** % **zone_id**

    These commands use the following values:

    - **Host_name** is the host name of the remote computer.
    - **Ipv6address** is the IPv6 address of the remote computer.
    - **zone_id** is the zone ID for the destination address. The zone ID for link-local destination addresses is the interface index of the interface from which you want to send tracert -6 packets. The zone ID for site-local destination addresses is the site ID that is listed in the output of the `netsh interface ipv6 show interface` command. You do not have to use the % **zone_id** portion of the command for global destination addresses.

    > [!NOTE]
    > The tracert command with the -6 parameter traces the path that is taken by IPv6 packets from this computer to another remote computer. The tracert -6 command uses ICMPv6 Echo Request messages (similar to the ping command) to produce command-line report information about each router that is crossed and the roundtrip time (RTT) for each hop.

    If tracert is not successful, you can use the command-line report information to determine which intermediate router forwarding either failed or was slowed.

## View the interface configuration

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type `netsh -c "interface ipv6"` , and then press ENTER.
3. Type `show interface [interface=] string`, and then press ENTER.

    This command uses the following value:

    [interface =] **string**: Specifies the interface name.

    > [!NOTE]
    > Additional parameters are available for this command.

## View the neighbor cache

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type `netsh`, and then press ENTER.
3. Type `interface ipv6`, and then press ENTER.
4. Type `show neighbors`, and then press ENTER.

> [!NOTE]
> To view the additional parameters that are available for this command, type `show neighbors /?`.

## View the destination cache

1. Click **Start**, point to **All Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type `netsh`, and then press ENTER.
3. Type `interface ipv6`, and then press ENTER.
4. Type `show destinationcache`, and then press ENTER.

> [!NOTE]
> To view the additional parameters that are available for this command, type `show destinationcache /?`.
