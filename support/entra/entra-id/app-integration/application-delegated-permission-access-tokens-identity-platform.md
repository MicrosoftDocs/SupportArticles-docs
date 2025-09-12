---
title: Application and Delegated Permissions for Access Tokens
description: Describes application and delegated permissions for access tokens in the Microsoft identity platform.
ms.reviewer: bachoang, v-weizhu
ms.service: entra-id
ms.date: 01/15/2025
ms.custom: sap:App registrations
---
# Application and delegated permissions for access tokens in the Microsoft identity platform

This article introduces the differences between application and delegated permissions for access tokens in the Microsoft identity platform to help diagnose issues when applications call web APIs.

## Overview

As described in the [Overview of permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview) and [Glossary: Microsoft identity platform](/entra/identity-platform/developer-glossary), there are two types of permissions for an access token: delegated permissions and application permissions. Delegated permissions are granted to a signed-in user, whereas application permissions are granted directly to an application. The key difference is that delegated permissions require user sign-in, while application permissions don't; instead, the application authenticates to Microsoft Entra ID using its own application identity (client ID and secret/assertion).

Regardless of permission types, you must [configure API permissions](/entra/identity-platform/quickstart-configure-app-access-web-apis#add-permissions-to-access-your-web-api) on the Microsoft Entra **App Registration** page: 

* Select **Application permissions** if your application doesn't need any user to sign in.
* Select **Delegated permissions** if your application requires a user to sign in so that the access token can be issued for that sign-in.

> [!NOTE]
> When you select **Application permissions**, admin consent must be granted for the permission to function correctly.

## Permission type tokens issued from OAuth2 authentication flows

Microsoft Entra ID supports various OAuth2 authentication flows. The kind of authentication flow that an application uses results in specific types of permissions in an access token.

Application permission tokens can only be obtained from the [client credentials grant flow](/entra/identity-platform/v2-oauth2-client-creds-grant-flow).

Delegated permission tokens can only be obtained from the following flows:

* [Implicit grant flow](/azure/active-directory/develop/v2-oauth2-implicit-grant-flow)
* [Authorization code grant flow](/azure/active-directory/develop/v2-oauth2-auth-code-flow)
* [On-Behalf-Of flow](/azure/active-directory/develop/v2-oauth2-on-behalf-of-flow)
* [Device authorization grant flow](/azure/active-directory/develop/v2-oauth2-device-code)
* [Resource Owner Password Credentials grant flow](/entra/identity-platform/v2-oauth-ropc)

## Identify the permission type for an access token

To determine whether an access token is a delegated or application permission token, inspect the token claims using a tool like [jwt.ms](https://jwt.ms/).

For application permission tokens, the permissions are in the `roles` claim:

```json
"oid": "<oid>"
"roles": [
    "User.Read.All"
],
"sub": "<sub>"
```

> [!NOTE]
> The `scp` claim is absent in application permission tokens.

For delegated permission tokens, the permissions are in the `scp` claim:

```json
"scp": "Directory.Read.All User.Read",
"sub": "<sub>",
```

> [!NOTE]
> The `roles` claim might still appear in a delegated permission token, but it lists the roles assigned to the user in the API app.

## Identify the permission type an API supports

Understanding what type of permissions an API supports is essential. Many errors such as 400, 401, 403, and 500 occur when applications call different APIs (for example, Microsoft Graph and Power BI) with incorrect permission type tokens. For an API, different REST endpoints might require different permission types. You can refer to the API endpoint documentation to check the supported permission type. You also need to evaluate whether the authentication flow used in the application generates the desired permission tokens.

### Example scenario

Power BI API: While Power BI supports both delegated and application permissions, some tasks, like viewing reports (requiring the **Report.Read.All** permission), can only be performed with a delegated token. On the **App Registration** page, **Application permissions** only support two permissions: **Tenant.Read.All** and **Tenant.ReadWrite.All.**

:::image type="content" source="media/application-delegated-permission-access-tokens-identity-platform/application-permissions-power-bi-api.png" alt-text="Screenshot that shows application permissions for the Power BI API.":::

In contrast, **Delegated permissions** offer a richer feature set:

:::image type="content" source="media/application-delegated-permission-access-tokens-identity-platform/delegated-permissions-power-bi-api.png" alt-text="Screenshot that shows delegated permissions for the Power BI API.":::

## Troubleshoot issues when calling Microsoft Graph REST endpoints

Users often encounter issues when their applications call Microsoft Graph REST endpoints. The requests work successfully in Microsoft Graph Explorer but fail in their applications. To troubleshoot these issues, check the following things:

* Check the permission type the access token has. Microsoft Graph Explorer always uses a delegated permission token.
* Ensure the same user account is used to sign in to Microsoft Graph Explorer and the application.
* Verify if the endpoint supports delegated permissions, application permissions, or both.
* Verify that the access token has the correct permissions to call the endpoint.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
