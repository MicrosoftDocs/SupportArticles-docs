---
title: Azure Kubernetes Service (AKS) Error Codes
description: List of common AKS error codes
ms.date: 10/23/2025
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: error-reference
ms.reviewer: v-ryanberg, chiragpa, albarqaw
ms.service: azure-kubernetes-service
ms.custom: sap:AKS error codes, AKS errors
---
# Azure Kubernetes Service (AKS) error codes

This article describes common AKS errors and how to resolve them.

| **Error code** | **Description** | **Details and mitigation** |
| --- | ---------- | ----------------- |
| AADSTS7000222 - BadRequest or InvalidClientSecret | Authentication failure with Azure Active Directory. | This involves invalid or expired service principal credentials. For more information, see [AADSTS7000222 - BadRequest or InvalidClientSecret error](../create-upgrade-delete/error-code-badrequest-or-invalidclientsecret.md). |
| Argument list too long | Application fails due to command line argument limitations. | The command line arguments exceed system limits in containerized applications. For more information, see [Application failures caused by the "argument list too long" error message](./azure-kubernetes/create-upgrade-delete/application-fails-argument-list-too-long). |
| AksCapacityHeavyUsage | Insufficient capacity in the Azure region. | There's high demand or limited resources in the selected region. For more information, see [Troubleshoot the AksCapacityHeavyUsage error code](./azure-kubernetes/error-codes/akscapacityheavyusage-error). |
| AKSOperationPreempted | Cluster operation is interrupted by a higher priority operation. | There are concurrent operations on the cluster, causing conflicts. For more information, see [AKSOperationPreempted or AKSOperationPreemptedByDelete error when performing a new operation](aksoperationpreempted-error.md). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |
| | | For more information, see [](). |

|  |  |

## References

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
