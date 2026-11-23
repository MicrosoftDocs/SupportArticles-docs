---
title: Troubleshoot issues when you pull from Azure Container Registry
description: Learn how to troubleshoot issues when you pull container images or artifacts from Azure Container Registry on a VM or other device, and resolve errors.
ms.date: 10/13/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: avtakkar, v-rekhanain, v-leedennis, andbar, kaushika
ms.service: azure-container-registry
ms.topic: troubleshooting
ms.custom: sap:Image Pull Issues
ai-usage: ai-assisted
#Customer intent: As an Azure Container Registry user, I want to learn how to troubleshoot common issues so that I can successfully pull a container image or artifact from Azure Container Registry by using an Azure virtual machine or other device.
---
# Troubleshoot issues when you pull from Azure Container Registry

## Summary

This article provides guidance for troubleshooting common issues that occur when pulling container images or artifacts from Azure Container Registry (ACR).

Pulling container images or artifacts from ACR is a fundamental task for deploying applications. However, issues can occur that are related to permissions, networking, identity management, and other factors. This article discusses how to troubleshoot issues that occur when you try to pull container images or artifacts from ACR by using an Azure virtual machine (VM) or other device (such as a laptops or on-premises computer). It also contains links to common scenarios and errors, and their resolutions.

## Prerequisites

Ensure you have the following prerequisites installed and configured before you start troubleshooting:

- [Azure CLI](/cli/azure/install-azure-cli)

## Troubleshooting checklist

The following checklist helps you systematically troubleshoot issues when pulling from ACR.

### Step 1: Reproduce the issue

Reproduce the issue (for example, by running `docker pull <image-name>`) so that you can view the error message and other details.

### Step 2: Check container registry health

To view a report about the health of the container registry, run the following [az acr check-health](/cli/azure/acr#az-acr-check-health) command.

```azurecli
az acr check-health --name <container-registry-name> --ignore-errors --yes
```

If an issue is detected, the report displays an error code and a description. For more information about the errors and possible solutions, see [Health check error reference](/azure/container-registry/container-registry-health-error-reference).

## Reference

- [Azure Container Registry documentation](/azure/container-registry/)
- [Check the health of an Azure container registry](/azure/container-registry/container-registry-check-health)
- ["Authentication required" error when trying to access Azure Container Registry](./authentication-required.md)
- ["Client with IP '\<device-ip-address>' is not allowed access" error](./client-ip-address-not-allowed-access.md)
- ["Context deadline exceeded" error during an image pull in Azure Container Registry](./context-deadline-exceeded.md)
- ["I/O time-out" error when trying to access Azure Container Registry](./download-failed-443-io-time-out.md)
- ["Manifest unknown: manifest tagged by "\<tag>" is not found" error](./manifest-tag-not-found.md)
- ["Request canceled while waiting for connection" error](./request-canceled-waiting-connection-timeout-exceeded.md)