---
title: Container group deployment remains in the Waiting state in Azure Container Instances
description: Learn how to resolve an issue in which a container group deployment never progresses from the Waiting state in Azure Container Instances (ACI).
ms.date: 09/30/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: edneto, v-leedennis, kegonzal, kaushika
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve a container group deployment that's stuck in the "Waiting" state so that I can successfully deploy an image onto a container instance.
ai-usage: ai-assisted
---
# Container group deployment remains in the Waiting state in Azure Container Instances

## Summary

This article discusses possible causes of a container group deployment in Azure Container Instances (ACI) that remains in the Waiting state, and how to resolve the issue so that your deployment succeeds.

## Symptoms

When you try to deploy a container group, the deployment times out after 30 minutes and fails and the container state is **Waiting**.

## Cause

The Waiting state indicates a condition that prevents deployment setup or container start. The most likely root causes include the following:

- The container main process doesn't start or crashes.
- The container uses reserved ports.
- The container group has an Azure file share volume and fails to mount it.
- There's subnet IP exhaustion (bring your own virtual network (BYOVNET) deployment).
- There are capacity issues.

## Solution

Possible solutions include the following:

- Check that the container runs fine locally. Use a local machine with Docker to validate the container runs correctly.
- Inspect possible errors on the **Container Events** tab starting with the main container process.
- Ensure the container definition doesn't use reserved ports. For more information, see [Does the ACI service reserve ports for service functionality?](/azure/container-instances/container-instances-faq#does-the-aci-service-reserve-ports-for-service-functionality-).
- Check that there's connectivity to the Azure file share and that the key is correct or valid. If you deploy on BYOVNET, check that Domain Name System (DNS) resolution is working for the Azure file share fully qualified domain name (FQDN).
- Check Azure file share volume [limitations](/azure/container-instances/container-instances-volume-azure-files#limitations) for ACI. Using a private endpoint to connect to an Azure file share isn't tested and might not be reliable. Instead, use a subnet service endpoint for private connectivity as recommended in documentation.
- Change the subnet network mask. ACI keeps its own IP mapping internally and at Azure Resource Manager (ARM) level all IPs always show as available. Depending on the frequency of deployments or restarts, subnet IP exhaustion errors can happen because internal mapping isn't updated in time. To avoid IP exhaustion, use a subnet network mask of `/24` or greater.
- To confirm possible capacity issues, attempt the deployment with fewer resource requests or in another region.

> [!NOTE]
> Don't use subnets smaller than `/24` to work around unsupported scenarios (like simulating a fixed IP address by restricting the Dynamic Host Configuration Protocol (DHCP) to only a few IPs). This configuration can cause failed deployments or failed start operations due to subnet full errors.

## References

- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)
- [Azure Container Instances states](/azure/container-instances/container-state)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
