---
title: Troubleshoot 429 Too Many Requests errors in AKS
description: Troubleshoot 429 Too Many Requests errors on your AKS clusters. Learn how to identify throttling causes and apply solutions to stay within Azure subscription limits.
ms.date: 11/06/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, v-leedennis, v-weizhu, fagonzal, andraciobanu, kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the 429 Too Many Requests errors that I'm receiving so that I can successfully use my Kubernetes cluster configured without exceeding the assigned quota for my Azure subscription.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot 429 Too Many Requests errors in Azure Kubernetes Service

## Summary

This article helps you troubleshoot "429 Too Many Requests" errors on your Azure Kubernetes Service (AKS) clusters, or clusters that use another Kubernetes implementation on Azure. Learn how to identify the cause of throttling and reduce request volumes to stay within your Azure subscription quota.

## Symptoms

You receive errors that resemble the following text.

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
> \\\"startTime\\\":\\\"2026-05-20T07:13:55.2177346+00:00\\\",  
> \\\"endTime\\\":\\\"2026-05-20T07:28:55.2177346+00:00\\\",  
> \\\"allowedRequestCount\\\":1800,  
> \\\"measuredRequestCount\\\":2208  
> }\",  
> \"target\":\"HighCostGetVMScaleSet30Min\"  
> }]
>
> **InnerError={\"internalErrorCode\":\"TooManyRequestsReceived\"}**"}

## Cause: Excessive call volumes throttle your Azure subscription

A Kubernetes cluster on Azure (with or without AKS) that frequently scales up or scales down, or uses the cluster autoscaler, can generate a large volume of HTTP calls. This call volume can cause failures because it exceeds the assigned quota for your Azure subscription.

