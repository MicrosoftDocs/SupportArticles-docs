---
title: Client with IP <device-ip-address> is not allowed access
description: Learn how to fix the (Client with IP <device-ip-address> is not allowed access) error message when you pull an image or artifact from Azure Container Registry.
ms.date: 07/08/2024
author: AndreiBarbu95
ms.author: andbar
editor: v-jsitser
ms.reviewer: v-rekhanain, v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Image Pull Issues
#Customer intent: As an Azure user, I want to fix the "Client with IP '<device-ip-address>' is not allowed access" error so that I can successfully pull an image or artifact from Azure Container Registry.
---
# "Client with IP '\<device-ip-address>' is not allowed access" error

This article discusses how to resolve the "client with IP '\<your-device-ip-address>' is not allowed access" error that occurs when you try to pull an image or artifact from Microsoft Azure Container Registry.

## Symptoms

When you try to pull an image or artifact from a container registry, you receive the following error message:

> Head "https\://\<container-registry-name>.azurecr.io/v2/\<repository>/manifests/\<tag>": denied: client with IP '\<your-device-ip-address>' is not allowed access. Refer <https://aka.ms/acr/firewall> to grant access.

## Cause

The container registry firewall is blocking access to your device, or the firewall disables public network access.

## Solution

Make sure that the built-in firewall for your container registry allows traffic to your device's IP address.

By default, an Azure container registry accepts connections over the internet from hosts on any network. To limit the public access, Azure Container Registry has a built-in firewall that can restrict access to specific IP addresses or Classless Inter-Domain Routings (CIDRs) or fully disable public network access.

Disabling or restricting access to specific IP addresses or CIDRs can cause an associated error if your device’s IP address isn't allowed by the built-in firewall of the container registry.

To fix this issue, make sure that the container registry's built-in firewall allows the IP address of the device on which you want to pull the artifact. For more information, see [Configure public IP network rules](/azure/container-registry/container-registry-access-selected-networks).

Alternatively, if you disabled public network access, you can [configure connectivity by using a private endpoint](/azure/container-registry/container-registry-private-link).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
