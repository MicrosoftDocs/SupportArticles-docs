---
title: Azure Policy fails to exclude privileged containers from AKS
description: Provides a workaround for an issue where Azure Policy fails to exclude privileged containers from Azure Kubernetes Service (AKS).
ms.date: 04/12/2024
ms.reviewer: momajed, cssakscic 
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Azure Policy can't exclude privileged containers from AKS clusters

This article provides a solution to an issue where Azure Policy can't exclude privileged containers from Azure Kubernetes Service (AKS) clusters.

## Symptoms

When you use Azure Policy in an AKS cluster, excluding privileged containers fails.

## Cause

Azure's built-in policies don't have container exclusion parameters for AKS clusters.

## Resolution

To resolve this issue, exclude containers from Azure Policy enforcement within your cluster. Here are the steps:

1. Create an exemption in the default Azure Security Center policy. This exemption allows you to customize the policy to meet specific requirements. 

   When creating an exemption, you can apply it to the whole assignment or exempt specific assignments based on your requirements. For more information, see [Exempt a resource](/azure/defender-for-cloud/exempt-resource).

2. Create a new policy assignment that excludes the desired pods or containers. This overrides the default policy behavior and excludes the specified pods or containers from policy enforcement. 

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
