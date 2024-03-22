---
title: Find-AzureRmResource fails or cannot be found after you update Azure modules
description: Fixes an issue in which the Find-AzureRmResource cmdlet fails or cannot be found after you update Azure modules.
ms.date: 08/14/2020
ms.service: automation
ms.author: genli
author: genlin
ms.reviewer: 
---
# Find-AzureRmResource fails or cannot be found after you update Azure modules

This article provides a resolution to an issue in which the `Find-AzureRmResource` cmdlet fails or cannot be found after you update Azure modules.

_Original product version:_ &nbsp; Azure Automation  
_Original KB number:_ &nbsp; 4338620

## Symptoms

After you update the Microsoft Azure modules in your automation account, any runbook that uses the `Find-AzureRmResource` cmdlet fails and returns an exception, or it records an error entry that states that the program cannot find the `Find-AzureRmResource`  cmdlet.

## Cause

Starting in Microsoft AzureRM 6.0.0, the `Find-AzureRmResource` cmdlet functionality is merged with the `Get-AzureRmResource` cmdlet, and the `Find-AzureRmResource` cmdlet is removed. This is noted in the [Azure PowerShell 6.0.0 migration guide](https://github.com/Azure/azure-powershell/blob/preview/documentation/migration-guides/migration-guide.6.0.0.md#breaking-changes-to-azurermresources-cmdlets).

## Resolution

To fix this issue, update your runbooks to use `Get-AzureRmResource` instead of `Find-AzureRmResource`. For more information, see the [usage of Get-AzureRmResource](/powershell/module/azurerm.resources/get-azurermresource?view=azurermps-6.1.0&preserve-view=true).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
