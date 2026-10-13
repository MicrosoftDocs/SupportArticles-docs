---
title: Context deadline exceeded error in Azure Container Registry
description: Learn how to resolve the "context deadline exceeded" error when you pull an image from Azure Container Registry. Follow DNS troubleshooting steps to fix it.
ms.date: 10/09/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: v-rekhanain, v-leedennis, andbar, kaushika
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

Your device didn't recognize the name of the container registry's sign-in server.

## Solution

Ensure that the name of the container registry sign-in server can be resolved. To manually test whether your device can resolve the sign-in server of the container registry, run the following [nslookup](/windows-server/administration/windows-commands/nslookup) command.

```cmd
nslookup <container-registry-name>.azurecr.io
```

If the name isn't resolved, try to isolate the issue by using Azure Domain Name Service (DNS). Run the following `nslookup` command to try to resolve the container registry sign-in server through the Azure DNS IP address (`168.63.129.16`).

```cmd
nslookup <container-registry-name>.azurecr.io 168.63.129.16
```

If Azure DNS resolves the name, check your device Domain Name System (DNS) settings. If the device uses a custom DNS server (not Azure DNS), ensure that the custom DNS server can resolve the name of the container registry sign-in server.