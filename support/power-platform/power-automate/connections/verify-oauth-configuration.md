---
title: Verify OAuth 2.0 for Power Automate custom connectors
description: Verify OAuth 2.0 configuration for Power Automate custom connectors. Verify endpoints, scopes, and tokens by using Postman.
ms.date: 05/01/2026
ms.reviewer: nravindra, v-shaywood
ms.custom: sap:Connections\Custom connectors
---

# Verify OAuth configuration for custom connectors

## Summary

This article helps you check and fix the OAuth 2.0 configuration for Microsoft Power Automate [custom connectors](/connectors/custom-connectors/) that authenticate by using [Microsoft Entra ID](/entra/identity-platform/). Use the article to verify authorization and token endpoints, scopes, redirect URIs, and bearer token behavior to make sure that connections succeed and that refresh tokens are issued when they're needed.

## Symptoms

A custom connector connection fails because authentication doesn't finish. You might experience one or more of the following symptoms:

- You receive `401 Unauthorized` responses from connector actions.
- Connections succeed briefly but then fail at a consistent interval.
- Postman requests succeed, but the same configuration fails through the custom connector.

## Cause

Most issues occur because of incorrect OAuth 2.0 settings, such as:

- Using the `authorize` endpoint instead of the required `token` endpoint.
- A mismatched redirect URI between the custom connector and the app registration.
- Missing or incorrect scopes. For example, omitting `offline_access` when refresh tokens are needed.
- A mixture of v1.0 and v2.0 endpoints or parameters.
- An [app registration](/entra/identity-platform/quickstart-register-app) that isn't set up for the intended tenant or multitenant scenario.

## Verify OAuth flow  

Before you set up a custom connector, verify your OAuth 2.0 flow end-to-end outside Power Automate by using a tool such as Postman. This step confirms that your authorization server, resource API, and parameters are correct. For more information about the OAuth 2.0 flow and token behavior, see:

- [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow)
- [Microsoft identity platform refresh tokens](/entra/identity-platform/refresh-tokens)

> [!NOTE]
> Custom connectors use the authorization code flow. The implicit and client credentials flows don't issue refresh tokens. Therefore, they aren't suitable for user-delegated authentication in custom connectors.

Before you begin testing, note the following parameters for your app registration in the [Microsoft Entra admin center](https://entra.microsoft.com/):

- **Directory (tenant) ID** and **Application (client) ID**: Use these values in the Postman collection and the custom connector.
- **Authorization endpoint**: The `/oauth2/v2.0/authorize` endpoint for your tenant. For example, `https://login.microsoftonline.com/<Tenant>/oauth2/v2.0/authorize`. Use this value in the Postman collection and the custom connector.
- **Token endpoint**: The `/oauth2/v2.0/token` endpoint for your tenant. For example, `https://login.microsoftonline.com/<Tenant>/oauth2/v2.0/token`. Use this value in the Postman collection and the custom connector.
- **Scopes**: Identify the [delegated scopes](/entra/identity-platform/scopes-oidc) that your resource API requires. Include `offline_access` if you need refresh tokens.

### Test OAuth by using Postman

Use Postman to verify that the identity platform issues tokens as expected, and that your API accepts them:

1. In your app registration's redirect URIs, add `https://oauth.pstmn.io/v1/callback`. You can remove this entry after testing.

1. In Postman, create a collection, and then open its **Authorization** tab. Specify the following values:

   - **Type**: Select **OAuth 2.0**.
   - **Auth URL**: Set to your tenant's **Authorization URL**.
   - **Access Token URL**: Set to your tenant's **Token (and Refresh) URL**. Don't use the **Authorization URL** here.
   - **Client ID**: to your app registration's **Application (client) ID**.
   - **Scope**: Set to your resource API's delegated scopes, space-delimited. Include `offline_access` if you need refresh tokens.

1. Select **Get New Access Token**, and then finish the sign-in and consent prompts in the dialog that opens.

1. In the result dialog, verify that an access token is returned. If you included the `offline_access` scope, verify that a refresh token is also returned.

1. Add a request to the collection that calls your resource API, and then send the request. Verify that the `Authorization` header contains a bearer token and that the request succeeds.

1. If any step fails, compare your parameters against the identity platform documentation: [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow) and [Microsoft identity platform refresh tokens](/entra/identity-platform/refresh-tokens).

### Define OAuth for a custom connector

After you verify the flow in Postman, configure the custom connector's **Security** settings to match the values that's used in the Postman collection:

- **Authorization URL**: Your authorization endpoint (same as the Postman **Auth URL**).
- **Token URL**: Your token endpoint (same as the Postman **Access Token URL**).
- **Refresh URL**: Same as the **Token URL**.
- **Client ID**: Same as the Postman **Client ID**.
- **Scope**: Same as the Postman **Scope**.
- **Redirect URL**: Use the value that's generated by the custom connector UI, and add it to your app registration's redirect URIs.

For field-by-field configuration and screenshots, see [Authenticate your API and connector with Microsoft Entra ID](/connectors/custom-connectors/azure-active-directory-authentication).

## Related content

- [Create a custom connector from a Postman collection](/connectors/custom-connectors/define-postman-collection)
- [Troubleshoot OAuth configuration (custom connectors)](/connectors/custom-connectors/troubleshoot-oauth2)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
