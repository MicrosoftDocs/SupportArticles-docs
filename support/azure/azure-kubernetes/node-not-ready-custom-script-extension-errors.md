---
title: Node Not Ready because of custom script extension (CSE) errors
description: Troubleshoot scenarios in which custom script extension (CSE) errors cause Node Not Ready states in an Azure Kubernetes Service (AKS) cluster node pool.
ms.date: 04/15/2022
ms.reviewer: rissing, chiragpa, momajed, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-node-not-ready
ms.custom: devx-track-azurecli
#Customer intent: As an Azure Kubernetes user, I want to prevent custom script extension (CSE) errors so that I can avoid a Node Not Ready state within a node pool,  and avoid a Cluster Not in Succeeded state within Azure Kubernetes Service (AKS).
---
# Troubleshoot node not ready failures caused by CSE errors

This article helps you troubleshoot scenarios in which a Microsoft Azure Kubernetes Service (AKS) cluster isn't in the `Succeeded` state and an AKS node isn't ready within a node pool because of custom script extension (CSE) errors.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

Because of CSE errors, an AKS cluster node isn't ready within a node pool, and the AKS cluster isn't in the `Succeeded` state.

## Cause

The node extension deployment fails and returns more than one error code when you provision the [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) and other components. This is the most common cause of errors. To verify that the node extension deployment is failing when you provision the kubelet, follow these steps:

1. To better understand the current failure on the cluster, run the [az aks show](/cli/azure/aks#az-aks-show) and [az resource update](/cli/azure/resource#az-resource-update) commands to set up debugging:

    ```azurecli
    clusterResourceId=$(az aks show \
        --resource-group <resource-group-name> --name <cluster-name> --output tsv --query id)
    az resource update --debug --verbose --ids $clusterResourceId
    ```

1. Check the debugging output and the error messages that you received from the `az resource update` command against the error list in the [CSE helper](https://github.com/Azure/AgentBaker/blob/1bf9892afd715a34e0c6b7312e712047f10319ce/parts/linux/cloud-init/artifacts/cse_helpers.sh) executable file on GitHub.

If any of the errors involve the CSE deployment of the kubelet, then you've verified that the scenario that's described here is the cause of the Node Not Ready failure.

In general, exit codes identify the specific issue that's causing the failure. For example, you'll see messages such as "Unable to communicate with API server" or "Unable to connect to internet." Or the exit codes might alert you to API network time-outs, or a node fault that needs a replacement.

## Solution 1: Make sure your custom DNS server is configured correctly

Set up your custom Domain Name System (DNS) server so that it can do name resolution correctly. Configure the server to meet the following requirements:

- If you're using custom DNS servers, make sure that the servers are healthy and reachable over the network.

- Make sure that custom DNS servers have the required [conditional forwarders to the Azure DNS IP address](/azure/private-link/private-endpoint-dns#on-premises-workloads-using-a-dns-forwarder) (or the forwarder to that address).

- Make sure that your private AKS DNS zone is linked to your custom DNS virtual networks if they're hosted on Azure.

- Don't use the Azure DNS IP address with the IP addresses of your custom DNS server. Doing this isn't recommended.

- Avoid using IP addresses instead of the DNS server in DNS settings. You can use Azure CLI commands to check for this situation on a virtual machine (VM) scale set or availability set.

  - For VM scale set nodes, use the [az vmss run-command invoke](/cli/azure/vmss/run-command#az-vmss-run-command-invoke) command:

    ```azurecli
    az vmss run-command invoke \
        --resource-group <resource-group-name> \
        --name <vm-scale-set-name> \
        --command-id RunShellScript \
        --instance-id 0 \
        --output tsv \
        --query "value[0].message" \
        --scripts "telnet <dns-ip-address> 53"
    az vmss run-command invoke \
        --resource-group <resource-group-name> \
        --name <vm-scale-set-name> \
        --instance-id 0 \
        --command-id RunShellScript \
        --output tsv \
        --query "value[0].message" \
        --scripts "nslookup <api-fqdn> <dns-ip-address>"
    ```

  - For VM availability set nodes, use the [az vm run-command invoke](/cli/azure/vm/run-command#az-vm-run-command-invoke) command:

    ```azurecli
    az vm run-command invoke \
        --resource-group <resource-group-name> \
        --name <vm-availability-set-name> \
        --command-id RunShellScript \
        --output tsv \
        --query "value[0].message" \
        --scripts "telnet <dns-ip-address> 53"
    az vm run-command invoke \
        --resource-group <resource-group-name> \
        --name <vm-availability-set-name> \
        --command-id RunShellScript \
        --output tsv \
        --query "value[0].message" \
        --scripts "nslookup <api-fqdn> <dns-ip-address>"
    ```

For more information, see [Name resolution for resources in Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances) and [Hub and spoke with custom DNS](/azure/aks/private-clusters#hub-and-spoke-with-custom-dns).

## Solution 2: Fix API network time-outs

Make sure that the API server can be reached and isn't subject to delays. To do this, follow these steps:

- Check the AKS subnet to see whether the assigned network security group (NSG) is blocking the egress traffic port 443 to the API server.

- Check the node itself to see whether the node has another NSG that's blocking the traffic.

- Check the AKS subnet for any assigned route table. If a route table has a network virtual appliance (NVA) or firewall, make sure that port 443 is available for egress traffic. For more information, see [Control egress traffic for cluster nodes in AKS](/azure/aks/limit-egress-traffic).

- If the DNS resolves names successfully and the API is reachable, but the node CSE failed because of an API time-out, take the appropriate action as shown in the following table.

  | Set type | Action |
  | -------- | ------ |
  | VM availability set | Delete the node from the Azure portal and the AKS API by using the [kubectl delete](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#delete) node command, and then scale up the cluster again. |
  | VM scale set | Either reimage the node, or delete the node, and then scale up the cluster again. |

- If the requests are being throttled by the AKS API server, upgrade to a higher service tier. For more information, see [AKS Uptime SLA](/azure/aks/uptime-sla).

## More information

- For general troubleshooting steps, see [Basic troubleshooting of Node Not Ready failures](node-not-ready-basic-troubleshooting.md).
