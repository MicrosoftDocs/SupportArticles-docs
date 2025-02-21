---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title: Error code AADSTS50173 - The provided grant has expired due to it being revoked
description: Describes a problem and solution in which a user receives the error AADSTS50173 when trying to sign-in
author:      custorod # GitHub alias
ms.author: custorod
ms.service: entra-id
ms.topic: troubleshooting-problem-resolution
ms.date:     02/21/2025
ms.subservice: authentication
---

# Error code AADSTS50173 - The provided grant has expired due to it being revoked

## Symptoms

When attempting to authenticate with Microsoft Entra ID, you may encounter the following error message:

```
AADSTS50173: The provided grant has expired due to it being revoked, a fresh auth token is needed. The user might have changed or reset their password. The grant was issued on '{authTime}' and the TokensValidFrom date (before which tokens are not valid) for this user is '{validDate}'.
```

## Cause

This error occurs when the refresh token used for authentication has been revoked. This can happen due to several factors, including:

- The user has changed or reset their password.
- The refresh token has expired.
- The refresh token has been revoked by an administrator.

For reference: 
[Token Revocation in Microsoft Entra ID](/entra/identity-platform/refresh-tokens#token-revocation) 
[Revoke user access in Microsoft Entra ID](/entra/identity/users/users-revoke-access) 


## Resolution

To resolve this issue, follow these steps:

### Step 1: If you’re a user receiving this error 

On the application being used, try to locate an option to re-authenticate and/or clear any cached token information. This can also be achieved by signing out and signing back in to the application (when applicable/available). 


### Step 2: If you’re an application developer looking to address this error 

If the application is using [Microsoft Authentication Library (MSAL)](/entra/identity-platform/msal-overview), follow guidance regarding on how to [Handle errors and exceptions in MSAL](/entra/msal/dotnet/advanced/exceptions/msal-error-handling).

If the application is not using [Microsoft Authentication Library (MSAL)](/entra/identity-platform/msal-overview), consult information about how to [Handle errors and exceptions in MSAL](/entra/msal/dotnet/advanced/exceptions/msal-error-handling) and try to implement a similar approach on the application. The goal is to request user to re-authenticate and obtain a fresh token.  

## More Information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes). 

To investigate individual errors, go to [https://login.microsoftonline.com/error](https://login.microsoftonline.com/error). 