---
title: AADSTS7000215 Invalid client secret is provided
description: Troubleshoot the AADSTS7000215 Invalid client secret is provided error message when you try to connect to the Azure Kubernetes Service (AKS) API server.
ms.date: 6/1/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot "AADSTS7000215: Invalid client secret is provided" error message so that I can connect successfully to the Azure Kubernetes Service (AKS) API server.
---
# "AADSTS7000215: Invalid client secret is provided" error when you try to use the AKS API

This article discusses how to troubleshoot the "AADSTS7000215: Invalid client secret is provided" error when you try to connect to the Microsoft Azure Kubernetes Service (AKS) API server.

## Cause

The credentials for the service principal have expired.

## Solution

[Update the credentials for an AKS cluster](/azure/aks/update-credentials).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
