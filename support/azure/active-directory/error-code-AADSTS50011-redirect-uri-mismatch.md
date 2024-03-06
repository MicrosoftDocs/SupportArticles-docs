---
title: Error AADSTS50011 the redirect URI does not match the redirect URIs configured for the application
description: Describes error AADSTS50011 that occurs when you sign in to an OIDC-based SSO application in Microsoft Entra ID.
author: aricrowe57
ms.date: 02/28/2024
ms.reviewer: arcrowe
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50011 with OpenID authentication: The redirect URI specified in the request does not match

This article describes a problem in which an `AADSTS50011` error message is returned when you try to sign in to an application that uses OpenID Connect (OIDC)-based authentication with Microsoft Entra ID.

## Symptoms

You receive the following error message when you try to sign in to an application that uses OIDC or OAuth2 authentication protocols with Microsoft Entra ID:

>Error AADSTS50011 - The redirect URI \<Redirect URI\> specified in the request does not match the redirect URIs configured for the application \<AppGUID\>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this.

## Cause

This error occurs if the redirect URI (reply URL) configured in the application (code) and the Microsoft Entra app registration don't match.

When a user accesses the application for authentication, the application redirects the user to Microsoft Entra ID with a predefined redirect URI. Once the user is authorized successfully, Microsoft Entra ID verifies the following values:

- The redirect URI sent from the application
- The redirect URI values in the registered application in Microsoft Entra ID

If the redirect URI the application sent doesn't match any of the redirect URIs in Microsoft Entra ID, error AADSTS50011 will be returned. If the values match, Microsoft Entra ID sends the user to the redirect URI.

## Resolution

To fix the issue, follow these steps to add a redirect URI in Microsoft Entra app registration.

1. Copy the application ID from the error message. This is the ID of your application that has been registered in Microsoft Entra ID.
    ![The screenshot about the application ID in AADSTS50011 error message](media\error-code-AADSTS50011-redirect-uri-mismatch\aadsts50011-error-appid.png)

1. Go to the [Azure portal](https://portal.azure.com). Make sure you sign in to the portal by using an account that has permissions to update Microsoft Entra Application registration.
1. Navigate to **Microsoft Entra ID**, select **App registrations**, locate the application registration by using the application ID, and then open the app registration page.

    You can also open the page directly by using the following links:

    - If this app is owned by an organization (Microsoft Entra tenant), use `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<AppGUID>`.
    - If this app is owned by your personal Microsoft (MSA) account, use `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<AppGUID>/isMSAApp/true`.

1. On the app registration page, select **Authentication**. In the **Platform configurations** section, select **Add URI** to add the redirect URI displayed in the error message to Microsoft Entra ID.

    ![The screenshot about redirect URI in the AADSTS50011 error message](media\error-code-AADSTS50011-redirect-uri-mismatch\aadsts50011-error-redirecturi.png)

1. Save the changes and wait three to five minutes for the changes to take effect, and then send the login request again. You should now be able to sign in to the application. If you don't see the Microsoft Entra login page, try clearing the password cache from your browser or use InPrivate browsing.

>[!Note]
>If the redirect URI sent from the application isn't the desired one, you should update your application code or configuration.

The following video shows how to fix the redirect URI mismatch error in Microsoft Entra ID:

> [!VIDEO https://www.youtube.com/embed/a_abaB7494s]

## More information

For a complete list of Active Directory authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
