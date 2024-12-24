---
title: Application and delegated permission for access tokens
description: Describes application and delegated permissions for access tokens in Microsoft identity platform.
ms.reviewer: bachoang, v-weizhu
ms.service: entra-id
ms.date: 12/24/2024
ms.custom: sap:App registrations
---
# Application and delegated permissions for access tokens in Microsoft identity platform

This article introduces the differences between application and delegated permissions for access tokens in Microsoft identity platform to help diagnosing issues when applications calling web APIs.

## Overview

As described in [Overview of permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview) and [Glossary: Microsoft identity platform](/entra/identity-platform/developer-glossary), there are two types of permissions for an access token: delegated permission and application permission. Delegated permission is granted to a signed-in user, whereas application permission is granted directly to an application. The key difference is that delegated permission requires user sign-in, while application permission doesn't; instead, the application authenticates to Microsoft Entra ID using its own application identity (client ID and secret/assertion).

Regardless of permission types, you must [add permissions in the API permissions pane](/entra/identity-platform/quickstart-configure-app-access-web-apis#add-permissions-to-access-your-web-api) on the Microsoft Entra **App registrations** page: 

* Select **Application permissions** if your application scenario doesn't need any user to sign in.
* Select **Delegated permissions** if your application requires a user to sign in so that the access token can be issued for that sign-in.

> [!NOTE]
> When you select **Application permissions**, [admin consent](/azure/active-directory/manage-apps/configure-user-consent) must be granted for the permission to function correctly.

## Permission type tokens issued from OAuth2 authentication flows

Microsoft Entra ID supports various OAuth2 authentication flows. The kind of authentication flow that an application uses results in specific types of permissions in an access token.

Application permission tokens can only be obtained from the [client credentials grant flow](/entra/identity-platform/v2-oauth2-client-creds-grant-flow).

Delegated permission token can only be obtained from the following flows:

* [Implicit grant flow](/azure/active-directory/develop/v2-oauth2-implicit-grant-flow)
* [Authorization code grant flow](/azure/active-directory/develop/v2-oauth2-auth-code-flow)
* [On-Behalf-Of flow](/azure/active-directory/develop/v2-oauth2-on-behalf-of-flow)
* [Device authorization grant flow](/azure/active-directory/develop/v2-oauth2-device-code)
* [Resource Owner Password Credentials grant flow](/azure/active-directory/develop/v2-oauth2-device-code)

## Identify permission type for access tokens

To determine whether an access token is a delegated or application permission token, use a tool like [jwt.ms](https://jwt.ms/) to inspect the token claims.

For application permission tokens, the permissions are in the `roles` claim:

 :::image type="content" source="media/application-delegated-permission-access-tokens-identity-platform/roles-claim.png" alt-text="Screenshot that shows the 'roles' claim.":::

> [!NOTE]
> The "scp" claim is absent in application permission tokens.

For **delegated permission tokens**, the permissions are in the `scp` claim:

 :::image type="content" source="media/application-delegated-permission-access-tokens-identity-platform/scp-claim.png" alt-text="Screenshot that shows the 'scp' claim.":::

> [!NOTE]
> The `roles` claim might still appear in a delegated permission token, but it lists roles assigned to the user in the API app.

## Identify permission type an API supports

Understanding what type of permissions an API supports is essential. Many errors such as 400, 401, 403, and 500 error occur when applications call different APIs (for example, Microsoft Graph and Power BI) with incorrect permission type tokens. For an API, different REST endpoints might require different types of permissions. You can refer to API endpoint documentations to check what permission type is supported. You also need to evaluate whether the authentication flow used in the application produces the desired permission tokens.

### Example scenarios

* [List trustFrameworkPolicies](/graph/api/trustframework-list-trustframeworkpolicies): Calling this REST endpoint requires a delegated permission token. An application permission token won't work.

    :::image type="content" source="media/application-delegated-permission-access-tokens-identity-platform/list-trustframeworkpolicies-permissions-type.png" alt-text="Screenshot that shows supported/unsupported permission type.":::

* Power BI API: While Power BI supports both delegated permissions and application permissions, some tasks like viewing reports (requiring `Report.Read.All` permission) can only be performed with a delegated token. In the **Request App Registration** page, **Application permissions** only support two permissions: **Tenant.Read.All** and **Tenant.ReadWrite.All.**

    :::image type="content" source="media/application-delegated-permission-access-tokens-identity-platform/application-permissions-power-bi-api.png" alt-text="Screenshot that shows application permissions for Power BI API.":::

     In contrast, **Delegated permissions** offer a richer feature set:

    :::image type="content" source="media/application-delegated-permission-access-tokens-identity-platform/delegated-permissions-power-bi-api.png" alt-text="Screenshot that shows delegated permissions for Power BI API.":::

## Troubleshoot issues when calling Microsoft Graph REST endpoints

Users often encounter issues when their applications call Microsoft Graph REST endpoints. The requests work successfully in Microsoft Graph Explorer but fail in their applications. To troubleshoot issues, check the following things:

* Check what permission type the access token has. Microsoft Graph Explorer always uses a delegated permission token.
* Ensure the same user account is used to sign in both Microsoft Graph Explorer and the application.
* Verify if the endpoint supports delegated permissions, application permissions, or both.
* Verify that the access token has correct permissions to call the endpoint.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]