---
title: Resolve IDX10501 signature validation errors in Azure AD applications
description: Learn how to resolve IDX10501 signature validation errors by obtaining the public key for token validation in Azure AD OAuth2 and SAML applications.
ms.date: 05/31/2025
ms.service: entra-id
ms.author: bachoang
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---

# Resolve IDX10501 signature validation errors in Microsoft Entra ID applications

This article describes how to resolve the following signature validation errors in Microsoft Entra ID applications:

- `IDX10501: Signature validation failed. Unable to match 'kid'`
- `IDX10501: Signature validation failed. Unable to match key`

These errors occur when your application can't find the public key needed to validate the token signature issued by Azure AD.

## Why signature validation errors occur

After successful authentication, Azure AD issues a signed JSON Web Token (JWT), such as an ID token or access token. Your application must validate the token signature using the public key of the certificate Azure AD used to sign the token.

Depending on your application's type (OAuth2 or SAML), the steps to obtain the public key differ.

## Example scenario setup

To illustrate this scenario, consider three Azure AD applications:

- **bhfrontend**: OAuth2 web application used for user sign-in and obtaining access tokens.
- **bhbackend**: OAuth2 backend application accessed by bhfrontend.
- **SharepointSAMLTest**: SAML backend application accessed by bhfrontend.

### Application registration details

- **bhbackend**: Registered via **Azure Active Directory** > **App registrations** > **New registration**.
- **SharepointSAMLTest**: Registered via **Azure Active Directory** > **Enterprise applications** > **New application** > **Non-gallery application** > **Configure SAML single sign-on**. Azure AD automatically assigns a certificate to this application, used to sign both SAML and OAuth2 tokens.
- **bhfrontend**: Registered similarly to bhbackend. Add API permissions for both bhbackend and SharepointSAMLTest, grant admin consent, and create a client secret for authorization code flow.

## Obtain public keys for OAuth2 applications

To validate tokens issued to OAuth2 applications, use the following Azure AD keys discovery endpoint:

- **Azure AD v1 endpoint**:  
  `https://login.microsoftonline.com/common/discovery/keys`

- **Azure AD v2 endpoint**:  
  `https://login.microsoftonline.com/common/discovery/v2.0/keys`

You can decode your JWT token using [jwt.ms](https://jwt.ms) and verify that the `kid` (key ID) matches one of the keys listed at the discovery endpoint.

## Obtain public keys for SAML applications

For SAML applications, Azure AD uses an application-specific certificate to sign tokens. To obtain the public key, use the following endpoint format:

```
https://login.microsoftonline.com/<tenant-name>/discovery/keys?appid=<SAML-App-ID>
```

Replace `<tenant-name>` with your Azure AD tenant name and `<SAML-App-ID>` with your application's ID (found in the Enterprise application's **Properties** section).

You can also find this endpoint from the application's metadata document:

- **Azure AD v1 metadata endpoint**:  
  ```
  https://login.microsoftonline.com/<tenant-name>/.well-known/openid-configuration?appid=<SAML-App-ID>
  ```

- **Azure AD v2 metadata endpoint**:  
  ```
  https://login.microsoftonline.com/<tenant-name>/v2.0/.well-known/openid-configuration?appid=<SAML-App-ID>
  ```

If your application uses custom signing keys (for example, due to claims mapping), you must include the `appid` parameter to retrieve the correct JWKS URI.

## Configure middleware to use the correct metadata endpoint

If your application encounters signature validation errors, configure your middleware to use the application-specific metadata endpoint.

### OpenID Connect middleware (OWIN)

```csharp
app.UseOpenIdConnectAuthentication(
    new OpenIdConnectAuthenticationOptions
    {
        ClientId = clientId,
        Authority = authority,
        RedirectUri = redirectUri,
        MetadataAddress = "https://login.microsoftonline.com/<tenant-name>/.well-known/openid-configuration?appid=<SAML-App-ID>",
        PostLogoutRedirectUri = redirectUri,
    });
```

### JWT Bearer authentication middleware (OWIN)

```csharp
app.UseJwtBearerAuthentication(new JwtBearerOptions
{
    Audience = "<your-audience>",
    Authority = "<your-authority>",
    MetadataAddress = "https://login.microsoftonline.com/<tenant-name>/.well-known/openid-configuration?appid=<SAML-App-ID>",
    TokenValidationParameters = new TokenValidationParameters
    {
        // Additional parameters
    }
});
```

### Microsoft.Identity.Web for web apps (ASP.NET Core)

```csharp
services.AddMicrosoftIdentityWebAppAuthentication(Configuration)
    .EnableTokenAcquisitionToCallDownstreamApi()
    .AddInMemoryTokenCaches();

services.Configure<MicrosoftIdentityOptions>(options =>
{
    options.MetadataAddress = "https://login.microsoftonline.com/<tenant-name>/.well-known/openid-configuration?appid=<SAML-App-ID>";
});
```

### Microsoft.Identity.Web for web APIs (ASP.NET Core)

```csharp
using Microsoft.AspNetCore.Authentication.JwtBearer;

services.AddMicrosoftIdentityWebApiAuthentication(Configuration);

services.Configure<JwtBearerOptions>(JwtBearerDefaults.AuthenticationScheme, options =>
{
    options.MetadataAddress = "https://login.microsoftonline.com/<tenant-name>/.well-known/openid-configuration?appid=<SAML-App-ID>";
});
```

Replace `<tenant-name>` and `<SAML-App-ID>` with your Azure AD tenant name and application ID.

## Next steps

- [Azure AD signing key rollover](https://learn.microsoft.com/azure/active-directory/develop/active-directory-signing-key-rollover)
- [OpenID Connect protocol](https://learn.microsoft.com/azure/active-directory/develop/v2-protocols-oidc)
- [SAML single sign-on](https://learn.microsoft.com/azure/active-directory/manage-apps/configure-single-sign-on-non-gallery-applications)
