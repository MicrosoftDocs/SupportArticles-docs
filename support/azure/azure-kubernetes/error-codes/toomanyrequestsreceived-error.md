---
title: Troubleshoot TooManyRequestsReceived, SubscriptionRequestsThrottled, or Throttled error codes (HTTP 429)
description: Learn how to identify and resolve HTTP 429 throttling errors in AKS. Troubleshoot ARM, Microsoft.Network, and AKS resource provider throttling issues.
ms.date: 07/28/2026
editor: v-jsitser
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, edneto, v-leedennis, dorinalecu, fagonzal, andraciobanu, dmendozaprez
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot HTTP 429 throttling error codes so that I can successfully create, update, and delete Azure Kubernetes Service (AKS) resources.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot TooManyRequestsReceived, SubscriptionRequestsThrottled, or Throttled error codes (HTTP 429)

## Summary

This article explains how to identify and resolve "HTTP 429 Too Many Requests" throttling errors that Azure Kubernetes Service (AKS) operations can surface. Throttling can originate from different layers, and the error code you see depends on which layer rejected the request:

- **Azure Resource Manager (ARM)** subscription-level throttling (for example, high-cost virtual machine scale set GET operations).
- **A lower-layer resource provider**, most commonly the network resource provider (**`Microsoft.Network`**), when AKS reads or writes network resources such as network security groups, virtual networks, or load balancers.
- The **AKS resource provider** itself, when too many requests are made against AKS resources.

All of these errors appear as HTTP status code 429. Use the scenario that matches your error message to find the cause and the corresponding mitigation.

## Symptoms

Depending on the throttled layer, you receive one of the following error shapes.

### Scenario 1: Microsoft.Network (network resource provider) throttling

This throttling is the most common throttling that AKS create, update, scale, and delete operations surface today. It occurs when AKS reads or writes network resources (network security groups, virtual networks, subnets, or load balancers) too frequently, and the network resource provider throttles the subscription.

The `code` and sub-code are `TooManyRequests`, and the inner detail is a retryable error against a `Microsoft.Network` resource:

> Status=429 Code="TooManyRequests"
>
> Message="Subscription '\<subscription-id>' was used to perform too many calls within last 5 minutes. The number of calls exceeds Microsoft.Network throttling limit. The call can be retried in 64 seconds."
>
> dependency="Microsoft.Network/networkSecurityGroups"
>
> innerErrorCode="RetryableErrorDueToTooManyCalls"

A related variant reports the size (rather than the number) of read requests:

> Message="Subscription '\<subscription-id>' retrieved a very large amount of data within last 5 minutes. The size of the data exceeds Microsoft.Network throttling limit. The call can be retried in 61 seconds."
>
> innerErrorCode="RetryableErrorDueTooHighReadDataSize"

Another variant surfaces with `code="SubscriptionRequestsThrottled"` when a network resource read (for example, public IP addresses during load balancer reconciliation) exceeds the backend storage limit:

> Reconcile standard load balancer failed.
>
> Category: ClientError;
>
> SubCode: SubscriptionRequestsThrottled;
>
> Dependency: Microsoft.Network/PublicIPAddresses;
>
> Status=429 Code="SubscriptionRequestsThrottled"
>
> Message="Number of requests for subscription '\<subscription-id>' and operation 'GET/SUBSCRIPTIONS/RESOURCEGROUPS/PROVIDERS/MICROSOFT.NETWORK/PUBLICIPADDRESSES' exceeded the backend storage limit. Please try again after '6' seconds."

### Scenario 2: Azure Resource Manager (ARM) subscription-level throttling

This issue occurs when a Kubernetes cluster performs frequent scale-up or scale-down operations, or uses the cluster autoscaler. These actions generate a large volume of HTTP calls that exceed the subscription's ARM quota. For example, the quota might be exceeded for virtual machine scale set GET operations:

