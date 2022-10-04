---
title: 'Credentials in ServicePrincipalProfile were invalid or AADSTS7000215: Invalid client secret'
description: Troubleshoot the credentials in ServicePrincipalProfile were invalid or AADSTS7000215 Invalid client secret is provided message.
ms.date: 5/25/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "The credentials in ServicePrincipalProfile were invalid" or "error:invalid_client AADSTS7000215: Invalid client secret is provided" error message so that I can work with my Azure Kubernetes Service (AKS) cluster successfully.
---
# "The credentials in ServicePrincipalProfile were invalid" or "error:invalid_client AADSTS7000215: Invalid client secret is provided" error message

This article discusses error messages involving the service principal profile credentials or the client secret when you try to create or manage a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) version 2.0.65 or later

## Symptoms

One of the following error messages appears when you're creating or managing an AKS cluster:

> The credentials in ServicePrincipalProfile were invalid

> error:invalid_client AADSTS7000215: Invalid client secret is provided

## Cause

Special characters in the value of the client secret haven't been escaped correctly.

## Solution

See [Update AKS cluster with new service principal credentials](/azure/aks/update-credentials#update-aks-cluster-with-new-service-principal-credentials), which describes how to use the [az aks update-credentials](/cli/azure/aks#az-aks-update-credentials) command with the `--client-secret` parameter to escape special characters in Azure CLI.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
