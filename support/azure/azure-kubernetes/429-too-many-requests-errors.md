---
title: 429 Too Many Requests errors
description: Troubleshoot why you receive 429 Too Many Requests errors on your Kubernetes clusters.
ms.date: 5/25/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the 429 Too Many Requests errors that I'm receiving so that I can successfully use my Kubernetes cluster configured without exceeding the assigned quota for my Azure subscription.
---
# 429 Too Many Requests errors

This article discusses how to troubleshoot failures that are caused by "429 Too Many Requests" errors on your Microsoft Azure Kubernetes Service (AKS) clusters (or clusters that use another Kubernetes implementation on Azure).

## Symptoms

You receive errors that resemble the following text:

> Service returned an error.
>
> **Status=429**
>
> Code=\"OperationNotAllowed\"
>
> **Message=\"The server rejected the request because too many requests have been received for this subscription.\"**
>
> Details=[{  
> **\"code\":\"TooManyRequests\",**  
> \"message\":\"{  
> \\\"operationGroup\\\":\\\"HighCostGetVMScaleSet30Min\\\",  
> \\\"startTime\\\":\\\"2020-09-20T07:13:55.2177346+00:00\\\",  
> \\\"endTime\\\":\\\"2020-09-20T07:28:55.2177346+00:00\\\",  
> \\\"allowedRequestCount\\\":1800,  
> \\\"measuredRequestCount\\\":2208  
> }\",  
> \"target\":\"HighCostGetVMScaleSet30Min\"  
> }]
>
> **InnerError={\"internalErrorCode\":\"TooManyRequestsReceived\"}**"}

## Cause: Excessive call volumes cause Azure to throttle your subscription

A Kubernetes cluster on Azure (with or without AKS) that does a frequent scale up or scale down, or uses the cluster autoscaler, can cause a large volume of HTTP calls. This call volume can result in failure, because it exceeds the assigned quota for your Azure subscription.

For more information about these errors, see [Throttling Azure Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling) and [Troubleshooting API throttling errors](/troubleshoot/azure/virtual-machines/troubleshooting-throttling-errors).

For AKS cluster, you can use [AKS Diagnose and Solve Problems](/azure/aks/aks-diagnostics) to analyze and identify the cause of these errors and get recommendations to resolve them. In the AKS Diagnose and Solve Problems, search **"Azure Resource Request Throttling"**, where you can get a report with a series of diagnostics to show if the cluster has experienced any request rate throttling (429 responses) of Azure Resource Manager (ARM) or Resource Provider (RP), and where the throttles came from.

**Request Rate Throttling has been detected for your Cluster**: This diagnostic provides some general recommendations if there's throttling that has been detected in the current AKS cluster.

**Cluster Auto-Scaler Throttling has been detected**: This diagnostic shows up if there's throttling that has been detected and originated from the cluster autoscaler. To reduce the volume of requests from the cluster autoscaler, use the following methods:

- Increase the autoscaler scan interval to reduce the number of calls to virtual machine scale sets from the cluster autoscaler. This method may have a negative latency impact on the time taken to scale up because the cluster autoscaler waits longer before calling Azure Compute Resource Provider (CRP) for a new virtual machine.
- Make sure the cluster is on a minimal Kubernetes version 1.18. Kubernetes version 1.18 and later versions handle request rate back-off better when 429 throttling responses are received. It's highly recommended to stay within supported Kubernetes versions to receive security patches.

**Throttling - Azure Resource Manager**: This diagnostic shows the throttled request numbers in the specified time range in this AKS cluster.

**Request Rate - Azure Resource Manager**: This diagnostic shows the total request numbers in the specified time range in this AKS cluster.

**View request rate and throttle details**: This diagnostic has multiple diagrams to determine the throttling details including throttled request and total requests. You can also filter the results further by using the following dimensions:

- Host: Host where HTTP status 429 responses were detected. Azure Resource Manager throttles come from `management.azure.com`, anything else is a lower layer resource provider.
- User agent: Requests with specified user agent that were throttled.
- Operation: Operations where HTTP status 429 responses were detected.
- Client IP: Client IP address that sent the throttled requests.

Request throttling can be caused by a combination of any cluster in this subscription, not just the request rate for this cluster.

## Solution 1: Upgrade to a later version of Kubernetes

Run Kubernetes 1.18.*x* or later. These versions contain many improvements that are described in [AKS throttling/429 errors](https://github.com/Azure/AKS/issues/1413) and [Support large clusters without throttling](https://github.com/kubernetes-sigs/cloud-provider-azure/issues/247). However, if you still see throttling (due to actual load or number of clients in the subscription), you can try the following solutions.

## Solution 2: Increase the auto scaler scan interval

If you find the **Cluster Auto-Scaler Throttling has been detected** diagnostic reports throttling caused by the cluster autoscaler, you can try to increase the [auto scaler scan interval](/azure/aks/cluster-autoscaler) to reduce the number of calls to virtual machine scale sets from the cluster autoscaler.

## Solution 3: Reconfigure third-party applications to make fewer calls

When you filter by user agent in the **View request rate and throttle details** diagnostic, if you find third-party applications (such as monitoring applications) that make an excessive number of GET requests, change the settings of these applications to reduce the frequency of the GET calls. In addition, make sure that the application clients are using exponential backoff when calling Azure APIs.

## Solution 4: Split your clusters into different subscriptions or regions

If there are numerous clusters and node pools that use virtual machine scale sets, try to split the clusters into different subscriptions or regions (within the same subscription). Most of the Azure API limits are shared limits at a subscription-region level. For example, all clusters, clients within sub one and the East US region share a limit for the virtual machine scale sets GET API. Hence, you can move or scale new AKS clusters in a new region and get unblocked on Azure API throttling. This technique helps if you expect the clusters to have high activity (for example, if you have an active cluster autoscaler). It also helps if you have many clients (such as Rancher, Terraform, and so on). Since all clusters are different in their elasticity and number of clients polling Azure APIs, there's no generic guidelines on the number of clusters that you can run per subscription-region level. For specific guidance, you can create a support ticket.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
