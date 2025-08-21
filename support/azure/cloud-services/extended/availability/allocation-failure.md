---
title: Allocation failure in Azure Cloud Services
description: This article helps troubleshoot allocation failure in Azure Cloud Services (extended support).
ms.service: azure-cloud-services-extended-support
author: surbhijain16
ms.author: surbhijain
ms.reviewer: surbhijain16
ms.date: 04/01/2024
ms.custom: sap:Service Availability and Performance
---

# Troubleshoot allocation failure in Azure Cloud Services (extended support)

When you deploy instances to a Cloud Service (extended support) or add new web or worker role instances, Microsoft Azure allocates compute resources. You may occasionally receive errors when performing these operations even before you reach the Azure subscription limits. This article explains the causes of some of the common allocation failures and suggests possible remediation. The information may also be useful when you plan the deployment of your services.

## Background – How allocation works

The servers in Azure datacenters are partitioned into clusters. A new cloud service allocation request is attempted in multiple clusters. When the first instance is deployed to a cloud service, that cloud service gets pinned to a cluster. Any further deployments for the cloud service happens in the same cluster. In this article, this mechanism is called "pinned to a cluster." The following Diagram 1 illustrates the case of a normal allocation, which is attempted in multiple clusters. Diagram 2 illustrates the case of an allocation that's pinned to Cluster 2 because that's where the existing Cloud Service CS_1 is hosted.

   :::image type="content" source="media/allocation-failure/allocation-failure-1.png" alt-text="Screenshot that shows cluster allocation":::

## Why allocation failure happens

When an allocation request is pinned to a cluster, there's a higher chance of failing to find free resources since the available resource pool is limited to a cluster. Furthermore, if your allocation request is pinned to a cluster but the type of resource you requested isn't supported by that cluster, your request fails even if the cluster has free resource. The following Diagram 3 illustrates the case where a pinned allocation fails because the only candidate cluster doesn't have free resources. Diagram 4 illustrates the case where a pinned allocation fails because the only candidate cluster doesn't support the requested virtual machine (VM) size, even though the cluster has free resources.

   :::image type="content" source="media/allocation-failure/allocation-failure-2.png" alt-text="Screenshot that shows cluster allocation failure":::

## Troubleshooting allocation failure for cloud services

The following table highlights the error messages for allocation failure and their solutions.

| Error code | Error message |
|-------|----------------------|
| AllocationFailed | Allocation failed. We don't have sufficient capacity for the requested VM size in this region. Read more about improving likelihood of allocation success at <https://aka.ms/allocation-guidance> |
| OverconstrainedAllocationRequest | Allocation failed. VMs with the following constraints can't  be allocated, because the condition is too restrictive. Remove some constraints and try again|
| ServiceAllocationFailure | Operation failed with error code 'InternalError' and error message 'An internal execution error occurred. Retry later'|

## Common issues

Here are the common allocation scenarios that cause an allocation request to be pinned to a single cluster.

- VIP Swap – If two cloud services are tagged swappable with one another, then both of them are allocated to the same cluster. If the cluster is nearing capacity, then request for deployment of the second cloud service may fail.
- Scaling - Adding new instances to an existing cloud service must allocate in the same cluster. Small scaling requests can usually be allocated, but not always. If the cluster is nearing capacity, the request may fail.

## Solutions

1. Redeploy to a new cloud service - This solution is likely to be most successful as it allows the platform to choose from all clusters in that region.
   1. Deploy the workload to a new cloud service
   2. Update the CNAME or A record to point traffic to the new cloud service
   3. Once zero traffic is going to the old site, you can delete the old cloud service. This solution should incur zero downtime.
2. Delete swappable cloud services - This solution preserves your existing DNS name, but  causes downtime to your application.
   1. Delete both cloud services that are swappable with each other
   2. Create a new deployment for both cloud services. This re-attempts to allocation on all clusters in the region.

## Next steps

Learn how to [troubleshoot cloud service role issues by using Azure PaaS computer diagnostics data](/archive/blogs/kwill/windows-azure-paas-compute-diagnostics-data).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
