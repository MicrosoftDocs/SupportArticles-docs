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

This article discusses how to resolve a scenario in Microsoft Azure Container Instances in which a container group is unresponsive and doesn't exit the "Waiting" state.

## Symptoms

When you try to deploy an image through a virtual network onto a private container instance, the deployment times out after 30 minutes and fails. Additionally, the container group deployment state is shown as **Waiting** in the Azure portal.

## Cause

Your firewall blocks access to port 19390. When container groups are deployed in virtual networks, port 19390 is required to connect to Container Instances from the Azure portal.

## Solution

Expand the Classless Inter-Domain Routing (CIDR) address range of the subnet by specifying a network mask of `/24` or smaller.

Make sure to check the [reserved ports for ACI service functionality](/azure/container-instances/container-instances-faq#does-the-aci-service-reserve-ports-for-service-functionality-) and [other limitations](/azure/container-instances/container-instances-virtual-network-concepts#other-limitations).

> [!NOTE]
> We don't recommend using small subnets to work around unsupported scenarios (such as simulating a fixed IP address for a private container instance by restricting DHCP to only a few IPs).

## More information

- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)

- [Azure Container Instances states](/azure/container-instances/container-state)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
