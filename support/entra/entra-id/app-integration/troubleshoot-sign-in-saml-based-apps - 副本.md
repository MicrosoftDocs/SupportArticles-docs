---
title: Infinite redirection between OpenID Connect app and Entra ID
description: Guidance for troubleshooting infinite redirection between OpenID Connect app and Entra ID.
ms.date: 12/26/2024
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# Troubleshooting infinite redirection between OIDC app and Entra ID

This article describes an infinite redirection issue between an OpenID Connect (OIDC) application and Microsoft Entra ID.

## Symptoms

When you browse to a website that is built by using an OpenID Connect (OIDC) app with Microsoft Entra ID, the browser enters an infinite loop between the website and Microsoft Entra ID authentication process.

The problem specifically occurs when you start browsing the website using the HTTP protocol. When using HTTPS, the issue doesn't occur.

## Cause

The `.AspNet.Cookies` cookie that stores the access token isn't sent in HTTP requests due to its secure attribute.

## Solution

### Recommended Fix: Enforce HTTPS Navigation

To resolve the issue, enforce HTTPS navigation for the site. HTTPS is always recommended for sites requiring authentication.

### Workaround

If your scenario requires the initial navigation to happen over http, you can customize the Cookies Authentication middleware to allow the authentication AspNet cookie for both HTTP and HTTPS scheme by setting the `CookieSecure` attribute to `CookieSecureOption.Never` as followed in the `Startup.Auth.cs` file:

> [!Note]
> This workaround isn't recommended for production environments as it compromises security by allowing cookies to be sent over HTTP.

```csharp
public void ConfigureAuth(IAppBuilder app)
        {
            app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                CookieSecure = CookieSecureOption.Never
            });

            app.UseOpenIdConnectAuthentication(
                new OpenIdConnectAuthenticationOptions
                {
                    ClientId = clientId,
                    Authority = authority,

}
        }
```

This issue is also discussed in the following GitHub issue: [ASP.NET Issue #219](https://github.com/aspnet/Security/issues/219).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
