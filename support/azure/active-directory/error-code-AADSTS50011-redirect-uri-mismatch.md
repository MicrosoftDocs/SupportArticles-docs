---
title: Error AADSTS50011  - The redirect URI specified in the request does not match the redirect URIs configured for the application.
description: Describes a problem in which you receive the error AADSTS50011 when signing in to an OIDC-based SSO application with Azure Active Directory.
author: aricrowe57
ms.date: 12/1/2021
ms.prod-support-area-path: 
ms.reviewer: arcrowe
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50011: The redirect URI specified in the request does not match

This article describes a problem in which error `AADSTS50011` is returned when trying to sign in to an application that uses OpenID Connect (OIDC) based single sign-on (SSO) with Azure Active Directory (Azure AD).

## Symptoms

You receive the following error message when trying to sign into an application that use OIDC or OAuth2 authentication protocols with Azure AD.

   Error AADSTS50011 - The redirect URI \<Redirect URI\> specified in the request does not match the redirect URIs configured for the application \<GUID\>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this.

## Cause

This error occurs if the `redirect URI` that the application sent doesn't match any of the redirect URIs registered on the application itself.

When the a user tries to sign in the application by using OIDC or OAuth2 SSO, the login server (Azure AD) needs to know where to send the authorization code or access token that proves the user has been successfully authenticated.  The application tells Azure AD this information by sending the `redirect URI` with the login request.  However, the protocol specifications require that the `redirect URI` that the application sends must also be registered on the application itself.  

## Resolution

To fix the issue, follow these steps:

1.  Copy the \<GUID\> value from the error message. This is your application (client) ID.

1. Go to the **Authentication** blade of your application in the Azure portal. You open the page directly by inserting your application ID as the GUID value in one of the following links:
   - If this app is owned by an organization (Azure AD tenant), use the link `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<GUID>/`. Make sure you sign in to the portal with an administrator account for that organization, or an account that owns the application.
   -  if this app is owned by your personal Microsoft (MSA) account, use the link `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<GUID>/isMSAApp/true`. Make sure you sign into the portal with that personal Microsoft account.

1. Copy the \<redirect URI\> value from the error message.
  
1. Add the redirect URI to the appropriate platform configuration. This might be web, single page app, or some public/native client platform. Make sure to save after the redirect URI is added.
  
After these steps are done, wait a few minutes and send the log in request again.  You should be able to sign in to the application.

>[!Note]
>The redirect URI is also known as the reply Url. These values depend on what protocol is being used. OIDC and OAuth2 protocols refer to this value as a redirect URI.

The following video shows how to fix the redirect URI mismatch error in Azure AD:

> [!VIDEO https://www.youtube.com/embed/a_abaB7494s]

## More Information

For a full list of Active Directory Authentication and authorization error codes, see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).
