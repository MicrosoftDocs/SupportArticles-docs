---
title: AADSTS7000215 Invalid client secret is provided
description: Troubleshoot the AADSTS7000215 Invalid client secret is provided error message when you try to connect to the Azure Kubernetes Service (AKS) API server.
ms.date: 7/6/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: chiragpa, nickoman
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "AADSTS7000215: Invalid client secret is provided" error message so that I can connect successfully to the Azure Kubernetes Service (AKS) API server.
---
# "AADSTS7000215: Invalid client secret is provided" error when you try to use the AKS API

This article discusses how to troubleshoot the "AADSTS7000215: Invalid client secret is provided" error when you try to connect to the Microsoft Azure Kubernetes Service (AKS) API server.

## Cause

The credentials for the service principal have expired.

## Solution

AKS clusters that are created by having a service principal have a one-year expiration time. To reset the credentials to extend the life of the service principal, follow the steps in [Update the credentials for an AKS cluster](/azure/aks/update-credentials).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
