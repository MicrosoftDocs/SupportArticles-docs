---
title: Error AADSTS50011 - The redirect URI specified in the request does not match the redirect URIs configured for the application...
description: Describes a problem in which you receive an error message when signing in to OIDC-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP). The error you receive is Error AADSTS50011 - The redirect URI <redirect URI sent> specified in the request does not match the redirect URIs configured for the application <GUID>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this.
ms.date: 12/1/2021
ms.prod-support-area-path: 
ms.reviewer: arcrowe
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50011: The redirect URI 'redirect URI sent' specified in the request does not match the redirect URIs configured for the application 'appId'...

This article describes a problem in which you receive the error message "Error AADSTS50011 - The redirect URI \<redirect URI sent\> specified in the request does not match the redirect URIs configured for the application \<GUID\>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/redirectUriMismatchError to learn more about how to fix this." when trying to sign into an OIDC-based app that has been integrated with Azure Active Directory (Azure AD).

## Symptoms

You receive error `AADSTS50011` when trying to sign into an application that has been setup to use Azure AD for identity management using OIDC or OAuth protocols.

## Cause

When an app tries to sign in an Azure Active Directory user with OIDC or OAuth, the login server (Azure AD) needs to know where to send the authorization code or access token that proves the user has been successfully authenticated.  The app tells Azure AD this by sending the URI to redirect to, called the 'redirect URI', with the login request.  However, protocol specifications require that the redirect URI the app sends in the request also be registered on the application itself.  You will receive this error if your app sent a redirect URI in the login request that doesn't match any of the redirect URIs registered on your application. 

## Resolution

To fix the issue, follow these steps:

1. Retreive your application (client) ID.  You may already know this value.  If not, you can extract it from the error message.   The error message should be in the format 'The redirect URI /<redirect URI sent/> specified in the request does not match the redirect URIs configured for the application /<GUID/>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal...'.  Copy the /<GUID/> value.
  
1. Navigate to the authentication blade of your application in the Azure portal.  You can get to this page directly by inserting your application ID as the GUID value in one of the following links:
   - 'https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<GUID>' . Use this link if this app is part of an organization, or AAD tenant.  This is most likely the link you want to use.  Make sure you sign in to the portal with an administrator account for that organization, or an account that owns the application.
   -  'https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Authentication/appId/<GUID>/isMSAApp/true'.  Use this link if this app is owned by your personal Microsoft (MSA) account.  Make sure you sign into the portal with that personal Microsoft account. 

1. Extract the redirect URI that was sent in the request from the error message.  The error message should be in the format 'The redirect URI /<redirect URI sent/> specified in the request does not match the redirect URIs configured for the application /<GUID/>. Make sure the redirect URI sent in the request matches one added to your application in the Azure portal...'.  Copy the /<redirect URI sent/> value.
  
1. Add the redirect URI to the appropriate platform configuration.  This might be web, single page app (spa), or some public/native client platform.  Make sure to save after the redirect URI is added.
  
After these steps are done, wait a few minutes and send the log in request again.  You should be able to sign in to the application.

>[!Note]
>The redirect URI is also known as the reply Url. These values depend on what protocol is being used. OIDC and OAuth protocols refer to this value as a redirect URI.

The following video shows how to fix the redirect URI mismatch error in Azure AD:

> [!VIDEO https://www.youtube.com/embed/a_abaB7494s]

## More Information

For a full list of Active Directory Authentication and authorization error codes, see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).
