---
title: Azure Storage network security FAQ
description: Answers to common questions about Azure Storage public and private endpoints, firewalls, virtual network rules, Network Security Perimeter, DNS, monitoring, and TLS.
author: aadetayo
ms.author: aadetayo
ms.service: azure-storage
ms.topic: faq
ms.date: 10/14/2026
---

# Azure Storage network security FAQ

This article answers frequently asked questions about securing network access to Azure Storage. It covers public and private endpoints, storage firewalls, virtual network rules, IP network rules, Azure Network Security Perimeter, DNS, monitoring, and TLS.

> [!IMPORTANT]
> Network controls determine whether a request can reach a storage endpoint. They don't authorize access to data. Use Microsoft Entra ID and Azure role-based access control (Azure RBAC), shared access signatures (SAS), access control lists (ACLs), or another supported authorization method in addition to network controls.

## Choose a network access model

### What are the security implications of enabling public network access?

Enabling public network access makes the storage account's public endpoints reachable from network locations that the storage firewall permits. It doesn't make data anonymous or bypass authorization, but it increases the network-reachable attack surface and can expose the account to unwanted connection attempts or configuration mistakes.

If workloads don't require the public endpoint, disable public network access and use private endpoints. If workloads require the public endpoint, set the default network action to **Deny** and allow only the required virtual networks, public IP ranges, resource instances, or trusted Azure services.

