---
title: Error AADSTS50011 - The reply URL specified in the request does not match the reply URLs configured for the application.
description: Describes a problem in which you receive an error message when signing in to OIDC-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP). The error you receive is AADSTS50011: The redirect URI <redirect URI sent> specified in the request does not match the redirect URIs configured for the application <GUID>.  Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this.
ms.date: 03/15/2021
ms.prod-support-area-path: 
ms.reviewer: arcrowe
ms.service: active-directory
ms.subservice: app-dev
---
Error AADSTS50011: The redirect URI <redirect URI sent> specified in the request does not match the redirect URIs configured for the application <GUID>.  Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this.

This article describes a problem in which you receive the error message "Error AADSTS50011: The redirect URI <redirect URI sent> specified in the request does not match the redirect URIs configured for the application <GUID>.  Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this." when trying to sign into an OIDC-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory (Azure AD).

## Symptoms

You receive error `AADSTS50011` when trying to sign into an application that has been setup to use Azure AD for identity management using OIDC or OAuth-based SSO.

## Cause

The ...

## Resolution

To fix the issue, follow these steps:

1. Ensure that...

As an example, refer to the following article for detailed steps about how to configure the values in Azure AD:

>[!Note]
>The redirect URI is also known as the reply Url. These values depend on what protocol is being used. OIDC and OAuth protocols refer to this value as a redirect URI.

After you've updated the Redirect URI value in Azure AD, and it matches the value sent by the application in the login request, you should be able to sign in to the application.

The following video shows how to fix the reply URL mismatch error in Azure AD:

> [!VIDEO https://www.youtube.com/embed/a_abaB7494s]

## More Information

For a full list of Active Directory Authentication and authorization error codes, see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).
