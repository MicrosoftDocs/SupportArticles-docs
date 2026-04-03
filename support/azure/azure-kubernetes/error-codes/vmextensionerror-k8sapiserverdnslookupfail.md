---
title: Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error message 
description: Fix the VMExtensionError_K8SAPIServerDNSLookupFail error in AKS. Learn how to diagnose and resolve API server name resolution failures when creating, starting, upgrading, or scaling your AKS cluster.
ms.date: 04/03/2026
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc, marcha
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error code (or error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL) so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error in AKS

## Summary

This article explains how to identify and resolve the `VMExtensionError_K8SAPIServerDNSLookupFail` error (also known as error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL) in Azure Kubernetes Service (AKS). This error occurs when cluster nodes are unable to resolve the Kubernetes API server name during cluster create, start, upgrade, or scale operations.

**In this article:**

- [Prerequisites](#prerequisites)
- [Symptoms](#symptoms)
- [Identify Your Cluster FQDN](#identify-your-cluster-fqdn)
- [Diagnose the Resolution Failure](#diagnose-the-resolution-failure)
- [Cause and Resolution by Error Type](#cause-and-resolution-by-error-type)
  - [NXDOMAIN — Domain Not Found](#nxdomain--domain-not-found)
  - [SERVFAIL — Server Failure](#servfail--server-failure)
  - [REFUSED — Query Refused](#refused--query-refused)
  - [Timeout — DNS Server Unreachable](#timeout--dns-server-unreachable)
  - [Mixed Errors — Multiple DNS Servers with Different Failures](#mixed-errors--multiple-dns-servers-with-different-failures)
- [Reference Links](#reference-links)

## Prerequisites

- (Private clusters only) A machine with network access to the cluster's virtual network (a VM in the same VNet or a peered VNet) to test DNS resolution. You don't need SSH access to the cluster nodes.

- The [nslookup](/windows-server/administration/windows-commands/nslookup) or [dig](https://linuxize.com/post/how-to-use-dig-command-to-query-dns-in-linux/) DNS resolution tool.

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59 or a later version.

## Symptoms

When you try to create, start, upgrade, or scale an AKS cluster, you receive an error message similar to:
> Message="CSE failed with 'VMExtensionError_K8SAPIServerDNSLookupFail'. Agents are unable to resolve Kubernetes API server name. \<Diagnostic Details\>. Please see https://aka.ms/aks/vmextensionerror_k8sapiserverdnslookupfail and https://aka.ms/aks/private-cluster#hub-and-spoke-with-custom-dns for more information."

The diagnostic details can include:

- **DNS server IP address** — the DNS server that the node queried
- **Cluster FQDN** — the fully qualified domain name that failed to resolve
- **Error type** — the specific resolution failure (NXDOMAIN, SERVFAIL, REFUSED, or timeout)

Use these details to identify your scenario in the sections below.

## Identify Your Cluster FQDN

Before troubleshooting, find your cluster's FQDN using one of the following methods:

**Azure CLI:**

```azurecli-interactive
az aks show --resource-group <resource-group-name> --name <cluster-name> --query "fqdn || privateFqdn" -o tsv
```

**Azure portal:**

1. Navigate to **Kubernetes services** > select your cluster
2. On the **Overview** page, find the **API server address** field — this is your cluster FQDN

**Cluster FQDN formats:**

- **Private clusters** have an FQDN like `<name>.<id>.privatelink.<region>.azmk8s.io`
- **Public clusters** have an FQDN like `<name>-<id>.hcp.<region>.azmk8s.io`

## Diagnose the Resolution Failure

From any machine on the cluster's virtual network (or a peered VNet), run the following commands. You don't need SSH access to the cluster nodes.

**Step 1: Test DNS resolution of the cluster FQDN**

```bash
nslookup <cluster-fqdn>
```

If resolution fails, test against a specific DNS server to narrow down the issue:

```bash
nslookup <cluster-fqdn> <dns-server-ip>
```

If you don't know the DNS server IP, check the VNet's DNS settings in the Azure portal or query it from a VM in the VNet:

**Azure portal:**

1. Navigate to **Virtual networks** > select the cluster's VNet
2. Under **Settings**, select **DNS servers**
3. Note the configured DNS server IP addresses (if set to **Custom**) or **Default (Azure-provided)** if using Azure DNS

**From a VM in the VNet:**

```bash
# Linux
cat /etc/resolv.conf
```

```powershell
# Windows (PowerShell)
Get-DnsClientServerAddress -AddressFamily IPv4
```

**Step 2: Verify DNS server reachability**

```bash
# Linux
nc -zv <dns-server-ip> 53
```

```powershell
# Windows (PowerShell)
Test-NetConnection -ComputerName <dns-server-ip> -Port 53
```

If the connection fails, the DNS server is unreachable (firewall, NSG, or server down).

**Step 3: Test resolution via Azure DNS directly (private clusters only)**

```bash
nslookup <cluster-fqdn> 168.63.129.16
```

If this succeeds but Step 1 fails, your custom DNS server isn't forwarding to Azure DNS correctly.

## Cause and Resolution by Error Type

This error occurs when cluster nodes are unable to resolve the API server FQDN via DNS. The root cause depends on your cluster type (public or private) and DNS configuration. Based on the DNS error type from the diagnostic details or your `nslookup` test, follow the appropriate section below.

On your DNS servers and firewall, make sure that nothing blocks the resolution to your cluster's FQDN. Your custom DNS server might be incorrectly configured if something is blocking even after you run the `nslookup` command and apply any necessary fixes. For help configuring your custom DNS server, review the following articles:

- [Create a private AKS cluster](/azure/aks/private-clusters)
- [Private Azure Kubernetes Service cluster with custom DNS server (Terraform example)](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
- [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

When you use a private cluster that has a custom DNS, an Azure Private DNS zone is created for the cluster. The DNS zone must be linked to the virtual network. This linking occurs after the cluster is created, so creating a private cluster with custom DNS may fail during initial creation. You can restore the creation process to a "success" state by reconciling the cluster (see the [NXDOMAIN](#nxdomain--domain-not-found) section below).

### NXDOMAIN — Domain Not Found

**What it means:** The DNS server responded that the domain doesn't exist. This is the most common cause (approximately 98% of cases).

**Common root causes:**

- Custom DNS server doesn't have a forwarder configured for the cluster's FQDN zone
- (Private clusters) Azure Private DNS zone not linked to the cluster's virtual network
- (Private clusters) Private DNS zone missing the A record for the cluster
- (Public clusters) Custom DNS server can't reach public DNS resolvers

**Resolution:**

1. **Verify your DNS server can resolve the cluster FQDN.** Test from a VM in the VNet:

   ```bash
   nslookup <cluster-fqdn> <dns-server-ip>
   ```

   If it fails, your DNS server needs a forwarding rule for the cluster's FQDN zone.

2. **Ensure your custom DNS server forwards queries it can't resolve.** Your DNS server must be able to resolve the cluster FQDN, either directly or by forwarding to an upstream resolver:

   - For **private clusters** — create a conditional forwarder for the zone `privatelink.<region>.azmk8s.io` pointing to Azure DNS (`168.63.129.16`). Azure DNS resolves the Private DNS zone records for your cluster.

     > [!NOTE]
     > Create the forwarder for the full `privatelink.<region>.azmk8s.io` zone, not for individual cluster FQDNs. Conditional forwarding doesn't support subdomains.

   - For **public clusters** — ensure your DNS server forwards unresolved queries to a public DNS resolver (for example, `8.8.8.8` or `1.1.1.1`). Public cluster FQDNs (`*.hcp.<region>.azmk8s.io`) are publicly resolvable.

   - For **both cluster types** — check that your DNS server doesn't have a conflicting override or stub zone for the `azmk8s.io` domain that could intercept resolution.

3. **Verify the Azure Private DNS zone link** (private clusters only):
   - In the Azure portal, navigate to **Private DNS zones** > find the zone matching `privatelink.<region>.azmk8s.io` > **Virtual network links**
   - Confirm the cluster's VNet (or the VNet where DNS resolution is needed) is listed

4. **If this is a first-time cluster creation** and it failed, the Private DNS zone link may not have completed. Reconcile the cluster:

   ```azurecli-interactive
   az resource update --resource-group <resource-group-name> \
       --name <cluster-name> \
       --namespace Microsoft.ContainerService \
       --resource-type ManagedClusters
   ```

### SERVFAIL — Server Failure

**What it means:** The DNS server encountered an internal failure while processing the query. This can indicate an unhealthy DNS server or a broken forwarding chain.

**Root causes:**

- DNS server is overloaded or misconfigured
- Upstream forwarder is unreachable from the DNS server
- DNS server can partially resolve the name but returns an error

**Resolution:**

1. **Check DNS server health** — verify the DNS service is running and responsive
2. **Verify upstream forwarders** — ensure the DNS server can reach its configured upstream resolvers (for example, `168.63.129.16` for private clusters, or `8.8.8.8`/`1.1.1.1` for public clusters)
3. **Test from another DNS server** to isolate whether the issue is specific to one server. If your VNet has multiple DNS servers configured, try querying a different one:

   ```bash
   nslookup <cluster-fqdn> <other-dns-server-ip>
   ```

   If the other server resolves successfully, the issue is with the failing DNS server — check its configuration and logs.

4. **Review DNS server logs** for errors related to the queried domain

### REFUSED — Query Refused

**What it means:** The DNS server actively refused to answer the query. This typically indicates an access control policy issue.

**Root causes:**

- DNS server ACL (access control list) blocks queries from the AKS node subnet
- DNS server policy restricts which domains can be queried
- DNS server restricts recursive queries for certain clients

**Resolution:**

1. **Check DNS ACL/policy** — ensure the AKS node subnet is allowed to query the DNS server
2. **Verify recursion settings** — confirm that recursive queries are enabled for the AKS node IP range
3. **Review DNS server security policies** for any rules that might block the `azmk8s.io` domain or `privatelink` subdomain

### Timeout — DNS Server Unreachable

**What it means:** The DNS server didn't respond within the timeout period. The node couldn't communicate with the DNS server at all.

**Root causes:**

- DNS server is down or not listening on port 53
- Network Security Group (NSG) blocking UDP/TCP port 53
- Firewall rule blocking DNS traffic between the AKS subnet and the DNS server
- DNS server IP is incorrect in the VNet configuration

**Resolution:**

1. **Verify DNS server reachability:**

   ```bash
   # Linux
   nc -zv <dns-server-ip> 53
   ```

   ```powershell
   # Windows (PowerShell)
   Test-NetConnection -ComputerName <dns-server-ip> -Port 53
   ```

2. **Check NSG rules** on both the AKS subnet and the DNS server subnet — ensure UDP and TCP port 53 are allowed inbound and outbound
3. **Check firewall rules** — verify no firewall (Azure Firewall, NVA, or host firewall) is blocking DNS traffic
4. **Verify DNS server is running** — confirm the DNS service is active and listening on port 53

### Mixed Errors — Multiple DNS Servers with Different Failures

If your VNet is configured with multiple DNS servers, you may see a combination of errors (for example, NXDOMAIN from one server and timeout from another). In this case:

1. **Test each DNS server individually:**

   ```bash
   nslookup <cluster-fqdn> <dns-server-ip-1>
   nslookup <cluster-fqdn> <dns-server-ip-2>
   ```

2. **Ensure all configured DNS servers** can resolve the cluster FQDN (via correct forwarders for private clusters or upstream public resolvers for public clusters)
3. **Ensure all DNS servers are reachable** from the AKS node subnet

## Reference Links

- [Create a private AKS cluster](/azure/aks/private-clusters)
- [Private cluster with custom DNS — hub-and-spoke](/azure/aks/private-clusters#hub-and-spoke-with-custom-dns)
- [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)
- [Private Azure Kubernetes service with custom DNS server (Terraform example)](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