For more information about these errors, see [Throttling Azure Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling) and [Troubleshooting API throttling errors](../../virtual-machines/windows/troubleshooting-throttling-errors.md). For information about how to analyze and identify the cause of these errors and get recommendations to resolve them, see [Analyze and identify errors by using AKS Diagnose and Solve Problems](#analyze-and-identify-errors-by-using-aks-diagnose-and-solve-problems).

## Solution 1: Increase the cluster autoscaler scan interval

If you [find the "Cluster Auto-Scaler Throttling has been detected" diagnostic reports throttling](#analyze-and-identify-errors-by-using-aks-diagnose-and-solve-problems) caused by the cluster autoscaler, try increasing the [autoscaler scan interval](/azure/aks/cluster-autoscaler) to reduce the number of calls to virtual machine scale sets from the cluster autoscaler.

## Solution 2: Reconfigure third-party applications to make fewer calls

When you [filter by user agents in the "View request rate and throttle details" diagnostic](#analyze-and-identify-errors-by-using-aks-diagnose-and-solve-problems), if you find third-party applications (such as monitoring applications) that make an excessive number of GET requests, change the settings of these applications to reduce the frequency of the GET calls. Also, ensure that the application clients use exponential backoff when calling Azure APIs.

## Solution 3: Split your clusters into different subscriptions or regions

If you have numerous clusters and node pools that use virtual machine scale sets, try splitting the clusters into different subscriptions or regions (within the same subscription). Most Azure API limits are shared limits at the subscription-region level. For example, all clusters and clients within subscription one and the East US region share a limit for the virtual machine scale sets GET API. You can move or scale new AKS clusters in a new region and get unblocked on Azure API throttling. This technique helps if you expect the clusters to have high activity (for example, if you have an active cluster autoscaler). It also helps if you have many clients (such as Rancher, Terraform, and so on). Since all clusters are different in their elasticity and the number of clients polling Azure APIs, there are no generic guidelines on the number of clusters that you can run per subscription-region level. For specific guidance, you can create a support ticket.

## Analyze and identify errors by using AKS Diagnose and Solve Problems

For an AKS cluster, use [AKS Diagnose and Solve Problems](/azure/aks/aks-diagnostics) to analyze and identify the cause of errors. You can also get recommendations to resolve them. Navigate to your cluster in the Azure portal, and select **Diagnose and solve problems** in the left navigation to open AKS Diagnose and Solve Problems. Search and open **Azure Resource Request Throttling**, where you can get a report with a series of diagnostics. Those diagnostics can show if the cluster experiences any request rate throttling (429 responses) of Azure Resource Manager (ARM) or Resource Provider (RP), and where the throttling comes from. For example:

- **Request Rate Throttling has been detected for your Cluster**: This diagnostic provides some general recommendations if throttling is detected in the current AKS cluster.
- **Cluster Auto-Scaler Throttling has been detected**: This diagnostic shows up if throttling is detected and originated from the cluster autoscaler.

  To reduce the volume of requests from the cluster autoscaler, use the following methods:

  - Increase the autoscaler scan interval to reduce the number of calls from the cluster autoscaler to virtual machine scale sets. This method might negatively affect latency because the cluster autoscaler waits longer before calling Azure Compute Resource Provider (CRP) for a new virtual machine.

- **Throttling - Azure Resource Manager**: This diagnostic shows the number of throttled requests in the specified time range in the AKS cluster.
- **Request Rate - Azure Resource Manager**: This diagnostic shows the total number of requests in the specified time range in the AKS cluster.
- **View request rate and throttle details**: This diagnostic has multiple diagrams to determine the throttling details, including throttled requests and total requests. You can also filter the results by using the following dimensions:

  - Host: The host where HTTP status 429 responses were detected. Azure Resource Manager throttles come from `management.azure.com`; anything else is a lower-layer resource provider.
  - User agent: Requests with a specified user agent that were throttled.
  - Operation: Operations where HTTP status 429 responses were detected.

Request throttling can be caused by a combination of any cluster in this subscription, not just the request rate for this cluster.

### Example 1: Cluster autoscaler throttling

This example shows how to analyze throttling that the cluster autoscaler causes.

If you find the **Cluster Auto-Scaler Throttling has been detected** diagnostic in AKS **Diagnose and Solve Problems** > **Known Issues, Availability and Performance** > **Azure Resource Request Throttling**, it means the cluster autoscaler can't send more requests because it's being throttled.

:::image type="content" source="media/429-too-many-requests-errors/cluster-auto-scaler-throttling.png" alt-text="Screenshot of the Cluster Auto-Scaler Throttling has been detected diagnostic in AKS Diagnose and Solve Problems." lightbox="media/429-too-many-requests-errors/cluster-auto-scaler-throttling.png" border="false":::

You can find the number of throttled requests and when the requests are throttled in the **Throttling - Azure Resource Manager** diagnostic.

:::image type="content" source="media/429-too-many-requests-errors/cas-arm-throttling.png" alt-text="Screenshot of the Throttling - Azure Resource Manager diagnostic showing when cluster autoscaler requests are throttled." lightbox="media/429-too-many-requests-errors/cas-arm-throttling.png" border="false":::

You can find the number of all ARM requests in the same time period.

:::image type="content" source="media/429-too-many-requests-errors/cas-arm-all-requests.png" alt-text="Screenshot of the Request Rate - Azure Resource Manager diagnostic showing all ARM requests in the same time period." lightbox="media/429-too-many-requests-errors/cas-arm-all-requests.png" border="false":::

Check the **View request rate and throttle details** diagnostic to find the throttling details. Select **429s by User Agent** from the **Select filter** drop-down list, and you can see that autoscaler requests are throttled from 15:00 to 16:00.

:::image type="content" source="media/429-too-many-requests-errors/cas-throttling-by-user-agent.png" alt-text="Screenshot of the 429s by User Agent filter showing throttled cluster autoscaler requests." lightbox="media/429-too-many-requests-errors/cas-throttling-by-user-agent.png" border="false":::

You can also find the total number of throttled requests for the cluster autoscaler and other user agents.

:::image type="content" source="media/429-too-many-requests-errors/cas-total-throttles-by-user-agent.png" alt-text="Screenshot of the total number of throttled requests for the cluster autoscaler and other user agents." lightbox="media/429-too-many-requests-errors/cas-total-throttles-by-user-agent.png" border="false":::

You can also filter throttles by operations. Virtual machine scale sets VM delete operation is throttled in this case.

:::image type="content" source="./media/429-too-many-requests-errors/cas-throttling-by-operation.png" alt-text="Screenshot of throttled requests filtered by operation, showing the virtual machine scale sets VM delete operation." lightbox="./media/429-too-many-requests-errors/cas-throttling-by-operation.png" border="false":::

You can find the number of throttled requests and all requests grouped by operations.

:::image type="content" source="media/429-too-many-requests-errors/cas-total-throttles-by-operation.png" alt-text="Screenshot of throttled requests and all requests grouped by operation." lightbox="media/429-too-many-requests-errors/cas-total-throttles-by-operation.png" border="false":::

Then, follow the suggestions in the **Recommended Action** to reduce the throttles.

:::image type="content" source="media/429-too-many-requests-errors/cluster-auto-scaler-throttling.png" alt-text="Screenshot of the Recommended Action section for the Cluster Auto-Scaler throttling diagnostic." lightbox="media/429-too-many-requests-errors/cluster-auto-scaler-throttling.png" border="false":::

### Example 2: Cloud provider throttling

This example shows throttling caused by the cloud provider. It often happens when you operate resources in larger clusters, such as provisioning an Azure Load Balancer in a cluster that has more than 500 nodes.

If you find throttling in your cluster, view the throttling details in the **View request rate and throttle details** diagnostic. Select **429s by User Agent** from the **Select filter** drop-down list. You can see that cloud provider requests were throttled from 03:00 to 06:00.

:::image type="content" source="media/429-too-many-requests-errors/cp-arm-throttling.png" alt-text="Screenshot of the Azure Resource Manager throttling diagnostic showing throttling detected for cloud provider requests." lightbox="media/429-too-many-requests-errors/cp-arm-throttling.png" border="false":::

:::image type="content" source="media/429-too-many-requests-errors/cp-throttle-by-user-agent.png" alt-text="Screenshot of the 429s by User Agent filter showing throttled cloud provider requests." lightbox="media/429-too-many-requests-errors/cp-throttle-by-user-agent.png" border="false":::

You can also filter by operations to find that the throttled operation is `Network/loadBalancers/read`.

:::image type="content" source="media/429-too-many-requests-errors/cp-throtlle-by-operation.png" alt-text="Screenshot of throttled requests filtered by operation, showing the Network/loadBalancers/read operation." lightbox="media/429-too-many-requests-errors/cp-throtlle-by-operation.png" border="false":::

Use the [Node IP-based Load Balancer](/azure/aks/load-balancer-standard#change-the-inbound-pool-type-preview) to reduce this throttle.