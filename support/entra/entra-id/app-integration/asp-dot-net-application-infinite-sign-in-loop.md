---
title: Infinite sign-in loop between ASP.NET application and Microsoft Entra ID
description: Helps you resolve an infinite sign-in loop issue between an ASP.NET application and with Microsoft Entra ID when performing sign in.
ms.date: 04/23/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---

# Infinite sign-in loop between ASP.NET application and Microsoft Entra ID

This article provides solutions to an issue where an ASP.NET application experiences an infinite redirect loop during signing in with Microsoft Entra ID.

## Symptoms

An ASP.NET application running an old version of OWIN middleware fails to recognize an authenticated request from Microsoft Entra ID.  It keeps sending the request back to Microsoft Entra ID for signing in, leading to the infinite loop issue. The following error message might be displayed in the browser:

> We couldn't sign you in. Please try again.

## Cause

This issue occurs due to a cookie mismanagement issue (a [known Katana bug](https://github.com/aspnet/AspNetKatana/wiki/System.Web-response-cookie-integration-issues)) in the old version of OWIN.

### How to recognize the Katana bug

Capture a Fiddler trace and examine one of the later redirect frames back to the web application. Note in the following screenshot, the request in frame 58 contains multiple OpenIdConnect.nonce cookies (red-circled). In a working scenario, you should only have one OpenIdConnect.nonce cookie set at the beginning before authentication. After the request is successfully authenticated, this nonce cookie is destroyed and ASP.NET sets its own session cookie. Because of this bug, you see there is a build up of these nonce cookies.

:::image type="content" source="media/asp-dot-net-application-infinite-sign-in-loop/openidconnet-nonce-cookies.png" alt-text="Screenshot that shows multiple OpenIdConnect nonce cookies." lightbox="media/asp-dot-net-application-infinite-sign-in-loop/openidconnet-nonce-cookies.png":::

## Solution 1: Upgrade to ASP.NET Core

The issue has been resolved in ASP.NET Core and a newer version of Katana OWIN for ASP.NET. To resolve this issue, upgrade your application to use ASP.NET Core.

If you must continue to use ASP.NET, perform the following things:

- Update your application's Microsoft.Owin.Host.SystemWeb package to be at least version 3.1.0.0.
- Modify your code to use one of the new cookie manager classes, for example:

    ```csharp
    app.UseCookieAuthentication(new CookieAuthenticationOptions 
    { 
        AuthenticationType = "Cookies", 
        CookieManager = new Microsoft.Owin.Host.SystemWeb.SystemWebChunkingCookieManager() 
    });
    ```
    
    Or
    
    ```csharp
    app.UseCookieAuthentication(new CookieAuthenticationOptions() 
    { 
        CookieManager = new SystemWebCookieManager() 
    });
    ```

## Solution 2: Correct the redirect URL

In some cases where the application is hosted under a virtual directory or an application instead of the root of the web site, the [solution 1](#solution-1-upgrade-to-aspnet-core) might not work. For more information, see [Infinite re-direct loop after AAD Authentication when redirect is specified](https://stackoverflow.com/questions/44397715/infinite-re-direct-loop-after-aad-authentication-when-redirect-is-specified) and [Microsoft Account OAuth2 sign-on fails when redirect URL is not under the website root](https://github.com/aspnet/AspNetKatana/issues/203).

For example, suppose you have the following environment:

- The root of a web site: `https://mysite` – This site runs under *Application Pool 1*.
- An application *test2* under the root: `https://mysite/test2` – This application runs under *Application Pool 2*.
- Your ASP.NET application runs under the *tes2* application with the following code:

    ```csharp
    public void Configuration(IAppBuilder app)
            {
                // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=316888
                app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);
                app.UseCookieAuthentication(new CookieAuthenticationOptions());
                app.UseOpenIdConnectAuthentication(
                    new OpenIdConnectAuthenticationOptions
                    {
                        // Sets the ClientId, authority, RedirectUri as obtained from web.config
                        ClientId = clientId,
                        Authority = authority,
                        RedirectUri = "https://mysite/test2",
                        // PostLogoutRedirectUri is the page that users will be redirected to after sign-out. In this case, it is using the home page
                        PostLogoutRedirectUri = redirectUri,
                        Scope = OpenIdConnectScope.OpenIdProfile,
                        // ResponseType is set to request the id\_token - which contains basic information about the signed-in user
                        ResponseType = OpenIdConnectResponseType.IdToken,
                        // ValidateIssuer set to false to allow personal and work accounts from any organization to sign in to your application
                        // To only allow users from a single organizations, set ValidateIssuer to true and 'tenant' setting in web.config to the tenant name
                        // To allow users from only a list of specific organizations, set ValidateIssuer to true and use ValidIssuers parameter
    
                        // OpenIdConnectAuthenticationNotifications configures OWIN to send notification of failed authentications to OnAuthenticationFailed method
                        
                        Notifications = new OpenIdConnectAuthenticationNotifications
                        {
                            AuthenticationFailed = OnAuthenticationFailed
                        }
    
                    }
                );
            }
    ```

    And you are using the following code for triggering the sign in flow:
    
    ```csharp
    public void SignIn()
            {
                if (!Request.IsAuthenticated)
                {
                    HttpContext.GetOwinContext().Authentication.Challenge(
                        new AuthenticationProperties { RedirectUri = "/" },
                        OpenIdConnectAuthenticationDefaults.AuthenticationType);
                }
            }
    ```

This scenario can result in an authentication infinite loop with a build-up of multiple OpenIdConnect.nonce cookies. The difference is that ASP.NET doesn't appear to set its authenticated session cookies. To resolve the issue in such scenario, set the redirect URLs in the OpenID Connect initialization code and the `Challenge` method (note the trailing slash in the redirect URL):

```csharp
app.UseOpenIdConnectAuthentication(
                new OpenIdConnectAuthenticationOptions
                {
                    // Sets the ClientId, authority, RedirectUri as obtained from web.config
                    ClientId = clientId,
                    Authority = authority,
                    RedirectUri = "https://mysite/test2/",
                    // PostLogoutRedirectUri is the page that users will be redirected to after sign-out. In this case, it is using the home page
                    PostLogoutRedirectUri = redirectUri,
                    Scope = OpenIdConnectScope.OpenIdProfile,
...
```

```csharp
 public void SignIn()
        {
            if (!Request.IsAuthenticated)
            {
                HttpContext.GetOwinContext().Authentication.Challenge(
                    new AuthenticationProperties { RedirectUri = "/test2/" },
                    OpenIdConnectAuthenticationDefaults.AuthenticationType);
            }
        }
```

## References

[Infinite redirects with ASP.NET OWIN and OpenID Connect](https://varnerin.info/infinite-redirects-with-aspnet-owin-and-openid-connect/)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]