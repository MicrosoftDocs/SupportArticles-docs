---
title: Custom Azure policy for validating controllers doesn't work
description: Provide a solution to an issue where a custom Azure policy for validating controllers doesn't work.
ms.date: 04/01/2024
ms.reviewer: momajed, cssakscic
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Custom Azure policy for validating controllers doesn't work

This article provides a solution to an issue where a custom Azure policy for validation controllers doesn't work.

## Symptoms

A custom Azure policy for validating controllers doesn't work.  You may encounter the following error message:

> Operation cannot be fulfilled on customresourcedefinitions.apiextensions.k8s.io \"k8sazureenforcenamenotregexes.constraints.gatekeeper.sh\": the object has been modified; please apply your changes to the latest version and try again”

## Resolution

To resolve this issue, follow these steps:

1. Use the Visual Studio extension designed for Azure Policy to generate the custom policy with the correct syntax.
2. Create and validate custom policies. For more information, see [Azure Policy for Kubernetes releases support for custom policy](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-policy-for-kubernetes-releases-support-for-custom-policy/ba-p/2699466).

This ensures that the policy is properly defined and adheres to the required format. It also can ensure that your custom policy for validating controllers functions correctly and meets the necessary requirements. 

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
