---
title: Error AADSTS50057 - User account is disabled
description: Provides a solution to an issue where a user experiences the AADSTS500571 error when they try to sign in to an Azure app that can be used with Microsoft Entra ID.
ms.service: identity
ms.topic: troubleshooting-problem-resolution
ms.date: 12/25/2023
ms.reviewer: custorod, joaos, v-weizhu
---

# Error AADSTS50057 - User account is disabled

This article discusses how to resolve the "AADSTS50057" error that occurs when a user tries to sign in to an application that can be used together with Microsoft Entra ID.

## Symptoms

When users try to sign in to an application that's integrated into Microsoft Entra ID, they receive an "AADSTS50057" error message ("The user account is disabled.").

## Cause

The user object is disabled on the resource tenant.

## Solution

Engage the resource tenant owners to determine why the user account is disabled. Then, take the corresponding action, as shown in the following table.

| Scenario | Action |
|--|--|
| The user account is supposed to be disabled. | No actions should be performed. Access is expectedly blocked. |
| The user account isn't supposed to be disabled, or it was disabled by mistake. | Resource tenant owners should re-enable the account. One of the options to re-enable the account is using PowerShell to set the `-AccountEnabled` parameter to `$true`, as described in the [Set-AzureADUser](/powershell/module/azuread/set-azureaduser#parameters) cmdlet reference. |

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to [https://login.microsoftonline.com/error](https://login.microsoftonline.com/error).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)] 
