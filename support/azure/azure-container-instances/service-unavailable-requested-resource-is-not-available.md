---
title: ServiceUnavailable (409) - requested resource is not available in the location
description: Provides a solution to the service unavailable error
ms.date: 02/23/2024
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: tomcassidy, v-leedennis
ms.topic: troubleshooting-problem-resolution
ms.service: container-instances
#Customer intent: As an Azure administrator, I want to learn how to resolve a ServiceUnavailable (409) error ("requested resource is not available in the location") so that I can successfully deploy a resource in Azure Container Instances.
---
# "ServiceUnavailable (409) - requested resource is not available in the location" error

This article discusses how to resolve the ServiceUnavailable (409) error ("The requested resource is not available in the location" '\<region-name>' at this moment") that occurs when you try to deploy a resource in Microsoft Azure Container Instances.

## Symptoms

You receive an error message that resembles the following text:

> The requested resource is not available in the location 'usgovvirginia' at this moment. Please retry with a different resource request or in another location. Resource requested: '2' CPU '4' GB memory 'Linux' OS virtual network. ServiceUnavailable (409).

## Cause

This issue might occur if a feature isn't available in certain regions or if there's a lack of capacity. This issue is typically intermittent.

## Solution

1. To determine whether you can deploy to an available region, see [Resource availability & quota limits for Azure Container Instances](/azure/container-instances/container-instances-resource-and-quota-limits).

1. To determine which features are available in your region, use the [Location - List Capabilities](/rest/api/container-instances/location/list-capabilities) REST API. You can also verify available features per region by selecting the "Try it" button in that article.

1. If you're deploying in an available region, and there's no feature limitation, retry the deployment.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
