---
title: Best Practices for Azure Storage Network Security
description: Learn how to design, deploy, and operate network controls for Azure Storage.
author: aadetayo
ms.author: aadetayo
ms.service: azure-storage
ms.topic: best-practice
ms.date: 10/14/2026
---

# Best practices for Azure Storage network security

Use the practices in this article to design, deploy, and operate network controls for Azure Storage. The guidance applies to Blob Storage, Data Lake Storage, Azure Files, Queue Storage, and Table Storage, subject to each service's endpoint, protocol, and feature support.

> [!IMPORTANT]
> Network security and authentication/authorization solve different problems. Network controls determine which network paths can reach a storage endpoint. Authentication verifies the identity or credentials making the request, while authorization determines what that identity or credential can access and what operations it can perform.

## Inventory every access path before you restrict the account

Create an access inventory for each storage account:

| **Area** | **Questions to answer** |
|----|----|
| Clients | Which applications, people, Azure services, and on-premises systems access the account? |
| Services | Which subresources are used: `blob`, `dfs`, `file`, `queue`, `table`, or `web`? |
| Protocols | Does the workload use HTTPS, SMB, NFS, or SFTP? |
| Networks | Which virtual networks, subnets, on-premises sites, and public NAT addresses are required? |
| DNS | Which clients use Azure-provided DNS, custom DNS, or on-premises DNS? |
| Authorization | Which managed identities, users, service principals, SAS tokens, account keys, ACLs, or local SFTP users are used? |
| Dependencies | Which monitoring, backup, disaster recovery, analytics, security, and data-integration services read from or write to the account? |
| Resiliency | Which regions and secondary endpoints are required during failover? |

Use resource logs and dependency testing to validate the inventory. Don't rely only on deployed firewall rules; obsolete or overbroad rules don’t prove that a workload still uses them. For more information on resource logs and storage service logs, see here [Resource logs in Azure Monitor - Azure Monitor \| Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/resource-logs?tabs=log-analytics) and [Monitor Azure Blob Storage \| Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/blobs/monitor-blob-storage?tabs=azure-portal)

## Prefer private endpoints for private IP connectivity

Use Azure Private Link and private endpoints when workloads require private IP access, when the public endpoint must be disabled, or when the security boundary is a virtual network rather than a public source IP.

Apply these design practices:

- Create a private endpoint for every required storage service subresource.
- For Data Lake Storage, deploy both `dfs` and `blob` private endpoints when operations can be redirected between those endpoints.
- Use hub-and-spoke connectivity when centralized endpoints meet the organization's isolation, routing, ownership, and failure-domain requirements.
- Treat the documented maximum of 200 private endpoints per storage account as an architecture constraint. Consolidate before reaching the limit.
- Keep private endpoint connections in an approved state and review them periodically.
- Restrict public network access only after the private path is tested from every required network.

A private endpoint can coexist with service endpoints in the same subnet. Use that only when different storage accounts intentionally require different connectivity models.

