---
title: Troubleshoot the K8SAPIServerConnFailVMExtensionError error code (51)
description: Learn how to troubleshoot the K8SAPIServerConnFailVMExtensionError error (51) during an Azure Kubernetes Service (AKS) cluster or node pool operation.
ms.date: 10/19/2026
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the K8SAPIServerConnFailVMExtensionError error code (or error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) so that I can successfully provision an Azure Kubernetes Service (AKS) cluster or node pool.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the K8SAPIServerConnFailVMExtensionError error code (51)

## Summary

This article explains how to identify and resolve the `K8SAPIServerConnFailVMExtensionError` error (also known as error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51). This error occurs when an Azure Kubernetes Service (AKS) node can't establish the API server connection that's required during node bootstrap. It can affect cluster or node pool operations such as create, start, scale, and upgrade.

## Prerequisites

- Azure CLI access that can read the AKS cluster configuration.
- A Linux host or diagnostic source that uses the same Domain Name System (DNS), routing, firewall, and egress path as the affected AKS node subnet.
- DNS lookup tools, such as `nslookup` or `dig`, and the Netcat (`nc`) command-line tool.

> [!IMPORTANT]
> A test from a local workstation validates only the workstation network path. It doesn't prove that AKS nodes can reach the API server.

## Symptoms

During an AKS cluster or node pool provisioning operation, the virtual machine (VM) extension reports `VMExtensionProvisioningError` and exit status 51. The error message resembles the following example:

> Unable to establish connection from agents to Kubernetes API server, please see <https://aka.ms/aks-required-ports-and-addresses> for more information.
>
> Details: Code="VMExtensionProvisioningError"
>
> Message="VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "**Enable failed: failed to execute command: command terminated with exit status=51**"
>
> "ExitCode": "51"

## Cause

The affected node can't establish the required connection to the managed Kubernetes API server endpoint during bootstrap. Depending on the cluster network model, this failure can be caused by one or more of the following conditions:

- DNS resolution failure.
- A blocked or incorrectly routed TCP 443 connection.
- Firewall or proxy inspection.
- Incorrect private DNS or private endpoint configuration.
- API server authorized IP ranges that don't include the cluster egress public IP address.
- Network controls between the node subnet and the delegated API server subnet for a cluster that uses API Server VNet Integration.

## Solution

### Step 1: Identify the API server network model

Run the following command to retrieve the relevant cluster configuration:

```azurecli
az aks show \
    --resource-group <resource-group> \
    --name <cluster-name> \
    --query "{fqdn:fqdn, privateFqdn:privateFqdn, privateCluster:apiServerAccessProfile.enablePrivateCluster, apiServerVnetIntegration:apiServerAccessProfile.enableVnetIntegration, authorizedIpRanges:apiServerAccessProfile.authorizedIpRanges, outboundType:networkProfile.outboundType}" \
    --output yaml
```

Use the command output to identify the applicable network model:

- **Traditional public API endpoint:** Nodes reach the API server through the AKS-required endpoint and cluster egress path.
- **Private Link-based private cluster:** The private fully qualified domain name (FQDN) must resolve to the cluster private endpoint and remain reachable from every node subnet.
- **API Server VNet Integration:** Nodes connect directly to the API server internal load balancer (ILB) in the delegated API server subnet. Node-to-API server traffic doesn't use DNS, so an FQDN-only test doesn't validate this path.

### Step 2: Test DNS resolution and TCP connectivity

For a cluster whose node path uses the API server FQDN, run the following commands from a host that uses the same network path as the affected node subnet:

```shell
nslookup <api-server-fqdn>
nc -vz -w 5 <api-server-fqdn> 443
```

If the cluster uses custom DNS servers, test both UDP and TCP DNS responses:

```shell
dig @<custom-dns-ip> <api-server-fqdn>
dig +tcp @<custom-dns-ip> <api-server-fqdn>
```

### Step 3: Troubleshoot the failing layer

Use the test results to identify the next action:

| Result | Interpretation | Action |
| --- | --- | --- |
| The DNS lookup fails or returns an unexpected IP address. | The node DNS path can't resolve the correct API server endpoint. | For a private cluster, verify the private DNS zone link or conditional forwarding to Azure DNS at `168.63.129.16`. Make sure that every node subnet can reach the custom DNS servers over UDP and TCP port 53. Verify that the managed private endpoint and DNS records weren't modified. |
| DNS resolution succeeds, but the TCP 443 connection times out or is refused. | The resolved endpoint is blocked or incorrectly routed. | Review effective routes, user-defined routes (UDRs), network security groups (NSGs), firewalls, and network virtual appliances (NVAs) from every node subnet. Allow the current AKS API server dependency for the cluster topology. For a public API endpoint that uses authorized IP ranges, include the actual cluster egress public IP address. |
| DNS resolution and TCP 443 connectivity succeed, but provisioning still fails. | Basic connectivity exists, but the node bootstrap flow can still be blocked. | Check proxies and firewalls for Transport Layer Security (TLS) inspection or Application-Layer Protocol Negotiation (ALPN) rewriting. Review the complete VM extension error, and use AKS diagnostics to identify the next blocked dependency. |

### Step 4: Apply network model-specific checks

#### Traditional public API endpoint

Allow HTTPS traffic on port 443 to the required regional AKS API server FQDN. If API server authorized IP ranges are enabled, include the cluster egress public IP address that's used by the load balancer, NAT gateway, firewall, or other outbound path.

#### Private Link-based private cluster

Confirm that the private FQDN resolves to a private IP address from the node network path. Validate the private DNS zone links or conditional forwarding, UDP and TCP port 53 connectivity, private endpoint presence, and routes or NSGs between every node subnet and the private endpoint.

API server authorized IP ranges apply only to the public API server endpoint. They don't apply to the private API server endpoint.

#### API Server VNet Integration

Don't rely on the API server FQDN test to validate node connectivity. Validate the routes between the node subnet and the delegated API server subnet. If NSGs restrict traffic within the virtual network, allow the following traffic:

| Destination | Source | Protocol | Port |
| --- | --- | --- | --- |
| API server subnet CIDR | Cluster subnet | TCP | 443 and 4443 |
| API server subnet CIDR | `AzureLoadBalancer` service tag | TCP | 9988 |

Also verify that the API server subnet has sufficient available IP addresses and that the cluster identity has the required permissions on both the API server subnet and node subnet.

### Step 5: Retry the AKS operation

After you correct the network or DNS configuration, retry the failed cluster or node pool operation. Confirm that the VM extension completes successfully.

> [!NOTE]
> If the failed operation is still running, wait for it to finish or fail before you retry. Avoid repeatedly retrying the operation while the underlying connectivity issue remains.

## More information

- [Outbound network and FQDN rules for Azure Kubernetes Service clusters](/azure/aks/outbound-rules-control-egress)
- [Create a private Azure Kubernetes Service cluster](/azure/aks/private-clusters)
- [Use API Server VNet Integration in Azure Kubernetes Service](/azure/aks/api-server-vnet-integration)
- [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges)
- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

 
