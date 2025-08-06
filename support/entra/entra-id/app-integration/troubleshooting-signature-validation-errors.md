---
title: Troubleshoot Access Token Signature Validation Errors
description: Helps you troubleshoot access token signature validation errors and provides solutions in some scenarios.
ms.date: 08/06/2025
ms.reviewer: willfid
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Troubleshoot access token signature validation errors

When a resource provider validates an access token's signature, signature validation errors occur. These errors might result from the signing key being unavailable or failing to validate the signature. This article helps you troubleshoot such errors and provides solutions in some scenarios.

## Step 1: Decode the access token

1. Get the access token being sent to the resource provider.
1. Decode the access token and review the following claims:

    - `aud` (Audience)
    - `iss` (Issuer)
    - `kid` (Key ID)

    > [!NOTE]
    > You can decode access tokens using [https://jwt.ms](https://jwt.ms).

## Step 2: Validate the audience claim of the access token

If you send a Microsoft Graph access token to a non-Microsoft Graph resource provider, you will get a signature validation error. Only Microsoft Graph can validate such token. The value of a Microsoft Graph token's `aud` claim is one of the following:

- `https://graph.microsoft.us`
- `https://graph.microsoft.us/`
- `https://graph.microsoft.com`
- `https://graph.microsoft.com/`
- `https://dod-graph.microsoft.us`
- `https://dod-graph.microsoft.us/`
- `00000003-0000-0000-c000-000000000000`

To resolve the signature validation error, ensure the correct access token is acquired for the resource provider and its `aud` claim is expected by the resource provider.

The audience claim of an access token is determined by the `scope` parameter that's sent in the request when acquiring access tokens. For example, to get an access token for `https://api.contoso.com`, use a scope like `https://api.contoso.com/read`.

For more information, see [Configure an application to expose a web API](/entra/identity-platform/quickstart-configure-app-expose-web-apis).

## Step 3: Validate the signing key

For other scenarios, the resource provider determines where to get the signing keys based on the OpenId Connect Metadata configuration and which signing key to use based on the `kid` claim of an access token. You can configure the OpenId Connect Metadata on the resource provider such as your custom API or API Authentication layer.

If you use a Microsoft authentication library like Microsoft Authentication Library (MSAL) or Microsoft Identity Web to authenticate an application, the default `MetadataAddress` that points to the OpenId Connect Metadata configuration is like `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration`.

If you have configured a tenant ID, the `MetadataAddress` would be `https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration`. If you have configured an `Authority` like `https://login.microsoftonline.us/{tenant-id}`, the `MetadataAddress` would be `https://login.microsoftonline.us/{tenant-id}/v2.0/.well-known/openid-configuration`.

The OpenId Connect Metadata endpoint includes the `jwks_uri` property (also known as discovery keys endpoint), which specifies the location of signing keys. Depending on which OpenId Connect Metadata endpoint is used, it will return a different URL for the `jwks_uri` property. Here's a table that provides a few examples:

| Metadata endpoint | Discovery keys endpoint |
| --- | --- |
| `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration` | `https://login.microsoftonline.com/common/discovery/v2.0/keys` |
| `https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration`| `https://login.microsoftonline.com/{tenant-id}/discovery/v2.0/keys` |
| `https://contosob2c.b2clogin.com/{tenant-id}/{policy}/v2.0/.well-known/openid-configuration` | `https://contosob2c.b2clogin.com/{tenant-id}/{policy}/discovery/v2.0/keys` |

The discovery keys endpoint includes multiple signing keys. If you use a specific key manually instead of the signing key provided in the access token, or your cached key, the signature validation might not succeed due to regular key rotations. For more details, see [Signing key rollover in the Microsoft identity platform](/entra/identity-platform/signing-key-rollover).

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

The `kid` claim of the access token must match one of the keys available on the discovery keys endpoint based on the `kid` property. If it doesn't match, there are two possible reasons:

- Microsoft Entra ID and Azure Active Directory (AD) B2C uses different signing keys.
- The application is enabled for Security Assertion Markup Language (SAML) Single Sign-On (SSO).

To resolve this mismatch, go to [Step 4: Validate the iss claim of the access token](#step-4-validate-the-iss-claim-of-the-access-token).

## Step 4: Validate the iss claim of the access token

### Scenario 1: Microsoft Entra ID and Azure AD B2C uses different signing keys

Check the `iss` claim of the access token. The `iss` claim indicates who issued the token:

- For Microsoft Entra ID-issued tokens, the `iss` claim has one of these formats:

  - `https://sts.windows.net/{tenant-id}` (used for v1.0 tokens)
  - `https://login.microsoftonline.com/{tenant-id}/v2.0` (used for v2.0 tokens)

- For Microsoft Entra External ID-issued tokens, the `iss` claim has this format:

    `https://{your-domain}.ciamlogin.com/{tenant-id}/v2.0/`

- For Azure AD B2C-issued tokens, the `iss` claim has this format:

    `https://{your-domain}.b2clogin.com/tfp/{tenant-id}/{policy-id}/v2.0/`

To avoid signature validation errors, configure your OpenID Connect Metadata correctly based on the token issuer:

- For Microsoft Entra ID-issued tokens, make sure the OpenId Connect Metadata configuration looks like `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration`.

    For more information, see [OpenID Connect on the Microsoft identity platform](/entra/identity-platform/v2-protocols-oidc).

- For Microsoft Entra External ID-issued tokens, make sure the OpenId Connect Metadata configuration looks like `https://{tenant-domain}.ciamlogin.com/{tenant-id}/v2.0/.well-known/openid-configuration`.

    For more information, see [Set up your OpenID Connect identity provider](/entra/external-id/customers/how-to-custom-oidc-federation-customers#set-up-your-openid-connect-identity-provider).

- For Azure AD B2C-issued tokens, make sure the OpenId Connect Metadata configuration looks like `<https://{your-domain}.b2clogin.com/{tenant-id}/{b2c-policy}/v2.0/.well-known/openid-configuration`.

    For more information, see [Web sign in with OpenID Connect in Azure Active Directory B2C](/azure/active-directory-b2c/openid-connect).

### Scenario 2: The application is enabled for SAML SSO

Assume that the access token is issued from Microsoft Entra ID instead of Azure AD B2C. When an application in Microsoft Entra ID is enabled for SAML SSO, the signing key used to sign tokens is the SAML signing certificate. So, when you look for the `kid` claim from the access token on the default discovery keys endpoint, usually `https://login.microsoftonline.com/common/discovery/v2.0/keys`, it might not be listed.

We don't recommend using both OAuth2 and SAML for the same application. To resolve this issue, keep your application separate for OAuth2 and SAML by using one of the following methods:

- Create a new app registration for OAuth2 (recommended method)
- Convert the enterprise application to use OAuth2 only.

    To do so, disable SAML SSO by setting the `preferredSingleSignOnMode` property on the `servicePrincipal` to `null` or `oidc`.

- Update the OpenId Connect Metadata configuration of the resource provider to include `?appid={application-id}`, like `https://login.microsoftonline.us/<tenant-id>/v2.0/.well-known/openid-configuration?appid=<application-id>`.

    > [!NOTE]
    > This solution is hard to implement and might not be possible depending on the resource provider.

## Examples of OpenId Connect Metadata configurations

Make sure you set the OpenId Connect Metadata configuration based on whether the access token is issued from Microsoft Entra ID or Azure AD B2C, or if adding `?appid={application-id}`.

Generally configuring the Microsoft Entra ID `Instance` and `Tenant`, or `Authority` correctly can resolve signature validation errors.

- `Instance`

    Microsoft Entra ID instance would be `https://login.microsoftonline.com`. For more information about Microsoft Entra ID instances, see [National clouds](/entra/identity-platform/authentication-national-cloud).

- `Tenant`

    Tenant would be `contoso.onmicrosoft.com`. You can also use the Directory ID or any verified domain. We recommend using the Directory ID or the initial domain provided by Microsoft Entra ID (such as `contoso.onmicrosoft.com`).

- `Authority`

    If you configure an `Authority`, `Instance` and `Tenant` isn't needed as `Authority` follows this format:

    `{Instance}/{Tenant}`

    So, `Authority` would be like `https://login.microsoftonline.com/contoso.onmicrosoft.com`.

Generally the `MetadataAddress` is built based on the `Instance`/`Tenant`/`Authority` configuration and will automatically concatenate `/.well-known/openid-configuration` at the end. The following sections provide examples of manually specifying the `MetadataAddress`.

### Example 1: Use Microsoft Identity Web

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

### Example 2: Use ASP.NET standard framework

- `UseWindowsAzureActiveDirectoryBearerAuthentication`

    Set the metadata to `https://login.microsoftonline.com/{tenant-id}/.well-known/openid-configuration`.

    ```csharp
    app.UseWindowsAzureActiveDirectoryBearerAuthentication(
                new WindowsAzureActiveDirectoryBearerAuthenticationOptions
                {
                    MetadataAddress = metadataAddress,
                    Tenant = ConfigurationManager.AppSettings["ida:Tenant"],
    ```

- `UseOpenIdConnectAuthentication`

    You can either set the `Authority` to `https://login.microsoftonline.com/{tenant-id}/v2.0`:

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

    Or set the `MetadataAddress` to `https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration`:

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

### Example 3: Use Azure App Service authentication

Refer to [Configure your App Service or Azure Functions app to use Microsoft Entra sign-in](/azure/app-service/configure-authentication-provider-aad).

### Exempale 4: Use Azure API Management

Refer to [Secure an Azure API Management API with Azure AD B2C](/azure/active-directory-b2c/secure-api-management?tabs=app-reg-ga).

## References

[Validate tokens](/entra/identity-platform/access-tokens#validate-tokens)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
