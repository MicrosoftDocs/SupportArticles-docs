---
title: Invalid client error (AADSTS7000218) when authenticating to Microsoft Entra ID
description: Provides a solution to the AADSTS7000218 error when a confidential client application authenticates to Microsoft Entra ID.
ms.date: 04/21/2025
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

This issue occurs because the application doesn't provide its credential (a client secret or a client assertion) as expected by the token endpoint. A confidential client must provide its credential when authenticating to Microsoft Entra ID.

## Resolution

To resolve this issue, include the client secret or client assertion in the token request. If you're not sure if the application is a credential client, go to the Verify if the application is a credential client section.

In some authentication flow scenarios such as [OAuth 2 Resource Owner Password Credentials (ROPC)](/entra/identity-platform/v2-oauth-ropc) grant flow or [OAuth 2 device authorization grant flow](/entra/identity-platform/v2-oauth2-device-code) where you don't expect the client application to be confidential, change the default client type to public in the App Registration:

1. In the [Azure portal](https://portal.azure.com/), in **App registrations**, select your application, and then select **Authentication**.
2. Select **Advanced settings** > **Default client type**.
3. For **Treat application as a public client**, select **Yes**.

Changing the default client type from confidential to public causes security implications. For more information, see [What’s the security implication of changing the default client type from confidential to public in Azure AD?](https://blogs.aaddevsup.xyz/2020/09/whats-the-security-implication-of-changing-the-default-client-type-from-confidential-to-public-in-azure-ad/)

## Verify if the application is a credential client

### Understand client types in Microsoft Entra ID

As defined in the [OAuth 2.0 specifications](https://tools.ietf.org/html/rfc6749), client applications are categorized into two types:

- Confidential client: A client who is able to securely store a secret used to authenticate to Microsoft Entra ID.

    For example: The client is a web application where its code and secret are stored on a server that’s not exposed to the public. The application's confidential information can only be accessed by an admin.
- Public client: A client that can't store any secret.

    For example: A public client is a mobile application or desktop application running in an insecure or unmanaged environment.

In the Microsoft Entra App Registration model, a registered application can be both a public client and a confidential client, depending on the context the application is used in. This is because an application might have part of it used as a public client while some other parts are designed to be used as a confidential client.  Depending on workflows, the application developer must decide if the application should act as a public or confidential client. A confidential client is expected in certain OAuth2 grant flows such as Client Credentials flow, Authorization Code flow, or On-Behalf-Of flow. It uses a flow to request a token.

### How Microsoft Entra ID determines the client type

- Based on the type of the redirect URI (reply URL):

    Microsoft Entra ID checks the redirect URI (reply URL) provided in the request and cross-checks it with the redirect URI registered in the App Registrations.
    - A **Web** type redirect URI classifies the application as a confidential client.
    - A **Public client (mobile & desktop)** type redirect URI classifies the application as a **public client**.

- Based on default client type (when no reply URL is provided):

    In some OAuth 2.0 flows, such as the [OAuth 2 Resource Owner Password Credentials (ROPC)](/azure/active-directory/develop/v2-oauth-ropc) grant flow, [OAuth 2 device authorization grant flow](/entra/identity-platform/v2-oauth2-device-code) and Integrated Windows Authentication, there is no reply URL provided in the token request. In these cases, Microsoft Entra ID uses the app registration's default client type to determine whether the client is confidential or public.

    - If **Default client type** is set to **Yes**, the client is public.
    - If it's set to **No**, the client is confidential.

#### How to identify the grant type and redirect URI used by an application

Review the application code or capture a [Fiddler](https://blogs.aaddevsup.xyz/2018/09/capture-https-traffic-with-http-fiddler/) trace to inspect the grant_type and redirect_uri parameters sent in the POST request to Microsoft Entra ID's token endpoint:

- V1 endpoint: `https://login.microsoftonline.com/<tenant name>/oauth2/token`
- V2 endpoint: `https://login.microsoftonline.com/<tenant name>/oauth2/v2.0/token`

Here's an example of Fiddler trace:

:::image type="content" source="media/confidential-client-application-authentication-error-aadsts7000218/grant-type.png" alt-text="Screenshot hat shwos a Fiddler trace example" lightbox="media/confidential-client-application-authentication-error-aadsts7000218/grant-type.png":::

Common OAuth 2.0 flows and their associated `grant_type` values are listed below:

| OAuth 2.0 flow | grant_typevalue |
| --- | --- |
| [ROPC](/entra/identity-platform/v2-oauth-ropc) | `password` |
| [Device Code](/entra/identity-platform/v2-oauth2-device-code) | `urn:ietf:params:oauth:grant-type:device_code` |
| [Authorization Code](/entra/identity-platform/v2-oauth2-auth-code-flow) | `authorization_code` |
| [Client Credentials](/entra/identity-platform/v2-oauth2-client-creds-grant-flow) | `client_credentials` |
| [On-Behalf-Of](/entra/identity-platform/v2-oauth2-on-behalf-of-flow) | `urn:ietf:params:oauth:grant-type:jwt-bearer` |
| [SAML Bearer Assertion](/entra/identity-platform/v2-saml-bearer-assertion) | `urn:ietf:params:oauth:grant-type:saml1_1-bearer` |

## References

- [Microsoft Authentication Library (MSAL) Client Applications](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet/wiki/Client-Applications)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]