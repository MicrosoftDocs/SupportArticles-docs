---
title: Error AADSTS500571 - Guest user account is disabled
description: Resolve a scenario in which a guest user experiences an AADSTS500571 error when they try to sign in to an Azure app that can be used with Microsoft Entra ID.
author: custorod
ms.author: custorod
ms.reviewer: azureidcic, v-leedennis
editor: v-jsitser
ms.service: active-directory
ms.subservice: app-mgmt
ms.topic: troubleshooting-problem-resolution
ms.date: 11/02/2023
---
# Error AADSTS500571 - Guest user account is disabled

This article discusses how to resolve an `AADSTS500571` error that occurs when a user tries to sign in to an application that can be used together with Microsoft Entra ID.

## Symptoms

When a guest user tries to sign in to an application that's integrated into Microsoft Entra ID, they receive an "AADSTS500571" error message ("The guest user account is disabled").

## Cause

The guest user object is disabled on the resource tenant.

## Solution

Engage the resource tenant owners or sponsor to determine the reason that the guest account is disabled. Then, take the corresponding action, as shown in the following table.

| Scenario | Action |
|--|--|
| The guest account is supposed to be disabled. | No actions should be performed. Access is expectedly blocked. |
| The guest account isn't supposed to be disabled, or it was disabled by mistake. | Resource tenant owners should re-enable the account. One of the options to re-enable the account is by using PowerShell to set the `-AccountEnabled` parameter to `$true`, as described in the [Set-AzureADUser](/powershell/module/azuread/set-azureaduser#parameters) cmdlet reference. |

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to <https://login.microsoftonline.com/error>.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
