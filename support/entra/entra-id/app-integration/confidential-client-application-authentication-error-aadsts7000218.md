---
title: Invalid Client Error AADSTS7000218 When Authenticating to Microsoft Entra ID
description: Provides a solution to the AADSTS7000218 error when a confidential client application authenticates to Microsoft Entra ID.
ms.date: 04/30/2025
ms.reviewer: bachoang, v-weizhu
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---

# Error AADSTS7000218 when a confidential client application authenticates to Microsoft Entra ID

This article provides a solution to the AADSTS7000218 error that occurs when a confidential client application authenticates to Microsoft Entra ID.

## Symptoms

When a confidential client application authenticates to Microsoft Entra ID to get an access token, the following error message is displayed:

```output
{
    "error": "invalid_client",
    "error_description": "AADSTS7000218: The request body must contain the following parameter: 'client_assertion' or 'client_secret'.\r\nTrace ID: xxx\r\nCorrelation ID: xxx\r\nTimestamp: 2019-08-18 20:38:28Z",
    "error_codes": [7000218],
    ...
}
```

## Cause

This issue occurs because the application doesn't provide the credentials (client secret or assertion) that the token endpoint expects. A confidential client must provide its credentials when authenticating to Microsoft Entra ID.

## Resolution

To resolve this issue, include the client secret or assertion in the token request.

In some authentication flow scenarios, such as the [OAuth 2 Resource Owner Password Credentials (ROPC)](/entra/identity-platform/v2-oauth-ropc) grant flow or [OAuth 2 device authorization grant flow](/entra/identity-platform/v2-oauth2-device-code), where you don't expect the client application to be confidential, allow public client flows in the **App registrations**:

1. In the [Azure portal](https://portal.azure.com/), in **App registrations**, select your application, and then select **Authentication**.
2. Select **Advanced settings** > **Allow public client flows**.
3. For **Enable the following mobile and desktop flows**, select **Yes**.

    :::image type="content" source="media/confidential-client-application-authentication-error-aadsts7000218/allow-public-client-flows.png" alt-text="Screenshot that shows the 'Enable the following mobile and desktop flows' option." lightbox="media/confidential-client-application-authentication-error-aadsts7000218/allow-public-client-flows.png":::

Changing the default client type from confidential to public causes security implications. For more information, see [What's the security implication of changing the default client type from confidential to public in Azure AD?](https://blogs.aaddevsup.xyz/2020/09/whats-the-security-implication-of-changing-the-default-client-type-from-confidential-to-public-in-azure-ad/)

## Understand client types in Microsoft Entra ID

As defined in the [OAuth 2.0 specification](https://tools.ietf.org/html/rfc6749), client applications are categorized into two types:

- Confidential client: A client that can securely store a secret used to authenticate to Microsoft Entra ID.

    For example, the client is a web application whose code and secrets are stored on a server that isn't exposed to the public. Only an admin can access the application's confidential information.
- Public client: A client that can't store any secret.

    For example, a public client is a mobile or desktop application running in an insecure or unmanaged environment.

In the Microsoft Entra App Registration model, a registered application can be both a public client and a confidential client, depending on the context in which the application is used. This is because an application might have a part used as a public client, while other parts are designed to be used as a confidential client. Depending on workflows, the application developer must decide if the application should act as a public or confidential client. A confidential client is expected in certain OAuth2 grant flows, such as the Client Credentials flow, Authorization Code flow, or On-Behalf-Of flow. It uses a flow to request a token.

## How Microsoft Entra ID determines the client type

- Method 1: Use the type of the redirect URI (reply URL)

    Microsoft Entra ID checks the redirect URI (reply URL) provided in the request and cross-checks it with the redirect URI registered in the App Registrations.
    - A redirect URI of type **Web** classifies the application as a confidential client.
    
        :::image type="content" source="media/confidential-client-application-authentication-error-aadsts7000218/web-client-type.png" alt-text="Screenshot that shows a Web-type redirect URI." lightbox="media/confidential-client-application-authentication-error-aadsts7000218/web-client-type.png":::
    - A redirect URI of type **Mobile and desktop applications** classifies the application as a public client.
    
       :::image type="content" source="media/confidential-client-application-authentication-error-aadsts7000218/public-client-type.png" alt-text="Screenshot that shows a public-type redirect URI." lightbox="media/confidential-client-application-authentication-error-aadsts7000218/public-client-type.png":::

- Method 2: Use the **Enable the following mobile and desktop flows** option (when no reply URL is provided)

    In some OAuth 2.0 flows, such as the [OAuth 2 Resource Owner Password Credentials (ROPC)](/azure/active-directory/develop/v2-oauth-ropc) grant flow, [OAuth 2 device authorization grant flow](/entra/identity-platform/v2-oauth2-device-code) and Integrated Windows Authentication, no reply URL is provided in the token request. In these cases, Microsoft Entra ID uses the app registration's **Enable the following mobile and desktop flows** to determine whether the client is confidential or public.

    - If **Enable the following mobile and desktop flows** is set to **Yes**, the client is public.
    - If it's set to **No**, the client is confidential.

### How to identify the grant type and redirect URI used by an application

Review the application code or capture a [Fiddler](https://blogs.aaddevsup.xyz/2018/09/capture-https-traffic-with-http-fiddler/) trace to inspect the `grant_type` and `redirect_uri` parameters sent in the POST request to the Microsoft Entra ID's token endpoint:

- V1 endpoint: `https://login.microsoftonline.com/<tenant name>/oauth2/token`
- V2 endpoint: `https://login.microsoftonline.com/<tenant name>/oauth2/v2.0/token`

Here's an example of a Fiddler trace:

:::image type="content" source="media/confidential-client-application-authentication-error-aadsts7000218/post-request.png" alt-text="Screenshot that shows a POST request in Fiddler.":::

:::image type="content" source="media/confidential-client-application-authentication-error-aadsts7000218/grant-type.png" alt-text="Screenshot that shows a grant type.":::

Common OAuth 2.0 flows and their associated `grant_type` values are listed as follows:

| OAuth 2.0 flow | grant_type value |
| --- | --- |
| [ROPC](/entra/identity-platform/v2-oauth-ropc) | `password` |
| [Device Code](/entra/identity-platform/v2-oauth2-device-code) | `urn:ietf:params:oauth:grant-type:device_code` |
| [Authorization Code](/entra/identity-platform/v2-oauth2-auth-code-flow) | `authorization_code` |
| [Client Credentials](/entra/identity-platform/v2-oauth2-client-creds-grant-flow) | `client_credentials` |
| [On-Behalf-Of](/entra/identity-platform/v2-oauth2-on-behalf-of-flow) | `urn:ietf:params:oauth:grant-type:jwt-bearer` |
| [SAML Bearer Assertion](/entra/identity-platform/v2-saml-bearer-assertion) | `urn:ietf:params:oauth:grant-type:saml1_1-bearer` |

## References

[Microsoft Authentication Library (MSAL) Client Applications](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet/wiki/Client-Applications)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
