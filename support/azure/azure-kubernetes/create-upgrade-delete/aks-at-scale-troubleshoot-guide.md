---
title: Troubleshoot common issues when you run or scale large AKS clusters FAQ
description: Troubleshoot common issues when you run or scale large AKS clusters, including quota, subnet, SNAT, and upgrade errors. Read the FAQ to resolve them.
ms.date: 10/26/2026
ms.reviewer: paahluwalia, mariochaves, v-leedennis, v-weizhu
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes Service customer, I want run large AKS clusters and troubleshoot edge cases and errors concerning throttling, networking limits, performance, and upgrades so that my application can run effectively on AKS.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---

# Troubleshoot common issues when you run or scale large Azure Kubernetes Service clusters

## Summary

This article helps you troubleshoot common issues that might occur when you run or scale large Azure Kubernetes Service (AKS) clusters. A large cluster is any cluster that runs at more than a 500-node scale. Use the answers to resolve quota, networking, scaling, and upgrade problems.

## I get a "quota exceeded" error during creation, scale up, or upgrade

Read the complete error code and message before requesting a quota increase.

The following guidance helps you address quota-related errors:

- If the error is QuotaExceeded or ManagedClusterCountExceedsQuotaLimit and states that the maximum number of managed clusters has been reached, request an Azure Kubernetes Service managed-cluster quota increase for the affected subscription and region.
- If the error identifies Total Regional vCPUs or a VM-family vCPU quota, review current usage for the affected region and request the applicable compute quota increase. You can review usage with the Azure portal Quotas page or az vm list-usage.

  ```bash
  az vm list-usage --location <region> --output table
  ```

- Don't treat AllocationFailed, SKUNotAvailable, InsufficientSubnetSize, or an AKS node limit as a compute-quota error. Follow the troubleshooting guidance for the error that was returned.

## I get an "InsufficientSubnetSize" error

InsufficientSubnetSize means the affected subnet doesn't have enough available addresses for the requested node-pool creation, scale, update, or upgrade operation. Use the following guidance to identify the cluster networking mode and the subnet named in the error before calculating the required capacity:

- Azure CNI Overlay: nodes receive addresses from the node subnet and pods receive addresses from the separate pod CIDR. Size the node subnet for nodes and temporary surge nodes. Size the pod CIDR for the maximum node count, including surge; Azure CNI Overlay assigns a /24 address block to each node.
- Azure CNI with a flat node subnet: the subnet provides addresses for nodes and pods. Include planned nodes and upgrade surge in the node-and-pod calculation.

  ```text
  (planned nodes + surge nodes) + ((planned nodes + surge nodes) * maxPods)
  ```

- Azure CNI Pod Subnet: calculate node-subnet and pod-subnet capacity separately according to the configured pod-subnet allocation mode.

Also reserve the Azure-reserved subnet addresses and addresses used by other connected resources. If a larger subnet is required, create a non-overlapping subnet, create a replacement node pool on that subnet, verify that its nodes and workloads are healthy, migrate workloads, delete the old node pool, and remove the old subnet only after confirming that no resources still use it.

## I'm having sporadic egress connectivity failures because of SNAT port exhaustion

For clusters that run at a relatively large scale (more than 500 nodes), use the AKS [Managed Network Address Translation (NAT) Gateway][Managed NAT Gateway] for greater scalability. Azure NAT Gateway supports up to 64,512 outbound UDP and TCP traffic flows per IP address, and a maximum of 16 IP addresses.

If you don't use Managed NAT, see [Troubleshoot source network address translation (SNAT) exhaustion and connection timeouts][Troubleshoot SNAT exhaustion and connection timeouts] to understand and resolve SNAT port exhaustion issues.

## I can't scale up to 5,000 nodes by using the Azure portal

Use Azure CLI for the node pool operations. The documented AKS limit is 5,000 nodes per virtual machine scale set cluster and 1,000 nodes per virtual machine scale set node pool. Subscription quota, regional SKU capacity, and network address capacity still apply.

Create a node pool with an explicit initial count.

```bash
az aks nodepool add --resource-group <resource-group> --cluster-name <cluster-name> --name <node-pool-name> --node-count <initial-count>
```

Scale a node pool with an explicit target count.