For more information, see [Use private endpoints for Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-private-endpoints) and [Scalability and performance targets for standard storage accounts](https://learn.microsoft.com/azure/storage/common/scalability-targets-standard-account).

## Design DNS as part of the private endpoint architecture

Private endpoint reliability depends on DNS. Clients should continue to use the normal storage account FQDN while DNS selects the private path.

- Use the recommended private DNS zone for each storage service, such as `privatelink.blob.core.windows.net`.
- Link private DNS zones only to the virtual networks that need them.
- For custom or on-premises DNS, use conditional forwarding or delegation to Azure DNS or Azure DNS Private Resolver.
- Don't put `privatelink` hostnames or private IP addresses in application connection strings.
- Don't use host-file entries outside short-lived testing.
- Don't create static A records for public storage endpoints. Public IP addresses can change.
- Test both positive and negative resolution from every network segment, including peered virtual networks and on-premises sites.
- When a private DNS zone covers an Azure service namespace, plan how clients in that virtual network resolve public resources of the same service type. Use the documented fallback or forwarding pattern rather than static public IP records.

See [Azure Private Endpoint private DNS zone values](https://learn.microsoft.com/azure/private-link/private-endpoint-dns) and [Azure Private Endpoint DNS integration scenarios](https://learn.microsoft.com/azure/private-link/private-endpoint-dns-integration).

## Disable public network access when it isn't required

For a private-only account, set **Public network access** to **Disabled** after private endpoints, DNS, authorization, monitoring, and recovery access are validated.

For an account that must retain the public endpoint:

1.  Set the storage firewall’s default action to **Deny**.
2.  Add only the required virtual network, IP network, resource instance, and trusted-service rules.
3.  Prefer a resource-specific rule or private endpoint over a broad exception.
4.  Review allowed rules regularly and remove unused entries.
5.  Use Azure Policy to audit or deny accounts that don’t meet the organization's public-access standard.

> [!CAUTION]
> Don't use `0.0.0.0/0` as a routine recovery or troubleshooting rule. Maintain a tested management path and a controlled rollback procedure instead.

Storage firewall rules control only the public endpoint. They don’t control traffic through private endpoints.

## Use IP rules only for stable public egress addresses

IP network rules are appropriate for clients that reach Azure Storage through a known public IPv4 address, such as an on-premises NAT gateway or a controlled internet egress.

- Add the public address that Azure Storage observes, not a client's private address.
  - To identify the source IP Azure Storage observed, review the request in Storage resource logs and inspect CallerIpAddress. This might differ from the client's local IP because of NAT, proxies, VPN gateways, or other egress infrastructure
- Use the narrowest practical CIDR ranges.
- Keep an authoritative owner and purpose for every rule.
- Monitor rule usage and remove stale entries.
- Plan for the maximum of 400 IP network rules per storage account.
- Don't depend on a storage account's destination IP address. Use the storage FQDN and honor DNS TTL.
- If the source address isn't stable, use a private endpoint or another supported identity-based network control instead of repeatedly changing IP rules.

When a subnet gains a storage service endpoint, storage-bound traffic switches from its public source IP to its virtual network private identity. Update the storage firewall before enabling the endpoint.

## Use service endpoints with explicit virtual network rules

Use a service endpoint when a subnet needs optimized Azure-backbone routing and subnet identity to a storage account's public endpoint, and private IP connectivity isn't required.

- Enable the storage service endpoint
- Add a storage virtual network rule for that subnet.
- Remember that enabling the endpoint doesn't grant access by itself; the storage account must allow the subnet and the request must be authorized.
- Choose the endpoint type deliberately:
  - `Microsoft.Storage` for regional storage service endpoint scenarios
  - `Microsoft.Storage.Global` when the subnet must connect to storage accounts in any Azure region
  - We recommend using `Microsoft.Storage.Global` instead of `Microsoft.Storage` because it supports both in-region and cross-region access
- A subnet can't use both storage endpoint types simultaneously.
- Before changing endpoint types, replace public-IP-based storage rules with the intended virtual network rules, stop critical transfers, and verify that applications reconnect automatically.

For disaster recovery, preconfigure the required virtual networks and storage network rules in the recovery region instead of waiting for an outage.

See [Azure virtual network service endpoints](https://learn.microsoft.com/azure/virtual-network/virtual-network-service-endpoints-overview) and [Azure Storage firewall rules and network access control](https://learn.microsoft.com/azure/storage/common/storage-network-security).

## Use trusted-service exceptions narrowly

The **Allow Azure services on the trusted services list to access this storage account** setting applies only to documented service scenarios. It isn't a general “allow all Azure” rule.

- Verify that the exact service and operation appear in the current trusted-services documentation.
- Grant the service's managed identity or service principal the minimum required data permissions.
- Prefer a resource instance rule when you need to scope public endpoint access to a specific supported Azure resource and both the source and target services support resource instance rules.
- Prefer a private endpoint or service-managed private endpoint when the service supports private connectivity.
- Revalidate the exception when the dependent service or architecture changes.

For Power BI, Azure Databricks, Azure Site Recovery, and other integrated services, use that service's current networking instructions. Don't assume that an exception supported by one service applies to another.

See [Trusted Azure services for Azure Storage network security](https://learn.microsoft.com/azure/storage/common/storage-network-security-trusted-azure-services).

## Roll out Network Security Perimeter in stages

Azure Network Security Perimeter can create a common public network boundary around supported PaaS resources. It complements private endpoints; it doesn't replace private IP connectivity.

Use this rollout sequence:

1.  Confirm that every storage service, protocol, region, and dependent Azure service in the workload is supported.
2.  Group resources with similar inbound and outbound requirements into perimeter profiles.
3.  Associate storage accounts in **transition mode**.
4.  Collect Network Security Perimeter access logs and storage resource logs through a representative workload cycle.
5.  Create only the required inbound and outbound rules.
6.  Test normal operations, deployment, monitoring, support, backup, and disaster recovery.
7.  Move to **enforced mode** during a controlled change window.
8.  Monitor denials and keep a documented rollback plan.

In enforced mode:

- Public traffic is denied by default except intra-perimeter traffic and traffic allowed by perimeter rules.
- Perimeter rules take precedence over the storage account's firewall rules.
- Trusted-service traffic is also subject to perimeter rules.
- Private endpoint traffic isn't subject to perimeter access rules.
- NSP support varies by Storage protocol and feature. SMB and NFS support IP network rules under NSP, but not all non-HTTPS scenarios have full feature parity. Verify current protocol-specific support before enabling enforced mode.

Design within the current scale guidance: up to 100 perimeters per subscription, 200 profiles per perimeter, 200 inbound and 200 outbound rule elements per profile, and 1,000 associated PaaS resources per perimeter.

See [Network Security Perimeter for Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-network-security-perimeter) and [Network Security Perimeter concepts](https://learn.microsoft.com/azure/private-link/network-security-perimeter-concepts).

## Require secure transport and modern TLS

- Keep **Secure transfer required** enabled.
- Set the minimum TLS version to TLS 1.2.
- Use resource logs to identify clients that negotiate older TLS versions before enforcing TLS 1.2 on an existing account.
- Remediate old clients and test before changing production.
- Don't claim that the storage account can enforce TLS 1.3. Azure Storage supports TLS 1.3 negotiation, but the account minimum currently can't be set to TLS 1.3.
- Don't promise per-account cipher-suite control. Azure Storage doesn't expose configuration to allow or block individual cipher suites beyond the effect of the minimum TLS version.

If a compliance requirement calls for a specific cipher policy, evaluate a supported intermediary such as Azure Application Gateway. Validate protocol compatibility, performance, availability, and end-to-end security before adoption.

See [Enforce a minimum required version of TLS for Azure Storage](https://learn.microsoft.com/azure/storage/common/transport-layer-security-configure-minimum-version) and [Require secure transfer](https://learn.microsoft.com/azure/storage/common/storage-require-secure-transfer).

## Keep authorization independent and least-privileged

A private network path doesn't prove that a caller should access data.

- Prefer Microsoft Entra ID and Azure RBAC over Shared Key authorization where supported.
- Use managed identities for Azure workloads.
- Scope roles to the smallest required resource and operation.
- For Data Lake Storage, coordinate Azure RBAC with POSIX-like ACLs.
- For SAS, prefer a user delegation SAS where supported, use the minimum permissions and resource scope, require HTTPS, and set a short expiration.
- Treat SAS tokens and account keys as secrets. Don't log or embed them in source code.
- For SFTP, prefer SSH public-key authentication, restrict each local user to required containers and paths, and rotate credentials.

Network restrictions and authorization should fail independently: a request should need both an allowed network path and valid permission.

## Enable logs before enforcing restrictions

Configure diagnostic settings for every storage service used by the account. Send logs to a destination that remains reachable after network restrictions are applied.

Monitor at least:

- Allowed and denied data-plane operations.
- `CallerIpAddress`, `AuthenticationType`, `RequesterObjectId`, `OperationName`, `StatusCode`, and `Uri` in storage resource logs.
- Private endpoint creation, approval, rejection, and deletion in the Azure Activity Log.
- Network Security Perimeter access logs for transition and enforced associations.
- DNS resolution and private endpoint connection state.
- Changes to public network access, firewall rules, virtual network rules, trusted-service exceptions, and minimum TLS version.

A sample query for Blob Storage is:

> StorageBlobLogs
>     | where TimeGenerated > ago(24h)
>     | project TimeGenerated, AccountName, OperationName, StatusCode,
>               AuthenticationType, RequesterObjectId, CallerIpAddress, Uri
>     | order by TimeGenerated desc

Adjust the table and time range for the storage service and investigation. The caller IP is the address presented to the service and can be a public NAT address or a private address, depending on the path.

See the [StorageBlobLogs table reference](https://learn.microsoft.com/azure/azure-monitor/reference/tables/storagebloblogs).

## Make network changes as migrations, not toggles

For any material change—enabling a private endpoint, disabling public access, changing a service endpoint type, enforcing a perimeter, or moving a resource—use a staged migration:

1.  **Discover:** Inventory callers, protocols, endpoints, authorization, DNS, and dependencies.
2.  **Prepare:** Add the replacement path, rules, DNS, monitoring, and rollback controls.
3.  **Validate:** Test data operations from every required location and confirm logs show the expected path.
4.  **Cut over:** Make the restriction during a controlled window. Stop critical transfers when a connection reset is possible.
5.  **Observe:** Monitor errors, latency, DNS, denied requests, and dependent services.
6.  **Clean up:** Remove obsolete public access, IP rules, DNS records, and endpoints after the validation period.

For a cross-subscription move, review support for the storage account and every dependent resource. Private endpoints and virtual networks have independent move restrictions, and some private-link resource types don’t support moves. Re-create unsupported dependencies and retest rather than assuming that the network configuration moves with the account.

## Design for failure and recovery

- Predeploy required connectivity in the recovery region.
- Validate DNS behavior for primary and secondary storage endpoints.
- Include private endpoints, firewall rules, perimeter rules, route tables, network security groups, and monitoring destinations in disaster-recovery tests.
- Test application reconnection after DNS or route changes.
- Avoid cached storage destination IPs and honor DNS TTL.
- Document which control plane remains available during a regional outage; don’t publish outage behavior that isn't covered by current service documentation.
- For Azure Site Recovery, follow the service-specific sequence for Recovery Services vault private endpoints, managed identity permissions, DNS, and any cache or target storage endpoints.

See [Failover considerations for storage accounts with private endpoints](https://learn.microsoft.com/azure/storage/common/storage-failover-private-endpoints) and [Enable replication for private endpoints in Azure Site Recovery](https://learn.microsoft.com/azure/site-recovery/azure-to-azure-how-to-enable-replication-private-endpoints).

## Pre-deployment validation checklist

Before enforcement, verify all the following:

- [ ] Every client, Azure service, protocol, subresource, and region is inventoried.
- [ ] Private endpoints exist for all required storage subresources.
- [ ] Standard storage FQDNs resolve to the intended private IPs from every private client network.
- [ ] Public network access is disabled, or the default network action is **Deny** with minimal allow rules.
- [ ] Trusted-service and resource instance exceptions are documented and authorized.
- [ ] Network Security Perimeter feature coverage and protocol limitations are validated.
- [ ] Secure transfer is required and the minimum TLS version is TLS 1.2.
- [ ] Data authorization is least-privileged and independent from network controls.
- [ ] Resource logs, activity logs, and perimeter logs reach a monitored destination.
- [ ] The rollback path doesn't require a broad public allow rule.
- [ ] Failover, secondary endpoint, and dependency tests have completed successfully.
- [ ] Obsolete rules, endpoints, and DNS records are scheduled for removal.

## Related content

- [Azure Storage network security](https://learn.microsoft.com/azure/storage/common/storage-network-security-overview)
- [Azure Storage firewall rules and network access control](https://learn.microsoft.com/azure/storage/common/storage-network-security)
- [Use private endpoints for Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-private-endpoints)
- [Azure Private Endpoint DNS integration scenarios](https://learn.microsoft.com/azure/private-link/private-endpoint-dns-integration)
- [Network Security Perimeter for Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-network-security-perimeter)
- [Trusted Azure services for Azure Storage network security](https://learn.microsoft.com/azure/storage/common/storage-network-security-trusted-azure-services)
