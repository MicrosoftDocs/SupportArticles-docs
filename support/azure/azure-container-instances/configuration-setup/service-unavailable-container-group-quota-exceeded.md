---
title: ServiceUnavailable - container group quota exceeded in region error in Azure Container Instances
description: Learn how to resolve the ServiceUnavailable container group quota exceeded in region error when you deploy multiple container groups in Azure Container Instances.
ms.date: 10/01/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: v-leedennis, kennethgp, tysonfreeman, kaushika
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve a "ServiceUnavailable" error ("Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region") so that I can successfully deploy container groups onto Azure Container Instances.
ai-usage: ai-assisted
---
# "ServiceUnavailable - container group quota exceeded in region" error 

## Summary

This article describes how to resolve a "ServiceUnavailable - container group quota exceeded in region" error that occurs when you try to deploy multiple container groups in different regions in Azure Container Instances (ACI).

## Symptoms

You receive the following error message.

> **Message**: Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region '\<region>'. Limit: '0', Usage: '0' Requested: '1'.  
> **ERROR**: (ServiceUnavailable) Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'ContainerGroups' exceeded in region '\<region>'.  
> **Limit**: '0',  
> **Usage**: '0'  
> **Requested**: '1'.  
> **Code**: ServiceUnavailable

However, you confirm there's enough quota settings for this deployment.

## Cause

You try to simultaneously deploy multiple container groups in different regions that use the same name. This action triggers the fraud detection logic in ACI. Automation scripts that run in the cloud might be trying to do this multi-deployment operation. You can identify this scenario by the `0` limit and usage fields in the error message.

## Solution

To avoid this error, send requests for container group deployments one at a time.