For more information, see [Azure Storage firewall rules and network access control](https://learn.microsoft.com/azure/storage/common/storage-network-security).

### How do I restrict or disable public network access?

Choose one of these models:

- **Private endpoint only:** Set **Public network access** to **Disabled**. Create and validate private endpoints and DNS before disabling the public endpoint.
- **Selected public networks:** Keep public network access enabled, set the default action to **Deny**, and add only the required virtual network, IP, resource instance, and exception rules.
- **Network Security Perimeter:** Associate the account with a perimeter and move from transition mode to enforced mode after validating access rules and logs.

> [!CAUTION]
> Validate data-plane access from every required workload and keep a tested administrative recovery path before changing production network settings.

### What is the difference between a private endpoint and a service endpoint?

A **private endpoint** assigns a private IP address from a virtual network to a specific storage service subresource. Clients use the storage account's normal fully qualified domain name (FQDN), and DNS resolves that name to the private IP from authorized networks. Private endpoint traffic doesn't use the storage account's public endpoint.

A **service endpoint** provides the subnet's virtual network identity to Azure Storage and optimizes routing over the Azure backbone, but clients still connect to the storage account's public endpoint. A storage virtual network rule controls whether that subnet can use the public endpoint.

Microsoft recommends private endpoints when you require private IP connectivity or want to disable the public endpoint. Service endpoints remain useful when public endpoint access is acceptable and subnet-based controls meet the requirement. See [Azure Storage network security](https://learn.microsoft.com/azure/storage/common/storage-network-security-overview) and [Azure virtual network service endpoints](https://learn.microsoft.com/azure/virtual-network/virtual-network-service-endpoints-overview).

### Can I combine private endpoints, virtual network rules, IP rules, and Network Security Perimeter?

Yes, but each control applies to a different path:

- Storage firewall IP, virtual network, resource instance, and trusted-service rules control access to the public endpoint.
- Storage firewall rules don't control traffic through a private endpoint.
- In Network Security Perimeter enforced mode, perimeter access rules become the top-level control for public traffic and override the storage account's firewall configuration.
- Private endpoint traffic isn't subject to Network Security Perimeter access rules.

Public-endpoint allow rules are alternatives: a request can be allowed when it matches an applicable configured rule. A request doesn't need to match every rule type.

## Private endpoints and Private Link

### What is the difference between Azure Private Link and a private endpoint?

Azure Private Link is the technology that provides private connectivity to supported Azure and partner services. A private endpoint is a network interface in your virtual network with a private IP address that connects to a particular Private Link resource and subresource.

### How do I configure a private endpoint for a storage account?

At a high level:

- Identify every storage service subresource the workload uses, such as `blob`, `dfs`, `file`, `queue`, `table`, or `web`.
- Create a private endpoint for each required subresource.
- Integrate the endpoint with the recommended private DNS zone or update your custom DNS design.
- Confirm the private endpoint connection is approved.
- From each client network, verify that the standard storage FQDN resolves to the expected private IP and that data-plane access succeeds.
- After validation, restrict or disable public network access.

For Data Lake Storage workloads, create private endpoints for both `dfs` and `blob` when the workload uses operations that can be redirected between those endpoints. See [Use private endpoints for Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-private-endpoints).

### What DNS configuration is required for private endpoints?

Clients must resolve the storage account's standard FQDN to the private endpoint IP address. Use the recommended Azure Private DNS zones, such as `privatelink.blob.core.windows.net` for Blob Storage, and link them to the required virtual networks.

For on-premises or custom DNS, configure conditional forwarding or delegation so private-link names resolve through Azure DNS or Azure DNS Private Resolver. Don't hard-code storage service IP addresses. See [Azure Private Endpoint private DNS zone values](https://learn.microsoft.com/azure/private-link/private-endpoint-dns) and [Azure Private Endpoint DNS integration scenarios](https://learn.microsoft.com/azure/private-link/private-endpoint-dns-integration).

### Can on-premises clients use a storage private endpoint?

Yes. The on-premises network needs private connectivity to the virtual network that hosts or can route to the private endpoint, typically through VPN or ExpressRoute. It also needs DNS resolution that returns the private endpoint IP and routing and security rules that permit the connection.

A service endpoint alone doesn't extend from a virtual network to on-premises clients. For public-endpoint access from on-premises, allow the appropriate public NAT IP addresses in the storage firewall.

### Do I use a different URL or connection string with a private endpoint?

No. Continue to use the normal storage account endpoint, such as `https://<account>.blob.core.windows.net`. DNS determines whether the connection uses the private endpoint or public endpoint. Don't put the `privatelink` hostname or a private IP address in application connection strings.

### How do SAS URLs work with private endpoints?

A SAS controls authorization; it doesn't provide network reachability. Generate the SAS for the normal storage service URL. A client can use the SAS only if it can reach an allowed endpoint and resolve the storage FQDN correctly. If public network access is disabled, a SAS used from the public internet won't make the account reachable.

Use the narrowest permissions and resource scope, prefer a user delegation SAS when supported, use a short expiration, require HTTPS, and protect the SAS as a secret.

### Does a private endpoint affect diagnostic logs or monitoring?

A private endpoint doesn't remove storage resource logs, metrics, activity logs, or diagnostic settings. However, any service that reads from or writes to a network-restricted storage account must itself have an allowed network path. Validate diagnostic destinations, monitoring agents, export jobs, and security products before disabling public network access.

### Can SFTP clients connect through a private endpoint?

Yes. For SFTP-enabled Blob Storage, create a private endpoint for the `blob` subresource, configure the corresponding private DNS zone, and ensure clients can route to the private IP on TCP port 22. Clients connect by using the normal storage account SFTP hostname. SFTP authentication and local-user permissions still apply.

Network Security Perimeter enforced mode blocks non-HTTPS protocols for associated storage accounts. Don't associate an SFTP workload with an enforced perimeter unless current feature documentation explicitly supports the required protocol. See [SFTP support for Azure Blob Storage](https://learn.microsoft.com/azure/storage/blobs/secure-file-transfer-protocol-support) and [Network Security Perimeter for Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-network-security-perimeter).

### How many private endpoints can a storage account have?

The documented maximum is 200 private endpoints per storage account. Before approaching the limit, reduce unnecessary endpoints and consider a shared hub-and-spoke design in which peered networks use centrally managed private endpoints and DNS. Confirm that the design meets routing, isolation, failure-domain, and application requirements. See [Scalability and performance targets for standard storage accounts](https://learn.microsoft.com/azure/storage/common/scalability-targets-standard-account).

### What should I check when a private endpoint connection fails?

Check the following in order:

- The client resolves the normal storage FQDN to the expected private IP.
- The private endpoint connection state is **Approved**.
- An endpoint exists for the storage subresource the client actually uses.
- Routes, network security groups, firewalls, and on-premises network devices permit the service port.
- The request is authorized for the data operation.
- The client isn't using a cached IP address, a `privatelink` URL, or a custom host-file entry.

Tools such as `nslookup`, `Resolve-DnsName`, `Test-NetConnection`, Azure Network Watcher, and storage resource logs can help isolate the failure.

## Firewalls, virtual networks, and IP rules

### How do storage firewall IP rules work?

IP network rules allow the public endpoint to accept requests from specified public IPv4 addresses or CIDR ranges after the storage account's default network action is set to **Deny**. They are intended for internet clients and on-premises networks that reach Azure through a stable public NAT address.

Don't enter private RFC 1918 addresses in public IP rules. If a subnet uses a storage service endpoint, traffic uses the subnet's private source identity and an IP rule for the workload's former public IP no longer applies. Each storage account supports up to 400 IP network rules.

### How do virtual network rules and service endpoints work together?

A storage virtual network rule identifies an allowed subnet. The subnet must also have the appropriate Azure Storage service endpoint enabled. Enabling the service endpoint changes storage-bound traffic from the workload's public source IP to its virtual network private identity.

Removing a service endpoint doesn't by itself prove that all access will stop. A client might still be allowed through another path, such as a public IP rule, a private endpoint, a trusted-service exception, a resource instance rule, or Network Security Perimeter. To troubleshoot unexpected access, inspect DNS resolution, the destination endpoint, the storage firewall configuration, and resource logs.

### What is the difference between Microsoft.Storage and Microsoft.Storage.Global?

`Microsoft.Storage` is the regional Azure Storage service endpoint. It provides connectivity to storage accounts in the same Azure region as the virtual network and to paired-region scenarios described in the service documentation.

`Microsoft.Storage.Global` is the cross-region service endpoint. It provides connectivity to storage accounts in any Azure region. A subnet can't use both endpoint types at the same time.

Changing the endpoint type can change source addressing and close existing TCP connections. Update storage virtual network rules first, schedule the change during a controlled window, and ensure applications reconnect automatically. Microsoft doesn't publish a fixed downtime duration for this change.

### Do storage service endpoint tags include services other than Azure Storage?

The `Microsoft.Storage` and `Microsoft.Storage.Global` service endpoint resources are scoped to Azure Storage. However, first-party and third-party applications can depend on Azure Storage, so changing storage connectivity can indirectly affect those applications. Inventory dependencies and test before changing a production subnet.

### How do trusted Azure services access a network-restricted storage account?

The **Allow Azure services on the trusted services list to access this storage account** exception lets specific Azure services bypass storage network rules for documented scenarios. It doesn't allow every Azure service, every resource instance, or arbitrary customer code running in Azure.

The workload still needs valid authorization to the storage account. Prefer a resource instance rule or private endpoint when you need access scoped to a particular resource and the service supports that model. See [Trusted Azure services for Azure Storage network security](https://learn.microsoft.com/azure/storage/common/storage-network-security-trusted-azure-services).

### Can IP rules restrict individual containers, shares, queues, tables, or blobs?

No. Storage network rules apply at the storage account endpoint, not to individual data objects. Use Microsoft Entra ID and Azure RBAC, ACLs for hierarchical namespace workloads, SFTP local-user permissions, or a scoped SAS for resource-level authorization.

### Can a storage account's public IP address change?

Yes. A storage endpoint can resolve to multiple IP addresses, and those addresses can change. Applications and network designs shouldn't depend on a cached storage IP. Use the storage account FQDN, honor the DNS record's time-to-live (TTL), and avoid static A records for public storage endpoints. See [Storage account endpoints](https://learn.microsoft.com/azure/storage/common/storage-account-overview#storage-account-endpoints).

### How can I identify the source IP of storage requests?

Enable resource logs for the required storage services and send them to a Log Analytics workspace, Event Hubs, or another supported destination. In Log Analytics, query tables such as `StorageBlobLogs`, `StorageFileLogs`, `StorageQueueLogs`, or `StorageTableLogs` and inspect fields such as `CallerIpAddress`, `AuthenticationType`, `RequesterObjectId`, `OperationName`, `StatusCode`, and `Uri`.

The observed address is the source presented to the storage service. Depending on the network path, it can be a public NAT address or a private address. Correlate it with DNS, routing, private endpoint, firewall, and identity information. See the [StorageBlobLogs table reference](https://learn.microsoft.com/azure/azure-monitor/reference/tables/storagebloblogs).

## Network Security Perimeter

### What is Azure Network Security Perimeter, and when should I use it with Azure Storage?

Azure Network Security Perimeter provides a logical boundary for supported platform-as-a-service (PaaS) resources that are deployed outside virtual networks. It can control public inbound and outbound access across multiple resources and help reduce data-exfiltration risk.

Use it when multiple supported PaaS resources require a consistent public network boundary. Use private endpoints when workloads require private IP connectivity. Review Azure Storage feature coverage and protocol limitations before association.

### What are transition mode and enforced mode?

**Transition mode** is the default onboarding mode. It helps you observe access patterns while the storage account can fall back to its existing firewall and trusted-service settings when a perimeter rule doesn't allow a connection.

**Enforced mode** denies public traffic by default except intra-perimeter traffic and traffic explicitly allowed by perimeter access rules. In enforced mode, perimeter rules override the storage account's public network firewall settings.

Start in transition mode, collect and review logs, create the minimum required rules, test all dependencies, and then move to enforced mode.

### How does Network Security Perimeter interact with private endpoints and trusted services?

Private endpoint traffic isn't evaluated by Network Security Perimeter access rules. Public traffic, including traffic from trusted Azure services, is subject to perimeter rules when the storage account is associated in enforced mode.

Don't assume that an existing trusted-service exception or storage firewall rule will continue to allow public traffic after enforcement. Model that dependency explicitly in the perimeter configuration or move it to a supported private path.

### What access-rule types and limits should I consider?

Network Security Perimeter supports public inbound rules based on approved network and identity attributes, such as source IP ranges, subscriptions, and supported network identifiers. Public outbound rules can use FQDNs for external destinations. Use only rule types documented for the current service and region.

Current documented scale guidance includes up to 100 perimeters per subscription, 200 profiles per perimeter, 200 inbound and 200 outbound rule elements per profile, and 1,000 associated PaaS resources per perimeter. Some values are recommended limits and others are hard limits; check the current [Network Security Perimeter concepts](https://learn.microsoft.com/azure/private-link/network-security-perimeter-concepts) before deployment.

### What should I do if access fails after enabling Network Security Perimeter?

- Confirm whether the association is in transition or enforced mode.
- Determine whether the request uses a private or public endpoint.
- For public traffic, review the profile association and the applicable inbound or outbound access rule.
- Review Network Security Perimeter access logs and storage resource logs.
- Check current Azure Storage feature coverage and protocol limitations.
- Return to transition mode only as part of a controlled rollback plan while you correct the rules.

Don't use a broad `0.0.0.0/0` allow rule as a routine troubleshooting step.

## TLS and secure transport

### What TLS settings should I use for Azure Storage?

Enable **Secure transfer required** and configure the minimum TLS version to TLS 1.2. Azure Storage supports TLS 1.2 and TLS 1.3, but TLS 1.3 currently can't be enforced as the account's minimum version. Compatible clients can negotiate TLS 1.3 automatically.

Before raising the minimum TLS version on an existing account, use logs to identify clients that still use older TLS versions, remediate them, and test the change. See [Enforce a minimum required version of TLS for Azure Storage](https://learn.microsoft.com/azure/storage/common/transport-layer-security-configure-minimum-version) and [Require secure transfer](https://learn.microsoft.com/azure/storage/common/storage-require-secure-transfer).

### Can I configure the cipher suites that Azure Storage accepts?

Not directly. The negotiated cipher suite depends on the TLS version, and a storage account can't allow or block individual cipher suites beyond enforcing a minimum TLS version. If a requirement calls for a specific cipher policy, evaluate a supported intermediary such as Azure Application Gateway and validate that the architecture supports the required storage protocol and traffic pattern.

## Azure service integrations and operations

### How should Azure services such as Site Recovery, Databricks, or Power BI access a restricted storage account?

There isn't one network configuration that applies to every Azure service. For each service, determine which of these models it supports:

- Private endpoints or service-managed private endpoints.
- A storage resource instance rule.
- The trusted Azure services exception for a documented scenario.
- Public endpoint access from documented outbound IP ranges.
- Network Security Perimeter rules and feature coverage.

The service also needs a supported identity and data authorization. Follow that service's current networking documentation instead of enabling a broad exception. For Site Recovery, private endpoint configuration includes the Recovery Services vault, DNS, managed identity permissions, and any required storage endpoints. See [Enable replication for private endpoints in Azure Site Recovery](https://learn.microsoft.com/azure/site-recovery/azure-to-azure-how-to-enable-replication-private-endpoints).

### How do I safely update or remove network rules or private endpoints?

Use a staged change:

- Inventory clients, protocols, storage subresources, identities, and dependencies.
- Add and validate the replacement path.
- Test DNS resolution and data operations from every required network.
- Change the firewall, perimeter association, or endpoint.
- Monitor errors and logs.
- Remove obsolete rules, DNS records, and private endpoints only after validation.

For cross-subscription resource moves, review the current move-support matrix for the storage account and every dependent network resource. Private endpoints and other networking resources can have separate move restrictions. Treat a subscription move as a resource-move project, not as a storage network-rule update.

## Related content

- [Azure Storage network security](https://learn.microsoft.com/azure/storage/common/storage-network-security-overview)
- [Azure Storage firewall rules and network access control](https://learn.microsoft.com/azure/storage/common/storage-network-security)
- [Use private endpoints for Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-private-endpoints)
- [Network Security Perimeter for Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-network-security-perimeter)
- [Trusted Azure services for Azure Storage network security](https://learn.microsoft.com/azure/storage/common/storage-network-security-trusted-azure-services)
