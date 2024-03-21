---
title: Method invocation failed error when you run Azure PowerShell cmdlets
description: Discusses that you receive an error message when you run Azure PowerShell cmdlets. Provides a resolution.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: domain-services
ms.custom: devx-track-azurepowershell
---
# Error when you run Azure PowerShell cmdlets: Method invocation failed

This article discusses an issue in which you receive an error message "Method invocation failed because [System.Object[]] doesn't contain a method named 'RemoveAll'." when you run Azure PowerShell cmdlets.

_Original product version:_ &nbsp; Microsoft Entra ID, Cloud Services (Web roles/Worker roles)  
_Original KB number:_ &nbsp; 3072418

## Symptoms

When you run Windows Azure PowerShell cmdlets, you receive an error message that resembles the following message:

> Method invocation failed because [System.Object[]] doesn't contain a method named 'RemoveAll'.

## Cause

This problem occurs for either of the following reasons:

- You are using an outdated version of Azure PowerShell.
- You are using a method name that does not exist.

## Resolution

To resolve this problem, do either of the following:

- Install the latest version of Azure PowerShell. To upgrade the program, see [How to install and configure Azure PowerShell](/powershell/azure).
- Make sure that you are using the correct method name.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
