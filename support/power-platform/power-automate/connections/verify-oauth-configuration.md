---
title: Verify OAuth 2.0 for Power Automate Custom Connectors
description: Verify OAuth 2.0 configuration for Power Automate custom connectors. Validate endpoints, scopes, and tokens with Postman today.
ms.date: 05/01/2026
ms.reviewer: nravindra, v-shaywood
ms.custom: sap:Connections\Custom connectors
---

# Verify OAuth configuration for custom connectors

## Summary

This article helps you check and fix the OAuth 2.0 configuration for Power Automate [custom connectors](/connectors/custom-connectors/) that authenticate with [Microsoft Entra ID](/entra/identity-platform/). Use it to validate authorization and token endpoints, redirect URIs, scopes, and bearer token behavior so connections succeed and refresh tokens are issued when needed.

## Symptoms

A custom connector connection fails because authentication doesn't complete. You might experience one or more of the following symptoms:

- `401 Unauthorized` responses from connector actions.
- Connections that succeed briefly and then fail at a consistent interval.
- Postman requests succeed, but the same configuration fails through the custom connector.

## Cause

Most issues come from incorrect OAuth 2.0 settings, such as:

- Using the `authorize` endpoint where the `token` endpoint is required.
- A mismatched redirect URI between the custom connector and the app registration.
- Missing or incorrect scopes, for example, omitting `offline_access` when refresh tokens are needed.
- Mixing v1.0 and v2.0 endpoints or parameters.
- An [app registration](/entra/identity-platform/quickstart-register-app) that isn't set up for the intended tenant or multitenant scenario.

## Solution

Before you set up a custom connector, validate your OAuth 2.0 flow end-to-end outside Power Automate by using a tool like Postman. This step confirms that your authorization server, resource API, and parameters are correct. For details about the OAuth 2.0 flow and token behavior, see:

- [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow).
- [Microsoft identity platform refresh tokens](/entra/identity-platform/refresh-tokens).

> [!NOTE]
> Custom connectors use the authorization code flow. The implicit and client credentials flows don't issue refresh tokens and aren't suitable for end-user delegated authentication in custom connectors.

Before you begin testing, note the following parameters for your app registration in the [Microsoft Entra admin center](https://entra.microsoft.com/):

- **Directory (tenant) ID** and **Application (client) ID**: Use these values in the Postman collection and the custom connector.
- **Authorization endpoint**: The `/oauth2/v2.0/authorize` endpoint for your tenant, for example, `https://login.microsoftonline.com/<Tenant>/oauth2/v2.0/authorize`. Use this value in the Postman collection and the custom connector.
- **Token endpoint**: The `/oauth2/v2.0/token` endpoint for your tenant, for example, `https://login.microsoftonline.com/<Tenant>/oauth2/v2.0/token`. Use this value in the Postman collection and the custom connector.
- **Scopes**: Identify the [delegated scopes](/entra/identity-platform/scopes-oidc) that your resource API requires. Include `offline_access` if you need refresh tokens.

### Test OAuth with Postman

Use Postman to confirm that the identity platform issues tokens as expected and that your API accepts them:

1. In your app registration's redirect URIs, add `https://oauth.pstmn.io/v1/callback`. You can remove it after testing.

1. In Postman, create a collection and open its **Authorization** tab. Configure these values:

   1. For **Type**, select **OAuth 2.0**.
   1. Set **Auth URL** to your tenant's **Authorization URL**.
   1. Set **Access Token URL** to your tenant's **Token (and Refresh) URL**. Don't use the **Authorization URL** here.
   1. Set **Client ID** to your app registration's **Application (client) ID**.
   1. Set **Scope** to your resource API's delegated scopes, separated by spaces. Include `offline_access` if you need refresh tokens.

1. Select **Get New Access Token**, and then complete the sign-in and consent prompts in the dialog that opens.

1. In the result dialog, confirm that an access token is returned. If you included the `offline_access` scope, confirm that a refresh token is also returned.

1. Add a request to the collection that calls your resource API, and then send the request. Confirm that the `Authorization` header contains a bearer token and that the request succeeds.

1. If any step fails, compare your parameters against the identity platform documentation: [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow) and [Microsoft identity platform refresh tokens](/entra/identity-platform/refresh-tokens).

### Define OAuth for a custom connector

After you confirm the flow in Postman, configure the custom connector's **Security** settings to match the values used in the Postman collection:

- **Authorization URL**: Your authorization endpoint (same as the Postman **Auth URL**).
- **Token URL**: Your token endpoint (same as the Postman **Access Token URL**).
- **Refresh URL**: Same as the **Token URL**.
- **Client ID**: Same as the Postman **Client ID**.
- **Scope**: Same as the Postman **Scope**.
- **Redirect URL**: Use the value generated by the custom connector UI, and add it to your app registration's redirect URIs.

For field-by-field configuration and screenshots, see [Authenticate your API and connector with Microsoft Entra ID](/connectors/custom-connectors/azure-active-directory-authentication).

## Related content

- [Create a custom connector from a Postman collection](/connectors/custom-connectors/define-postman-collection)
- [Troubleshoot OAuth configuration (custom connectors)](/connectors/custom-connectors/troubleshoot-oauth2)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
