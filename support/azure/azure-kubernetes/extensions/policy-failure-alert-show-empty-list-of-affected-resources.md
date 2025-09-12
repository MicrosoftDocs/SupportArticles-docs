---
title: Azure policy failure alert shows an empty list of affected resources
description: Provide a solution to an issue where an Azure policy failure alert shows an empty list of affected resources.
ms.date: 04/12/2024
ms.reviewer: momajed, cssakscic
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Azure policy failure alert shows an empty list of affected resources

This article provides a solution to an issue where a policy failure alert shows an empty list of affected resources when you use the Azure Policy Add-on for Azure Kubernetes Service (AKS).

## Symptoms

When an Azure policy deployed in an AKS cluster fails, the policy failure alert incorrectly displays an empty list of affected resources in the Azure portal.

## Cause

This issue might be caused by a delay or Graph API issue. This issue can occur even if the policy violation has been resolved. 

## Resolution

If you suspect the alert is erroneous and the policy violation has been mitigated, wait for some time to allow for potential updates and synchronizations. In most cases, the issue can be resolved automatically when the system updates the alert status. 

However, if the alert persists for more than a week or you believe the alert is inaccurate, we recommend opening a support case with Azure Support. Provide details about the specific policy, the related alert, error messages, or any relevant information. The Azure Support team will assist in investigating and resolving the issue.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
