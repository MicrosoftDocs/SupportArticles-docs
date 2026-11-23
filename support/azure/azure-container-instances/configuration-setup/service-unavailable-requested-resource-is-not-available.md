---
title: ServiceUnavailable (409) - requested resource isn't available in the location error in Azure Container Instances
description: Learn how to fix the ServiceUnavailable (409) error when a requested resource isn't available in the location during Azure Container Instances deployment. Follow these steps.
ms.date: 10/22/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: tomcassidy, v-leedennis, kennethgp, tysonfreeman, zhixinsun, kaushika
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve a ServiceUnavailable (409) error ("requested resource is not available in the location") so that I can successfully deploy a resource in Azure Container Instances.
ai-usage: ai-assisted
---
# "ServiceUnavailable (409) - requested resource isn't available in the location" error in Azure Container Instances

## Summary

This article explains how to troubleshoot the "ServiceUnavailable (409) - requested resource isn't available in the location" error when you deploy a container group in Azure Container Instances (ACI).

## Symptoms

You receive an error message that resembles the following text:

> The requested resource isn't available in the location '\<region>' at this moment. Please retry with a different resource request or in another location. Resource requested: '2' CPU '4' GB memory 'Linux' OS virtual network. ServiceUnavailable (409).

The region, resource values, operating system (OS), and network description in the message depend on the requested configuration.

## Cause

This error indicates that ACI couldn't complete resource allocation for the requested container group configuration in the selected region. Allocation requires available capacity on an ACI-managed compute backend that supports the requested CPU and memory, OS, and features. For a container group deployed into an Azure virtual network, that backend must also support virtual network deployment. The failure can result from capacity constraints or backend allocation issues. It doesn't necessarily mean that the requested CPU or memory exceeds a supported limit.

This error can affect both smaller container groups and **Big Containers**. Larger resource requests can further limit the available placement options. Temporary capacity constraints might be resolved by retrying later, but retrying doesn't resolve an unsupported configuration or a persistent allocation issue.

## Solution

The following steps help you troubleshoot the error and identify an appropriate mitigation:

- Verify that the selected region supports ACI and review the applicable resource limits in [Resource availability and quota limits for Azure Container Instances](/azure/container-instances/container-instances-resource-and-quota-limits). Check the requirements and restrictions for the requested OS, SKU, and networking configuration. A request within the published limits is still subject to regional resource availability.
- Use the [Location - List Capabilities](/rest/api/container-instances/location/list-capabilities) REST API to review the resource capabilities reported for the selected region. You can run the API by selecting **Try it** in that article. Compare the relevant returned entries with the requested configuration, and consult the applicable feature documentation for additional restrictions. This API reports capabilities and limits, not real-time available capacity or a complete validation of every feature combination.
- If the selected region and requested configuration are supported, retry the deployment later. If workload requirements allow, reduce the requested CPU or memory, or try another supported region. Preserve the resources that the workload needs, and review networking dependencies and data residency requirements before changing regions. These actions can mitigate capacity constraints but don't guarantee successful allocation.
- If you're deploying **Big Containers**, open an Azure support request to validate regional capacity. For more information, see [Big Containers](/azure/container-instances/big-containers#next-steps).
