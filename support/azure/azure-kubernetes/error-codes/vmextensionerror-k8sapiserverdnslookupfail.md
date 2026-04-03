---
title: Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error message 
description: Fix the VMExtensionError_K8SAPIServerDNSLookupFail error in AKS. Learn how to resolve DNS lookup failures for NXDOMAIN, SERVFAIL, REFUSED, and timeout scenarios when creating or deploying your AKS cluster.
ms.date: 04/03/2026
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc, marcha
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error code (or error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL) so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error in AKS

## Summary

This article explains how to identify and resolve the `VMExtensionError_K8SAPIServerDNSLookupFail` error (also known as error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL) in Azure Kubernetes Service (AKS). This error occurs when cluster nodes can't resolve the Kubernetes API server's fully qualified domain name (FQDN) during cluster create, start, upgrade, or scale operations.

## Prerequisites

- A machine with network access to the cluster's virtual network (a VM in the same VNet or a peered VNet). You don't need SSH access to the cluster nodes.

- The [nslookup](/windows-server/administration/windows-commands/nslookup) or [dig](https://linuxize.com/post/how-to-use-dig-command-to-query-dns-in-linux/) DNS lookup tool.

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59 or a later version.

## Symptoms

When you try to create, start, upgrade, or scale an AKS cluster, you receive an error message similar to:
> Code="VMExtensionProvisioningError"
> 
> Message="CSE failed with 'VMExtensionError_K8SAPIServerDNSLookupFail'. Agents are unable to resolve Kubernetes API server name. <Diagnostic details>. Please see https://aka.ms/aks/vmextensionerror_k8sapiserverdnslookupfail and https://aka.ms/aks/private-cluster#hub-and-spoke-with-custom-dns for more information."

The diagnostic details can include:

- **DNS server IP address** — the DNS server that the node queried
- **Cluster FQDN** — the fully qualified domain name that failed to resolve
- **Error type** — the specific DNS failure (NXDOMAIN, SERVFAIL, REFUSED, or timeout)

Use these details to identify your scenario in the sections below.

## Identify your cluster FQDN

Before troubleshooting, find your cluster's FQDN:

```azurecli-interactive
az aks show --resource-group <resource-group-name> --name <cluster-name> --query "fqdn || privateFqdn" -o tsv
```

- **Private clusters** have an FQDN like `<name>.<id>.privatelink.<region>.azmk8s.io`
- **Public clusters** have an FQDN like `<name>-<id>.hcp.<region>.azmk8s.io`

## Diagnose the DNS failure

From any machine on the cluster's virtual network (or a peered VNet), run the following commands. You don't need SSH access to the cluster nodes.

**Step 1: Test DNS resolution of the cluster FQDN**

```bash
nslookup <cluster-fqdn> <dns-server-ip>
```

If you don't know the DNS server IP, check the VNet's DNS settings in the Azure portal, or run:

```bash
# From a Linux VM in the VNet
cat /etc/resolv.conf
```

**Step 2: Verify DNS server reachability**

```bash
nc -zv <dns-server-ip> 53
```

If the connection fails, the DNS server is unreachable (firewall, NSG, or server down).

**Step 3: Test resolution via Azure DNS directly (private clusters only)**

```bash
nslookup <cluster-fqdn> 168.63.129.16
```

If this succeeds but Step 1 fails, your custom DNS server isn't forwarding to Azure DNS correctly.

## Cause and resolution

Based on the DNS error type, follow the appropriate section below.

### NXDOMAIN — Domain not found

**What it means:** The DNS server responded that the domain doesn't exist. This is the most common cause (approximately 98% of cases).

**Root causes:**

- Missing conditional forwarder from your custom DNS server to Azure DNS (`168.63.129.16`)
- Azure Private DNS zone not linked to the cluster's virtual network
- Private DNS zone missing the A record for the cluster

**Resolution for private clusters with custom DNS:**

1. **Create a conditional forwarder** on your DNS server for the zone `privatelink.<region>.azmk8s.io` pointing to `168.63.129.16`.

   > [!NOTE]
   > Create the forwarder for the full `privatelink.<region>.azmk8s.io` zone, not for individual cluster FQDNs. Conditional forwarding doesn't support subdomains.

2. **Verify the Azure Private DNS zone** is linked to the VNet:
   - In the Azure portal, navigate to **Private DNS zones** > find the zone matching `privatelink.<region>.azmk8s.io` > **Virtual network links**
   - Confirm the cluster's VNet (or the VNet where DNS resolution is needed) is listed

3. **If this is a first-time cluster creation** and it failed, the Private DNS zone link may not have completed. Reconcile the cluster:

   ```azurecli-interactive
   az resource update --resource-group <resource-group-name> \
       --name <cluster-name> \
       --namespace Microsoft.ContainerService \
       --resource-type ManagedClusters
   ```

**Resolution for public clusters:**

Public cluster FQDNs (`*.hcp.<region>.azmk8s.io`) are publicly resolvable. If you get NXDOMAIN:

1. Verify your custom DNS server can reach public DNS resolvers (for example, `8.8.8.8` or `168.63.129.16`)
2. Check that your DNS server doesn't have a conflicting override for the `azmk8s.io` domain

### SERVFAIL — Server failure

**What it means:** The DNS server encountered an internal failure while processing the query. This can indicate an unhealthy DNS server or a broken forwarding chain.

**Root causes:**

- DNS server is overloaded or misconfigured
- Upstream forwarder is unreachable from the DNS server
- DNS server can partially resolve the name but returns an error

**Resolution:**

1. **Check DNS server health** — verify the DNS service is running and responsive
2. **Verify upstream forwarders** — ensure the DNS server can reach its configured forwarders (for example, `168.63.129.16`)
3. **Test from a different DNS server** to isolate whether the issue is server-specific:

   ```bash
   nslookup <cluster-fqdn> 168.63.129.16
   ```

4. **Review DNS server logs** for errors related to the queried domain

### REFUSED — Query refused

**What it means:** The DNS server actively refused to answer the query. This typically indicates an access control policy issue.

**Root causes:**

- DNS server ACL (access control list) blocks queries from the AKS node subnet
- DNS server policy restricts which domains can be queried
- DNS server restricts recursive queries for certain clients

**Resolution:**

1. **Check DNS ACL/policy** — ensure the AKS node subnet is allowed to query the DNS server
2. **Verify recursion settings** — confirm that recursive queries are enabled for the AKS node IP range
3. **Review DNS server security policies** for any rules that might block the `azmk8s.io` domain or `privatelink` subdomain

### Timeout — DNS server unreachable

**What it means:** The DNS server didn't respond within the timeout period. The node couldn't communicate with the DNS server at all.

**Root causes:**

- DNS server is down or not listening on port 53
- Network Security Group (NSG) blocking UDP/TCP port 53
- Firewall rule blocking DNS traffic between the AKS subnet and the DNS server
- DNS server IP is incorrect in the VNet configuration

**Resolution:**

1. **Verify DNS server reachability:**

   ```bash
   nc -zv <dns-server-ip> 53
   ```

2. **Check NSG rules** on both the AKS subnet and the DNS server subnet — ensure UDP and TCP port 53 are allowed inbound and outbound
3. **Check firewall rules** — verify no firewall (Azure Firewall, NVA, or host firewall) is blocking DNS traffic
4. **Verify DNS server is running** — confirm the DNS service is active and listening on port 53

### Mixed errors — Multiple DNS servers with different failures

If your VNet is configured with multiple DNS servers, you may see a combination of errors (for example, NXDOMAIN from one server and timeout from another). In this case:

1. **Test each DNS server individually:**

   ```bash
   nslookup <cluster-fqdn> <dns-server-ip-1>
   nslookup <cluster-fqdn> <dns-server-ip-2>
   ```

2. **Ensure all configured DNS servers** have the conditional forwarder for `privatelink.<region>.azmk8s.io`
3. **Ensure all DNS servers are reachable** from the AKS node subnet

## Reference links

- [Create a private AKS cluster](/azure/aks/private-clusters)
- [Private cluster with custom DNS — hub-and-spoke](/azure/aks/private-clusters#hub-and-spoke-with-custom-dns)
- [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)
- [Private Azure Kubernetes service with custom DNS server (Terraform example)](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
