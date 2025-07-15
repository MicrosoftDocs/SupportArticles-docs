---
ai-usage: ai-assisted
---
# Troubleshooting signature validation errors

Signature validation errors occur when a resource provider (not Microsoft Entra ID) can't validate the token's signature. They could be due to the signing key being unavailable or failing to validate the signature. This article covers common scenarios and solutions to resolve these errors. While the root cause remains consistent, token validation approaches may vary among developers and vendors.

Steps to troubleshoot:

- [Step 1](#step1)
- [Step 2](#step2)

## Steps to troubleshoot

### <a id="step1"/> [Step 1: Get and decode the access token](#tab/step1)

To understand the issue, get and decode the access token being sent to the resource provider. Then, review the following claims in the token:
- **aud** (Audience)
- **iss** (Issuer)
- **kid** (Key ID)

You can decode access tokens using [https://jwt.ms](https://jwt.ms).

### <a id="step2"/> [Step 2: Identify the access token using the "aud" claim](#tab/step2)

If you send a Microsoft Graph access token to a non-Microsoft Graph resource provider, you will get a signature validation error. Only Microsoft Graph can validate these tokens. You can identify Microsoft Graph tokens by the "aud" claim. Its value is one of the following:
- https://graph.microsoft.us
- https://graph.microsoft.us/
- https://graph.microsoft.com
- https://graph.microsoft.com/
- https://dod-graph.microsoft.us
- https://dod-graph.microsoft.us/
- 00000003-0000-0000-c000-000000000000

---

**Solution:** Ensure the correct access token is acquired for the resource provider and the “aud” claim is expected by the resource provider. The audience of access tokens is determined by the scope parameter that is sent in the request when acquiring access tokens. For example, to get an access token for https://api.contoso.com, use a scope like https://api.contoso.com/read.

For more information, see [Configure an application to expose a web API](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-configure-app-expose-web-apis).

### Step 3: Validate the signing key configuration

For other scenarios, the resource provider determines where to get the signing keys based on the OpenId Connect Metadata configuration and which signing key to use based on the “kid” claim in the access token. You can configure this on the resource provider such as your custom API or API Authentication layer. If you use a Microsoft Authentication library like MSAL or Microsoft Identity Web, the default configuration is like the following:

{"token_endpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/token","token_endpoint_auth_methods_supported":["client_secret_post","private_key_jwt","client_secret_basic"],"jwks_uri":"https://login.microsoftonline.com/common/discovery/v2.0/keys","response_modes_supported":["query","fragment","form_post"],"subject_types_supported":["pairwise"],"id_token_signing_alg_values_supported":["RS256"],"response_types_supported":["code","id_token","code id_token","id_token token"],"scopes_supported":["openid","profile","email","offline_access"],"issuer":"https://login.microsoftonline.com/{tenantid}/v2.0","request_uri_parameter_supported":false,"userinfo_endpoint":"https://graph.microsoft.com/oidc/userinfo","authorization_endpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/authorize","device_authorization_endpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/devicecode","http_logout_supported":true,"frontchannel_logout_supported":true,"end_session_endpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/logout","claims_supported":["sub","iss","cloud_instance_name","cloud_instance_host_name","cloud_graph_host_name","msgraph_host","aud","exp","iat","auth_time","acr","nonce","preferred_username","name","tid","ver","at_hash","c_hash","email"],"kerberos_endpoint":"https://login.microsoftonline.com/common/kerberos","tenant_region_scope":null,"cloud_instance_name":"microsoftonline.com","cloud_graph_host_name":"graph.windows.net","msgraph_host":"graph.microsoft.com","rbac_url":"https://pas.windows.net"}

#### If you have configured a Tenant ID, then the MetadataAddress would be [<u>https://login.microsoftonline.com/{tenantid}/v2.0/.well-known/openid-configuration</u>](https://login.microsoftonline.com/{tenantid}/v2.0/.well-known/openid-configuration). If you configured an Authority that looks like [<u>https://login.microsoftonline.us</u>](https://login.microsoftonline.us/e21bbca2-1b75-4dea-9e34-d3d95d2ec661)[<u>/{tenantid}</u>](https://login.microsoftonline.com/{tenantid}/v2.0/.well-known/openid-configuration) then the MetadataAddress would be <u>https://login.microsoftonline.us/e21bbca2-1b75-4dea-9e34-d3d95d2ec661/v2.0/.well-known/openid-configuration</u>

The OpenId Connect Metadata endpoint includes a jwks\_uri property (also known as discovery keys endpoint), which specifies the location of signing keys. Depending on which OpenId Connect Metadata endpoint is used, it will return a URL for the jwks\_uri. Here’s a table that provides a few examples:

| **Metadata endpoint** | **Discovery keys endpoint** |
| --- | --- |
| https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration | https://login.microsoftonline.com/common/discovery/v2.0/keys |
| https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration | https://login.microsoftonline.com/{tenant-id}/discovery/v2.0/keys |
| https://login.microsoftonline.us/{tenant-id}/v2.0/.well-known/openid-configuration | https://login.microsoftonline.us/{tenant-id}/discovery/v2.0/keys |
| https://contosob2c.b2clogin.com/{tenant-id}/{policy}/v2.0/.well-known/openid-configuration | https://contosob2c.b2clogin.com/{tenant-id}/{policy}/discovery/v2.0/keys |

The discovery keys endpoint can include multiple signing keys. If you search for a specific key or cached keys manually instead of the signing key provided by the access token, the signature validation might not succeed due to regular key rotations. For more details, see [Signing key rollover in the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/signing-key-rollover)**.**

The content of discovery keys endpoint looks like this:

"keys": [ { "kty": "RSA", "use": "sig", "kid": "nOo3ZDrODXEK1jKWhXslHR_KXEg", "x5t": "nOo3ZDrODXEK1jKWhXslHR_KXEg", "n": "oaLLT9hkcSj2tGf...", "e": "AQAB", "x5c": [ "MIIDBTCCAe..." ], "issuer": "https://login.microsoftonline.com/aa00d1fa-5269-4e1c-b06d-30868371d2c5/v2.0" },

### Step 4: Verify the "iss" claim

The “kid” claim in the access token must match one of the available keys available on the discovery key endpoint based on the “kid” property. If the “kid” doesn't match, there are two possible reasons:
- Microsoft Entra ID and B2C uses different signing keys.
- The application is enabled for SAML SSO.

### Microsoft Entra ID and B2C uses different signing keys

Check the “iss” claim of the access token. For Microsoft Entra ID-issued tokens, the "iss" claim has one of these formats:
- https://sts.windows.net/{tenant-id} (used for v1.0 tokens)
- https://login.microsoftonline.com/{tenant-id}/v2.0 (used for v2.0 tokens)

For Azure B2C-issued tokens, the "iss" claim follows this structure:
- https://{your-domain}.b2clogin.com/tfp/{tenant-id}/{policy-id}/v2.0/

Important: Make sure your OpenId Connect Metadata configuration on the resource provider is configured correctly.

**Solution:** Ensure the OpenID Connect Metadata configuration matches the issuer:

**For Microsoft Entra ID-issued tokens,** make sure the OpenId Connect Metadata configuration looks like this <u>https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration</u>

{"token_endpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/token","token_endpoint_auth_methods_supported":["client_secret_post","private_key_jwt","client_secret_basic"],"jwks_uri":"https://login.microsoftonline.com/common/discovery/v2.0/keys","response_modes_supported":["query","fragment","form_post"],"subject_types_supported":["pairwise"],"id_token_signing_alg_values_supported":["RS256"],"response_types_supported":["code","id_token","code id_token","id_token token"],"scopes_supported":["openid","profile","email","offline_access"],"issuer":"https://login.microsoftonline.com/{tenantid}/v2.0","request_uri_parameter_supported":false,"userinfo_endpoint":"https://graph.microsoft.com/oidc/userinfo","authorization_endpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/authorize","device_authorization_endpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/devicecode","http_logout_supported":true,"frontchannel_logout_supported":true,"end_session_endpoint":"https://login.microsoftonline.com/common/oauth2/v2.0/logout","claims_supported":["sub","iss","cloud_instance_name","cloud_instance_host_name","cloud_graph_host_name","msgraph_host","aud","exp","iat","auth_time","acr","nonce","preferred_username","name","tid","ver","at_hash","c_hash","email"],"kerberos_endpoint":"https://login.microsoftonline.com/common/kerberos","tenant_region_scope":null,"cloud_instance_name":"microsoftonline.com","cloud_graph_host_name":"graph.windows.net","msgraph_host":"graph.microsoft.com","rbac_url":"https://pas.windows.net"}

For more information, see [OpenID Connect on the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc).

**For Azure B2C-issued tokens,** make sure the OpenId Connect Metadata configuration looks like <u>https://{domain}.b2clogin.com/{tenant-id}/{b2c-policy}/v2.0/.well-known/openid-configuration</u>

https://{domain}.b2clogin.com/{tenant-id}/{policy}/v2.0/.well-known/openid-configuration

For more information, see [Web sign in with OpenID Connect in Azure Active Directory B2C](https://learn.microsoft.com/en-us/azure/active-directory-b2c/openid-connect).

### The application is enabled for SAML SSO

Assume that the token is issued from Microsoft Entra ID and not Azure B2C. When an application in Microsoft Entra ID is enabled for **Security Assertion Markup Language (SAML)** **Single Sign-On (SSO)**, the signing key used to sign tokens is the SAML signing certificate that is generated when SAML SSO is enabled. When you look for the “kid” from the access token on the default discovery keys endpoint, usually [https://login.microsoftonline.com/common/discovery/v2.0/keys](https://login.microsoftonline.com/common/discovery/v2.0/keys), it might not be listed.

To resolve this issue, keep your apps separate for OAuth2 and SAML. We don't recommend using the same app that performs both OAuth2 and SAML.
- Create a new app registration and don't enable SAML SSO (recommended solution)
- Convert the Enterprise App to use OAuth2 only. 

    To do so, disable SAML SSO by setting the preferredSingleSignOnMode property on the servicePrincipal to null or oidc.
- Update the OpenId Connect Metadata configuration of the resource provider to include ?appid={application-id}, like [https://login.microsoftonline.us/<tenant-id>/v2.0/.well-known/openid-configuration?appid=<application-id>](https://login.microsoftonline.us/e21bbca2-1b75-4dea-9e34-d3d95d2ec661/v2.0/.well-known/openid-configuration?appid=06051593-1954-4e1f-a75f-7e5de243aeff).

    NOTE: This solution is hard to implement and might not be possible depending on the resource provider.

### Examples of configuring OpenID Connect Metadata

Make sure you set the OpenId Connect Metadata configuration based on whether the token is issued from Microsoft Entra ID or Azure B2C or if you need to add ?appid={application-id}.

Generally if you configure the Microsoft Entra instance and tenant or authority correctly, this will resolve your issue.

#### **Instance**

Microsoft Entra instance would be [<u>https://login.microsoftonline.com</u>](https://login.microsoftonline.com/). For more information about Microsoft Entra Instances, see [**National clouds**](https://learn.microsoft.com/en-us/entra/identity-platform/authentication-national-cloud)**.**

#### **Tenant**

Tenant would be contoso.onmicrosoft.com. You can also use the directory id or any verified domain. We recommend using the Directory ID or the initial domain provided by Microsoft Entra ID (such as contoso.onmicrosoft.com).

#### **Authority**

If configuring an Authority, generally Instance and Tenant is not needed as Authority follows this format:

{Instance}/{Tenant}

So, Authority would be like [<u>https://login.microsoftonline.com/contoso.onmicrosoft.com</u>](https://login.microsoftonline.com/contoso.onmicrosoft.com)

Generally the Metadata Address is built based on this Instance/Tenant/Authority configuration and will automatically concatenate /.well-known/openid-configuration at the end.

The following sections provide examples of manually specifying the Metadata Address.

#### Using Microsoft Identity Web

csharp
services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
.AddMicrosoftIdentityWebApp(options =&gt;
{
Configuration.Bind("AzureAd", options);
options.MetadataAddress = metadataAddress;
});

For more details, see [Microsoft Identity Web customization](https://github.com/AzureAD/microsoft-identity-web/wiki/customization).

#### Using ASP.NET standard Framework
- **UseWindowsAzureActiveDirectoryBearerAuthentication**
Set the Metadata to https://login.microsoftonline.com/{tenant-id}/.well-known/openid-configuration.
- **UseOpenIdConnectAuthentication**
You can either set the Authority as [<u>https://login.microsoftonline.com/{tenant-id}/v2.0</u>](https://login.microsoftonline.com/%7Btenant-id%7D/v2.0)<u>.</u>

    Or set the Metadata to [<u>https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration</u>](https://login.microsoftonline.com/%7Btenant-id%7D/v2.0/.well-known/openid-configuration)

#### Using Azure App Service Authentication

See [Configure your App Service or Azure Functions app to use Microsoft Entra sign-in](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-aad).

#### **Using Azure API Management**

See [Secure an Azure API Management API with Azure AD B2C](https://learn.microsoft.com/en-us/azure/active-directory-b2c/secure-api-management?tabs=app-reg-ga).

## References
- [Validate tokens](https://learn.microsoft.com/en-us/entra/identity-platform/access-tokens#validate-tokens)