---
title: Troubleshoot the OutboundConnFailVMExtensionError error code (50) in AKS
description: Learn how to troubleshoot the OutboundConnFailVMExtensionError (50) when you create, start, scale, or upgrade an AKS cluster, and restore outbound connectivity.
ms.date: 10/28/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, jaewonpark, v-leedennis, jovieir, v-weizhu, andbar
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot the OutboundConnFailVMExtensionError error code (50) in Azure Kubernetes Service 

## Summary

This article helps you identify and resolve the `OutboundConnFailVMExtensionError` error (error code `ERR_OUTBOUND_CONN_FAIL`, error number 50) that might occur when you create, start, scale, or upgrade an Azure Kubernetes Service (AKS) cluster. Follow these steps to restore outbound connectivity so that node provisioning succeeds.

## Prerequisites

Ensure the following prerequisites are met before you start troubleshooting:

- The following command-line tools. Run these tools on the AKS node where they're installed by default, not on your local computer:
  - The Client URL ([cURL](https://curl.se/download.html)) tool
  - The [Netcat](https://linuxcommandlibrary.com/man/netcat) (nc) command-line tool
  - The [dig](https://linux.die.net/man/1/dig) command-line tool
- [Azure CLI](/cli/azure/install-azure-cli), if you can't connect to the node by using SSH and want to run the commands through `run-command` instead.

## Symptoms

When you try to create, scale, or upgrade an AKS cluster, you receive an error message that resembles the following example:

```output
Code: OutboundConnFailVMExtensionError
Message: Create or update virtual machine extension /subscriptions/<subscription-id>/resourceGroups/<node-resource-group>/providers/Microsoft.Compute/virtualMachines/<vm-name>/extensions/<extension-name> failed. VM has reported a user failure when processing extension '<extension-name>'. Please correct the error and try again. (publisher 'Microsoft.Azure.Extensions' and type 'CustomScript'). Error code: '2'. Error message: 'failed to execute command: command terminated with exit status=50
[stdout]
{ "ExitCode": "50", "Output": "...
+ retrycmd_if_failure 20 1 15 curl -v --insecure --proxy-insecure https://mcr.microsoft.com/v2/
...
+ exit 50", ... }

[stderr]
{"level":"ERROR","msg":"aks-node-controller failed","error":"provision failed: exitCode=50 ..."}
...
More information on troubleshooting is available at https://aka.ms/VMExtensionCSELinuxTroubleshoot.
```

The key indicators of this error are the `OutboundConnFailVMExtensionError` code, the `exit status=50` value, and the `curl` command against `https://mcr.microsoft.com/v2/` in the output. The extension name depends on the node pool type. For example, Virtual Machine Scale Sets node pools use `vmssCSE`, and Virtual Machines node pools use names such as `cse-agent-<number>`.

> [!NOTE]
> The error output shows the command that failed, but it doesn't include the output of the `curl` command itself. Therefore, the error doesn't show whether the failure occurred at the DNS, TCP, TLS, or HTTP level. To identify the exact failure point, run the same check on the node as described in the [Manual troubleshooting](#manual-troubleshooting) section.

This error might also cause your running nodes to become NotReady or cause image pull failures because outbound connectivity is blocked from some or all nodes in your cluster.

## Cause

During node provisioning, the Custom Script Extension (CSE) runs a connectivity check against the Microsoft Container Registry (MCR) endpoint by running `curl -v --insecure --proxy-insecure https://mcr.microsoft.com/v2/`. The check retries several times. If the node can't reach `mcr.microsoft.com` over HTTPS on port 443, the CSE exits with code 50, and node provisioning fails.

This outbound requirement applies to all AKS clusters, regardless of whether the cluster is public or private. The public or private setting controls only how the API server is accessed. It doesn't change the outbound connectivity that the nodes require. For the full list of the endpoints and ports that AKS nodes must reach, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

> [!NOTE]
> The CSE check targets only `mcr.microsoft.com`. However, pulling images from MCR also requires access to other endpoints, such as `*.data.mcr.microsoft.com`. If you block only these other endpoints, the node can be provisioned successfully, but image pulls fail later.

> [!TIP]
> By default, AKS clusters require outbound access to the endpoints that are listed in [Outbound network and FQDN rules for AKS clusters](/azure/aks/outbound-rules-control-egress). If your environment must not allow outbound internet traffic, consider a network isolated AKS cluster. Network isolated clusters pull the required images from a private Azure Container Registry instance, and they don't require outbound internet access. For more information, see [Create a network isolated AKS cluster](/azure/aks/network-isolated?pivots=aks-managed-acr).

Many reasons can block outbound traffic. A good starting point is to run a connectivity analysis with [Azure Virtual Network Verifier](/azure/virtual-network-manager/concept-virtual-network-verifier). By running a connectivity analysis, you can visualize the hops within the traffic flow and any misconfigurations within Azure networking resources that block traffic. To manually troubleshoot outbound connectivity failures, you can use the Secure Shell protocol (SSH) to connect to the node. This section covers instructions for both types of investigations.

### Check if Azure network resources are blocking traffic to the endpoint

To determine if Azure network resources are blocking traffic to the endpoint, run a connectivity analysis from your AKS cluster nodes to the endpoint by using the [Azure Virtual Network Verifier](/azure/virtual-network-manager/concept-virtual-network-verifier#supported-features-of-the-reachability-analysis) tool.

> [!NOTE]
> - Azure Virtual Network Verifier can't access any external or third-party networking resources, such as a custom firewall. If the connectivity analysis doesn't detect any blocked traffic, manually check any external networking to cover all hops in the traffic flow.
> - Azure Firewall is evaluated by using static layer 4 (network) rules only. Application rules (FQDN filtering) aren't evaluated. Therefore, the analysis might report that traffic is allowed even though an Azure Firewall application rule blocks it. In this case, use the steps in [Manual troubleshooting](#manual-troubleshooting).
> - Azure Virtual Network Verifier is available only in [specific regions](/azure/virtual-network-manager/concept-virtual-network-verifier).

1. In the Azure portal, go to your cluster. In the sidebar, go to **Settings** > **Node pools**.
1. Find the node pool that you want to run a connectivity analysis from. Select the node pool to set it as the scope.
1. Select **Connectivity analysis (Preview)** from the toolbar at the top of the page. If you don't see it, select the three dots (**...**) in the toolbar at the top of the page to open the expanded menu. 

:::image type="content" source="media/error-code-outboundconnfailvmextensionerror/vnet-integration-node-pools.png" alt-text="Screenshot of the node pool toolbar in the Azure portal with the Connectivity analysis (Preview) option." lightbox="media/error-code-outboundconnfailvmextensionerror/vnet-integration-node-pools.png":::

1. Select a Virtual Machine Scale Set (VMSS) instance as the source. The source IP addresses are populated automatically.
1. Select a public domain name/endpoint as the destination for the analysis, such as `mcr.microsoft.com`. The destination IP addresses are also populated automatically.
1. Run the analysis and wait up to 2 minutes for the results. In the resulting diagram, identify the associated Azure network resources and where traffic is blocked. To view the detailed analysis output, select the **JSON output** tab or select the arrows in the diagram.

### Manual troubleshooting

If the Azure Virtual Network Verifier tool doesn't provide enough insight into the issue, you can manually troubleshoot outbound connectivity failures by using the Secure Shell protocol (SSH) to connect to the node. To make the connection, follow the instructions in [Connect to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/node-access). Then, test the connectivity on the cluster by following these steps.

#### Step 1: Test outbound connectivity to MCR

After you connect to the node, run the same connectivity check that the CSE runs:

```bash
curl -v --insecure --proxy-insecure https://mcr.microsoft.com/v2/
```

If the command returns any HTTP response (for example, `HTTP/2 200`), the node can reach MCR. If the command fails, use the error in the verbose output to identify where the traffic is blocked:

| `curl` output | Likely cause |
| ------------- | ------------ |
| `Could not resolve host` | DNS resolution failure. Check your DNS configuration. |
| `Connection timed out` or `Connection refused` | Traffic is blocked at the network layer (layer 4), for example, by an NSG, a route table, or a firewall network rule. |
| The TCP connection succeeds, but the TLS handshake fails or the connection is reset (for example, `Connection reset by peer` or `SSL_ERROR_SYSCALL`) | Traffic is blocked at the application layer (layer 7), for example, by a firewall application rule that filters by FQDN, or by a proxy. |

To narrow down the issue further, you can test DNS resolution and TCP connectivity separately:

```bash
# Test DNS resolution.
dig mcr.microsoft.com

# Test TCP connectivity on port 443 (layer 4 only).
nc -vz mcr.microsoft.com 443
```

> [!IMPORTANT]
> The `nc` command tests only whether a TCP connection can be established (layer 4). It doesn't test TLS or HTTP (layer 7). If a firewall filters traffic by FQDN, `nc` can succeed even though the `curl` check that the CSE runs fails. Always use the `curl` command to confirm connectivity.

> [!NOTE]
> The CSE runs `curl` with the `--insecure` option, so TLS inspection by a firewall or proxy doesn't cause error code 50. However, TLS inspection can cause image pull failures later. To check whether TLS inspection occurs, run the `curl` command without the `--insecure` option, and verify that the certificate is issued by a public certificate authority.

If you can't access the node through SSH, you can test the outbound connectivity by running the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command against the Virtual Machine Scale Set instance:

```azurecli
# Get the VMSS instance IDs.
az vmss list-instances --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --output table

# Use an instance ID to test outbound connectivity.
az vmss run-command invoke --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --command-id RunShellScript \
    --instance-id <vmss-instance-id> \
    --output json \
    --scripts "curl -v --insecure --proxy-insecure https://mcr.microsoft.com/v2/"
```

> [!NOTE]
> These commands are for Virtual Machine Scale Sets, the default and most common node pool type in AKS. If you use a Virtual Machines node pool, adjust the commands to use [az vm run-command invoke](/cli/azure/vm/run-command#az-vm-run-command-invoke).

#### Step 2: Test connectivity through an HTTP proxy

If your AKS cluster uses an [HTTP proxy](/azure/aks/http-proxy), run the `nc`, `curl`, and `dig` commands after you connect to the node:

```bash
# Test connectivity to the proxy server from the AKS node.
nc -vz <http-s-proxy-address> <port>

# Test HTTPS traffic to MCR through an HTTP proxy server.
curl -v --proxy http://<http-proxy-address>:<port>/ --head https://mcr.microsoft.com/v2/

# Test HTTPS traffic to MCR through an HTTPS proxy server.
curl -v --proxy https://<https-proxy-address>:<port>/ --head https://mcr.microsoft.com/v2/

# Test DNS functionality.
dig mcr.microsoft.com
```

If you can't access the node through SSH, you can run the same tests by using the `az vmss run-command invoke` command against the Virtual Machine Scale Set instance (or the `az vm run-command invoke` command for Virtual Machines node pools):

```azurecli
# Get the VMSS instance IDs.
az vmss list-instances --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --output table

# Use an instance ID to test HTTPS traffic to MCR through an HTTP proxy server.
az vmss run-command invoke --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --command-id RunShellScript \
    --instance-id <vmss-instance-id> \
    --output json \
    --scripts "curl -v --proxy http://<http-proxy-address>:<port>/ --head https://mcr.microsoft.com/v2/"

# Use an instance ID to test HTTPS traffic to MCR through an HTTPS proxy server.
az vmss run-command invoke --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --command-id RunShellScript \
    --instance-id <vmss-instance-id> \
    --output json \
    --scripts "curl -v --proxy https://<https-proxy-address>:<port>/ --head https://mcr.microsoft.com/v2/"

# Use an instance ID to test DNS functionality.
az vmss run-command invoke --resource-group <mc-resource-group-name> \
    --name <vmss-name> \
    --command-id RunShellScript \
    --instance-id <vmss-instance-id> \
    --output json \
    --scripts "dig mcr.microsoft.com"
```

## Solution

The following table lists specific reasons why traffic might be blocked, and the corresponding solution for each reason:

| Issue | Solution |
| ----- | -------- |
| Traffic is blocked by firewall rules or a Network Security Group (NSG) | This issue occurs when the AKS required ports or Fully Qualified Domain Names (FQDNs) are blocked by a firewall or NSG. Ensure these ports and FQDNs are allowed. If `nc` succeeds but `curl` fails, check for firewall application rules that filter traffic by FQDN. To determine what's blocked, check the connectivity as described in the preceding [Cause](#cause) section. For more information about AKS required ports and FQDNs, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress). |
| User-defined routes send outbound traffic to a firewall or network virtual appliance (NVA) that doesn't allow it | If the cluster uses the `userDefinedRouting` outbound type, or the node subnet has a route table that sends `0.0.0.0/0` traffic to a firewall or NVA, verify that the next hop is reachable and that it allows the AKS required FQDNs and ports. For more information, see [Customize cluster egress with outbound types in AKS](/azure/aks/egress-outboundtype). |
| The HTTP proxy is misconfigured | If the cluster uses an HTTP proxy, verify that the proxy address and port are correct, that the proxy is reachable from the node subnet, and that the proxy allows the AKS required FQDNs. For more information, see [HTTP proxy support in AKS](/azure/aks/http-proxy). |
| Custom DNS servers can't resolve the required endpoints | If the virtual network uses custom DNS servers, those servers must resolve public FQDNs such as `mcr.microsoft.com`. Typically, you configure them to forward queries to Azure DNS (`168.63.129.16`). For private clusters, the custom DNS servers must also resolve the private DNS zone of the API server. For more information, see [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16) and [Create a private AKS cluster](/azure/aks/private-clusters). |
| DNS queries for the required endpoints are blocked | Verify that your firewall or DNS proxy doesn't block DNS queries, including AAAA (IPv6) record queries, for the required endpoints. |

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
