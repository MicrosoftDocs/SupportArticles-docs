---
title: Remote Procedure Call (RPC) dynamic port work with firewalls
description: This article describes how to use the solution together with a firewall when configuring RPC dynamic port allocation.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, timball
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# How to configure RPC dynamic port allocation to work with firewalls

This article helps you modify the Remote Procedure Call (RPC) parameters in the registry to make sure RPC dynamic port allocation can work with firewalls.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 154596

## Summary

 RPC dynamic port allocation is used by server applications and remote administration applications, such as Dynamic Host Configuration Protocol (DHCP) Manager, Windows Internet Name Service (WINS) Manager, and so on. RPC dynamic port allocation instructs the RPC program to use a particular random port in the range configured for TCP and UDP, based on the implementation of the operating system used. For more information, see references below.

Customers using firewalls may want to control which ports RPC is using so that their firewall router can be configured to forward only these Transmission Control Protocol (UDP and TCP) ports.

Many RPC servers in Windows let you specify the server port in custom configuration items such as registry entries. When you can specify a dedicated server port, you know what traffic flows between the hosts across the firewall. And you can define what traffic is allowed in a more directed manner.

As a server port, choose a port outside of the range you may want to specify below. You can find a comprehensive list of Server ports that are used in Windows and major Microsoft products in [Service overview and network port requirements for Windows](service-overview-and-network-port-requirements.md).

The article also lists the RPC servers and which RPC servers can be configured to use custom server ports beyond the facilities the RPC runtime offers.

Some firewalls also allow for UUID filtering where it learns from an RPC Endpoint Mapper request for an RPC interface UUID. The response has the server port number, and a subsequent RPC Bind on this port is then allowed to pass.

> [!IMPORTANT]
> Use the method that is described in this article only if the RPC server does not offer a way to define the server port.

The following registry entries apply to Windows NT 4.0 and above. They don't apply to previous versions of Windows NT. Even though you can configure the port used by the client to communicate with the server, the client must be able to reach the server by its actual IP address. You can't use DCOM through firewalls that do address translation. For example, a client connects to virtual address 198.252.145.1, which the firewall maps transparently to the server's actual address of, say, 192.100.81.101. DCOM stores raw IP addresses in the interface marshaling packets. If the client can't connect to the address specified in the packet, it won't work.

For more information, see [Using DCOM/COM+ with Firewall](https://social.msdn.microsoft.com/forums/en-US/6809c825-b4f9-4176-a172-c028ff1eafab/using-dcomcom-with-firewall).

## More information

The values (and Internet key) discussed below don't appear in the registry. They must be added manually using the Registry Editor.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

With Registry Editor, you can modify the following parameters for RPC. The RPC Port key values discussed below are all located in the following key in the registry:

`HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\Internet\Entry name Data Type`

- Ports REG_MULTI_SZ

  Specifies a set of IP port ranges consisting of either all the ports available from the Internet or all the ports not available from the Internet. Each string represents a single port or an inclusive set of ports.

  For example, a single port may be represented by 5984, and a set of ports may be represented by 5000-5100. If any entries are outside the range of 0 to 65535, or if any string can't be interpreted, the RPC runtime treats the entire configuration as invalid.

- PortsInternetAvailable REG_SZ Y or N (not case-sensitive)

  If Y, the ports listed in the Ports key are all the Internet-available ports on that computer. If N, the ports listed in the Ports key are all those ports that aren't Internet-available.

- UseInternetPorts REG_SZ Y or N (not case-sensitive

  Specifies the system default policy.

  If Y, the processes using the default will be assigned ports from the set of Internet-available ports, as defined previously.
  If N, the processes using the default will be assigned ports from the set of intranet-only ports.

### Example

In this example, ports 5000 through 6000 inclusive have been arbitrarily selected to help illustrate how the new registry key can be configured. It isn't a recommendation of a minimum number of ports needed for any particular system.

1. Add the Internet key under `HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc`
2. Under the Internet key, add the values **Ports** (MULTI_SZ), **PortsInternetAvailable** (REG_SZ), and **UseInternetPorts** (REG_SZ).

    For example, the new registry key appears as follows:

    > Ports: REG_MULTI_SZ: 5000-6000  
    PortsInternetAvailable: REG_SZ: Y  
    UseInternetPorts: REG_SZ: Y

3. Restart the server. All applications that use RPC dynamic port allocation use ports 5000 through 6000, inclusive.

You should open up a range of ports above port 5000. Port numbers below 5000 may already be in use by other applications and could cause conflicts with your DCOM application(s). Furthermore, previous experience shows that a minimum of 100 ports should be opened, because several system services rely on these RPC ports to communicate with each other.

> [!NOTE]
> The minimum number of ports required may differ from computer to computer. Computers with higher traffic may run into a port exhaustion situation if the RPC dynamic ports are restricted. Take this into consideration when restricting the port range.

> [!WARNING]
> If there is an error in the port configuration or there are insufficient ports in the pool, the Endpoint Mapper Service will not be able to register RPC servers with dynamic endpoints. When there is a configuration error, the error code will be 87 (0x57) ERROR_INVALID_PARAMETER. This can affect Windows RPC servers as well, such as Netlogon. It will log event 5820 in this case:

```output
Log Name: System  
Source: NETLOGON  
Event ID: 5820  
Level: Error  
Keywords: Classic  
Description:  
The Netlogon service could not add the AuthZ RPC interface. The service was terminated. The following error occurred: The parameter is incorrect.
```

For more information, see:

- [Service overview and network port requirements for Windows](https://support.microsoft.com/help/832017)
- [How to configure a firewall for Active Directory domains and trusts](https://support.microsoft.com/help/179442)
- [Restricting Active Directory RPC traffic to a specific port](https://support.microsoft.com/help/224196)
- [The default dynamic port range for TCP/IP has changed since Windows Vista and in Windows Server 2008](https://support.microsoft.com/help/929851)
