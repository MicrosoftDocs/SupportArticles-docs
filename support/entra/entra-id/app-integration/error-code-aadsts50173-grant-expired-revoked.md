---
title: Error code AADSTS50173 - The Provided Grant Has Expired Due to it Being Revoked
description: Discusses how to handle a situation in which a user receives an AADSTS50173 error when trying to sign in to an application.
author: custorod
ms.author: custorod
ms.reviewer: joaos
ms.service: entra-id
ms.topic: troubleshooting-problem-resolution
ms.date: 02/21/2025
ms.subservice: authentication
ms.custom: sap:Issues signing in to applications
---

# Error AADSTS50173 - The provided grant has expired due to it being revoked

## Symptoms

When users try to sign in to an application that uses Microsoft Entra ID authentication, they receive the following error message:

> `AADSTS50173: The provided grant has expired due to it being revoked, a fresh auth token is needed. The user might have changed or reset their password. The grant was issued on '{authTime}' and the TokensValidFrom date (before which tokens are not valid) for this user is '{validDate}'.`


## Cause

This error occurs if the refresh token that's used for authentication is revoked. This issue occurs if:

- The user changes or resets their password.
- The refresh token expires.
- An administrator revokes the refresh token.

For more information, see:

- [Refresh tokens in the Microsoft identity platform](/entra/identity-platform/refresh-tokens#token-revocation) 
- [Revoke user access in Microsoft Entra ID](/entra/identity/users/users-revoke-access) 

## Resolution

To resolve this issue, follow the applicable steps.

### For users

On the application that experiences the issues, try to locate an option to reauthenticate or clear any cached token information. You can also perform these actions by signing out and signing back in to the application (if this step is applicable or available). 

### For application developers

If the application is using [Microsoft Authentication Library (MSAL)](/entra/identity-platform/msal-overview), follow [this guidance to handle errors and exceptions in MSAL](/entra/msal/dotnet/advanced/exceptions/msal-error-handling).

If the application isn't using MSAL, follow this guidance to [handle errors and exceptions in MSAL](/entra/msal/dotnet/advanced/exceptions/msal-error-handling), and try to implement a similar approach on the application. The goal is to request that the user reauthenticate and obtain a fresh token.

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes). 

To investigate individual errors, go to [https://login.microsoftonline.com/error](https://login.microsoftonline.com/error).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