> Service returned an error.
>
> **Status=429**
>
> Code="OperationNotAllowed"
>
> **Message="The server rejected the request because too many requests have been received for this subscription."**
>
> Details=[{ **"code":"TooManyRequests",** "message":"{ \"operationGroup\":\"HighCostGetVMScaleSet30Min\", \"startTime\":\"...\", \"endTime\":\"...\", \"allowedRequestCount\":1800, \"measuredRequestCount\":2208 }", "target":"HighCostGetVMScaleSet30Min" }]
>
> **InnerError={"internalErrorCode":"TooManyRequestsReceived"}**

A read-throttling variant that can appear when you delete a cluster:

> internalErrorCode: TooManyRequestsReceived
>
> StatusCode: 429
>
> { message: "Number of read requests for subscription '.....' exceeded the limit of '....' for time interval 'XX:XX:XX'. Please try again after '.....' seconds." }

### Scenario 3: AKS resource provider throttling

This error occurs when too many requests are made against AKS resources themselves. For example, repeated create or modify operations, or automated scripts running frequent LIST operations. The `code` is `Throttled` and the message references the AKS handler request limit:

> Category: ClientError;
>
> SubCode: Throttled;
>
> OriginalError: autorest/azure: Service returned an error. **Status=429**
>
> **Code="Throttled"**
>
> Message="The PutManagedClusterHandler.PUT request limit has been exceeded for SubID='*\<subscription-id-guid>*', please retry again in X seconds. For more information, please visit aka.ms/aks/throttling";

Request throttling can occur on various Azure components, so the exact message can differ depending on the resource where the issue occurs. Resource provider throttling is independent of ARM throttling and is tailored to the operations of a specific resource provider.

## Cause

Every subscription-level and tenant-level operation is subject to throttling limits. Each resource provider, such as ARM, `Microsoft.Network`, and the AKS resource provider, enforces its own limits. When the request rate or read-data volume exceeds the applicable limit, the layer returns HTTP status code 429 ("Too many requests"). Common triggers include:

- A high volume of network resource reads or writes during cluster or node pool create, update, scale, and delete operations (Scenario 1).
- Frequent scale operations or an active cluster autoscaler generating many ARM calls (Scenario 2).
- Automated scripts or clients making frequent operations against AKS resources (Scenario 3).

