---
title: Allocation failure in Azure Cloud Services
description: Troubleshoot allocation failure in Azure Cloud Services (extended support).
ms.topic: article
ms.service: cloud-services-extended-support
author: surbhijain16
ms.author: surbhijain16
ms.reviewer: gachadw
ms.date: 01/07/2022
ms.custom: 
---

# Troubleshoot Allocation failure on Azure Cloud Services (extended support)

When you deploy instances to a Cloud Service (extended support) or add new web or worker role instances, Microsoft Azure allocates compute resources. You may occasionally receive errors when performing these operations even before you reach the Azure subscription limits. This article explains the causes of some of the common allocation failures and suggests possible remediation. The information may also be useful when you plan the deployment of your services.

## Background – How allocation works
The servers in Azure datacenters are partitioned into clusters. A new cloud service allocation request is attempted in multiple clusters. When the first instance is deployed to a cloud service, that cloud service gets pinned to a cluster. Any further deployments for the cloud service will happen in the same cluster. In this article, we'll refer to this as "pinned to a cluster". Diagram 1 below illustrates the case of a normal allocation which is attempted in multiple clusters; Diagram 2 illustrates the case of an allocation that's pinned to Cluster 2 because that's where the existing Cloud Service CS_1 is hosted.

   :::image type="content" source="media/allocation-failure/allocation-failure-1.png" alt-text="Screenshot that shows cluster allocation":::

## Why allocation failure happens
When an allocation request is pinned to a cluster, there's a higher chance of failing to find free resources since the available resource pool is limited to a cluster. Furthermore, if your allocation request is pinned to a cluster but the type of resource you requested is not supported by that cluster, your request will fail even if the cluster has free resource. Diagram 3 below illustrates the case where a pinned allocation fails because the only candidate cluster does not have free resources. Diagram 4 illustrates the case where a pinned allocation fails because the only candidate cluster does not support the requested VM size, even though the cluster has free resources.

   :::image type="content" source="media/allocation-failure/allocation-failure-2.png" alt-text="Screenshot that shows cluster allocation":::

## Troubleshooting allocation failure for cloud services
The following list highlights the error messages for allocation failure and their solutions.

| Error Code | Error Message |
|-------|----------------------|
| AllocationFailed | Allocation failed. We do not have sufficient capacity for the requested VM size in this region. Read more about improving likelihood of allocation success at http://aka.ms/allocation-guidance|
| OverconstrainedAllocationRequest | Allocation failed. VM(s) with the following constraints cannot be allocated, because the condition is too restrictive. Please remove some constraints and try again|
| ServiceAllocationFailure | Operation failed with error code 'InternalError' and errorMessage 'An internal execution error occurred. Please retry later|

## Common Issues
Here are the common allocation scenarios that cause an allocation request to be pinned to a single cluster.

- VIP Swap – If two cloud services are tagged swappable with one another, then both of them are allocated to the same cluster. If the cluster is nearing capacity, then request for deployment of the second cloud service may fail.
- Scaling - Adding new instances to an existing cloud service must allocate in the same cluster. Small scaling requests can usually be allocated, but not always. If the cluster is nearing capacity, the request may fail.

## Solutions

1. Redeploy to a new cloud service - This solution is likely to be most successful as it allows the platform to choose from all clusters in that region.
- Deploy the workload to a new cloud service
- Update the CNAME or A record to point traffic to the new cloud service
- Once zero traffic is going to the old site, you can delete the old cloud service. This solution should incur zero downtime.
2. Delete swappable cloud services - This solution will preserve your existing DNS name, but will cause downtime to your application.
- Delete both the cloud services that are swappable with each other, and then
- Create a new deployment for both cloud services. This will re-attempt to allocation on all clusters in the region. 

## Next steps

- Learn how to [troubleshoot cloud service role issues by using Azure PaaS computer diagnostics data](/archive/blogs/kwill/windows-azure-paas-compute-diagnostics-data).
