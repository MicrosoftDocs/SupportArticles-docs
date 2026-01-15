---
title: ServiceUnavailable - container group quota exceeded in region
description: Learn how to resolve a (ServiceUnavailable - container group quota exceeded in region) error message that occurs when you try to deploy several container groups.
ms.date: 02/23/2024
author: tysonfms
ms.author: tysonfreeman
editor: kennethgp
ms.reviewer: v-leedennis
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve a "ServiceUnavailable" error ("Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region") so that I can successfully deploy container groups onto Azure Container Instances.
---
# "(ServiceUnavailable)... container group quota... exceeded in region" error

This article discusses how to resolve a "quota exceeded" error that occurs when you try to deploy multiple container groups in different regions in Microsoft Azure Container Instances.

## Symptoms

You receive the following error message:

> **Message**: Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region '\<region>'. Limit: '0', Usage: '0' Requested: '1'.  
> **ERROR**: (ServiceUnavailable) Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region '\<region>'.  
> **Limit**: '0',  
> **Usage**: '0'  
> **Requested**: '1'.  
> **Code**: ServiceUnavailable

However, you confirm there's enough quota settings for this deployment.

## Cause

You try to simultaneously deploy multiple container groups in different regions that use the same name. This action triggers the fraud detection logic in Container Instances. Automation scripts that are run in the cloud might be trying to do this multi-deployment operation. You can identify this scenario by the '0' limit and usage fields in error message.

## Solution

To avoid this error, issue requests for container group deployments one at a time.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
