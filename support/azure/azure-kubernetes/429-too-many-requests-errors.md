---
title: 429 Too Many Requests errors
description: Troubleshoot why you receive 429 Too Many Requests errors on your Kubernetes clusters.
ms.date: 08/29/2023
ms.reviewer: chiragpa, nickoman, v-leedennis, v-weizhu
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

For more information about these errors, see [Throttling Azure Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling) and [Troubleshooting API throttling errors](../virtual-machines/troubleshooting-throttling-errors.md). For information about how to analyze and identify the cause of these errors and get recommendations to resolve them, see [Analyze and identify errors by using AKS Diagnose and Solve Problems](#analyze-and-identify-errors-by-using-aks-diagnose-and-solve-problems).

## Solution 1: Upgrade to a later version of Kubernetes

Run Kubernetes 1.18.*x* or later. These versions contain many improvements that are described in [AKS throttling/429 errors](https://github.com/Azure/AKS/issues/1413) and [Support large clusters without throttling](https://github.com/kubernetes-sigs/cloud-provider-azure/issues/247). However, if you still see throttling (due to the actual load or number of clients in the subscription), you can try the following solutions.

## Solution 2: Increase the autoscaler scan interval

If you [find the "Cluster Auto-Scaler Throttling has been detected" diagnostic reports throttling](#analyze-and-identify-errors-by-using-aks-diagnose-and-solve-problems) caused by the cluster autoscaler, you can try to increase the [autoscaler scan interval](/azure/aks/cluster-autoscaler) to reduce the number of calls to virtual machine scale sets (VMSS) from the cluster autoscaler.

## Solution 3: Reconfigure third-party applications to make fewer calls

When you [filter by user agents in the "View request rate and throttle details" diagnostic](#analyze-and-identify-errors-by-using-aks-diagnose-and-solve-problems), if you find third-party applications (such as monitoring applications) that make an excessive number of GET requests, change the settings of these applications to reduce the frequency of the GET calls. In addition, make sure that the application clients use exponential backoff when calling Azure APIs.

## Solution 4: Split your clusters into different subscriptions or regions

If there are numerous clusters and node pools that use virtual machine scale sets, try to split the clusters into different subscriptions or regions (within the same subscription). Most Azure API limits are shared limits at the subscription-region level. For example, all clusters and clients within sub one and the East US region share a limit for the virtual machine scale sets GET API. Hence, you can move or scale new AKS clusters in a new region and get unblocked on Azure API throttling. This technique helps if you expect the clusters to have high activity (for example, if you have an active cluster autoscaler). It also helps if you have many clients (such as Rancher, Terraform, and so on). Since all clusters are different in their elasticity and the number of clients polling Azure APIs, there are no generic guidelines on the number of clusters that you can run per subscription-region level. For specific guidance, you can create a support ticket.

## Analyze and identify errors by using AKS Diagnose and Solve Problems

For an AKS cluster, you can use [AKS Diagnose and Solve Problems](/azure/aks/aks-diagnostics) to analyze and identify the cause of these errors and get recommendations to resolve them. Navigate to your cluster in the Azure portal, and select **Diagnose and solve problems** in the left navigation to open AKS Diagnose and Solve Problems. Search and open *Azure Resource Request Throttling*, where you can get a report with a series of diagnostics. Those diagnostics can show if the cluster has experienced any request rate throttling (429 responses) of Azure Resource Manager (ARM) or Resource Provider (RP), and where the throttling comes from. For example:

- **Request Rate Throttling has been detected for your Cluster**: This diagnostic provides some general recommendations if throttling has been detected in the current AKS cluster.

- **Cluster Auto-Scaler Throttling has been detected**: This diagnostic shows up if throttling has been detected and originated from the cluster autoscaler.

  To reduce the volume of requests from the cluster autoscaler, use the following methods:

  - Increase the autoscaler scan interval to reduce the number of calls from the cluster autoscaler to virtual machine scale sets. This method may have a negative latency impact on the time taken to scale up because the cluster autoscaler waits longer before calling Azure Compute Resource Provider (CRP) for a new virtual machine.
  - Make sure the cluster is on a minimum Kubernetes version of 1.18. Kubernetes version 1.18 and later versions handle request rate backoff better when 429 throttling responses are received. We highly recommend staying within supported Kubernetes versions to receive security patches.

- **Throttling - Azure Resource Manager**: This diagnostic shows the number of throttled requests in the specified time range in the AKS cluster.

- **Request Rate - Azure Resource Manager**: This diagnostic shows the total number of requests in the specified time range in the AKS cluster.

- **View request rate and throttle details**: This diagnostic has multiple diagrams to determine the throttling details, including throttled requests and total requests. You can also filter the results by using the following dimensions:

  - Host: The host where HTTP status 429 responses were detected. Azure Resource Manager throttles come from `management.azure.com`; anything else is a lower-layer resource provider.
  - User agent: Requests with a specified user agent that were throttled.
  - Operation: Operations where HTTP status 429 responses were detected.
  - Client IP: The client IP address that sent the throttled requests.

Request throttling can be caused by a combination of any cluster in this subscription, not just the request rate for this cluster.

### Example 1: Cluster Auto-Scaler throttling

This example is about analyzing throttling caused by the cluster autoscaler.

If you find the **Cluster Auto-Scaler Throttling has been detected** diagnostic in AKS **Diagnose and Solve Problems** > **Known Issues, Availability and Performance** > **Azure Resource Request Throttling**, it indicates requests issued by the cluster autoscaler have been throttled.

:::image type="content" source="media/429-too-many-requests-errors/cluster-auto-scaler-throttling.png" alt-text="Diagram that shows Cluster Auto-Scaler requests throttling is detected." lightbox="media/429-too-many-requests-errors/cluster-auto-scaler-throttling.png" border="false":::

You can find the number of throttled requests and when the requests are throttled in the **Throttling - Azure Resource Manager** diagnostic.

:::image type="content" source="media/429-too-many-requests-errors/cas-arm-throttling.png" alt-text="Diagram that shows when cluster autoscaler requests are throttled." lightbox="media/429-too-many-requests-errors/cas-arm-throttling.png" border="false":::

You can find the number of all ARM requests in the same time period.

:::image type="content" source="media/429-too-many-requests-errors/cas-arm-all-requests.png" alt-text="Diagram of all ARM requests." lightbox="media/429-too-many-requests-errors/cas-arm-all-requests.png" border="false":::

You can check the **View request rate and throttle details** diagnostic to find the throttling details. Select **429s by User Agent** from the **Select filter** drop-down list, and you can see that autoscaler requests are throttled from 15:00 to 16:00.

:::image type="content" source="media/429-too-many-requests-errors/cas-throttling-by-user-agent.png" alt-text="Diagram of throttles by user agents." lightbox="media/429-too-many-requests-errors/cas-throttling-by-user-agent.png" border="false":::

You can also find the total number of throttled requests for the cluster autoscaler and other user agents.

:::image type="content" source="media/429-too-many-requests-errors/cas-total-throttles-by-user-agent.png" alt-text="Diagram of total throttles by user agent." lightbox="media/429-too-many-requests-errors/cas-total-throttles-by-user-agent.png" border="false":::

You can also filter throttles by operations. VMSS VM delete operation is throttled in this case.

:::image type="content" source="./media/429-too-many-requests-errors/cas-throttling-by-operation.png" alt-text="Diagram of throttles by operations." lightbox="./media/429-too-many-requests-errors/cas-throttling-by-operation.png" border="false":::

You can find the number of throttled requests and all requests grouped by operations.

:::image type="content" source="media/429-too-many-requests-errors/cas-total-throttles-by-operation.png" alt-text="Diagram of total throttles by operations." lightbox="media/429-too-many-requests-errors/cas-total-throttles-by-operation.png" border="false":::

Then, you can follow the suggestions in the **Recommended Action** to reduce the throttles.

:::image type="content" source="media/429-too-many-requests-errors/cluster-auto-scaler-throttling.png" alt-text="Diagram show that Cluster Auto-Scaler requests throttling is detected." lightbox="media/429-too-many-requests-errors/cluster-auto-scaler-throttling.png" border="false":::

### Example 2: Cloud Provider throttling

This example is about the throttles caused by the Cloud Provider. It often happens when operating resources in larger clusters, for example, provisioning an Azure Load Balancer in a cluster that has more than 500 nodes.

If you find throttling in your cluster, you can see the throttling details in the **View request rate and throttle details** diagnostic. Select **429s by User Agent** from the **Select filter** drop-down list, and you can see that cloud provider requests were throttled from 03:00 to 06:00.

:::image type="content" source="media/429-too-many-requests-errors/cp-arm-throttling.png" alt-text="Diagram that shows throttling is detected." lightbox="media/429-too-many-requests-errors/cp-arm-throttling.png" border="false":::

:::image type="content" source="media/429-too-many-requests-errors/cp-throttle-by-user-agent.png" alt-text="Diagram of throttles by user agent." lightbox="media/429-too-many-requests-errors/cp-throttle-by-user-agent.png" border="false":::

You can also filter by operations to find out that the throttled operation is "Network/loadBalancers/read".

:::image type="content" source="media/429-too-many-requests-errors/cp-throtlle-by-operation.png" alt-text="Diagram of throttles by operation." lightbox="media/429-too-many-requests-errors/cp-throtlle-by-operation.png" border="false":::

You can use the AKS preview feature [Node IP-based Load Balancer](/azure/aks/load-balancer-standard#change-the-inbound-pool-type-preview) to reduce this throttle.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
