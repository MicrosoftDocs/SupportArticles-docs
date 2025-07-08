---
title: Troubleshoot the OutboundConnFailVMExtensionError error code (50)
description: Learn how to troubleshoot the OutboundConnFailVMExtensionError error (50) when you try to start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 12/30/2024
ms.reviewer: rissing, chiragpa, jaewonpark, v-leedennis, jovieir, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the OutboundConnFailVMExtensionError error code (50)

This article describes how to identify and resolve the `OutboundConnFailVMExtensionError` error (also known as error code `ERR_OUTBOUND_CONN_FAIL`, error number 50) that might occur if you create, start, scale, or upgrade a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Netcat](https://linuxcommandlibrary.com/man/netcat) (nc) command-line tool

- The [dig](https://linux.die.net/man/1/dig) command-line tool

- The Client URL ([cURL](https://curl.se/download.html)) tool

## Symptoms

When you try to create, scale, or upgrade an AKS cluster, you may receive the following error message:

> Unable to establish outbound connection from agents, please see <https://aka.ms/aks-required-ports-and-addresses> for more information.
>
> Details: Code="VMExtensionProvisioningError"
>
> Message="VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "**Enable failed: failed to execute command: command terminated with exit status=50**\n[stdout]\n\n[stderr]\nnc: connect to mcr.microsoft.com port 443 (tcp) failed: Connection timed out\nCommand exited with non-zero status
>
> Error details : "vmssCSE error messages : {**vmssCSE exit status=50, output=pt/apt.conf.d/95proxy**...}

## Cause

The custom script extension that downloads the necessary components to provision the nodes couldn't establish the necessary outbound connectivity to obtain packages. For public clusters, the nodes try to communicate with the Microsoft Container Registry (MCR) endpoint (`mcr.microsoft.com`) on port 443.

There are many reasons why the outbound traffic might be blocked. The best way to troubleshoot outbound connectivity failures is by running a connectivity analysis with [Azure Virtual Network Verifier (Preview)](/azure/virtual-network-manager/concept-virtual-network-verifier). By running a connectivity analysis, you can visualize the hops within the traffic flow and any misconfigurations within Azure networking resources that are blocking traffic. To manually troubleshoot outbound connectivity failures, you can use the Secure Shell protocol (SSH) to connect to the node. This section covers instructions for both types of investigations:

### Check if Azure network resources are blocking traffic to the endpoint

To determine if traffic is blocked to the endpoint due to Azure network resources, run a connectivity analysis from your AKS cluster nodes to the endpoint using the [Azure Virtual Network Verifier (Preview)](/azure/virtual-network-manager/concept-virtual-network-verifier) tool. The connectivity analysis covers the following resources:

- Azure Load Balancer
- Azure Firewall
- A network address translation (NAT) gateway
- Network security group (NSG)
- Network policy

> [!NOTE]
>
> Azure Virtual Network Verifier (Preview) doesn't look at any external or third-party networking resources, such as a custom firewall. After running the connectivity analysis, we recommend that you perform a manual check of any external networking to cover all hops in the traffic flow.
> 
> Currently, clusters using Azure CNI Overlay aren't supported for this feature. Support for CNI Overlay is planned for August 2025.

1. Navigate to your cluster in the Azure portal. In the sidebar, navigate to the Settings -> Node pools blade.
1. Identify the nodepool you want to run a connectivity analysis from. Click on the nodepool to select it as the scope.
1. Click on the three dots "..." in the toolbar at the top of the page. In the expanded menu, select "Connectivity analysis (Preview)."<img width="626" alt="image" src="https://github.com/user-attachments/assets/b2f05947-f753-49b9-9536-98d0b998ab52" />
1. Select a Virtual Machine Scale Set (VMSS) instance as the source. The source IP addresses are generated automatically.
1. Select a public domain name/endpoint as the destination for the analysis. The destination IP addresses are also generated automatically.
1. Run the analysis and wait up to 2 minutes for the results. In the resulting diagram, identify the associated Azure network resources and where traffic is blocked. Click on the icons to show the detailed analysis output.

### Manual troubleshooting

If the Azure Virtual Network Verifier (Preview) tool doesn't provide enough insight into the issue, you can manually troubleshoot outbound connectivity failures by using the Secure Shell protocol (SSH) to connect to the node. To make the connection, follow the instructions in [Connect to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/node-access). Then, test the connectivity on the cluster by following these steps:

1. After you connect to the node, run the `nc` and `dig` commands:

   ```bash
   nc -vz mcr.microsoft.com 443 
   dig mcr.microsoft.com 443
   ```

   > [!NOTE]  
   > If you can't access the node through SSH, you can test the outbound connectivity by running the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command against the Virtual Machine Scale Set instance:
   >
   > ```azurecli
   > # Get the VMSS instance IDs.
   > az vmss list-instances --resource-group <mc-resource-group-name> \
   >     --name <vmss-name> \
   >     --output table
   > 
   > # Use an instance ID to test outbound connectivity.
   > az vmss run-command invoke --resource-group <mc-resource-group-name> \
   >     --name <vmss-name> \
   >     --command-id RunShellScript \
   >     --instance-id <vmss-instance-id> \
   >     --output json \
   >     --scripts "nc -vz mcr.microsoft.com 443"
   > ```
1. If you try to create an AKS cluster by using an HTTP proxy, run the `nc`, `curl`, and `dig` commands after you connect to the node:
   ```bash
   # Test connectivity to the HTTP proxy server from the AKS node.
   nc -vz <http-s-proxy-address> <port>
   
   # Test traffic from the HTTP proxy server to HTTPS.
   curl --proxy http://<http-proxy-address>:<port>/ --head https://mcr.microsoft.com
   
   # Test traffic from the HTTPS proxy server to HTTPS.
   curl --proxy https://<https-proxy-address>:<port>/ --head https://mcr.microsoft.com
   
   # Test DNS functionality.
   dig mcr.microsoft.com 443
   ```
   > [!NOTE]  
   > If you can't access the node through SSH, you can test the outbound connectivity by running the `az vmss run-command invoke` command against the Virtual Machine Scale Set instance:
   >
   > ```azurecli
   > # Get the VMSS instance IDs.
   > az vmss list-instances --resource-group <mc-resource-group-name> \
   >     --name <vmss-name> \
   >     --output table
   > 
   > # Use an instance ID to test connectivity from the HTTP proxy server to HTTPS.
   > az vmss run-command invoke --resource-group <mc-resource-group-name> \
   >     --name <vmss-name> \
   >     --command-id RunShellScript \
   >     --instance-id <vmss-instance-id> \
   >     --output json \
   >     --scripts "curl --proxy http://<http-proxy-address>:<port>/ --head https://mcr.microsoft.com"
   > 
   > # Use an instance ID to test connectivity from the HTTPS proxy server to HTTPS.
   > az vmss run-command invoke --resource-group <mc-resource-group-name> \
   >     --name <vmss-name> \
   >     --command-id RunShellScript \
   >     --instance-id <vmss-instance-id> \
   >     --output json \
   >     --scripts "curl --proxy https://<https-proxy-address>:<port>/ --head https://mcr.microsoft.com"
   > 
   > # Use an instance ID to test DNS functionality.
   > az vmss run-command invoke --resource-group <mc-resource-group-name> \
   >     --name <vmss-name> \
   >     --command-id RunShellScript \
   >     --instance-id <vmss-instance-id> \
   >     --output json \
   >     --scripts "dig mcr.microsoft.com 443"
   > ```

## Solution

The following table lists specific reasons why traffic might be blocked, and the corresponding solution for each reason:

| Issue | Solution |
| ----- | -------- |
| Traffic is blocked by firewall rules, a proxy server, or Network Security Group (NSG) | This issue occurs when the AKS required ports or Fully Qualified Domain Names (FQDNs) are blocked by a firewall, proxy server, or NSG. Ensure these ports and FQDNs are allowed. To determine what's blocked, check the connectivity provided in the preceding [Cause](#cause) section. For more information about AKS required ports and FQDNs, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).|
| The AAAA (IPv6) record is blocked on the firewall | On your firewall, verify that nothing exists that would block the endpoint from resolving in Azure DNS. |
| Private cluster can't resolve internal Azure resources | In private clusters, the Azure DNS IP address (`168.63.129.16`) must be added as an upstream DNS server if custom DNS is used. Verify that the address is set on your DNS servers. For more information, see [Create a private AKS cluster](/azure/aks/private-clusters) and [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16). |

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
