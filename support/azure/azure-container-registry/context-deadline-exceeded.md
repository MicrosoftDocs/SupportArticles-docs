---
title: Context deadline exceeded error in Azure Container Registry
description: Learn how to resolve a (context deadline exceeded) error that occurs when you try to pull an image from Azure Container Registry.
ms.date: 07/08/2024
author: AndreiBarbu95
ms.author: andbar
editor: v-jsitser
ms.reviewer: v-rekhanain, v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Image Pull Issues
#Customer intent: As an Azure user, I want to fix a "context deadline exceeded" error so that I can successfully pull an image from Azure Container Registry.
---
# "Context deadline exceeded" error during an image pull in Azure Container Registry

This article discusses how to resolve the "context deadline exceeded" error that occurs when you try to pull an image from Microsoft Azure Container Registry.

## Symptoms

When you try to pull an image from your container registry, you receive the following error message:

> Get "https\://\<container-registry-name>.azurecr.io/v2/": context deadline exceeded

## Cause

Your device didn't recognize the name of the container registry's sign-in server.

## Solution

Make sure that the name of the container registry sign-in server can be resolved. To manually test whether your device can resolve the sign-in server of the container registry, run the following [nslookup](/windows-server/administration/windows-commands/nslookup) command:

```cmd
nslookup <container-registry-name>.azurecr.io
```

If the name wasn't successfully resolved, you can try to isolate the issue by using Azure Domain Name Service (DNS). Run the following `nslookup` command to try to resolve the container registry sign-in server through the Azure DNS IP address (`168.63.129.16`):

```cmd
nslookup <container-registry-name>.azurecr.io 168.63.129.16
```

If Azure DNS resolves the name, check your device DNS settings. If the device is using a custom DNS server (not Azure DNS), make sure that the custom DNS server can resolve the name of the container registry sign-in server.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
