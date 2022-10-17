---
title: Common issues with running or scaling large AKS clusters
description: Common issues with running or scaling large AKS clusters
ms.date: 10/17/2022
author: pavneeta
ms.author: paahluwalia
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an azure kubernetes service customer, I want run large AKS clsuters and troubleshoot edge cases and errors concerning throttling , networking limits, performance and upgrades so that my application can run on AKS.
---

# Common issues with running or scaling large AKS clusters
This article lists common issues when running or scaling large clusters with Azure Kubernetes Service (AKS) and provides troubleshooting tips for resolving them. 

## I'm getting a quota exceeded error during creation, scale up or upgrade. What should I do?
You need to request a quota for the corresponding resource type by creating a support request in the subscription where you're trying to create/scale/upgrade. Learn more about [regional compute quota][regional compute quota]

## I'm getting an insufficientSubnetSize error while deploying an AKS cluster with advanced networking. What should I do?

This error indicates a subnet in use for a cluster no longer has available IPs within its CIDR for successful resource assignment. This issue can happen during upgrades, scale outs or node pool creation. This issue occurs as the number of free IPs in the subnet is less than the number of nodes requested times (*) the node pool's --max-pod value.

Pre-requisites: 
* To scale beyond 400 nodes, you need to use Azure CNI networking plugin 
* Plan your Virtual network and subnets to account for the no. of nodes and pods you're deploying, learn more about [planning IP addresses for your cluster][planning IP addresses for your cluster]. To reduce the overhead of subnet planning or cluster re-creation due to Ip exhaustion, use [Dynamic Ip allocation][Dynamic Ip allocation]

Mitigation: 
The following mitigation can be taken by creating new subnets. The permission to create a new subnet is required for mitigation due to the inability to update an existing subnet's CIDR range.
1.	Rebuild a new subnet with a larger CIDR range sufficient for operation goals
2.	Create a new subnet with a new desired non-overlapping range.
3.	Create a new node pool on the new subnet.
4.	Drain pods from the old node pool residing in the old subnet to be replaced.
5.	Delete the old subnet and old node pool.

## Sporadic egress connectivity failures - SNAT port exhaustion 

For clusters running at relatively large scale > 500 Nodes, we recommend them to use AKS’s Managed ANT Gateway Add-on feature as it provides for greater scalability. Azure NAT Gateway allows up to 64,512 outbound UDP and TCP traffic flows per IP address with a maximum of 16 IP addresses. 

If not using Managed NAT, you can learn more about understanding and solving for  SNAT Port exhaustion problems here - [Troubleshoot SNAT exhaustion and connection timeouts][Troubleshoot SNAT exhaustion and connection timeouts] 

## I can't scale beyond 1k Nodes using the Portal

Azure portal hasn't yet updated the experience to support the new 5000 node limit. You can scale up your clusters using the Azure CLI upto a maximum of 5000 nodes if the node limit quota for the cluster has been increased: 

1.	Create a minimum of 
node pools in the cluster (since the max. Node pool node limit is 1000)
```bash
az aks nodepool add -g MyResourceGroup -n nodepool1 --cluster-name MyManagedCluster 
```
2.	Scale up the Nodepools one at a time (ideally with five-mins sleep time between consecutive scale ups of 1000)

```bash
az aks nodepool scale --cluster-name MyManagedCluster   --name  nodepool1  --resource-group MyResourceGroup
```

## Upgrade is running but is slow

By default, AKS configures upgrades to surge with one extra node. A default value of one for the max surge settings will enable AKS to minimize workload disruption by creating an extra node before the cordon/drain of existing applications to replace an older versioned node. 

When upgrading clusters with a large no. of nodes, using the default value of max-surge means that it can take several hours to upgrade the entire cluster as AKS churns through hundreds of nodes. You can customize the max-surge property per node pool to enable a trade-off between upgrade speed and upgrade disruption. By increasing the max surge value, the upgrade process completes faster, but setting a large value for max surge may cause disruptions during the upgrade process.

```bash
# Update max surge for an existing node pool 
az aks nodepool update -n mynodepool -g MyResourceGroup --cluster-name MyManagedCluster --max-surge 5
```

## Upgrade running into Quota/5k cluster limit
[Troubleshoot QuotaExceeded error code][Troubleshoot QuotaExceeded error code]


## Internal service creation at greater than 750 Node scale is slow or fails due to timeout error

Standard Load Balancer back-end pool updates are a known performance bottleneck. AKS is working on a new capability that will allow faster creation of services/ILB at scale. You can provide us with your feedback here [AK Support for Load balancer with IP-based back-end pool][AK Support for Load balancer with IP-based back-end pool] 

Mitigation: 

It's recommended to scale down the cluster to fewer than 750 nodes and then create the internal LB for the cluster. You can create an internal LB by creating a service type LoadBalancer and the azure-load-balancer-internal annotation as shown in the following example:

Step 1. To create an internal load balancer, create a service manifest named internal-lb.yaml with the service type LoadBalancer and the azure-load-balancer-internal annotation as shown in the following example:

```YAML
apiVersion: v1
kind: Service
metadata:
  name: internal-app
  annotations:
    service.beta.kubernetes.io/azure-load-balancer-internal: "true"
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: internal-app
```

Step 2.  Deploy the internal load balancer using the kubectl apply and specify the name of your YAML manifest:

```bash
kubectl apply -f internal-lb.yaml
```

You can also provision an internal load balancer as mentioned above when the cluster is created and keep an internal load-balanced service running, enabling you to add further services to the LB at scale.


## SLB service creation at scale takes hours
Standard Load Balancer back-end pool updates are a known performance bottleneck. AKS is working on a new capability that will allow you to run load balanced services at scale with considerably faster performance for create, update and delete operations. You can provide us with your feedback here [AK Support for Load balancer with IP-based back-end pool][AK Support for Load balancer with IP-based back-end pool] 

additionalContent: |
  [!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

  [!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

<!-- Links - External -->
[regional compute quota]: quotas-skus-regions.md
[planning IP addresses for your cluster]: configure-azure-cni.md
[Dynamic Ip allocation]: configure-azure-cni.md
[Managed NAT Gateway]: nat-gateway.md
[Troubleshoot QuotaExceeded error code]: ../quotas/regional-quota-requests.md
[AK Support for Load balancer with IP-based back-end pool]: https://github.com/Azure/AKS/issues/3245
[Troubleshoot SNAT exhaustion and connection timeouts]: ..azure-docs/articles/load-balancer/troubleshoot-outbound-connection.md

