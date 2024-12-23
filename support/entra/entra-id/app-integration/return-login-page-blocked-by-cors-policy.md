---
title: Error AADSTS50003 - No signing key configured
description: Describes a problem in which you receive the error AADSTS50003 when signing in to SAML SSO configured app with Microsoft Entra ID. 
ms.date: 10/12/2022
ms.reviewer: bernawy
ms.service: entra-id
ms.custom: sap:Issues Signing In to Applications
---
# Troubleshoot CORS redirection errors in Azure App Service

This article addresses the Cross-Origin Resource Sharing (CORS) redirection issue that occurs when you navigate back to the login page after logging into an Azure app service using Entra ID authentication. This error does not occur when using a private browsing mode.

Here’s an example of the error message:

>`Failed to load https://login.windows.net/{GUID} (index):{GUID}/oauth2/autho…{GUID}&state=redir%3D%252F.auth%252Fme%253Fv%253D1518029528427: Redirect from ‘https://login.windows.net/…{GUID}&oauth2/autho…{GUID}&state=redir%3D%252F.auth%252Fme%253Fv%253D1518029528427′ to ‘https://login.microsoftonline.com/{GUID}/oaut…{GUID}&state=redir%3D%252F.auth%252Fme%253Fv%253D158029528427′ has been blocked by CORS policy: No ‘Access-Control-Allow-Origin’ header is present on the requested resource. Origin ‘{my-origin}’ is therefore not allowed access.`

## Cause

In a typical scenario, after a user authenticates with Azure Entra ID to access an application, Azure App Service sets a cookie named `AppServiceAuthSession` for the authenticated session in the client’s browser. The app may rely on XMLHttpRequest or AJAX requests for various functionalities, and these requests to Azure App Service include the **AppServiceAuthSession** cookie. If this cookie is missing from a request, Azure App Service redirects the request to Azure Entra ID for login. However, this redirection turns the AJAX request into a cross-origin request because the destination domain changes. By default, Azure AD does not allow cross-origin requests, which leads to the issue.

## Solution

