---
title: Active Directory domain join troubleshooting guidance
description: Provides guidance to troubleshoot domain join issues.
ms.date: 11/15/2022
author: v-lianna
ms.author: v-lianna
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

- *Netsetup.log*: The *Netsetup.log* file is a valuable resource when you troubleshoot a domain join issue. The *netsetup.log* file is located at *C:\\Windows\\Debug\\netsetup.log*.
- Network trace: During an AD domain join, multiple types of traffic occur between the client and some DNS servers and then between the client and some DCs. If you see an error in any of the above traffic, follow the corresponding troubleshooting steps of that protocol or component to narrow it down. For more information, see [Using Netsh to Manage Traces](/windows/win32/ndf/using-netsh-to-manage-traces).
- Domain join hardening changes: Windows updates released on and after October 11, 2022, contain additional protections introduced by [CVE-2022-38042](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-38042). These protections intentionally prevent domain join operations from reusing an existing computer account in the target domain unless one of the following conditions:

  - The user attempting the operation is the creator of the existing account.
  - The computer was created by a member of domain administrators.

   For more information, see [KB5020276—Netjoin: Domain join hardening changes](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8).

## Common issues and solutions

### Error code 0x569

> The user has not been granted the requested logon type at this computer.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: failed to find a DC having account <computer name>$': 0x525
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: found DC '\\<DC name>.<domain>.<tld>' in the specified domain
mm/dd/yyyy hh:mm:ss:ms NetUseAdd to \\<DC name>.<domain>.<tld>\IPC$ returned 1385
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of connecting to dc '\\<DC Name>.<Domain>.<tld>': 0x569
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x569
```

Error 0x569 is logged when the domain join user lacks the **Access this computer from the network** user right. Make sure of the following items:

- Verify that the user account performing the domain join operation (or the security group that owns the member of the domain join user) has been granted the **Access this computer from the network** right in the default domain controllers policy.
- The default domain controllers policy is linked to the OU that hosts the DC computer account that's servicing the domain join operation.
- The DC servicing the domain join operation successfully applies the policy, specifically the user rights settings defined in the default domain controllers policy.

### Error code 0x534

> No mapping between account names and security IDs was done.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpCreateComputerObjectInDs: NetpGetComputerObjectDn failed: 0x534
mm/dd/yyyy hh:mm:ss:ms NetpProvisionComputerAccount: LDAP creation failed: 0x534
mm/dd/yyyy hh:mm:ss:ms ldap_unbind status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0x534
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: status of disconnecting from '\\<DC name>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x534
```
  
The domain join graphical user interface (GUI) can call the `NetJoinDomain` API twice to join a computer to a domain. The first call is made without the "create" flag being specified to locate a pre-created computer account in the target domain. If no account is found, a second `NetJoinDomain` API call may be made with the "create" flag specified.
  
In another scenario, the 0x534 error code is logged when you attempt to change the password for a machine account. However, the account can't be found on the targeted DC, likely because the account was not created or due to replication latency or a replication failure.

The 0x534 error code is commonly logged as a transient error when domain join searches the target domain. The searching determines whether a matching computer account was pre-created or whether the join operation needs to dynamically create a computer account on the target domain. Check the bit flags in the join options and whether the type of join being performed is relying on a pre-created or newly created computer account.

### Error code 0x6BF or 0xC002001C

