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

## Solution 1: Upgrade to a later version of Kubernetes

Run Kubernetes 1.18.*x* or later. These versions contain many improvements that are described in [AKS throttling/429 errors](https://github.com/Azure/AKS/issues/1413) and [Support large clusters without throttling](https://github.com/kubernetes-sigs/cloud-provider-azure/issues/247).

## Solution 2: Reconfigure third-party applications to make fewer calls

If third-party applications (such as monitoring applications) make an excessive number of GET requests, change the settings of these applications to reduce the frequency of the GET calls.

## Solution 3: Split your clusters into different subscriptions

If there are numerous clusters and node pools that use virtual machine scale sets, try to split the clusters into different subscriptions. This technique helps if you expect the clusters to have high activity (for example, if you have an active cluster autoscaler). It also helps if you have many clients (such as Rancher, Terraform, and so on).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
