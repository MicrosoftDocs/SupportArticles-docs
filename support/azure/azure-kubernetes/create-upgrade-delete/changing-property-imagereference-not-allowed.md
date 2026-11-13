---
title: Resolve changing property imageReference isn't allowed error in AKS
description: Resolve the 'Changing property imageReference isn't allowed' error when you upgrade or scale an Azure Kubernetes Service (AKS) cluster. Follow these steps to resolve it.
ms.date: 11/10/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, v-leedennis, kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "Changing property 'imageReference' is not allowed" error message so that I can upgrade or scale my Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Resolve the "Changing property 'imageReference' isn't allowed" error when you upgrade or scale an AKS cluster

## Summary

This article helps you resolve the "Changing property 'imageReference' isn't allowed" error that occurs when you upgrade or scale an Azure Kubernetes Service (AKS) cluster, so that your operation completes successfully.

## Symptoms

When you try to upgrade or scale an AKS cluster, you might receive the "Changing property 'imageReference' isn't allowed" error message.

## Cause

Unexpected results can occur if you modify or delete tags and other properties of resources within the *MC_** resource group. Also, altering the resources within the *MC_** group in the AKS cluster breaks the service-level objective (SLO).
 
## Solution

Add another node pool, and then delete the affected node pool to resolve the error.