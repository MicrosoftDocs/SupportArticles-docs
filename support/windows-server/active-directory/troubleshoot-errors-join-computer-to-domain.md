---
title: Troubleshoot errors that occur when you join Windows-based computers to a domain
description: Troubleshooting guide for error messages that occurs when you join Windows-based computers to a domain.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\On-premises Active Directory domain join, csstroubleshoot
---
# How to troubleshoot errors that occur when you join Windows-based computers to a domain

This article describes several common error messages that can occur when you join client computers that are running Windows to a domain. This article also provides troubleshooting suggestions for these errors.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4341920

## Where to find the Netsetup.log file

Windows clients log the details of domain join operations in the %windir%\\debug\\Netsetup.log file.

## Networking error messages and resolutions

### Error 1

> An attempt to resolve the DNS name of a DC in the domain being joined has failed. Please verify this client is configured to reach a DNS server that can resolve DNS names in the target domain.

#### Resolution

When you type the domain name, make sure that you type the Domain Name System (DNS) name and not the Network Basic Input/Output System (NetBIOS) name. For example, if the DNS name of the target domain is `contoso.com`, make sure that you enter `contoso.com` instead of the NetBIOS domain name of "contoso."

Additionally, verify that the computer can reach a DNS server that hosts the DNS zone of the target domain or can resolve DNS names in that domain. Make sure that the correct DNS server is configured on this client as the preferred DNS, and that the client has connectivity to that server. To verify this, you can run one of the following commands:

```console
nltest /dsgetdc:<netbios domain name> /force
```

```console
nltest /dsgetdc:<DNS domain name> /force
```

### Error 2

> An attempt to resolve the DNS name of a domain controller in the domain being joined has failed. Please verify this client is configured to reach a DNS server that can resolve DNS names in the target Domain.

#### Resolution

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

Additionally, verify that the computer can reach a DNS server that hosts the DNS zone of the target domain or can resolve DNS names in that domain. Make sure that the correct DNS server is configured on this client as the preferred DNS, and that the client has connectivity to that server. To verify this, you can run one of the following commands:

```console
nltest /dsgetdc:<netbios domain name> /force
```

```console
nltest /dsgetdc:<DNS domain name> /force
```

### Error 3

> An operation was attempted on a nonexistent network connection.

#### Resolution

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.
Additionally, restart the computer before you try to join the computer to the domain.

### Error 4

> Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed. Disconnect all previous connections to the server or shared resource and try again.

#### Resolution

Restart the computer that you are trying to join to the domain to make sure that there are no latent connections to any of the domain servers.

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

### Error 5

> Network name cannot be found.

#### Resolution

Verify that the computer can reach a DNS server that hosts the DNS zone of the target domain or can resolve DNS names in that domain. Make sure that the correct DNS server has been configured on this client as the preferred DNS, and that the client has connectivity to that server. To verify this, you can run one of the following commands:

```console
nltest /dsgetdc:<netbios domain name> /force
```

```console
nltest /dsgetdc:<DNS domain name> /force
```

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

Additionally, you can update the network adapter driver.

### Error 6

> No more connections can be made to this remote computer at this time because there are already as many connections as the computer can accept.

#### Resolution

Before joining the computer to the domain, make sure that you have cleared all mapped connections to any drives.

Restart the computer that you are trying to join to the domain to make sure that there are no latent connections to any of the domain servers.

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name.

The error may be transient. Try again later. If the issue persists, verify the status of the DC that the client is connecting to (active connections, network connectivity, and so on). You may want to restart the DC if the issue persists.

### Error 7

> The format of the specified network name is invalid.

#### Resolution

Verify that the computer can reach a DNS server that hosts the DNS zone of the target domain or can resolve DNS names in that domain. Make sure that the correct DNS server has been configured on this client as the preferred DNS, and that the client has connectivity to that server. To verify this, you can run one of the following commands:

```console
nltest /dsgetdc:<netbios domain name> /force
```

```console
nltest /dsgetdc:<DNS domain name> /force
```

When you type the domain name, make sure that you type the DNS name and not the NetBIOS name. Make sure that you have the most up-to-date drivers installed for the client computer's network adapter. Verify connectivity between the client that is being joined and the target DC over the required ports and protocols. Disable the **TCP** **Chimney**  offload feature and IP offloading.

### Error 8

> The directory service has exhausted the pool of relative identifiers.

#### Resolution

Make sure that the DC that hosts the relative ID (RID) operations master is online and functional. For more information, see [Event ID 16650: The account-identifier allocator failed to initialize in Windows Server](event-16650-account-identifier-allocator-not-initialize.md).

