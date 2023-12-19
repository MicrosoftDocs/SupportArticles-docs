---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      custorod # GitHub alias
ms.author:    # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     12/19/2023
---

# Error AADSTS50057 - User account is disabled

This article discusses how to resolve an `AADSTS50057` error that occurs when a user tries to sign in to an application that can be used together with Microsoft Entra ID.

## Symptoms

When a user tries to sign in to an application that's integrated into Microsoft Entra ID, they receive an "AADSTS50057" error message ("The user account is disabled.").

## Cause

The user object is disabled on the resource tenant.

## Solution

Engage the resource tenant owners to determine the reason that the user account is disabled. Then, take the corresponding action, as shown in the following table.

| Scenario | Action |
|--|--|
| The user account is supposed to be disabled. | No actions should be performed. Access is expectedly blocked. |
| The user account isn't supposed to be disabled, or it was disabled by mistake. | Resource tenant owners should re-enable the account. One of the options to re-enable the account is by using PowerShell to set the `-AccountEnabled` parameter to `$true`, as described in the [Set-AzureADUser](/powershell/module/azuread/set-azureaduser#parameters) cmdlet reference. |

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to <https://login.microsoftonline.com/error>.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)] 
