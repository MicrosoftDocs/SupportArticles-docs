---
title: Azure policy failure alert shows an empty list of affected resources
description: Provide a solution to an issue where Azure policy failure alert shows an empty list of affected resources.
ms.date: 04/09/2024
ms.reviewer: momajed, cssakscic
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Azure policy failure alert shows an empty list of affected resources

This article provides a solution to an issue where a policy failure alert shows an empty list of affected resources when you use Azure Policy's Add-on for Azure Kubernetes Service (AKS).

## Symptoms

When an Azure policy deployed in an AKS cluster fails, the policy failure alert is display incorrectly and shows an empty list of affected resources in the Azure portal.

## Cause

This issue might occur due to a delay or Graph API issue. This issue can occur even if the policy violation has been resolved. 

## Resolution

If you suspect that the alert is erroneous and the policy violation has been mitigated, wait for some time to allow for potential updates and synchronization. In most cases, the issue can be resolved automatically as the system updates the alert status. 

However, if the alert persists for more than a week or you believe it to be inaccurate, we recommend openning a support case with Azure Support. Provide details about the specific policy, the alert in question, error messages, or any relevant information. The Azure Support team will assist in investigating and resolving the issue.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
