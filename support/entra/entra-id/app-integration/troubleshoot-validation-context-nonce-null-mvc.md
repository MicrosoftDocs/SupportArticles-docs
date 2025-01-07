---
title: Resolving nonce validation errors in ASP.NET MVC with OpenID Connect
description: This article provides solutions to the common nonce validation errors that are encountered in ASP.NET MVC apps by using OpenID Connect middleware.
ms.date: 01/02/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Development	Developing or Registering apps with Microsoft identity platform
---

# "ValidationContext.Nonce is null" errors in ASP.NET MVC apps

This article provides solutions to the common nonce validation errors that you might encounter in ASP.NET MVC apps by using OpenID Connect (OIDC)  middleware.

## Common error messages

Depending on the version of Open Web Interface for .NET (OWIN) that you use, you might receive one of the following error messages:

- IDX21323: RequireNonce is '[PII is hidden by default. Set the 'ShowPII' flag in IdentityModelEventSource.cs to true to reveal it.]'. OpenIdConnectProtocolValidationContext.Nonce was null, OpenIdConnectProtocol.ValidatedIdToken.Payload.Nonce was not null. The nonce cannot be validated. If you do not need to check the nonce, set OpenIdConnectProtocolValidator.RequireNonce to false.

- IDX10311: RequireNonce is 'true' (default) but validationContext.Nonce is null. A nonce cannot be validated. If you do not need to check the nonce, set OpenIdConnectProtocolValidator.RequireNonce to false.

## Understanding nonce cookies

The ASP.NET OIDC middleware uses a nonce cookie to prevent [replay attacks](/dotnet/framework/wcf/feature-details/replay-attacks). The app throws the exception if it can't find the nonce cookie in the authenticated request. Cookies are domain-based. This means that if the cookies are set for a specific domain, all subsequent requests to that domain will include the cookies until they expire or are deleted.

The following Fiddler traces describe how these cookies are set and used in a working flow:

- In Frame 116, the browser sends a request to the OIDC app that's protected by Microsoft Entra ID. After receiving the request, the app detects that it isn't authenticated. It then redirects the request to Microsoft Entra ID (`login.microsoftonline.com`) for authentication. Additionally, the app sets the `OpenIdConnect.nonce` cookie in the "302" redirect response.

    :::image type="content" source="media/troubleshoot-validation-context-nonce-null-mvc/fiddler-trace-start-auth.png" alt-text="Screenshot of Frame 116 in Fiddler Trace." lightbox="media/troubleshoot-validation-context-nonce-null-mvc/fiddler-trace-start-auth.png":::

- After successful authentication (Frame 120-228), Microsoft Entra ID redirects the request back to the web app (Frame 229) together with the authenticated ID token. The nonce cookie that was previously set for this domain is also included in the POST request. The OIDC middleware validates the authenticated token and the nonce cookie before it continues to load the page (through another redirect). At this point, the nonce cookie's purpose is finished, and the app invalidates it by setting the expiration attribute to expire.

    :::image type="content" source="media/troubleshoot-validation-context-nonce-null-mvc/fiddler-trace-after-auth.png" alt-text="Screenshot of Fiddler Trace Frames related to authentication." lightbox="media/troubleshoot-validation-context-nonce-null-mvc/fiddler-trace-after-auth.png":::

## Solution

### Cause 1: Multiple domains are used for the same website

The browser originally navigates to the app on Domain A (Frame 9), and the nonce cookie is set for this domain. Later, Microsoft Entra ID sends the authenticated token to Domain B (Frame 91). Because the redirection to Domain B doesn't include the nonce cookie, the web app throws the `validationContext.Nonce is null` error.

:::image type="content" source="media/troubleshoot-validation-context-nonce-null-mvc/fiddler-trace-multiple-domains.png" alt-text="Screenshot of Fiddler Trace Frames related to Cause 1." lightbox="media/troubleshoot-validation-context-nonce-null-mvc/fiddler-trace-multiple-domains.png":::

### Solution 1

To resolve this issue, follow these steps:

1. Redirect the request back to the same domain that was originally used after authentication. To control where Azure AD sent the authenticated request back to the app, set the `OpenIdConnectAuthentications.RedirectUri` property in the `ConfigureAuth` method.

1. Configure the redirect URI (reply URL) in App Registration. Otherwise you might receive the following error: AADSTS50011: The reply URL that's specified in the request doesn't  match the reply URLs that Azure configured for the app. For more information, see [Error AADSTS50011 with OpenID authentication](error-code-aadsts50011-redirect-uri-mismatch.md).

### Cause 2: Missing SameSite attributes

Because of the [SameSite cookie security updates](/azure/active-directory/develop/howto-handle-samesite-cookie-changes-chrome-browser?tabs=dotnet), all cookies that are involved in the authentication process (including Nonce cookies) should contain the following attributes:

- SameSite=None
- Secure

For more information, see [SameSite cookies and the Open Web Interface for .NET](/aspnet/samesite/owin-samesite).

![Screenshot of missing SameSite attributes Fiddler trace.](./media//troubleshoot-validation-context-nonce-null-mvc/fiddler-trace-misisng-samesite.png)

### Solution 2

To make sure that both the required attributes are included, follow these steps:

1. Use the HTTPS protocol to navigate to the web app.
1. Update .NET Framework and NuGet packages:
    - For .NET Framework apps: Upgrade .NET Framework to version 4.7.2+ and relevant NuGet packages (Microsoft.Owin.Security.OpenIdConnect, Microsoft.Owin) to version 4.1.0+.
    - For .NET Core apps:
        - Version 2._x_ apps should use .NET Core 2.1+.
        - Version 3._x_ apps should use .NET Core 3.1+.

Example configuration code for Startup.Auth.cs:

```csharp
using System.Configuration;
using Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OpenIdConnect;
using System.Threading.Tasks;
using Microsoft.Owin.Security.Notifications;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;

namespace NetWebAppOIDC2
{
    public partial class Startup
    {
        private static string clientId = ConfigurationManager.AppSettings["ida:ClientId"];
        private static string aadInstance = ConfigurationManager.AppSettings["ida:AADInstance"];
        private static string tenantId = ConfigurationManager.AppSettings["ida:TenantId"];
        private static string postLogoutRedirectUri = ConfigurationManager.AppSettings["ida:PostLogoutRedirectUri"];
        private static string authority = aadInstance + tenantId;

        public void ConfigureAuth(IAppBuilder app)
        {
            app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);

            app.UseCookieAuthentication(new CookieAuthenticationOptions());
            app.UseOpenIdConnectAuthentication(
                new OpenIdConnectAuthenticationOptions
                {
                    ClientId = clientId,
                    Authority = authority,
                    PostLogoutRedirectUri = postLogoutRedirectUri,
                    RedirectUri = "https://localhost:44313",
                    
                    Notifications = new OpenIdConnectAuthenticationNotifications
                    {
                        AuthenticationFailed = OnAuthenticationFailed
                    }

                    // Don't use SystemwebCookieManager class here to override the default CookieManager because that seems to negate the SameSite cookie attribute that's being set.
                    // CookieManager = new SystemWebCookieManager()

                });
        }

        private Task OnAuthenticationFailed(AuthenticationFailedNotification<OpenIdConnectMessage, OpenIdConnectAuthenticationOptions> context)
        {
            context.HandleResponse();
            context.Response.Redirect("/?errormessage=" + context.Exception.Message);
            return Task.FromResult(0);
        }
    }
}
```

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
