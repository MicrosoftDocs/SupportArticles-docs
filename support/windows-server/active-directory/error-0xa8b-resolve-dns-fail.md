---
title: An Attempt to Resolve the DNS Name of a DC in the Domain Being Joined Has Failed
description: Provides troubleshooting steps for resolving the Domain Name System (DNS) error code 0xa8b when you join a workgroup computer to a domain.
ms.date: 03/19/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, v-lianna
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
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: status of verifying DNS A record name resolution for '<DC name>.<domain>.<tld>: 0x2746
mm/dd/yyyy hh:mm:ss:ms NetpDsGetDcName: failed to find a DC in the specified domain: 0xa8b, last error is 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpDsGetDcName returned: 0xa8b
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0xa8b
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0xa8b
```

Here's more information about the error code:

|HEX error  |Decimal error  |Symbolic error string  |
|---------|---------|---------|
|0xa8b     |2699         |NERR_SetupCheckDNSConfig         |

This error occurs for one or more of the following reasons:

- The workgroup computer being joined points to an invalid DNS server.
- The DNS server used by the joining computer is invalid, is missing the required zones, or is missing the required records for the target domain.
- The target Active Directory domain contains a problematic DNS name.
- Network problems exist on either the workgroup computer, the target domain controller (DC), or the network used to connect the client and target DC.

## Troubleshooting steps

To resolve this error, follow these steps:

1. Verify that the computer being joined points to valid DNS server IP addresses. Invalid examples include:

    - Invalid Internet Service Provider (ISP)-provided DNS servers.
    - A stale or nonexistent DNS server on the corporate intranet.
    - A DNS server in an error state that prevents it from loading the `_msdcs.<forest root domain>` or target AD domain zones, or from resolving queries for those zones. Event ID 4521 might be logged.

2. Verify that all DNS servers configured on the client host the required zones and valid records for a DC in the target domain. Check for the following misconfigurations:

    - Forward lookup zone for the target AD domain is missing.
    - The `_msdcs` forward lookup zone is missing.
    - The `_msdcs.<forest root domain>` zone doesn't contain a Lightweight Directory Access Protocol (LDAP) SRV record for a DC in the target domain.
    - Host A record is missing from the target AD domain zone.
    - Host A record is present but contains the wrong IP address for the target DC.
    - The host A record is present but was registered by a network interface that isn't accessible to the client computer.

3. Check for special names in the target Active Directory domain that require other configuration:

    - Single-label DNS name.
    - Disjoint namespace.
    - All numeric top-level domains (TLDs) or TLDs containing numeric characters.

4. Check for network problems on the workgroup computer, target DC, or the network connecting the computer and the target DC:

    - A broken Network Interface Card (NIC)  on the client computer or the target DC.
    - A broken network link.
