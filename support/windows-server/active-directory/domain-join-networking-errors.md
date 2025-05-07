---
title: Troubleshoot Networking Errors When Joining Windows-based Computers to a Domain
description: Troubleshooting guide for networking related error messages that occur when you join Windows-based computers to a domain.
ms.date: 05/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Troubleshoot networking errors that occur when you join Windows-based computers to a domain

This article describes several networking related error messages that occur when you join client computers that are running Windows to a domain. This article also provides troubleshooting suggestions for these errors.

## Where to find the NetSetup.log file

The **NetSetup.log** file contains most information about domain join activities. The file is located on the client machine at **%windir%\\debug\\NetSetup.log**. This log file is enabled by default. No need to explicitly enable it.

## An attempt to resolve the DNS name of a DC in the domain being joined has failed. Please verify this client is configured to reach a DNS server that can resolve DNS names in the target domain

### Resolution

When you type the domain name, make sure that you type the Domain Name System (DNS) name and not the network basic input/output System (NetBIOS) name. For example, if the DNS name of the target domain is `contoso.com`, make sure that you enter `contoso.com` instead of the NetBIOS domain name of "contoso."

Additionally, verify that the computer can reach a DNS server that hosts the DNS zone of the target domain or can resolve DNS names in that domain. Make sure that the correct DNS server is configured on this client as the preferred DNS, and that the client has connectivity to that server. To verify this, you can run one of the following commands:

```console
nltest /dsgetdc:<netbios domain name> /force
```

```console
nltest /dsgetdc:<DNS domain name> /force
```

## An attempt to resolve the DNS name of a domain controller in the domain being joined has failed. Please verify this client is configured to reach a DNS server that can resolve DNS names in the target Domain

### Resolution

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

Additionally, verify that the computer can reach a DNS server that hosts the DNS zone of the target domain or can resolve DNS names in that domain. Make sure that the correct DNS server is configured on this client as the preferred DNS, and that the client has connectivity to that server. To verify this, you can run one of the following commands:

```console
nltest /dsgetdc:<netbios domain name> /force
```

```console
nltest /dsgetdc:<DNS domain name> /force
```

## An operation was attempted on a nonexistent network connection

### Resolution

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

Additionally, restart the computer before you try to join the computer to the domain.

## Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed. Disconnect all previous connections to the server or shared resource and try again

### Resolution

Restart the computer that you're trying to join to the domain to make sure that there are no latent connections to any of the domain servers.

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

## Network name cannot be found

### Resolution

Verify that the computer can reach a DNS server that hosts the DNS zone of the target domain or can resolve DNS names in that domain. Make sure that the correct DNS server has been configured on this client as the preferred DNS, and that the client has connectivity to that server. To verify this, you can run one of the following commands:

```console
nltest /dsgetdc:<netbios domain name> /force
```

```console
nltest /dsgetdc:<DNS domain name> /force
```

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

Additionally, you can update the network adapter driver.

## No more connections can be made to this remote computer at this time because there are already as many connections as the computer can accept

### Resolution

Before joining the computer to the domain, make sure that you have cleared all mapped connections to any drives.

Restart the computer that you're trying to join to the domain to make sure that there are no latent connections to any of the domain servers.

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

The error might be transient. Try again later. If the issue persists, verify the status of the domain controller (DC) that the client is connecting to (active connections, network connectivity, and so on). You might want to restart the DC if the issue persists.

## The format of the specified network name is invalid

### Resolution

Verify that the computer can reach a DNS server that hosts the DNS zone of the target domain or can resolve DNS names in that domain. Make sure that the correct DNS server has been configured on this client as the preferred DNS, and that the client has connectivity to that server. To verify this, you can run one of the following commands:

```console
nltest /dsgetdc:<netbios domain name> /force
```

```console
nltest /dsgetdc:<DNS domain name> /force
```

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name. Make sure that you have the most up-to-date drivers installed for the client computer's network adapter. Verify connectivity between the client that is being joined and the target DC over the required ports and protocols. Disable the TCP Chimney Offload feature and IP offloading.

## The directory service has exhausted the pool of relative identifiers

### Resolution

Make sure that the DC that hosts the relative ID (RID) operations master is online and functional. For more information, see [Event ID 16650: The account-identifier allocator failed to initialize in Windows Server](event-16650-account-identifier-allocator-not-initialize.md).

> [!Note]
> You can use the `netdom query fsmo` command to determine which DC has the RID Master role.

Verify that Active Directory is replicating between all DCs. You can use the following command to detect any errors:

```console
repadmin /replsummary /bysrc /bydest /sort:delta
```

## The remote procedure call failed and did not execute

### Resolution

Make sure that you have the most up-to-date drivers installed for the client computer's network adapter. Verify connectivity between the client that is being joined and the target DC over the required ports and protocols. Disable the TCP Chimney Offload feature and IP offloading.

This problem can also be caused by one of the following conditions:

- A network device (router, firewall, or VPN device) is blocking connectivity over the ports and protocols that are used by the MSRPC protocol.
- A network device (router, firewall, or VPN device) is rejecting network packets between the client that is being joined and the DC.

> [!NOTE]
> The following articles contain port requirement information:  
>
> - [832017 Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md)  
> - [179442 How to configure a firewall for domains and trusts](config-firewall-for-ad-domains-and-trusts.md)  

## Changing the Primary Domain DNS name of this computer to "" failed. The name will remain ".".The specified server cannot perform the operation

### Resolution

This error occurs when you use the domain join UI to join a Windows 7 or Windows Server 2008 R2 workgroup computer to an Active Directory domain by specifying the target DNS domain. To fix this error, see [2018583 Windows 7 or Windows Server 2008 R2 domain join displays error "Changing the Primary Domain DNS name of this computer to "" failed...."](https://support.microsoft.com/help/2018583/windows-7-or-windows-server-2008-r2-domain-join-displays-error-changin).