> [!Note]
> You can use the `netdom query fsmo` command to determine which DC has the RID Master role.

Verify that Active Directory is replicating between all DCs. You can use the following command to detect any errors:

```console
repadmin /replsummary /bysrc /bydest /sort:delta
```

### Error 9

> The remote procedure call failed and did not execute.

#### Resolution

Make sure that you have the most up-to-date drivers installed for the client computer's network adapter. Verify connectivity between the client that is being joined and the target DC over the required ports and protocols. Disable the **TCP Chimney**  offload feature and IP offloading.

This problem can also be caused by one of the following conditions:

- A network device (router, firewall, or VPN device) is blocking connectivity over the ports and protocols that are used by the MSRPC protocol.
- A network device (router, firewall, or VPN device) is rejecting network packets between the client that is being joined and the DC.

> [!NOTE]
> The following articles contain port requirement information:  
[832017 Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md)  
[179442 How to configure a firewall for domains and trusts](config-firewall-for-ad-domains-and-trusts.md)  

### Error 10

> Changing the Primary Domain DNS name of this computer to "" failed. The name will remain ".".The specified server cannot perform the operation.

#### Resolution

This error occurs when you use the domain join UI to join a Windows 7 or Windows Server 2008 R2 workgroup computer to an Active Directory domain by specifying the target DNS domain. To fix this error, see [2018583 Windows 7 or Windows Server 2008 R2 domain join displays error "Changing the Primary Domain DNS name of this computer to "" failed...."](https://support.microsoft.com/help/2018583/windows-7-or-windows-server-2008-r2-domain-join-displays-error-changin).

## Authentication error messages and resolutions

### Error 1

> You have exceeded the maximum number of computer accounts you are allowed to create in this domain.

#### Resolution

Make sure that you have permissions to add computers to the domain, and that you have not exceeded the quota that is defined by your Domain Administrator.

To join a computer to the domain, the user account must be granted **Create computer object** permissions in Active Directory.

> [!Note]
> By default, a non-administrator user can join a maximum of 10 computers to an Active Directory domain.

### Error 2

> Logon failure: The target account name is incorrect.

#### Resolution

Check that the domain controllers (DCs) are registered by using correct IP addresses on the DNS server, and that their Service Principal Names (SPNs) are registered correctly in their Active Directory accounts.

### Error 3

> Logon failure: the user has not been granted the requested logon type at this computer.

#### Resolution

Make sure that you have permissions to add computers to the domain. To join a computer to the domain, the user account must be granted the **Create computer object**  permission in Active Directory.

Additionally, make sure that the specified user account is allowed to log on locally to the client computer. To do this, configure the **Allow log on locally** setting in Group Policy under **Computer Configuration > Windows Settings > Security Settings > Local Policies > User Rights Assignment**.

### Error 4

> Logon failure: unknown user name or bad password.

#### Resolution

Make sure that you use the correct user name and password combination of an existing Active Directory user account when you are prompted for credentials to add the computer to the domain.

### Error 5

> No mapping between account names and security IDs was done.

#### Resolution

This error is likely a transient error that is logged when a domain join searches the target domain to determine whether a matching computer account was already created or whether the join operation has to dynamically create a computer account on the target domain.

### Error 6

> Not enough storage is available to complete this operation.

#### Resolution

This error can occur when the Kerberos token size is larger than the maximum default size. If this situation, you have to increase the Kerberos token size of the computer that you try to join to the domain. For more information, see the following Knowledge Base articles:  
[935744 "Not enough storage is available to complete this operation" error message when you use a domain controller to join a computer to a domain](../../windows-client/windows-security/not-enough-storage-available-complete-operation-error.md)  
[327825 Problems with Kerberos authentication when a user belongs to many groups](../windows-security/kerberos-authentication-problems-if-user-belongs-to-groups.md)

### Error 7

> The account is not authorized to login from this station.

#### Resolution

This problem is related to mismatched SMB Signing settings between the client computer and the DC that is being contacted for the domain join operation. Review the following documentation to further investigate the current and recommended values in your environment:  
[281648 Error message: The account is not authorized to login from this station](account-not-authorized-login-from-this-station.md)
[823659 Client, service, and program issues can occur if you change security settings and user rights assignments](https://support.microsoft.com/help/823659/client-service-and-program-issues-can-occur-if-you-change-security-set)

### Error 8

> The account specified for this service is different from the account specified for other services running in the same process.

#### Resolution

Make sure that the DC through which you are trying to join the domain has the Windows Time service started.