For background, see [Throttling Azure Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling) and, for the AKS resource provider specifically, [Throttling limits on AKS resource provider APIs](/azure/aks/quotas-skus-regions#throttling-limits-on-aks-resource-provider-apis).

## Solution

The HTTP 429 response includes a `Retry-After` value that specifies how many seconds to wait before sending the next request. If you send a request before that interval elapses, the request isn't processed and a new retry value is returned. Beyond honoring `Retry-After`, apply the mitigation that matches your scenario.

### Reduce the request volume (all scenarios)

- Make sure your clients and automation use **exponential backoff** when calling Azure APIs.
- Reduce the frequency of automated LIST or GET operations against AKS and Azure resources.
- Space out create, update, and delete operations. For a given cluster, ensure one operation completes successfully before starting another.

### Scenario 1: Microsoft.Network throttling

- Reduce the frequency of operations that read or write network resources, such as network security groups, virtual networks, subnets, and load balancers.
- For load-balancer-related throttling in larger clusters, use the [Node IP-based load balancer](/azure/aks/load-balancer-standard#change-the-inbound-pool-type-preview) to reduce the number of network resource-provider calls.
- If many clusters in the same subscription and region operate network resources concurrently, consider splitting clusters across subscriptions or regions (see Scenario 2). Network resource-provider limits are also shared at the subscription-region level. If you have access to a different subscription, you can deploy the cluster to that subscription.

### Scenario 2: ARM subscription-level throttling

- **Increase the autoscaler scan interval.** If throttling is caused by the cluster autoscaler, increase the [autoscaler scan interval](/azure/aks/cluster-autoscaler) to reduce the number of calls to virtual machine scale sets. This change can slightly increase scale-up latency because the autoscaler waits longer before calling the Azure Compute resource provider for a new virtual machine.
- **Reconfigure third-party applications to make fewer calls.** If monitoring or other third-party applications make an excessive number of GET requests, change their settings to reduce the call frequency and use exponential backoff.
- **Split your clusters into different subscriptions or regions.** Most Azure API limits are shared at the subscription-region level. For example, all clusters and clients within one subscription and the East US region share a limit for the virtual machine scale set GET API. Moving or scaling new AKS clusters into a new region can unblock you. This action helps when clusters have high activity (for example, an active autoscaler) or when you have many clients (such as Rancher or Terraform). Because clusters differ in elasticity and in the number of clients polling Azure APIs, there's no generic guidance on how many clusters you can run per subscription-region. For specific guidance, create a support ticket.

### Scenario 3: AKS resource provider throttling

Examine and modify the access pattern of the throttled subscription. The following table lists common access patterns and the corresponding solutions.

| Access pattern | Solution |
| -------------- | -------- |
| Automated scripts constantly run LIST operations against managedCluster resources. | Run the scripts less frequently. |
| Users attempt to deploy multiple AKS clusters in a short period of time. | Space out deployments or use different subscriptions. |
| Users attempt to modify the same AKS cluster multiple times consecutively. | Space out operations. Ensure successful completion before initiating another one. |
| Users attempt to add, modify, or delete one or more agentPools on the same AKS cluster. | Space out operations. Ensure successful completion before initiating another one. |

## Analyze and identify errors by using AKS Diagnose and Solve Problems

For an AKS cluster, use [AKS Diagnose and Solve Problems](/azure/aks/aks-diagnostics) to analyze and identify the cause of errors and get recommendations to resolve them. Go to your cluster in the Azure portal, and select **Diagnose and solve problems** in the left navigation to open AKS Diagnose and Solve Problems. Search and open *Azure Resource Request Throttling*, where you can get a report with a series of diagnostics. Those diagnostics can show whether the cluster experienced any request rate throttling (429 responses) of Azure Resource Manager (ARM) or a resource provider (RP), and where the throttling comes from. For example:

- **Request Rate Throttling has been detected for your Cluster**: Provides general recommendations if throttling is detected in the current AKS cluster.

- **Cluster Auto-Scaler Throttling has been detected**: Shows up if throttling is detected and originated from the cluster autoscaler.

  To reduce the volume of requests from the cluster autoscaler, increase the autoscaler scan interval to reduce the number of calls from the cluster autoscaler to virtual machine scale sets. This method might have a negative latency impact on scale-up time because the cluster autoscaler waits longer before calling the Azure Compute resource provider (CRP) for a new virtual machine.

- **Throttling - Azure Resource Manager**: Shows the number of throttled requests in the specified time range in the AKS cluster.

- **Request Rate - Azure Resource Manager**: Shows the total number of requests in the specified time range in the AKS cluster.

- **View request rate and throttle details**: Has multiple diagrams to determine the throttling details, including throttled requests and total requests. You can also filter the results by using the following dimensions:

  - Host: The host where HTTP status 429 responses are detected. Azure Resource Manager throttles come from `management.azure.com`; anything else is a lower-layer resource provider (for example, `Microsoft.Network`).
  - User agent: Requests with a specified user agent that are throttled.
  - Operation: Operations where HTTP status 429 responses are detected.

Request throttling can be caused by a combination of any cluster in this subscription, not just the request rate for this cluster.

### Example 1: Cluster autoscaler throttling

This example shows how to analyze throttling caused by the cluster autoscaler.

If you find the **Cluster Auto-Scaler Throttling has been detected** diagnostic in AKS **Diagnose and Solve Problems** > **Known Issues, Availability and Performance** > **Azure Resource Request Throttling**, it indicates that requests from the cluster autoscaler are throttled.

:::image type="content" source="media/toomanyrequestsreceived-error/cluster-auto-scaler-throttle.png" alt-text="Screenshot of the diagnostic showing that Cluster Auto-Scaler requests throttling is detected." lightbox="media/toomanyrequestsreceived-error/cluster-auto-scaler-throttle.png" border="false":::

You can find the number of throttled requests and when the requests are throttled in the **Throttling - Azure Resource Manager** diagnostic.

:::image type="content" source="media/toomanyrequestsreceived-error/cas-arm-throttle.png" alt-text="Screenshot of the diagnostic showing when cluster autoscaler requests are throttled." lightbox="media/toomanyrequestsreceived-error/cas-arm-throttle.png" border="false":::

You can find the number of all ARM requests in the same time period.

:::image type="content" source="media/toomanyrequestsreceived-error/cas-arm-all-requests.png" alt-text="Screenshot of the diagnostic showing all ARM requests." lightbox="media/toomanyrequestsreceived-error/cas-arm-all-requests.png" border="false":::

You can check the **View request rate and throttle details** diagnostic to find the throttling details. Select **429s by User Agent** from the **Select filter** drop-down list, and you can see that autoscaler requests are throttled from 15:00 to 16:00.

:::image type="content" source="media/toomanyrequestsreceived-error/cas-throttle-by-user-agent.png" alt-text="Screenshot of the diagnostic showing throttles by user agents." lightbox="media/toomanyrequestsreceived-error/cas-throttle-by-user-agent.png" border="false":::

You can also find the total number of throttled requests for the cluster autoscaler and other user agents.

:::image type="content" source="media/toomanyrequestsreceived-error/cas-total-throttles-by-user-agent.png" alt-text="Screenshot of the diagnostic showing total throttles by user agent." lightbox="media/toomanyrequestsreceived-error/cas-total-throttles-by-user-agent.png" border="false":::

You can also filter throttles by operations. The VMSS VM delete operation is throttled in this case.

:::image type="content" source="media/toomanyrequestsreceived-error/cas-throttle-by-operation.png" alt-text="Screenshot of the diagnostic showing throttles by operations." lightbox="media/toomanyrequestsreceived-error/cas-throttle-by-operation.png" border="false":::

You can find the number of throttled requests and all requests grouped by operations.

:::image type="content" source="media/toomanyrequestsreceived-error/cas-total-throttles-by-operation.png" alt-text="Screenshot of the diagnostic showing total throttles by operations." lightbox="media/toomanyrequestsreceived-error/cas-total-throttles-by-operation.png" border="false":::

Then, follow the suggestions in the **Recommended Action** to reduce the throttles.

### Example 2: Cloud provider (Microsoft.Network) throttling

This example shows throttling caused by the cloud provider. It often happens when you operate resources in larger clusters. For example, it happens when you provision an Azure load balancer in a cluster that has more than 500 nodes.

If you find throttling in your cluster, you can see the throttling details in the **View request rate and throttle details** diagnostic. Select **429s by User Agent** from the **Select filter** drop-down list, and you can see that cloud provider requests were throttled from 03:00 to 06:00.

:::image type="content" source="media/toomanyrequestsreceived-error/cp-arm-throttle.png" alt-text="Screenshot of the diagnostic showing that throttling is detected." lightbox="media/toomanyrequestsreceived-error/cp-arm-throttle.png" border="false":::

:::image type="content" source="media/toomanyrequestsreceived-error/cp-throttle-by-user-agent.png" alt-text="Screenshot of the diagnostic showing throttles by user agent." lightbox="media/toomanyrequestsreceived-error/cp-throttle-by-user-agent.png" border="false":::

You can also filter by operations to find out that the throttled operation is "Network/loadBalancers/read".

:::image type="content" source="media/toomanyrequestsreceived-error/cp-throttle-by-operation.png" alt-text="Screenshot of the diagnostic showing throttles by operation." lightbox="media/toomanyrequestsreceived-error/cp-throttle-by-operation.png" border="false":::

Use the [Node IP-based load balancer](/azure/aks/load-balancer-standard#change-the-inbound-pool-type-preview) to reduce this throttle.

## More information

- [Throttling Azure Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling)
- [Throttling limits on AKS resource provider APIs](/azure/aks/quotas-skus-regions#throttling-limits-on-aks-resource-provider-apis)
- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
