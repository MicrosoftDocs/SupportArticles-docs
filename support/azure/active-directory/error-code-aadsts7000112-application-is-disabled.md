---
title: Error AADSTS7000112 - Application is disabled
description: Learn how to resolve the AADSTS7000112 error when you try to sign in to an Azure app that can be used with Microsoft Entra ID.
author: custorod
ms.author: custorod
ms.editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: identity-platform
ms.topic: troubleshooting-problem-resolution
ms.date: 01/11/2024
---

# Error AADSTS7000112 - Application is disabled

This article discusses how to resolve the `AADSTS7000112` error that occurs when you try to sign in to an application that can be used together with Microsoft Entra ID.

## Symptoms

When you try to sign in to an Azure application that's integrated into Microsoft Entra ID, you receive the following `AADSTS7000112` error message:

> Application '\<appIdentifier>'(\<appName>) disabled.

## Cause

The service principal object is disabled on the resource tenant.

## Solution

Work together with the resource tenant owners to determine why the service principal object is disabled. Then, use the following table to take the appropriate action.

| Scenario | Action |
|--|--|
| The service principal is supposed to be disabled. | Don't do anything. Access is intentionally blocked. We don't expect or recommend that resource tenant administrators of first-party applications disable the respective service principal. Microsoft Services automatically provisions and manages the service principals. |
| The service principal isn't supposed to be disabled, or it was disabled mistakenly. | Ask the resource tenant owners to re-enable the service principal. One method to re-enable the service principal is to use PowerShell to set the `-AccountEnabled` parameter to `$true`. For more information, see the [Set-AzureADServicePrincipal](/powershell/module/azuread/set-azureadserviceprincipal#example-1-disable-the-account-of-a-service-principal) cmdlet reference. |

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes).

To investigate individual errors, go to <https://login.microsoftonline.com/error>.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
