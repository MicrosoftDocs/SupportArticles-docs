---
title: Warning (Pending service account password expiration) in Azure Stack
description: Provides information to an issue in which you receive a warning message in Microsoft Azure Stack.
ms.date: 08/14/2020
ms.service: azure-stack
ms.author: genli
author: genlin
ms.reviewer: 
---
# Warning in Azure Stack: Pending service account password expiration

This article provides information to an issue in which you receive a warning message in Microsoft Azure Stack: Pending Service Account Password Expiration.

_Original product version:_ &nbsp; Azure Stack Hub  
_Original KB number:_ &nbsp; 4465694

## Symptoms

In a Microsoft Azure Stack environment, you receive the following warning message:

> Pending Service Account Password Expiration

## Resolution

To resolve this problem, follow these steps.

**For an installation of Azure Stack earlier than version 1807**

1. Update the system to [Azure Stack 1807](/azure/azure-stack/azure-stack-update-1807) or a later version.  
2. Create a support request if you have issues when you try to update your environment, or if you expect that you won't be able to update to version 1807 before the account passwords expire.

**For an installation of Azure Stack 1807 or a later version**

Create a support request immediately. Microsoft engineers will assist you to resolve the problem.

## More information

The Azure Stack servicing policy requires that you run versions that are current or no more than two updates behind the current version in your environment. For example, if you have version 1807 installed in your environment, your environment is supported until the release of version 1810.

## References

For more information about updates for Azure Stack, see the "Update package release cadence" section of the following article:
[Azure Stack servicing policy](/azure-stack/operator/azure-stack-servicing-policy?view=azs-2005&preserve-view=true#update-package-release-cadence)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
