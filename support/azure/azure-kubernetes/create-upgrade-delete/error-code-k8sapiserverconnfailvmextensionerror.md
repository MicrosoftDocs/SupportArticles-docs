---
title: Troubleshoot K8SAPIServerConnFailVMExtensionError error code (51) in AKS
description: Learn how to troubleshoot the K8SAPIServerConnFailVMExtensionError (51) when AKS nodes cant connect to the API server. Follow the steps to fix it.
ms.date: 11/13/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc, andbar, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the K8SAPIServerConnFailVMExtensionError error code (or error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) so that I can successfully create, start, scale, or upgrade an Azure Kubernetes Service (AKS) cluster or node pool.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot the "K8SAPIServerConnFailVMExtensionError" error code (51) in Azure Kubernetes Service

## Summary

This article helps you troubleshoot the `K8SAPIServerConnFailVMExtensionError` error code (also known as `ERR_K8S_API_SERVER_CONN_FAIL`, error number 51) so that you can successfully create, start, scale, or upgrade an Azure Kubernetes Service (AKS) cluster or node pool.

When AKS provisions a Linux node, the node bootstrap script (delivered through the `vmssCSE` Custom Script Extension) checks whether the node can reach the cluster's Kubernetes API server on TCP port 443 before it starts the kubelet. If the node can resolve the API server address but can't establish a connection to it, the script exits with code 51, the node isn't registered in the cluster, and the operation fails.

In most cases, this error is caused by a network configuration in the customer's environment (such as a firewall, network security group, route table, proxy, or authorized IP range) that blocks or drops traffic from the node subnet to the API server.

> [!NOTE]
> - This article applies to Linux nodes. If the node can't *resolve* the API server name, you receive a different error. For more information, see [Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)](error-code-k8sapiserverdnslookupfailvmextensionerror.md). If the node can't reach required outbound endpoints such as `mcr.microsoft.com`, see [Troubleshoot the OutboundConnFailVMExtensionError error code (50)](error-code-outboundconnfailvmextensionerror.md).
> - If your cluster uses [API Server VNet Integration](/azure/aks/api-server-vnet-integration), a blocked connection to the API server usually causes a different error. See [Clusters that use API Server VNet Integration](#clusters-that-use-api-server-vnet-integration).

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), signed in to the subscription that contains the AKS cluster.
- Permissions to read the AKS cluster and to run commands on the virtual machine scale sets (VMSS) or virtual machines (VMs) in the cluster's node resource group (for example, the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles/compute#virtual-machine-contributor) role).

