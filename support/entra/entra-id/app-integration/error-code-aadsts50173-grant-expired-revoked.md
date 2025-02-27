---
title: Error code AADSTS50173 - The provided grant has expired due to it being revoked
description: Describes a problem and solution in which a user receives the error AADSTS50173 when trying to sign-in
author:      custorod
ms.author: custorod
ms.service: entra-id
ms.topic: troubleshooting-problem-resolution
ms.date:     02/21/2025
ms.subservice: authentication
ms.custom: sap:Issues Signing In to Applications
---

# AADSTS50173 - The provided grant has expired due to it being revoked

## Symptoms

When users try to sign in to an application that uses Microsoft Entra ID authentication, they receive the following error message:

> `AADSTS50173: The provided grant has expired due to it being revoked, a fresh auth token is needed. The user might have changed or reset their password. The grant was issued on '{authTime}' and the TokensValidFrom date (before which tokens are not valid) for this user is '{validDate}'.`


## Cause

This error occurs when the refresh token used for authentication has been revoked. This issue occurs if:

- The user changes or resets their password.
- The refresh token expires.
- An administrator revokes the refresh token.

For more information, see:

- [Token Revocation in Microsoft Entra ID](/entra/identity-platform/refresh-tokens#token-revocation) 
- [Revoke user access in Microsoft Entra ID](/entra/identity/users/users-revoke-access) 


## Resolution

To resolve this issue, follow these steps:

### For end users

On the application being used, try to locate an option to reauthenticate and clear any cached token information. This can also be achieved by signing out and signing back in to the application (when applicable/available). 

### For application developers

If the application is using [Microsoft Authentication Library (MSAL)](/entra/identity-platform/msal-overview), follow guidance regarding on how to [Handle errors and exceptions in MSAL](/entra/msal/dotnet/advanced/exceptions/msal-error-handling).

If the application isn't using [Microsoft Authentication Library (MSAL)](/entra/identity-platform/msal-overview), consult information about how to [Handle errors and exceptions in MSAL](/entra/msal/dotnet/advanced/exceptions/msal-error-handling) and try to implement a similar approach on the application. The goal is to request user to re-authenticate and obtain a fresh token.  

## More Information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes). 

To investigate individual errors, go to [https://login.microsoftonline.com/error](https://login.microsoftonline.com/error). 