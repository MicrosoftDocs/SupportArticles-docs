---
title: Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error message 
description: Fix the VMExtensionError_K8SAPIServerDNSLookupFail error in AKS. Diagnose API server DNS failures during create, start, upgrade, or scale operations. Learn more.
ms.date: 07/01/2026
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error code (or error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL) so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error in Azure Kubernetes Service 

## Summary

This article explains how to identify and resolve the `VMExtensionError_K8SAPIServerDNSLookupFail` error (also known as error code `ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL`) in Azure Kubernetes Service (AKS). This error occurs when cluster nodes can't resolve the Kubernetes API server name during cluster create, start, upgrade, or scale operations.

## Prerequisites

- (Private clusters only.) A machine with network access to the cluster's virtual network (VNet) (a virtual machine (VM) in the same VNet or a peered VNet) to test DNS resolution. You don't need Secure Shell (SSH) access to the cluster nodes.

- The [nslookup](/windows-server/administration/windows-commands/nslookup) or [dig](https://linuxize.com/post/how-to-use-dig-command-to-query-dns-in-linux/) DNS resolution tool.

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59, or a later version.

## Symptoms

When you try to create, start, upgrade, or scale an AKS cluster, you receive an error message like the following:

> Agents are unable to resolve Kubernetes API server name. It's likely custom DNS server is not correctly configured, please see <https://aka.ms/aks/private-cluster#hub-and-spoke-with-custom-dns> for more information.
>
> Code: "VMExtensionProvisioningError"
>
> Message: CSE failed with 'VMExtensionError_K8SAPIServerDNSLookupFail'. Agents are unable to resolve Kubernetes API server name. It's likely custom DNS server is not correctly configured, please see https://aka.ms/aks/vmextensionerror_k8sapiserverdnslookupfail and https://aka.ms/aks/private-cluster#hub-and-spoke-with-custom-dns for more information.
> 
> "In some logs, this may also appear as exit status=52 / ExitCode: 52"

The diagnostic details can include:

- **DNS server IP address** — The DNS server that the node queried.
- **Cluster FQDN** — The fully qualified domain name that failed to resolve.
- **Error type** — The specific resolution failure (`NXDOMAIN`, `SERVFAIL`, `REFUSED`, or `timeout`).

Use these details to identify your scenario in the following sections.

## Identify your cluster fully qualified domain name

Before troubleshooting, find your cluster's fully qualified domain name (FQDN) using one of the following methods.

**Use Azure CLI**

```azurecli-interactive
az aks show --resource-group <resource-group-name> --name <cluster-name> --query "fqdn || privateFqdn" -o tsv
```

**Use the Azure portal**

1. In the [Azure portal](https://portal.azure.com), go to **Kubernetes services** and select your cluster.
1. On the **Overview** page, find the **API server address** field which shows your cluster FQDN.

**Review cluster FQDN formats**

- **Private clusters** have an FQDN like `<name>.<id>.privatelink.<region>.azmk8s.io`.
- **Public clusters** have an FQDN like `<name>-<id>.hcp.<region>.azmk8s.io`.

## Diagnose the resolution failure

From any machine on the cluster's virtual network (or a peered VNet), perform the following steps. 

> [!NOTE]
> You don't need SSH access to the cluster nodes.

1. **Test DNS resolution of the cluster FQDN**

Run this command to test if the cluster FQDN resolves.

```bash
nslookup <cluster-fqdn>
```

If resolution fails, test against a specific DNS server to narrow down the issue.

```bash
nslookup <cluster-fqdn> <dns-server-ip>
```

If you don't know the DNS server IP, check the VNet's DNS settings in the Azure portal or query it from a VM in the VNet.

**Use the Azure portal**

1. Go to **Virtual networks** and select the cluster's VNet.
2. In **Settings**, select **DNS servers**.
3. Note the configured DNS server IP addresses (if set to **Custom**) or **Default (Azure-provided)** if using Azure DNS.

**View from a VM in the VNet**

Run the following commands.

```bash
# Linux
cat /etc/resolv.conf
```

```powershell
# Windows (PowerShell)
Get-DnsClientServerAddress -AddressFamily IPv4
```

1. **Verify DNS server reachability**

Run the following commands.

```bash
# Linux
nc -zv <dns-server-ip> 53
```

```powershell
# Windows (PowerShell)
Test-NetConnection -ComputerName <dns-server-ip> -Port 53
```

If the connection fails, the DNS server is unreachable (firewall, network security group (NSG), or the server is down).

1. **Test resolution using Azure DNS directly (private clusters only)**

Run the following command.

```bash
nslookup <cluster-fqdn> 168.63.129.16
```

If this test succeeds but the DNS resolution fails, your custom DNS server isn't forwarding to Azure DNS correctly.

## Cause and resolution by error type

This error occurs when cluster nodes can't resolve the API server FQDN by using DNS. The root cause depends on your cluster type (public or private) and DNS configuration. Based on the DNS error type from the diagnostic details or your `nslookup` test, use the following guidance as it applies to your scenario.

On your DNS servers and firewall, make sure that nothing blocks the resolution to your cluster's FQDN. You might incorrectly configure your custom DNS server if something blocks resolution even after you run the `nslookup` command and apply any necessary fixes. For help with configuring your custom DNS server, see the following resources:

- [Create a private AKS cluster](/azure/aks/private-clusters).
- [Private Azure Kubernetes Service cluster with custom DNS server (Terraform example)](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster).
- [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

When you use a private cluster that has a custom DNS, you create an Azure Private DNS zone for the cluster. You must link the DNS zone to the virtual network. This linking occurs after the cluster is created, so creating a private cluster with custom DNS might fail during initial creation. You can restore the creation process to a `success` state by reconciling the cluster. For more information, see the following section.

### NXDOMAIN — Domain not found error

#### Symptoms

The DNS server responds that the domain doesn't exist. This error is the most common cause (about 98 percent of cases).

#### Causes

Common root causes for this error include:

- The custom DNS server doesn't have a forwarder configured for the cluster's FQDN zone.
- The Azure Private DNS zone isn't linked to the cluster's virtual network (private clusters).
- The private DNS zone is missing the `A` record for the cluster (private clusters).
- The custom DNS server can't reach public DNS resolvers (public clusters).

#### Solution

Perform the following steps to resolve this error.

1. **Verify your DNS server can resolve the cluster FQDN** 

Test from a VM in the VNet using the following command:

   ```bash
   nslookup <cluster-fqdn> <dns-server-ip>
   ```

If it fails, your DNS server needs a forwarding rule for the cluster's FQDN zone.

1. **Ensure your custom DNS server forwards queries it can't resolve** 

Your DNS server must be able to resolve the cluster FQDN, either directly or by forwarding to an upstream resolver:

   - For **private clusters** — Create a conditional forwarder for the zone `privatelink.<region>.azmk8s.io` pointing to Azure DNS (`168.63.129.16`). Azure DNS resolves the private DNS zone records for your cluster.

     > [!NOTE]
     > Create the forwarder for the full `privatelink.<region>.azmk8s.io` zone, not for individual cluster FQDNs. Conditional forwarding doesn't support subdomains.

   - For **public clusters** — Ensure your DNS server forwards unresolved queries to a public DNS resolver (for example, `8.8.8.8` or `1.1.1.1`). Public cluster FQDNs (`*.hcp.<region>.azmk8s.io`) are publicly resolvable.

   - For **both cluster types** — Check that your DNS server doesn't have a conflicting override or stub zone for the `azmk8s.io` domain that could intercept the resolution.

1. **Verify the Azure Private DNS zone link** (private clusters only)

   - In the Azure portal, go to **Private DNS zones** and find the zone matching `privatelink.<region>.azmk8s.io` > **Virtual network links**.

   - Confirm the cluster's VNet (or the VNet where DNS resolution is needed) is listed

If the cluster was created for the first time and the creation failed, the private DNS zone link might not be complete. Reconcile the cluster by using the following command to restore the cluster to a `success` state:

   ```azurecli-interactive
   az resource update --resource-group <resource-group-name> \
       --name <cluster-name> \
       --namespace Microsoft.ContainerService \
       --resource-type ManagedClusters
   ```

### SERVFAIL — Server failure error

#### Symptoms

The DNS server encountered an internal failure while processing the query. This failure can indicate an unhealthy DNS server or a broken forwarding chain.

#### Causes

Common root causes for this error include:

- The DNS server is overloaded or misconfigured.
- The upstream forwarder is unreachable from the DNS server.
- The DNS server can partially resolve the name but returns an error.

#### Solution

Perform the following steps to resolve this error.

1. **Check DNS server health**

Verify the DNS service is running and responsive.

1. **Verify upstream forwarders**

Ensure the DNS server can reach its configured upstream resolvers (for example, `168.63.129.16` for private clusters, or `8.8.8.8`/`1.1.1.1` for public clusters).

1. **Test from another DNS server** 

Isolate whether the issue is specific to one server. If your VNet has multiple DNS servers configured, try querying a different one using the following command:

   ```bash
   nslookup <cluster-fqdn> <other-dns-server-ip>
   ```

   If the other server resolves successfully, the issue is with the failing DNS server. Check its configuration and logs.

1. **Review DNS server logs** 

Check for errors related to the queried domain.

### REFUSED — Query refused error

#### Symptoms

The DNS server actively refuses to answer the query. This response typically indicates an access control policy issue.

#### Causes

Common root causes for this error include:

- The DNS server access control list (ACL) blocks queries from the AKS node subnet.
- The DNS server policy restricts which domains can be queried.
- The DNS server restricts recursive queries for certain clients.

#### Solution

Perform the following steps to resolve this error.

1. **Check DNS ACL and policy**

Ensure the AKS node subnet is allowed to query the DNS server.

1. **Verify recursion settings**

Confirm that recursive queries are enabled for the AKS node IP range.

1. **Review DNS server security policies** 

Check for any rules that block the `azmk8s.io` domain or `privatelink` subdomain.

### Timeout — DNS server unreachable error

#### Symptoms

The DNS server doesn't respond within the timeout period. The node can't communicate with the DNS server at all.

#### Causes

Common root causes for this error include:

- The DNS server is down or not listening on port 53.
- An NSG blocks UDP or TCP port 53.
- A firewall rule blocks DNS traffic between the AKS subnet and the DNS server.
- The DNS server IP is incorrect in the VNet configuration.

#### Solution

Perform the following steps to resolve this error.

1. **Verify DNS server reachability**

Run the following commands to test connectivity to the DNS server on port 53.

```bash
   # Linux
   nc -zv <dns-server-ip> 53
```

```powershell
   # Windows (PowerShell)
   Test-NetConnection -ComputerName <dns-server-ip> -Port 53
```

1. **Check NSG rules**  

Check both the AKS subnet and the DNS server subnet and ensure UDP and TCP port 53 are allowed inbound and outbound traffic.

1. **Check firewall rules**

Verify no firewall (like Azure Firewall, Network Virtual Appliance (NVA), or host firewall) is blocking DNS traffic.

1. **Verify the DNS server is running**

Confirm the DNS service is active and listening on port 53.

### Mixed errors - multiple DNS servers with different failures

#### Symptoms

If you configure your VNet with multiple DNS servers, you might see a combination of errors. For example, you might see **NXDOMAIN** from one server and timeout from another server. 

#### Solution

Perform the following steps to resolve these errors.

1. **Test each DNS server individually**

Run the following command:

   ```bash
   nslookup <cluster-fqdn> <dns-server-ip-1>
   nslookup <cluster-fqdn> <dns-server-ip-2>
   ```

1. **Ensure all configured DNS servers can resolve the cluster FQDN** 

Check for correct forwarders for private clusters or upstream public resolvers for public clusters.

1. **Ensure all DNS servers are reachable** 

Verify this condition from the AKS node subnet.

## References

- [Create a private AKS cluster](/azure/aks/private-clusters)
- [Private cluster with custom DNS—hub-and-spoke](/azure/aks/private-clusters#hub-and-spoke-with-custom-dns)
- [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)
- [Private Azure Kubernetes service with custom DNS server (Terraform example)](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