The connectivity tests in this article run on the AKS nodes by using [Azure Run Command](/azure/virtual-machines/linux/run-command). They use the [curl](https://curl.se/docs/manpage.html) command-line tool (or [Netcat](https://linuxcommandlibrary.com/man/netcat) (`nc`) for clusters that use API Server VNet Integration). These tools are already included in AKS Linux node images, so you don't have to install them on your local computer or on the nodes.

## Symptoms

When you try to create, start, scale, or upgrade an AKS cluster or node pool, the operation fails and you receive an error message that resembles the following example (identifiers are replaced with placeholders, and repeated progress output is removed):

```output
Code: K8SAPIServerConnFailVMExtensionError
Message: Create or update VMSS <vmss-resource-id> failed. Multiple VM extensions failed to be provisioned on the VM. The Extensions failed due to the errors:

[Extension Name: '<vmss-name>-AKSLinuxBilling'
Error Message: The handler for VM extension type 'Microsoft.AKS.Compute.AKS.Linux.Billing' has reported terminal failure for VM extension '<vmss-name>-AKSLinuxBilling' with error message: 'Dependent Extension Microsoft.Azure.Extensions.CustomScript did not succeed. Status was error'.]

[Extension Name: 'vmssCSE'
Error Message: VM has reported a user failure when processing extension 'vmssCSE'. Please correct the error and try again. (publisher 'Microsoft.Azure.Extensions' and type 'CustomScript'). Error code: '2'. Error message: 'failed to execute command: command terminated with exit status=51
[stdout]
{ "ExitCode": "51", "Output": "...
* connect to <api-server-ip> port 443 from <node-ip> port <port> failed: Connection timed out
* Failed to connect to <api-server-fqdn> port 443 after <n> ms: Couldn't connect to server
curl: (28) Failed to connect to <api-server-fqdn> port 443 after <n> ms: Couldn't connect to server
...
API server connection check code: 51
+ exit 51", ... }
```

Key indicators of this error:

- The `vmssCSE` extension fails with `exit status=51` and the output contains `API server connection check code: 51`.
- The output shows a failed connection to the API server on port 443 (for example, `Connection timed out`, `Connection refused`, or `curl: (28) Failed to connect`).
- Other AKS extensions on the same VM (such as `AKSLinuxBilling`) might also fail with `Dependent Extension Microsoft.Azure.Extensions.CustomScript did not succeed`. This error is a side effect of the `vmssCSE` failure, not a separate problem.

In some API versions or tools, the message might begin with `Unable to establish connection from agents to Kubernetes API server, please see https://aka.ms/aks-required-ports-and-addresses for more information.` followed by `Code="VMExtensionProvisioningError"`.

## Cause

During node provisioning, the bootstrap script validates connectivity from the node to the API server before it starts the kubelet:

| Cluster configuration | Address that the node uses | Check performed by the bootstrap script |
|---|---|---|
| Public cluster | Public API server FQDN (`<dns-prefix>-<hash>.hcp.<region>.azmk8s.io`) | DNS lookup, then `curl https://<api-server-fqdn>:443` (with retries) |
| Private cluster | Private API server FQDN (for example, `<dns-prefix>-<hash>.<guid>.privatelink.<region>.azmk8s.io`) that resolves to the private endpoint IP | DNS lookup, then `curl https://<api-server-fqdn>:443` (with retries) |

If the DNS lookup fails, the script exits with code 52 or 53. If the DNS lookup succeeds but the TCP/TLS connection to port 443 can't be established within the retry period, the script exits with code 51.

The node must be able to reach the API server for AKS to work. This requirement is documented in [Outbound network and FQDN rules for AKS clusters](/azure/aks/outbound-rules-control-egress#azure-global-required-fqdn--application-rules): `*.hcp.<location>.azmk8s.io` on HTTPS port 443 is required for node-to-API server communication.

Common reasons why the connection fails include:

- **Egress filtering blocks the API server.** A firewall, network virtual appliance (NVA), or proxy on the egress path doesn't allow TCP 443 to the API server FQDN (`*.hcp.<region>.azmk8s.io`) or to the API server public IP address.
- **TLS inspection or a proxy interferes with the connection.** A device that intercepts, decrypts, or rewrites TLS traffic (including the Application-Layer Protocol Negotiation (ALPN) extension) to the API server breaks the connection.
- **Network security group (NSG) rules deny the traffic.** An outbound rule on the node subnet or NIC blocks TCP 443 from the nodes to the API server.
- **User-defined routes (UDRs) send traffic to the wrong next hop.** A route table on the node subnet sends API server traffic to an NVA that drops it, routes it asymmetrically, or has no path to the destination.
- **API server authorized IP ranges don't include the cluster's egress IP.** If [authorized IP ranges](/azure/aks/api-server-authorized-ip-ranges) are enabled and the nodes egress through an IP address that isn't in the list (for example, the public IP of an Azure Firewall, NAT gateway, or other NVA), the API server rejects the connection.
- **(Private clusters) The private FQDN resolves to the wrong IP address.** Custom DNS servers or a manually managed private DNS zone return an outdated or incorrect IP address, so the node connects to an address where the API server isn't listening.
- **(Private clusters) The node can't reach the private endpoint.** For example, NSG rules or UDRs block traffic to the private endpoint IP, or the private endpoint is in a peered VNet that isn't reachable from the node subnet.

## Solution

### Step 1: Gather cluster information

1. Get the API server endpoints and the network configuration of the cluster by running the [az aks show](/cli/azure/aks#az-aks-show) command:

    ```azurecli
    az aks show \
        --resource-group <resource-group> \
        --name <cluster-name> \
        --query "{fqdn:fqdn, privateFqdn:privateFqdn, nodeResourceGroup:nodeResourceGroup, outboundType:networkProfile.outboundType, privateCluster:apiServerAccessProfile.enablePrivateCluster, vnetIntegration:apiServerAccessProfile.enableVnetIntegration, authorizedIpRanges:apiServerAccessProfile.authorizedIpRanges}" \
        --output json
    ```

    Use the output to determine the API server FQDN that the nodes use:

    - **Public cluster**: Use the `fqdn` value.
    - **Private cluster**: Use the `privateFqdn` value. If `privateFqdn` is empty (for example, when the private DNS zone is set to `none`), use the `fqdn` value.

    If `vnetIntegration` is `true`, see [Clusters that use API Server VNet Integration](#clusters-that-use-api-server-vnet-integration) instead.

    The error message usually contains the API server FQDN that the node tried to reach (for example, `Failed to connect to <api-server-fqdn> port 443`).

1. Identify the node pool instances that failed provisioning.

    - For node pools that use **Virtual Machine Scale Sets** (default):

        ```azurecli
        az vmss list \
            --resource-group <node-resource-group> \
            --query "[].{name:name, nodePool:tags.\"aks-managed-poolName\", provisioningState:provisioningState}" \
            --output table

        az vmss list-instances \
            --resource-group <node-resource-group> \
            --name <vmss-name> \
            --query "[].{instanceId:instanceId, name:name, provisioningState:provisioningState}" \
            --output table
        ```

    - For [Virtual Machines node pools](/azure/aks/virtual-machines-node-pools):

        ```azurecli
        az vm list \
            --resource-group <node-resource-group> \
            --query "[?tags.\"aks-managed-poolName\"=='<node-pool-name>'].{name:name, provisioningState:provisioningState}" \
            --output table
        ```

### Step 2: Test connectivity from the node to the API server

Because the node didn't register in the cluster, you can't use `kubectl debug` to access it. Instead, use [Azure Run Command](/azure/virtual-machines/linux/run-command) to run the same check that the bootstrap script runs.

> [!NOTE]
> - The VM or VMSS instance must still exist and be running. If AKS already removed the failed instance, run the tests from a test VM that you deploy in the same node subnet (with the same NSG and route table).
> - Run Command returns only the last 4,096 bytes of output, and only one Run Command can run on a VM at a time.
> - The `--query "value[0].message" --output tsv` parameters in the following commands print the command output as readable text instead of JSON.

The following command is the same check that the bootstrap script runs. It sends an HTTPS request to the API server FQDN by using the cluster certificate authority (`/etc/kubernetes/certs/ca.crt`) that's already on the node. The verbose (`-v`) output shows the IP address that the FQDN resolves to and where the connection fails, so a separate DNS lookup isn't required. The `--max-time 30` parameter stops the test after 30 seconds if the API server doesn't respond.

- For a **Virtual Machine Scale Sets** node pool, run the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command:

    ```azurecli
    az vmss run-command invoke \
        --resource-group <node-resource-group> \
        --name <vmss-name> \
        --instance-id <instance-id> \
        --command-id RunShellScript \
        --scripts "curl -v --max-time 30 --cacert /etc/kubernetes/certs/ca.crt https://<api-server-fqdn>:443" \
        --query "value[0].message" \
        --output tsv
    ```

- For a **Virtual Machines** node pool, run the [az vm run-command invoke](/cli/azure/vm/run-command#az-vm-run-command-invoke) command:

    ```azurecli
    az vm run-command invoke \
        --resource-group <node-resource-group> \
        --name <vm-name> \
        --command-id RunShellScript \
        --scripts "curl -v --max-time 30 --cacert /etc/kubernetes/certs/ca.crt https://<api-server-fqdn>:443" \
        --query "value[0].message" \
        --output tsv
    ```

If the node can reach the API server, the `[stdout]` section contains an `Unauthorized` response from the API server, and the `[stderr]` section shows a successful connection. The `401` response is expected because the request is anonymous. The following example is abbreviated:

```output
Enable succeeded:
[stdout]
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "Unauthorized",
  "reason": "Unauthorized",
  "code": 401
}
[stderr]
* Host <api-server-fqdn>:443 was resolved.
* IPv4: <api-server-ip>
*   Trying <api-server-ip>:443...
* Connected to <api-server-fqdn> (<api-server-ip>) port 443
...
*  SSL certificate verify ok.
...
< HTTP/2 401
...
```

If the node can't reach the API server, the `[stdout]` section is empty and curl reports the error at the end of the `[stderr]` section. For example:

```output
Enable succeeded:
[stdout]

[stderr]
* Host <api-server-fqdn>:443 was resolved.
* IPv4: <api-server-ip>
*   Trying <api-server-ip>:443...
* Connection timed out after 30001 milliseconds
* Closing connection
curl: (28) Connection timed out after 30001 milliseconds
```

> [!NOTE]
> `Enable succeeded` only means that Run Command ran the script. It doesn't mean that the connectivity test passed.

#### Review the node provisioning log (optional)

To see the exact command and output of the failed check, review the end of the node provisioning log:

```azurecli
az vmss run-command invoke \
    --resource-group <node-resource-group> \
    --name <vmss-name> \
    --instance-id <instance-id> \
    --command-id RunShellScript \
    --scripts "grep -E 'curl -v --cacert|API server connection check code' /var/log/azure/cluster-provision.log | tail -n 20" \
    --query "value[0].message" \
    --output tsv
```

For a Virtual Machines node pool, use `az vm run-command invoke --resource-group <node-resource-group> --name <vm-name>` with the same `--command-id`, `--scripts`, `--query`, and `--output` values.

### Step 3: Interpret the results

| Result | Meaning | Next step |
|---|---|---|
| curl returns an HTTP response (for example, `HTTP/2 401` with an `Unauthorized` status) | The node can now reach the API server. The issue might have been transient or already fixed. | Retry the operation (see [Step 5](#step-5-retry-the-operation)). |
| `curl: (6) Could not resolve host` | The node can't resolve the API server name. | See [Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)](error-code-k8sapiserverdnslookupfailvmextensionerror.md). |
| The IP address in the `IPv4:` or `Trying` line isn't the expected API server IP address (private clusters) | DNS returns an incorrect or outdated record. | Verify that the private DNS zone record matches the private endpoint IP and that custom DNS servers forward the zone to Azure DNS (`168.63.129.16`). See [Private AKS clusters](/azure/aks/private-clusters). |
| `curl: (28)` (`Connection timed out` or `Operation timed out`) | Packets are dropped on the path (NSG, firewall, NVA, UDR, or authorized IP ranges). | Go to [Step 4](#step-4-fix-the-network-configuration). |
| `curl: (7)` (`Connection refused`), `curl: (35)` or `curl: (56)` (`Connection reset by peer`) | A device on the path actively rejects or resets the connection, or the node connects to the wrong IP address. | Check firewalls, proxies, and NVAs on the path, and verify the resolved IP address. |
| A TLS error, such as `curl: (60) SSL certificate problem` or `curl: (35) ... unexpected eof while reading` | A proxy or TLS inspection device intercepts the connection. | Exclude the API server FQDN from TLS inspection, and don't modify the ALPN extension. |

### Step 4: Fix the network configuration

Based on the cluster configuration, verify the following items.

> [!TIP]
> To check Azure networking resources (NSGs, route tables, Azure Firewall, NAT gateway, load balancer, and VNet peering) along the path from a node pool to a destination, you can also run a connectivity analysis by using [Azure Virtual Network Verifier](/azure/virtual-network-manager/concept-virtual-network-verifier). This tool doesn't evaluate third-party or on-premises devices.

#### Public clusters

- If you restrict egress traffic through a firewall or NVA, allow TCP 443 to `*.hcp.<region>.azmk8s.io` (application rule) or to the API server public IP address (network rule). For the complete list of requirements, see [Outbound network and FQDN rules for AKS clusters](/azure/aks/outbound-rules-control-egress) and [Limit network traffic with Azure Firewall in AKS](/azure/aks/limit-egress-traffic).
- Make sure that NSGs on the node subnet and node NICs don't deny outbound TCP 443 to the API server.
- Make sure that TLS inspection and proxies don't intercept or alter traffic to the API server FQDN.
- If API server authorized IP ranges are enabled, make sure that the public IP address that the nodes use for egress (for example, the Azure Firewall, NAT gateway, or NVA public IP) is included. For more information, see [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges).

#### Private clusters

- Verify that the API server FQDN resolves to the private endpoint IP address from the node subnet. If you use custom DNS servers, make sure that they forward the private DNS zone to Azure DNS (`168.63.129.16`) or otherwise return the correct record.
- Make sure that NSGs and UDRs on the node subnet allow traffic to the private endpoint IP address on TCP 443, and that the traffic isn't routed through an NVA that drops it.
- For more information, see [Create a private AKS cluster](/azure/aks/private-clusters).

### Step 5: Retry the operation

After you fix the network configuration, run the connectivity test from [Step 2](#step-2-test-connectivity-from-the-node-to-the-api-server) again to confirm that the node can reach the API server. Then, retry the operation that failed (create, start, scale, or upgrade). If the cluster or node pool remains in a failed state, you can reconcile the cluster by running the [az aks update](/cli/azure/aks#az-aks-update) command without other parameters:

```azurecli
az aks update --resource-group <resource-group> --name <cluster-name>
```

## Clusters that use API Server VNet Integration

In clusters that use [API Server VNet Integration](/azure/aks/api-server-vnet-integration), the nodes connect directly to the private IP address of the API server internal load balancer in the delegated API server subnet, without a DNS lookup. The bootstrap script tests this connection by using `nc -vz <api-server-ip> 443` instead of curl, and it retries the test for longer than the time limit of the Custom Script Extension.

Because of this, if the connection is blocked, node provisioning usually fails with a Custom Script Extension timeout instead of the `K8SAPIServerConnFailVMExtensionError` error (exit code 51). For example, the error contains `CSETimeoutVMExtensionError`, `exit status=124`, `nc -vz <api-server-ip> 443`, and `CSE timeout approaching, exiting early`.

To check whether the connection to the API server is blocked, follow these steps:

1. Get the private IP address of the API server. The IP address also appears in the error message (`nc -vz <api-server-ip> 443`).

    ```azurecli
    az network lb show \
        --resource-group <node-resource-group> \
        --name kube-apiserver \
        --query "frontendIPConfigurations[].privateIPAddress" \
        --output tsv
    ```

1. Test the connection from an affected node by running the same Netcat check that the bootstrap script runs. Use the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command for a Virtual Machine Scale Sets node pool, or the [az vm run-command invoke](/cli/azure/vm/run-command#az-vm-run-command-invoke) command for a Virtual Machines node pool:

    ```azurecli
    az vmss run-command invoke \
        --resource-group <node-resource-group> \
        --name <vmss-name> \
        --instance-id <instance-id> \
        --command-id RunShellScript \
        --scripts "nc -vz -w 10 <api-server-ip> 443" \
        --query "value[0].message" \
        --output tsv
    ```

    ```azurecli
    az vm run-command invoke \
        --resource-group <node-resource-group> \
        --name <vm-name> \
        --command-id RunShellScript \
        --scripts "nc -vz -w 10 <api-server-ip> 443" \
        --query "value[0].message" \
        --output tsv
    ```

    Netcat writes its result to the `[stderr]` section. A successful test shows `Connection to <api-server-ip> 443 port [tcp/https] succeeded!`. A failed test shows an error such as `nc: connect to <api-server-ip> port 443 (tcp) timed out` or `nc: connect to <api-server-ip> port 443 (tcp) failed: Connection refused`.

1. If the test fails, check what blocks the traffic between the node subnet and the API server subnet:

    - Make sure that NSG rules on the node subnet, the node NICs, and the API server subnet allow the following communication:

        | Destination | Source | Protocol | Port |
        |---|---|---|---|
        | API server subnet CIDR | Cluster (node) subnet | TCP | 443 and 4443 |
        | API server subnet CIDR | Azure Load Balancer | TCP | 9988 |

    - Make sure that UDRs on the node subnet don't send traffic for the API server subnet through an NVA or firewall that drops it or routes it asymmetrically.

    For more information, see [API Server VNet Integration - NSG security rules](/azure/aks/api-server-vnet-integration#network-security-group-nsg-security-rules).

1. After you fix the network configuration, run the Netcat test again, and then retry the operation.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
- [Troubleshoot the OutboundConnFailVMExtensionError error code (50)](error-code-outboundconnfailvmextensionerror.md)
- [Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)](error-code-k8sapiserverdnslookupfailvmextensionerror.md)
- [Outbound network and FQDN rules for AKS clusters](/azure/aks/outbound-rules-control-egress)
- [API Server VNet Integration in AKS](/azure/aks/api-server-vnet-integration)
- [Create a private AKS cluster](/azure/aks/private-clusters)
- [Run scripts in a Linux VM by using action Run Commands](/azure/virtual-machines/linux/run-command)