> The remote procedure call failed and did not execute.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaHandle: LsaOpenPolicy on \\<DC name>.<domain>.<tld> failed: 0xc002001c
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaPrimaryDomain: status: 0xc002001c
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: initiaing a rollback due to earlier errors
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of disconnecting from '\\<DC name>.<domain>.<tld>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x6bf
```

This error occurs when a network device (router, firewall, or VPN device) rejects network packets between the client being joined and the DC.

Make sure of the following items:

- Verify the connectivity between the client being joined and the target DC over the required ports and protocols.
- Disable bind time feature negotiation.
- Disable TCP Chimney Offload and IP offload.

### Error code 0x6D9

> There are no more endpoints available from the endpoint mapper.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpGetDnsHostName: Read NV Hostname: <hostname>
mm/dd/yyyy hh:mm:ss:ms NetpGetDnsHostName: PrimaryDnsSuffix defaulted to DNS domain name: <DNS domain>.<TLD>
mm/dd/yyyy hh:mm:ss:ms NetpLsaOpenSecret: status: 0xc0000034
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaPrimaryDomain: status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpLsaOpenSecret: status: 0xc0000034
mm/dd/yyyy hh:mm:ss:ms NetpManageMachineAccountWithSid: NetUserAdd on \\<hostname>.<domain> for <computername>$ failed: 0x8b0
mm/dd/yyyy hh:mm:ss:ms NetpManageMachineAccountWithSid: status of attempting to set password on \\<DC name>.<domain>.<tld> for <hostname>$: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of creating account: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpGetComputerObjectDn: Unable to bind to DS on \\<DC name>.<domain>.<tld>: 0x6d9
mm/dd/yyyy hh:mm:ss:ms NetpSetDnsHostNameAndSpn: NetpGetComputerObjectDn failed: 0x6d9
mm/dd/yyyy hh:mm:ss:ms ldap_unbind status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of setting DnsHostName and SPN: 0x6d9
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: initiaing a rollback due to earlier errors
mm/dd/yyyy hh:mm:ss:ms NetpGetLsaPrimaryDomain: status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpManageMachineAccountWithSid: status of disabling account <hostname>$ on \\<DC name>.<domain>.<tld>: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: rollback: status of deleting computer account: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpLsaOpenSecret: status: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: rollback: status of deleting secret: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomain: status of disconnecting from \\<DC name>.<domain>.<tld>: 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x6d9
```
  
Error 0x6D9 is logged when network connectivity is blocked between the joining client and the helper DC. The network connectivity services the domain join operation over port 135 or a port in the ephemeral range between 1025 to 5000 or 49152 to 65535. For more information, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).  

To resolve this error, follow these steps:

1. On the joining client, open the *%systemroot%\\debug\\NETSETUP.LOG* file and determine the name of the helper DC selected by the joining client to perform the join operation.
2. Verify that the joining client has network connectivity to the DC over the required ports and protocols used by the applicable operating system (OS) versions. Domain join clients connect a helper DC over TCP port 135 by the dynamically assigned port in the range between 49152 and 65535.
3. Ensure that the OS, software and hardware routers, firewalls, and switches allow connectivity over the required ports and protocols.

### Error code 0xA8B

> An attempt to resolve the DNS name of a DC in the domain being joined has failed. Please verify this client is configured to reach a DNS server that can resolve DNS names in the target domain.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: status of verifying DNS A record name resolution for '<DC name>.<domain>.<tld>': 0x2746
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: failed to find a DC in the specified domain: 0xa8b, last error is 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpDsGetDcName returned: 0xa8b
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0xa8b
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0xa8b
```
  
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

### Error code 0x40

> Cannot join a host into domain.

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetUseAdd to \\<DC name>.<domain>.<tld>\IPC$ returned 64
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: status of connecting to dc '\\<DC name>.<domain>.<tld>': 0x40
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0x40
```

The issue is related to Server Message Block (SMB). A firewall device between the client and the DC intercepted the Key Distribution Center (KDC) request packet and altered some data in it. As a result, the DC cannot process the request properly.

### Other errors that occur when you join Windows-based computers to a domain

For more information, see:

- Troubleshoot [Networking error messages and resolutions](troubleshoot-errors-join-computer-to-domain.md#networking-error-messages-and-resolutions)
- Troubleshoot [Authentication error messages and resolutions](troubleshoot-errors-join-computer-to-domain.md#authentication-error-messages-and-resolutions)
