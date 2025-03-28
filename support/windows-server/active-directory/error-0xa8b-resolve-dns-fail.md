---
title: An Attempt to Resolve the DNS Name of a DC in the Domain Being Joined Has Failed
description: Provides troubleshooting steps for resolving the Domain Name System (DNS) error code 0xa8b when you join a workgroup computer to a domain.
ms.date: 03/26/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, herbertm, dennhu, eriw, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Error code 0xa8b: An attempt to resolve the DNS name of a DC in the domain being joined has failed

This article provides troubleshooting steps for resolving the Domain Name System (DNS) error code 0xa8b when you join a workgroup computer to a domain. It includes causes and resolutions for common DNS issues.

When you join a workgroup computer to a domain, you receive the following error message:

> An attempt to resolve the DNS name of a DC in the domain being joined has failed. Please verify this client is configured to reach a DNS server that can resolve DNS names in the target domain.

When you check the **NetSetup.log** file, you see the following entries:

```output
NetpDsGetDcName: status of verifying DNS A record name resolution for '<DC name>.<domain>.<tld>: 0x2746
NetpDsGetDcName: failed to find a DC in the specified domain: 0xa8b, last error is 0x0
NetpJoinDomainOnDs: NetpDsGetDcName returned: 0xa8b
NetpJoinDomainOnDs: Function exits with status of: 0xa8b
NetpDoDomainJoin: status: 0xa8b
```

Here's more information about the error code:

|HEX error  |Decimal error  |Symbolic error string  |
|---------|---------|---------|
|0xa8b     |2699         |NERR_SetupCheckDNSConfig         |

This error occurs for one or more of the following reasons:

- The workgroup computer being joined points to an invalid DNS server.
- The DNS server used by the joining computer is invalid, is missing the required zones, or is missing the required records for the target domain.
- The target Active Directory (AD) domain contains a problematic DNS name.
- Network problems exist on the workgroup computer, the target domain controller (DC), or the network used to connect the client and target DC.

## Troubleshooting steps

To resolve this error, follow these steps:

1. Verify that the computer being joined points to valid DNS server IP addresses. Invalid examples include:

    - Invalid Internet Service Provider (ISP)-provided DNS servers.
    - ISP-provided DNS servers that don't host the AD domain zone.
    - A stale or nonexistent DNS server on the corporate intranet.
    - A corporate network DNS server that doesn't host the AD domain zone.
    - A corporate network DNS server in an error state that prevents it from loading the `_msdcs.<forest root domain>` or target AD domain zones, or from resolving queries for those zones. Event ID 4521 might be logged.

2. Verify that all DNS servers configured on the client host the required zones and valid records for a DC in the target domain. Check for the following misconfigurations:

    - Forward lookup zone for the target AD domain is missing.
    - The `_msdcs` forward lookup zone is missing.
    - The `_msdcs.<forest root domain>` zone doesn't contain a Lightweight Directory Access Protocol (LDAP) SRV record for a DC in the target domain.
    - The host A record is missing from the target AD domain zone.
    - The host A record is present but contains the wrong IP address for the target DC.
    - The host A record is present but is registered by a network interface that isn't accessible to the client computer.

3. Check for special names in the target Active Directory domain that require other configuration:

    - Single-label DNS name. For more information, see [Deployment and operation of Active Directory domains that are configured by using single-label DNS names](deployment-operation-ad-domains.md#how-to-enable-windows-based-clients-to-do-queries-and-dynamic-updates-with-single-label-dns-zones).
    - Disjoint namespace. For more information, see [Event IDs 5788 and 5789 occur on a Windows-based computer](event-ids-5788-5789.md).
    - All numeric top-level domains (TLDs) or TLDs containing numeric characters.

4. Check for network problems on the workgroup computer, target DC, or the network connecting the computer and the target DC:

    - A broken Network Interface Card (NIC)  on the client computer or the target DC.
    - A broken network link.

You can use tools like [nslookup](/windows-server/administration/windows-commands/nslookup) to verify the availability and content of DNS records from the client end, and use tools like [ping](/windows-server/administration/windows-commands/ping) or [tracert](/windows-server/administration/windows-commands/tracert) to check the reachability of IP addresses. You can use [PortQry](../networking/portqry-command-line-port-scanner-v2.md) to try specific DC UDP and TCP server ports. A starting point for DC server ports is to [Configure a firewall for AD domains and trusts](config-firewall-for-ad-domains-and-trusts.md).
