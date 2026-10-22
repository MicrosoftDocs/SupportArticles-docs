---
title: Context deadline exceeded error in Azure Container Registry
description: Learn how to resolve the "context deadline exceeded" error when you pull an image from Azure Container Registry. Follow DNS troubleshooting steps to fix it.
ms.date: 10/21/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: v-rekhanain, v-leedennis, andbar, kaushika, mborkar
ms.service: azure-container-registry
ms.topic: troubleshooting
ms.custom: sap:Image Pull Issues
ai-usage: ai-assisted
#Customer intent: As an Azure user, I want to fix a "context deadline exceeded" error so that I can successfully pull an image from Azure Container Registry.
---
# Resolve "context deadline exceeded" error during an image pull in Azure Container Registry

## Summary

This article describes how to resolve the "context deadline exceeded" error that occurs when you try to pull an image from Azure Container Registry (ACR).

## Symptoms

When you try to pull an image from your container registry, you receive the following error message.

> Get "https\://\<container-registry-name>.azurecr.io/v2/": context deadline exceeded

## Cause

The client couldn't resolve the container registry authentication server name. A DNS resolution issue can prevent the client from connecting to the registry and result in the "context deadline exceeded" error.

## Solution

First, run the following command to check the health of the container registry and the client environment:

[az acr check-health --name `<container-registry-name>` --ignore-errors –yes](/azure/container-registry/container-registry-check-health)

If the command reports a Domain Name System (DNS)-related issue, continue with the following name-resolution checks. If it reports another error, use the reported error information to continue troubleshooting.

Make sure that the name of the container registry sign-in server can be resolved. To manually test whether your device can resolve the sign-in server of the container registry,  run the following [nslookup](/windows-server/administration/windows-commands/nslookup) command.

```cmd
nslookup <container-registry-name>.azurecr.io
```

If the registry authentication server name resolves successfully, DNS resolution is working from the affected device. Continue with the general Azure Container Registry image-pull troubleshooting guidance to investigate other possible causes of the image-pull failure.

If the name wasn't successfully resolved, you can try to isolate the issue by using Azure DNS. Run the following `nslookup` command to try to resolve the container registry sign-in server through the Azure DNS IP address (`168.63.129.16`).

```cmd
nslookup <container-registry-name>.azurecr.io 168.63.129.16
```

If Azure DNS resolves the registry authentication server name but the device's configured DNS server doesn't resolve it, review the DNS configuration of the affected device. If the device uses a custom DNS server instead of Azure DNS, ensure that the custom DNS server can resolve `<container-registry-name>.azurecr.io`.
