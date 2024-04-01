---
title: Excluding privileged containers fails
description: Provides a workaround to an issue where excluding privileged containers fails.
ms.date: 04/01/2024
ms.reviewer: momajed, cssakscic 
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Azure Policy can't exclude privileged containers from AKS clusters

This article provides a solution to an issue where Azure Policy can't exclude privileged containers from Azure Kubernetes Service (AKS) clusters.

## Symptoms

AKS clusters shouldn't allow privileged containers, but excluding privileged containers fails.

## Cause

Azure's built-in policies don't have container exclusion parameters for AKS clusters.

## Resolution

To resolve this issue, exclude containers from Azure Policy enforcement within your cluster. To do this, follow these steps:

1.	Create an exemption in the default Azure Security Center policy. This exemption will allow you to customize the policy for specific requirements. 

    When creating an exemption, you have the option to apply it to the whole assignment or exempt specific assignments based on your requirements. For more information, see [Exempt a resource](/azure/defender-for-cloud/exempt-resource).

2.	Create a new policy assignment that excludes the desired pods or containers. This will override the default policy behavior and exclude the specified pods or containers from policy enforcement. 

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