```bash
az aks nodepool scale --resource-group <resource-group> --cluster-name <cluster-name> --name <node-pool-name> --node-count <target-count>
```

Before each operation, verify the applicable regional and VM-family vCPU quota, target VM SKU availability, and subnet or pod-CIDR capacity. Confirm that the operation completed successfully and that the new nodes are **Ready** before starting the next scale operation. Preserve temporary capacity for future upgrades; current node count plus max surge must remain within the supported node pool scale set limit.

## My upgrade is running, but it's slow

In its default configuration, AKS surges during an upgrade by taking the following actions:

- Creating one new node.
- Scaling the node pool beyond the desired number of nodes by one node.

For the max surge settings, a default value of one node means that AKS creates one new node before it drains the existing applications and replaces an earlier-versioned node. This extra node lets AKS minimize workload disruption.

When you upgrade clusters that have many nodes, it can take several hours to upgrade the entire cluster if you use the default value of `max-surge`. You can customize the `max-surge` property per node pool to enable a tradeoff between upgrade speed and upgrade disruption. By increasing the max surge value, you enable the upgrade process to finish sooner. However, a large value for max surge might also cause disruptions during the upgrade process.

Run the following command to increase or customize the max surge for an existing node pool.

```bash
az aks nodepool update --resource-group MyResourceGroup --name mynodepool --cluster-name MyManagedCluster --max-surge 5
```

Use the operation error and node-pool state to determine where the upgrade is waiting.

The following checks help you determine why the upgrade might be waiting:

- If replacement or surge nodes aren't provisioning, check Total Regional vCPU and VM-family quota, InsufficientSubnetSize, SKUNotAvailable, AllocationFailed, and the target node readiness state.
- If old nodes aren't draining, review Pod Disruption Budgets, pod eviction errors, replacement-pod scheduling, drain timeout, and node soak settings.

Max surge controls how many extra nodes AKS can create during the rolling upgrade. A higher value can increase parallelism but also requires extra temporary VM quota, regional capacity, and subnet addresses. Change it only after confirming that the extra capacity is available and that the workload's disruption controls remain valid. Use the Activity Log, the operation error, node-pool provisioning state, and Ready nodes to validate progress.

  
## My upgrade is reaching the 5,000-node cluster limit

The 5,000-node value is the documented AKS limit for a VM scale set cluster; it's not a regional vCPU quota. A compute-quota increase doesn't raise this limit. Revise the scale or upgrade plan so that the cluster stays within the documented cluster limit. Also verify each VM scale set node pool independently: the pool's current node count plus max surge must stay within the documented 1,000-node node-pool limit.

## Internal or Standard Load Balancer service creation is slow at scale

LoadBalancer service provisioning can be slow at high node counts when the cluster uses VM scale set IP-configuration-based backend membership (nodeIPConfiguration). With IP-address-based backend membership (nodeIP), AKS adds node private IP addresses to the load balancer backend pool without updating the VM scale set network-interface configuration.

The documented nodeIP option requires a Standard Load Balancer, VM scale set node pools, and Kubernetes version 1.23 or later. Don't use nodeIP when the cluster uses Azure Private Link Service, which requires nodeIPConfiguration.

Changing the backend-pool type on an existing cluster temporarily disrupts incoming service traffic. Plan the update for an approved maintenance window and follow the current configuration procedure.

```bash
az aks update --resource-group <resource-group> --name <cluster-name> --load-balancer-backend-pool-type nodeIP
```

For more information, see [Change the inbound pool type](/azure/aks/configure-load-balancer-standard#change-the-inbound-pool-type).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

## References

- [CNI plug-in](/azure/aks/configure-azure-cni)
- [Regional compute quota](/azure/quotas/regional-quota-requests)
- [Planning IP addresses for your cluster](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster)
- [Dynamic IP allocation](/azure/aks/configure-azure-cni#dynamic-allocation-of-ips-and-enhanced-subnet-support)
- [Managed NAT Gateway](/azure/aks/nat-gateway)
- [Increase regional vCPU quotas](/azure/quotas/regional-quota-requests)
- [AK Support for Load balancer with IP-based back-end pool](https://github.com/Azure/AKS/issues/3245)
- [Troubleshoot SNAT exhaustion and connection timeouts](/azure/load-balancer/troubleshoot-outbound-connection)
