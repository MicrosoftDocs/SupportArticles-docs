---
title: Common issues when you run or scale large AKS clusters FAQ
description: Review common issues when you run or scale large AKS clusters. The article includes troubleshooting tips for resolving these issues.
ms.date: 10/21/2022
ms.reviewer: paahluwalia, v-leedennis
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes Service customer, I want run large AKS clusters and troubleshoot edge cases and errors concerning throttling, networking limits, performance, and upgrades so that my application can run effectively on AKS.
---

# Common issues when you run or scale large AKS clusters FAQ

This article answers frequently asked questions about common issues that might occur when you run or scale large clusters in Microsoft Azure Kubernetes Service (AKS). A large cluster is any cluster that runs at more than a 500-node scale.

## I get a "quota exceeded" error during creation, scale up, or upgrade

To resolve this issue, create a support request in the subscription in which you're trying to create, scale, or upgrade, and request a quota for the corresponding resource type. For more information, see [regional compute quotas][regional compute quota].

## I get an "insufficientSubnetSize" error when I deploy an AKS cluster that uses advanced networking

This error indicates that a subnet that's in use for a cluster no longer has available IPs within its CIDR for successful resource assignment. This issue can occur during upgrades, scale outs, or node pool creation. This issue occurs because the number of free IPs in the subnet is less than the result of the following formula:

> number of nodes requested * node pool `--max-pod` value

### Prerequisites

* To scale beyond 400 nodes, you have to use the [Azure CNI networking plug-in][CNI plug-in].

* To help plan your virtual network and subnets to accommodate the number of nodes and pods that you're deploying, see [planning IP addresses for your cluster][planning IP addresses for your cluster]. To reduce the overhead of subnet planning or cluster re-creation that you would do because of IP exhaustion, see [Dynamic IP allocation][Dynamic IP allocation].

### Solution

Because you can't update an existing subnet's CIDR range, you must have permission to create a new subnet to resolve this issue. Follow these steps:

1. Rebuild a new subnet that has a larger CIDR range that's sufficient for operation goals.

2. Create a new subnet that has a new non-overlapping range.

3. Create a new node pool on the new subnet.

4. Drain pods from the old node pool that resides in the old subnet that will be replaced.

5. Delete the old subnet and old node pool.

## I'm having sporadic egress connectivity failures because of SNAT port exhaustion

For clusters that run at a relatively large scale (more than 500 nodes), we recommend that you use the AKS [Managed Network Address Translation (NAT) Gateway][Managed NAT Gateway] for greater scalability. Azure NAT Gateway allows up to 64,512 outbound UDP and TCP traffic flows per IP address, and a maximum of 16 IP addresses.

If you're not using Managed NAT, see [Troubleshoot source network address translation (SNAT) exhaustion and connection timeouts][Troubleshoot SNAT exhaustion and connection timeouts] to understand and resolve SNAT port exhaustion issues.

## I can't scale beyond 1,000 nodes by using the portal

Azure portal hasn't yet updated the experience to support the new 5,000-node limit. You can scale up your clusters by using the Azure CLI up to a maximum of 5,000 nodes if the node limit quota for the cluster was increased. Follow these steps:

1. Create a minimum number of node pools in the cluster (because the maximum node pool node limit is 1,000) by running the following command:

   ```bash
   az aks nodepool add --resource-group MyResourceGroup --name nodepool1 --cluster-name MyManagedCluster
   ```

2. Scale up the node pools one at a time. Ideally, set five minutes of sleep time between consecutive scale-ups of 1,000. Run the following command:

   ```bash
   az aks nodepool scale --resource-group MyResourceGroup --name nodepool1 --cluster-name MyManagedCluster
   ```

## My upgrade is running, but it's slow

In its default configuration, AKS surges during an upgrade by taking the following actions:

- Creating one new node.
- Scaling the node pool beyond the desired number of nodes by one node.

For the max surge settings, a default value of one node means that AKS creates one new node before it drains the existing applications and replaces an earlier-versioned node. This extra node lets AKS minimize workload disruption.

When you upgrade clusters that have a many nodes, it can take several hours to upgrade the entire cluster if you use the default value of `max-surge`. You can customize the `max-surge` property per node pool to enable a tradeoff between upgrade speed and upgrade disruption. By increasing the max surge value, you enable the upgrade process to finish sooner. However, a large value for max surge might also cause disruptions during the upgrade process.

Run the following command to increase or customize the max surge for an existing node pool:

```bash
az aks nodepool update --resource-group MyResourceGroup --name mynodepool --cluster-name MyManagedCluster --max-surge 5
```

## My upgrade is reaching the quota (5,000 cluster) limit

To resolve this issue, see [Increase regional vCPU quotas][Increase regional vCPU quotas].

## My internal service creation at more than 750 nodes is slow or failing because of a time-out error

Standard Load Balancer (SLB) back-end pool updates are a known performance bottleneck. We're working on a new capability that will enable faster creation of services and SLB at scale. To send us your feedback about this issue, see [Azure Kubernetes support for load balancer with IP-based back-end pool][AK Support for Load balancer with IP-based back-end pool].

### Solution

We recommend that you scale down the cluster to fewer than 750 nodes, and then create an internal load balancer for the cluster. To create an internal load balancer, create a `LoadBalancer` service type and `azure-load-balancer-internal` annotation, per the following example procedure.

#### Step 1: Create an internal load balancer

To create an internal load balancer, create a service manifest that's named *internal-lb.yaml* and that contains the `LoadBalancer` service type and the `azure-load-balancer-internal` annotation, as shown in the following example:

```yaml
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

#### Step 2: Deploy the internal load balancer 

Deploy the internal load balancer by using the `kubectl apply` command, and specify the name of your YAML manifest, as shown in the following example:

```bash
kubectl apply -f internal-lb.yaml
```

After your cluster is created, you can also provision an internal load balancer (per this procedure), and keep an internal load-balanced service running. Doing this enables you to add more services to the load balancer at scale.

## SLB service creation at scale takes hours to run

SLB back-end pool updates are a known performance bottleneck. We're working on a new capability that will allow you to run load balanced services at scale with considerably faster performance for create, update, and delete operations. To send us your feedback, see [Azure Kubernetes support for load balancer with IP-based back-end pool][AK Support for Load balancer with IP-based back-end pool].

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[CNI plug-in]: /azure/aks/configure-azure-cni
[regional compute quota]: /azure/quotas/regional-quota-requests
[planning IP addresses for your cluster]: /azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster
[Dynamic IP allocation]: /azure/aks/configure-azure-cni#dynamic-allocation-of-ips-and-enhanced-subnet-support
[Managed NAT Gateway]: /azure/aks/nat-gateway
[Increase regional vCPU quotas]: /azure/quotas/regional-quota-requests
[AK Support for Load balancer with IP-based back-end pool]: https://github.com/Azure/AKS/issues/3245
[Troubleshoot SNAT exhaustion and connection timeouts]: /azure/load-balancer/troubleshoot-outbound-connection
