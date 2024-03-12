---
title: Error AADSTS7000110 - Request is ambiguous, multiple application identifiers found
description: Learn how to resolve an AADSTS7000110 error that occurs when you try to sign in to an Azure app that can be used together with Microsoft Entra ID.
author: custorod
ms.author: custorod
ms.editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: identity-platform
ms.topic: troubleshooting-problem-resolution
ms.date: 01/11/2024
---

# Error AADSTS7000110: Request is ambiguous, multiple application identifiers found

This article discusses how to resolve the `AADSTS7000110` error that occurs when an application tries to obtain or refresh a token from Microsoft Entra ID.

## Symptoms

When you try to sign in to an Azure application that can be used together with Microsoft Entra ID, you receive the following `AADSTS7000110` error message:

> Request is ambiguous, multiple application identifiers found.

## Cause

The application tried to do one of the following activities:

- Redeem an OAuth2 authorization code to get an access token or a refresh token that has the wrong application ID (`client_id` parameter).

- Use a refresh token that was initially issued to the application ID of a different caller.

## Solution

Use an OAuth2 authorization code or a refresh token that's from the same application ID (`client_id` parameter).

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes).

To investigate individual errors, go to <https://login.microsoftonline.com/error>.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)] 
