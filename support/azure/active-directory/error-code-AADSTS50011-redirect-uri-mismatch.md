---
title: Error AADSTS50011 the redirect URI does not match the redirect URIs configured for the application
description: Describes error AADSTS50011 that occurs when you sign in to an OIDC-based SSO application in Azure Active Directory.
author: aricrowe57
ms.date: 03/31/2023
ms.reviewer: arcrowe
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50011: The redirect URI specified in the request does not match

This article describes a problem in which an `AADSTS50011` error message is returned when you try to sign in to an application that uses OpenID Connect (OIDC)-based authentication with Azure Active Directory (Azure AD).

## Symptoms

You receive the following error message when you try to sign in to an application that uses OIDC or OAuth2 authentication protocols with Azure AD:

>Error AADSTS50011 - The redirect URI \<Redirect URI\> specified in the request does not match the redirect URIs configured for the application \<AppGUID\>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this.

## Cause

This error occurs if the redirect URI (reply URL) configured in the application (code) and the Azure AD app registration don't match.

When a user accesses the application for authentication, the application redirects the user to Azure AD with predefined redirect URI. Once the user is authorized successfully, Azure AD verifies the following values:

- The redirect URI sent from the application
- The redirect URI values in the registered application in Azure AD

If the redirect URI that the application sent doesn't match any of the redirect URIs in Azure AD, the error AADSTS50011 will be returned. If the values match, Azure AD sends user to the redirect URI.

## Resolution

To fix the issue, follow these steps to add redirect URI in Azure AD app registration.

1. Copy the application ID from the error message. This is the ID of your application that has been registered in Azure AD.
    ![The screenshot about the application ID in AADSTS50011 error message](media\error-code-AADSTS50011-redirect-uri-mismatch\aadsts50011-error-appid.png)

1. Go to the [Azure portal](https://portal.azure.com). Make sure that you sign in to the portal by using an account that has permissions to update Azure AD Application registration.
1. Negative to **Azure Active Directory**, select **App registrations**, locate the application registration by using the application ID, and then open the app registration page.

    You can also open the page directly by using the following links:

    - If this app is owned by an organization (Azure AD tenant), use `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<AppGUID>`.
    - If this app is owned by your personal Microsoft (MSA) account, use `https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<AppGUID>/isMSAApp/true`.

1. On the app registration page, select **Authentication**. In the **Platform configurations** section, select **Add URI** to add the Redirect URI that is displayed in the error message to Azure AD.

    ![The screenshot about redirect URI in the AADSTS50011 error message](media\error-code-AADSTS50011-redirect-uri-mismatch\aadsts50011-error-redirecturi.png)

1. Save the changes and wait three to five minutes for the changes to take effect, and then send the log-in request again. You should now be able to sign in to the application.

>[!Note]
>If the redirect URI sent from the application is not the desired one, you should update your application code or configuration.

The following video shows how to fix the redirect URI mismatch error in Azure AD:

> [!VIDEO https://www.youtube.com/embed/a_abaB7494s]

## More information

For a full list of Active Directory authentication and authorization error codes, see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
