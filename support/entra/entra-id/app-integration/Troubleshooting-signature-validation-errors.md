---
title: Troubleshoot signature validation errors
description: Describes the most common scenarios that lead to such errors and provides solutions.
ms.date: 07/17/2025
ms.reviewer: willfid, v-weizhu
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Troubleshoot signature validation errors

When an Azure resource provider, other than Microsoft Entra ID, validate an access token's signature, signature validation errors occur. These errors might result from the signing key being unavailable or failing to validate the signature. This article describes the most common scenarios that lead to such errors and provides solutions. While the root cause remains consistent, approaches to token validation might differ across developers and vendors.

## Before troubleshooting

1. Get the access token being sent to the resource provider.
1. Decode the access token and review the following claims:

    - `aud` (Audience)
    - `iss` (Issuer)
    - `kid` (Key ID)

    > [!NOTE]
    > You can decode access tokens using [https://jwt.ms](https://jwt.ms).

## Scenario: Send a Microsoft Graph access token to a non-Microsoft Graph resource provider

If you send a Microsoft Graph access token to a non-Microsoft Graph resource provider, you will get a signature validation error. Only Microsoft Graph can validate these tokens. For Microsoft Graph tokens, the value of its `aud` claim is one of the following:

- `https://graph.microsoft.us`
- `https://graph.microsoft.us/`
- `https://graph.microsoft.com`
- `https://graph.microsoft.com/`
- `https://dod-graph.microsoft.us`
- `https://dod-graph.microsoft.us/`
- `00000003-0000-0000-c000-000000000000`

To resolve the signature validation error, ensure the correct access token is acquired for the resource provider and its `aud` claim is expected by the resource provider.

The audience of access tokens is determined by the scope parameter that's sent in the request when acquiring access tokens. For example, to get an access token for `https://api.contoso.com`, use a scope like `https://api.contoso.com/read`. For more information, see [Configure an application to expose a web API](/entra/identity-platform/quickstart-configure-app-expose-web-apis).

## Other scenarios

As for other scenarios, the resource provider determines where to get the signing keys based on the OpenId Connect Metadata configuration and which signing key to use based on the `kid` claim in the access token. You can configure this on the resource provider such as your custom API or API Authentication layer. If you use a Microsoft Authentication library like Microsoft Authentication Library (MSAL) or Microsoft Identity Web, the default configuration is like `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration`.

If you have configured a tenant ID, the `MetadataAddress` would be `https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration`. If you have configured an `Authority` like `https://login.microsoftonline.us/{tenant-id}`, then the `MetadataAddress` would be `https://login.microsoftonline.us/{tenant-id}/v2.0/.well-known/openid-configuration`.

The OpenId Connect Metadata endpoint includes a `jwks_uri` property (also known as discovery keys endpoint), which specifies the location of signing keys. Depending on which OpenId Connect Metadata endpoint is used, it will return a URL for the `jwks_uri`. Here's a table that provides a few examples:

| Metadata endpoint | Discovery keys endpoint |
| --- | --- |
| `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration` | `https://login.microsoftonline.com/common/discovery/v2.0/keys` |
| `https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration`| `https://login.microsoftonline.com/{tenant-id}/discovery/v2.0/keys` |
| `https://login.microsoftonline.us/{tenant-id}/v2.0/.well-known/openid-configuration`| `https://login.microsoftonline.us/{tenant-id}/discovery/v2.0/keys` |
| `https://contosob2c.b2clogin.com/{tenant-id}/{policy}/v2.0/.well-known/openid-configuration` | `https://contosob2c.b2clogin.com/{tenant-id}/{policy}/discovery/v2.0/keys` |

The discovery keys endpoint can include multiple signing keys. If you search for a specific key or cached keys manually instead of the signing key provided by the access token, the signature validation might not succeed due to regular key rotations. For more details, see [Signing key rollover in the Microsoft identity platform](/entra/identity-platform/signing-key-rollover).

The content of discovery keys endpoint looks like this:

```json
"keys": [
		{
			"kty": "RSA",
			"use": "sig",
			"kid": "nOo3ZDrODXEK1jKWhXslHR_KXEg",
			"x5t": "nOo3ZDrODXEK1jKWhXslHR_KXEg",
			"n": "oaLLT9hkcSj2tGf...",
			"e": "AQAB",
			"x5c": [
				"MIIDBTCCAe..."
			],
			"issuer": "https://login.microsoftonline.com/{tenant-id}/v2.0"
		},
```

The `kid` claim in the access token must match one of the keys available on the discovery keys endpoint based on the `kid` property. If the `kid` doesn't match, there are two possible reasons:

- Microsoft Entra ID and Azure Active Directory (AD) B2C uses different signing keys.
- The application is enabled for Security Assertion Markup Language (SAML) Single Sign-On (SSO).

### Microsoft Entra ID and Azure AD B2C uses different signing keys

Check the `iss` claim of the access token.

For Microsoft Entra ID-issued tokens, the `iss` claim has one of these formats:

- `https://sts.windows.net/{tenant-id}` (used for v1.0 tokens)
- `https://login.microsoftonline.com/{tenant-id}/v2.0` (used for v2.0 tokens)

For Azure AD B2C-issued tokens, the `iss` claim follows this format:

`https://{your-domain}.b2clogin.com/tfp/{tenant-id}/{policy-id}/v2.0/`

Make sure your OpenId Connect Metadata configuration on the resource provider is configured correctly:

For Microsoft Entra ID-issued tokens, make sure the OpenId Connect Metadata configuration looks like `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration`.

For more information, see [OpenID Connect on the Microsoft identity platform](/entra/identity-platform/v2-protocols-oidc).

For Azure AD B2C-issued tokens, make sure the OpenId Connect Metadata configuration looks like `<https://{your-domain}.b2clogin.com/{tenant-id}/{b2c-policy}/v2.0/.well-known/openid-configuration`.

For more information, see [Web sign in with OpenID Connect in Azure Active Directory B2C](/azure/active-directory-b2c/openid-connect).

### The application is enabled for SAML SSO

Assume that the token is issued from Microsoft Entra ID instead of Azure AD B2C. When an application in Microsoft Entra ID is enabled for SAML SSO, the signing key used to sign tokens is the SAML signing certificate that is generated when SAML SSO is enabled. When you look for the `kid` from the access token on the default discovery keys endpoint, `https://login.microsoftonline.com/common/discovery/v2.0/keys`, it might not be listed.

To resolve this issue, keep your apps separate for OAuth2 and SAML. We don't recommend using the same app that performs both OAuth2 and SAML.

- Create a new app registration and don't enable SAML SSO (recommended solution)
- Convert the Enterprise App to use OAuth2 only.

    To do so, disable SAML SSO by setting the `preferredSingleSignOnMode` property on the `servicePrincipal` to null or `oidc`.
- Update the OpenId Connect Metadata configuration of the resource provider to include `?appid={application-id}`, like `https://login.microsoftonline.us/<tenant-id>/v2.0/.well-known/openid-configuration?appid=<application-id>`.

    > [!NOTE]
    > This solution is hard to implement and might not be possible depending on the resource provider.

### Configure OpenID Connect Metadata

Make sure you set the OpenId Connect Metadata configuration based on whether the token is issued from Microsoft Entra ID or Azure AD B2C or if you need to add `?appid={application-id}`.

To resolve your issue, configure the Microsoft Entra instance and tenant, or authority correctly:

- Instance

    Microsoft Entra instance would be `https://login.microsoftonline.com`. For more information about Microsoft Entra instances, see [National clouds](/entra/identity-platform/authentication-national-cloud).

- Tenant

    Tenant would be `contoso.onmicrosoft.com`. You can also use the Directory ID or any verified domain. We recommend using the Directory ID or the initial domain provided by Microsoft Entra ID (such as `contoso.onmicrosoft.com`).

- Authority

    If you configure an Authority, Instance and Tenant isn't needed as Authority follows this format:

    `{Instance}/{Tenant}`

    So, Authority would be like `https://login.microsoftonline.com/contoso.onmicrosoft.com`.

### Specify the Metadata Address

Generally the Metadata Address is built based on the Instance/Tenant/Authority configuration and will automatically concatenate `/.well-known/openid-configuration` at the end.

The following sections provide examples of manually specifying the Metadata Address.

#### Use Microsoft Identity Web

```csharp
services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
                    .AddMicrosoftIdentityWebApp(
                       options =>
                       {
                           Configuration.Bind("AzureAd", options);
                           options.MetadataAddress = metadataAddress,
                           
                       })
                       .EnableTokenAcquisitionToCallDownstreamApi(options => Configuration.Bind("AzureAd", options), initialScopes)
                         .AddMicrosoftGraph(Configuration.GetSection("GraphAPI"))
                         .AddInMemoryTokenCaches();
```

For more details, see [Microsoft Identity Web customization](https://github.com/AzureAD/microsoft-identity-web/wiki/customization).

#### Use ASP.NET standard framework

- `UseWindowsAzureActiveDirectoryBearerAuthentication`

    Set the Metadata to `https://login.microsoftonline.com/{tenant-id}/.well-known/openid-configuration`.

    ```csharp
    app.UseWindowsAzureActiveDirectoryBearerAuthentication(
                new WindowsAzureActiveDirectoryBearerAuthenticationOptions
                {
                    MetadataAddress = metadataAddress,
                    Tenant = ConfigurationManager.AppSettings["ida:Tenant"],
    ```

- `UseOpenIdConnectAuthentication`

    You can either set the Authority to `https://login.microsoftonline.com/{tenant-id}/v2.0`:

    ```csharp
    public void Configuration(IAppBuilder app)
        {
            app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);

            app.UseCookieAuthentication(new CookieAuthenticationOptions());
            app.UseOpenIdConnectAuthentication(
            new OpenIdConnectAuthenticationOptions
            {
                // Sets the ClientId, authority, RedirectUri as obtained from web.config
                ClientId = clientId,
                Authority = authority,
    ```

    Or set the Metadata Address to `https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration`:

    ```csharp
     public void Configuration(IAppBuilder app)
        {
            app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);

            app.UseCookieAuthentication(new CookieAuthenticationOptions());
            app.UseOpenIdConnectAuthentication(
            new OpenIdConnectAuthenticationOptions
            {
                // Sets the ClientId, authority, RedirectUri as obtained from web.config
                ClientId = clientId,
                MetadataAddress = metadataAddress,
    ```

#### Use Azure App Service authentication

Refer to [Configure your App Service or Azure Functions app to use Microsoft Entra sign-in](/azure/app-service/configure-authentication-provider-aad).

#### Use Azure API Management

Refer to [Secure an Azure API Management API with Azure AD B2C](/azure/active-directory-b2c/secure-api-management?tabs=app-reg-ga).

## References

[Validate tokens](/entra/identity-platform/access-tokens#validate-tokens)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]