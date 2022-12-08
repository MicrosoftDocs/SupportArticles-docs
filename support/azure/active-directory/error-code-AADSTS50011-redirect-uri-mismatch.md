---
title: Error AADSTS50011 the redirect URI not match the redirect URIs configured for the application
description: Describes error AADSTS50011 that occurs when you sign in to an OIDC-based SSO application in Azure Active Directory.
author: aricrowe57
ms.date: 03/11/2022
ms.reviewer: arcrowe
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50011: The redirect URI specified in the request does not match

This article describes a problem in which an `AADSTS50011` error message is returned when you try to sign in to an application that uses OpenID Connect (OIDC)-based single sign-on (SSO) with Azure Active Directory (Azure AD).

## Symptoms

You receive the following error message when you try to sign in to an application that uses OIDC or OAuth2 authentication protocols with Azure AD:

>Error AADSTS50011 - The redirect URI \<Redirect URI\> specified in the request does not match the redirect URIs configured for the application \<GUID\>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this.

## Cause

This error occurs if the `redirect URI` that the application sent doesn't match any of the redirect URIs that are registered on the application itself.

When the user tries to sign in to the application by using OIDC or OAuth2 SSO, the login server (Azure AD) has to know where to send the authorization code or access token that proves that the user has been successfully authenticated. The application notifies Azure AD by sending the `redirect URI` together with the login request. However, the protocol specifications require that the `redirect URI` that the application sends must also be registered on the application itself.

## Resolution

To fix the issue, follow these steps:

1. Copy the \<GUID\> value from the error message. This is your application (client) ID.

1. Go to the **Authentication** blade of your application in the Azure portal. You can open the page directly by inserting your application ID as the GUID value in one of the following links:
    - If this app is owned by an organization (Azure AD tenant), use `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<GUID>`. Make sure that you sign in to the portal by using an administrator account for that organization, or an account that owns the application.
    - If this app is owned by your personal Microsoft (MSA) account, use `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<GUID>/isMSAApp/true`. Make sure that you sign in to the portal by using your personal Microsoft account.

1. Copy the \<redirect URI\> value from the error message.

1. Add the redirect URI to the appropriate platform configuration. This might be the web, single page app, or some public/native client platform. Make sure to save the input after the redirect URI is added.

1. Wait three to five minutes to let the change take effect, and then send the log-in request again. You should now be able to sign in to the application.

>[!Note]
>The redirect URI is also known as the reply URL. These values depend on which protocol is used. OIDC and OAuth2 protocols refer to this value as a redirect URI.

The following video shows how to fix the redirect URI mismatch error in Azure AD:

> [!VIDEO <https://www.youtube.com/embed/a_abaB7494s>]

## More information

For a full list of Active Directory authentication and authorization error codes, see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
