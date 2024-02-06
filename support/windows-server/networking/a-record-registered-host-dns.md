---
title: Host's A record is registered in DNS
description: The IP address registers an A record for the host name in its primary DNS suffix zone. It occurs after you clear the "Register this connection's address in DNS" check box.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# The host's A record is registered in DNS after you choose not to register the connection's address

This article provides methods to fix an issue where the IP address registers an A record for the host name in its primary DNS suffix zone. This issue occurs after you clear the **Register this connection's address in DNS** check box.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 275554

> [!NOTE]
> This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see [Microsoft Support Lifecycle Policy](/lifecycle/).

## Symptoms

In Windows 2000, you clear the **Register this connection's address in DNS** check box under Advanced TCP/IP Settings for a network interface. In this scenario, the IP address may register an A record for the host name in its primary DNS suffix zone.

For example, this behavior may occur if you have the following configuration:

- The DNS service is installed on the server.
- The DNS server zone is contoso.com, where the **contoso**.com zone can be updated dynamically.
- The server host name is Server1.contoso.com, where Server1 has two network adapters that have IP addresses of 10.1.1.1 and 10.2.2.2.
- You clear the **Register this connection's address in DNS** check box on the network adaptor that has the IP address of 10.2.2.2. Then you delete the host record for Server1.contoso.com 10.2.2.2.

The host record for Server1.contoso.com 10.2.2.2 is dynamically added back to the zone late. The unwanted registration of this record can be reproduced if you restart the DNS service on the server.

## Cause

By default, when the DNS service is installed on a Windows 2000 computer, it listens to all network interfaces that are configured by using TCP/IP. When DNS causes an interface to listen for DNS queries, the interface tries to register the host's A record in the zone that matches its primary DNS suffix. The interface tries to register the host's A record regardless of the settings that have been configured in the TCP/IP properties. This behavior is by design and can take place under the following circumstances:

- The DNS service is installed on the server whose configuration you're trying to change.
- The DNS zone that matches the primary DNS suffix of the server is enabled to update dynamically.

## Resolution

> [!NOTE]
> The resolution that is described in this article only works on member servers that run DNS in a domain. It does not resolve this issue on domain controller computers. For more information about how to resolve this issue on a domain controller, see [Name resolution and connectivity issues on a Routing and Remote Access Server that also runs DNS or WINS](name-resolution-connectivity-issues.md).

To prevent a DNS server from registering an A record for a specific interface in its primary DNS suffix zone, use one of the following methods.

### Method 1

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Configure the DNS service to publish specific IP addresses to the DNS zone. To do so, make the following registry modification:

- PublishAddresses: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters`
- Data type: REG_SZ
- Range: IP address [IP address]
- Default value: blank

This modification specifies the IP addresses that you want to publish for the computer. The DNS server creates A records only for the addresses in this list. If this entry doesn't appear in the registry, or if its value is blank, the DNS server creates an A record for each of the computer's IP addresses.

This entry is for computers that have multiple IP addresses, only a subset of which you want to publish. Typically, it prevents the DNS server from returning a private network address in response to a query when the computer has a corporate network address.

DNS reads its registry entries only when it starts. You can change entries while the DNS server is running by using the DNS console. If you change entries by editing the registry, the changes aren't effective until you restart the DNS server.

The DNS server doesn't add this entry to the registry. You can add it by editing the registry or by using a program that edits the registry.

### Method 2

Remove the interface from the list of interfaces that the DNS server listens on. To do so, follow these steps:

1. Start the DNS Management Microsoft Management Console (MMC).
2. Right-click the DNS server, and then select **Properties**.
3. Select the **Interfaces** tab.
4. Under **Listen on**, select the **Only the following IP addresses** check box.
5. Type the IP addresses that you want the server to listen on. Include only the IP addresses of the interfaces for which you want a host's A record registered in DNS.
6. Select **OK**, and then quit the DNS Management MMC.

## Status

Microsoft has confirmed that it's a problem in the products that are listed at the beginning of this article.

## More information

For more information about how to disable dynamic registrations, see [How to enable or disable DNS updates in Windows 2000 and in Windows Server 2003](enable-disable-dns-dynamic-registration.md).

The registry key to disable dynamic update of the DHCP client service is:

- Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DisableDynamicUpdate`
- Data type: REG_DWORD
- Range: 0 - 1
- Default value: 0

> [!NOTE]
> This registry key doesn't resolve the issue that's outlined in this article. If the DNS server listens on a specific interface, the host's A record for that interface is registered.

If you remove an IP address from the list of the DNS server's listening interfaces, the server no longer accepts DNS requests that are sent to that IP address. This option is sometimes used in situations where the DNS server is also a domain controller and has an interface that's connected to a disjointed network. For such configuration, make sure that Active Directory client computers don't direct any queries to an interface that they can't reach.
