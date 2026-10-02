---
title: ServiceUnavailable (409) - requested resource isn't available in the location error in Azure Container Instances
description: Learn how to fix the ServiceUnavailable (409) error when the requested resource isn't available in the location while you deploy to Azure Container Instances (ACI).
ms.date: 10/02/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: tomcassidy, v-leedennis, kennethgp, tysonfreeman, kaushika
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve a ServiceUnavailable (409) error ("requested resource is not available in the location") so that I can successfully deploy a resource in Azure Container Instances.
ai-usage: ai-assisted
---
# "ServiceUnavailable (409) - requested resource isn't available in the location" error in Azure Container Instances

## Summary

This article explains how to fix the "ServiceUnavailable (409) - requested resource isn't available in the location" error that occurs when you try to deploy a resource in Azure Container Instances (ACI).

## Symptoms

You receive an error message that resembles the following text:

> The requested resource is not available in the location '\<region>' at this moment. Please retry with a different resource request or in another location. Resource requested: '2' CPU '4' GB memory 'Linux' OS virtual network. ServiceUnavailable (409).

## Cause

This issue might occur if a feature isn't available in certain regions or if there's a lack of capacity. This issue is typically intermittent.

When container group deployment requests are larger than 4 CPU or 16-GB memory, the deployment is marked as **Big Container Group**. Big Container Group region capacity is enabled on demand. If there's no infrastructure available for the deployment, you encounter the error.

## Solution

The following steps outline how to resolve this error:

- To determine whether you can deploy to an available region, see [Resource availability & quota limits for Azure Container Instances](/azure/container-instances/container-instances-resource-and-quota-limits).
- To determine which features are available in your region, use the [Location - List Capabilities](/rest/api/container-instances/location/list-capabilities) REST API. You can also verify available features per region by selecting the **Try it** button in that article.
- If you're deploying in an available region, and there's no feature limitation, retry the deployment.
- If you're deploying a Big Container Group, open a support ticket to validate region capacity.
