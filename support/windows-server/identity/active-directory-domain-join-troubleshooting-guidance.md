---
title: Active Directory domain join troubleshooting guidance
description: Provides guidance to troubleshoot domain join issues.
ms.date: 11/15/2022
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-join-issues, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Active Directory domain join troubleshooting guidance

This guide provides you with the fundamental concepts used when troubleshooting Active Directory domain join issues.

## Troubleshooting checklist

- Domain Name System (DNS): Anytime you have an issue joining a domain, one of the first things to check is DNS. DNS is the heart of Active Directory and makes things work correctly, including domain join. Make sure of the following items:

  - DNS server addresses are correct.
  - DNS suffix search order is correct if multiple DNS domains are in play.
  - There are no stale or duplicate DNS records referencing the same computer account.
  - Reverse DNS doesn't point to a different name as the A record.
  - The domain name, domain controllers (DCs), and DNS servers can be pinged.
  - Check for DNS record conflicts for the specific server.

- *Netsetup.log*: The *Netsetup.log* file is a valuable resource when you troubleshoot a domain join issue. The *netsetup.log* file is located at *C:\\WindowsDebugnetsetup.log*.
- Network trace: During an AD domain join, multiple types of traffic occur between the client and some DNS servers and then between the client and some DCs. If you see an error in any of the above traffic, follow the corresponding troubleshooting steps of that protocol or component to narrow it down.
- Domain join hardening changes: Windows updates released on and after October 11, 2022, contain additional protections introduced by [CVE-2022-38042](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-38042). These protections intentionally prevent domain join operations from reusing an existing computer account in the target domain unless one of the following conditions:

  - The user attempting the operation is the creator of the existing account.
  - The computer was created by a member of domain administrators.

For more information, see [KB5020276—Netjoin: Domain join hardening changes](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8).

## Common issues and solutions

### Error Code 0x569

> The user has not been granted the requested logon type at this computer.
  
Error 0x569 is logged when the domain join user lacks the **Access this computer from the network** user right. Make sure of the following items:

- Verify that the user account performing the domain join operation (or the security group that owns the member of the domain join user) has been granted the **Access this computer from the network** right in the default domain controllers policy.
- The default domain controllers policy is linked to the OU that hosts the DC computer account that's servicing the domain join operation.
- The DC servicing the domain join operation successfully applies the policy, specifically the user rights settings defined in the default domain controllers policy.

### Error Code 0x534

> No mapping between account names and security IDs was done.
  
The domain join graphical user interface (GUI) can call the `NetJoinDomain` API twice to join a computer to a domain. The first call is made without the "create" flag being specified to locate a pre-created computer account in the target domain. If no account is found, a second `NetJoinDomain` API call may be made with the "create" flag specified.
  
In another scenario, the 0x534 error code is logged when you attempt to change the password for a machine account. However, the account can't be found on the targeted DC, likely because the account was not created or due to replication latency or a replication failure.

The 0x534 error code is commonly logged as a transient error when domain join searches the target domain. The searching determines whether a matching computer account was pre-created or whether the join operation needs to dynamically create a computer account on the target domain. Check the bit flags in the join options and whether the type of join being performed is relying on a pre-created or newly created computer account.

### Error Code 0x6BF or 0xC002001C

> The remote procedure call failed and did not execute.

This error occurs when a network device (router, firewall, or VPN device) rejects network packets between the client being joined and the DC.

Make sure of the following items:

- Verify the connectivity between the client being joined and the target DC over the required ports and protocols.
- Disable bind time feature negotiation.
- Disable TCP Chimney Offload and IP offload.

### Error Code 0x6D9

> There are no more endpoints available from the endpoint mapper.
  
Error 0x6D9 is logged when network connectivity is blocked between the joining client and the helper DC. The network connectivity services the domain join operation over port 135 or a port in the ephemeral range between 1025 to 5000 or 49152 to 65535. For more information, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).  

To resolve this error, follow these steps:

1. On the joining client, open the *%systemroot%\\debug\\NETSETUP.LOG* file and determine the name of the helper DC selected by the joining client to perform the join operation.
2. Verify that the joining client has network connectivity to the DC over the required ports and protocols used by the applicable operating system (OS) versions. Domain join clients connect a helper DC over TCP port 135 by the dynamically assigned port in the range between 49152 and 65535.
3. Ensure that the OS, software and hardware routers, firewalls, and switches allow connectivity over the required ports and protocols.

### Error Code 0xA8B

> An attempt to resolve the DNS name of a DC in the domain being joined has failed. Please verify this client is configured to reach a DNS server that can resolve DNS names in the target domain.
  
Error 0xA8B occurs if:

- The workgroup computer being joined points to an invalid DNS server.
- The DNS server(s) used by the joining computer is invalid, is missing the required zones, or is missing the required records for the target domain.
- The target Active Directory domain contains a problematic DNS name.
- Network problems exist on the workgroup computer, the target DC, or the network used to connect the client and target DC.

To resolve this error, follow these steps:

1. Verify that the computer being joined points to valid DNS server IP addresses. Invalid examples include:

   - A stale or non-existent ISP DNS server on the corporate intranet.  
   - A DNS server in an error state that prevents it from loading the *_msdcs.\<Forest Root Domain>* or target AD domain zones or resolving queries for those zones. Event ID 4521 may be logged.

2. Verify that all DNS servers configured on the client host the required zones and valid records for a DC in the target domain. Check for the following misconfigurations:
   - Forward lookup zone for the target AD domain is missing.
   - The *_msdcs* forward lookup zone is missing.
   - The *_msdcs.\<Forest Root Domain>* zone doesn't contain a Lightweight Directory Access Protocol (LDAP) SRV record for a DC in the target domain.
   - Host A record is missing from the target AD domain zone.
   - Host A record is present but contains the wrong IP address for the target DC.
   - The host A record is present but was registered by a network interface that isn't accessible to the client computer.

3. Check for special names in the target Active Directory domain that require additional configuration:

   - Single-label DNS name
   - Disjoint Namespace
   - All numeric top-level domains (TLDs) or TLDs containing numeric characters

4. Check for network problems on the workgroup computer, target DC, or the network connecting the computer and the target DC:
   - A broken Network Interface Card (NIC) on the client computer or the target DC
   - A broken network switch that drops network packets between the client and target DC

### Error Code 0x40

> Cannot join a host into domain.

The issue is related to Server Message Block (SMB). A firewall device between the client and the DC intercepted the Key Distribution Center (KDC) request packet and altered some data in it. As a result, the DC cannot process the request properly.

### Other errors that occur when you join Windows-based computers to a domain

For more information, see:

- Troubleshoot [Networking error messages and resolutions](troubleshoot-errors-join-computer-to-domain.md#networking-error-messages-and-resolutions)
- Troubleshoot [Authentication error messages and resolutions](troubleshoot-errors-join-computer-to-domain.md#authentication-error-messages-and-resolutions)
