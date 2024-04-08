---
title: Custom Azure Policy for validating controllers doesn't work
description: Provide a solution to an issue where a custom Azure Policy for validating controllers doesn't work.
ms.date: 04/08/2024
ms.reviewer: momajed, cssakscic
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Custom Azure Policy for validating controllers doesn't work

This article provides a solution to an issue where a custom policy for validating controllers doesn't work when you use Azure Policy with an Azure Kubernetes Service (AKS) cluster.

## Symptoms

A custom policy created for validating controllers fails with an error.

## Cause

The custom policy isn't defined with the correct syntax.

## Solution

To resolve this issue, follow these steps to ensure that the custom policy works correctly and meets the necessary requirements:

1. Generate the custom policy with the correct syntax by using the Visual Studio Code extension designed for Azure Policy.

    Using this tool to generate a custom policy ensures that it can be properly defined and adhere to the required format.
   
3. Create and validate the custom policy by referencing [Azure Policy for Kubernetes releases support for custom policy](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-policy-for-kubernetes-releases-support-for-custom-policy/ba-p/2699466).


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
