---
title: Container group deployment remains in Waiting state
description: Learn how to resolve an issue in which a container group deployment never progresses from the Waiting state in Azure Container Instances.
ms.date: 04/17/2025
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: edneto, v-leedennis
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve a container group deployment that's stuck in the "Waiting" state so that I can successfully deploy an image onto a container instance.
---
# Container group deployment remains in Waiting state

This article discusses possible causes and how to resolve an unresponsive deployment which doesn't exit the Waiting state.

## Symptoms

When you try to deploy a container group, the deployment times out after 30 minutes and fails. Additionally, the container state is shown as **Waiting**.

## Cause

The Waiting state indicates there's a condition preventing deployment setup or container start. The most likely root causes include:

- The container main process won't start or crashes.
- The container is using reserved ports.
- The container group has an Azure file share volume and it's failing to mount.
- There's subnet IP exhaustion (like bring your own virtual network (BYOVNET)).
- There are capacity issues.

## Solution

Possible solutions include:

- Check that the container runs fine locally. A local machine with Docker can be used to do this.
- Inspect possible errors on the **Container Events** tab starting with the main container process.
- Make sure no reserved ports are being used in the container definition. For more information, see [Does the ACI service reserve ports for service functionality?](/azure/container-instances/container-instances-faq#does-the-aci-service-reserve-ports-for-service-functionality-).
- Check that theress connectivity to the Azure file share and that the key is correct or valid. If deployment is on BYOVNET, check that DNS resolution is working for the Azure file share fully qualified domain name (FQDN).
- Check Azure file share volume [limitations](/azure/container-instances/container-instances-volume-azure-files#limitations) for Azure Container Instances (ACI). Using a private endpoint to connect to an Azure file share hasn't been tested and might not be reliable. Instead, use a subnet service endpoint for private connectivity as recommended in documentation.
- Change the subnet network mask. ACI keeps its own IP mapping internally and at ARM level all IPs always show as available. Depending on the frequency of deployments or restarts, subnet IP exhaustion errors can happen because internal mapping isn't updated in time. To avoid this issue, we recommend using a subnet network mask of `/24` or greater.
- Attempt the deployment with less resource requests or in another region to confirm possible capacity issues.

> [!NOTE]
> We don't recommend using subnets smaller than `/24` to work around unsupported scenarios (like simulating a fixed IP address by restricting the Dynamic Host Configuration Protocol (DHCP) to only a few IPs) as this can cause failed deployments or failed start operations due to subnet full errors.

## Resources

- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)

- [Azure Container Instances states](/azure/container-instances/container-state)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
