---
title: How to Resolve Token Signature Validation Errors in Microsoft Entra ID applications
description: This article describes how to resolve IDX10501 Signature Validation Errors in Microsoft Entra ID applications。
ms.date: 06/03/2025
author: genlin
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# IDX10501 Signature Validation Errors in Microsoft Entra ID applications

If a client application obtains an access token from Microsoft Entra ID and sends it to a resource (API) application, the resource application must validate the token. It does this by using the public key from the certificate that was used to sign the token. If the application cannot find the correct key identifier (kid), it may throw an error like:

> IDX10501: Signature validation failed. Unable to match 'kid'

To resolve token signature validation errors like IDX10501, make sure that your application is configured to retrieve the correct public key from Microsoft Entra ID. Use the appropriate key discovery or metadata endpoint based on the application type and signing configuration.

## For OAuth2 resource applications

This section demonstrates how OAuth2 application validates an token issued from Microsoft Entra ID:

1. Use an API client to perform an [Authorization Code flow](/entra/identity-platform/v2-oauth2-auth-code-flow) and acquire an token.
1. Decode the token by using [jwt.ms](https://jwt.ms), and take a note of the `kid`.
1. Depend on your Microsoft Entra ID application version, use the token as a Bearer token to call one of the following keys discovery endpoints. The API will return three keys. The `kid` you obtained in step 2 should match one of the keys returned by the keys discovery endpoint.

    For v1.0 applications, use:

    ```http
    https://login.microsoftonline.com/common/discovery/keys
    ```

    For v2.0 applications, use:
    ```http
    https://login.microsoftonline.com/common/discovery/v2.0/keys
    ```

## For SAML resource applications

For SAML apps like `SharepointSAMLTest`, Microsoft Entra ID uses the app-specific certificate to sign tokens. To retrieve the correct public key, follow these steps:

1. Use the API client to acquire an access token for the SAML app.
2. Use the following keys discovery endpoint, replacing `<tenant>` and `<SAML App ID>` with your values. 
    ```http
   https://login.microsoftonline.com/<tenant>/discovery/keys?appid=<SAML App ID>
    ```
3. If your app uses custom signing keys with the [claims-mapping](/entra/identity-platform/saml-claims-customization), you must append an `appid` query parameter containing the app's client ID to retrieve a `jwks_uri` that points to your app’s specific signing key information. For example:

    ```http
   https://login.microsoftonline.com/{tenant}/v2.0/.well-known/openid-configuration?appid=6731de76-14a6-49ae-97bc-6eba6914391e
    ```
    
### Middleware Configuration Examples

To avoid signature validation errors, configure your middleware to use the correct metadata endpoint.

**OpenID Connect Middleware (OWIN)**

```csharp
app.UseOpenIdConnectAuthentication(
    new OpenIdConnectAuthenticationOptions
    {
        ClientId = clientId,
        Authority = authority,
        RedirectUri = redirectUri,
        MetadataAddress = "https://login.microsoftonline.com/<tenant>/.well-known/openid-configuration?appid=<SAML App ID>",
        PostLogoutRedirectUri = redirectUri,
    });

```

**JWT Bearer Authentication Middleware**

```csharp
app.UseJwtBearerAuthentication(new JwtBearerOptions
{
    Audience = "...",
    Authority = "...",
    MetadataAddress = "https://login.microsoftonline.com/<tenant>/.well-known/openid-configuration?appid=<SAML App ID>",
    TokenValidationParameters = new TokenValidationParameters
    {
        // Additional validation parameters
    }
});


```
**Microsoft.Identity.Web (Web App)**

```csharp
services.AddMicrosoftIdentityWebAppAuthentication(Configuration)
        .EnableTokenAcquisitionToCallDownstreamApi()
        .AddInMemoryTokenCaches();

services.Configure<MicrosoftIdentityOptions>(options =>
{
    options.MetadataAddress = "https://login.microsoftonline.com/<tenant>/.well-known/openid-configuration?appid=<SAML App ID>";
});
```


**Microsoft.Identity.Web (Web API)**

```csharp
services.AddMicrosoftIdentityWebApiAuthentication(Configuration);

services.Configure<JwtBearerOptions>(JwtBearerDefaults.AuthenticationScheme, options =>
{
    options.MetadataAddress = "https://login.microsoftonline.com/<tenant>/.well-known/openid-configuration?appid=<SAML App ID>";
});
```

## Next step

To learn more about Microsoft Entra ID signing keys rollover, see [Access tokens in the Microsoft identity platform][/entra/identity-platform/access-tokens]
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
