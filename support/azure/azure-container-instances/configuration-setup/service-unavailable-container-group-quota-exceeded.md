---
title: ServiceUnavailable - container group quota exceeded in region
description: Learn how to resolve a (ServiceUnavailable - container group quota exceeded in region) error message that occurs when you try to deploy several container groups.
ms.date: 02/23/2024
author: tysonfms
ms.author: tysonfreeman
editor: shanjungfu
ms.reviewer: v-leedennis, kennethgp
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve a "ServiceUnavailable" error ("Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region") so that I can successfully deploy container groups onto Azure Container Instances.
---
# "(ServiceUnavailable)... container group quota... exceeded in region" error

This article discusses how to resolve a "quota exceeded" error that occurs when you try to deploy multiple container groups in different regions in Microsoft Azure Container Instances.

## Symptoms

When deploying multiple Azure Container Instances (ACI) container groups across different regions, the deployment fails with the following error:

> **Message**: Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region '\<region>'. Limit: '0', Usage: '0' Requested: '1'.  
> **ERROR**: (ServiceUnavailable) Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region '\<region>'.  
> **Limit**: '0',  
> **Usage**: '0'  
> **Requested**: '1'.  
> **Code**: ServiceUnavailable

The error may suggest a quota issue even though the customer has confirmed that sufficient quota is available for the deployment

## Cause

You try to simultaneously deploy multiple container groups in different regions that use the same name. This action triggers the fraud detection logic in Container Instances. Automation scripts that run in the cloud might be attempting this multi-deployment operation.

You can identify this scenario by the `0` values in the Limit and Usage fields of the error message.

## Solution

Verify whether the deployment process or automation is simultaneously creating container groups with the same name across multiple Azure regions.

If this deployment pattern is identified, modify the deployment workflow to submit the container group deployment requests one at a time instead of deploying them simultaneously.