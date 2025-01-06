---
title: Infinite redirection between OpenID Connect app and Entra ID
description: Provides guidance for troubleshooting infinite redirection between the OpenID Connect app and Entra ID.
ms.date: 12/26/2024
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# Troubleshoot infinite redirection between OIDC app and Entra ID

This article describes an infinite redirection issue that exists between an OpenID Connect (OIDC) application and Microsoft Entra ID.

## Symptoms

When you browse to a website that's built by using an OpenID Connect (OIDC) app and Microsoft Entra ID, the browser enters an infinite loop that forms between the website and the Microsoft Entra ID authentication process.

The issue specifically occurs when you browse the website by using the HTTP protocol. When you use HTTPS, the issue doesn't occur.

## Cause

The `.AspNet.Cookies` cookie that stores the access token isn't sent in HTTP requests because of its secure attribute.

## Solution: Enforce HTTPS navigation

To resolve the issue, enforce HTTPS navigation for the site. HTTPS is always recommended for sites that require authentication.

## Workaround

If your scenario requires the initial navigation to occur over HTTP, you can customize the Cookies Authentication middleware to allow the authentication AspNet cookie for both the HTTP and HTTPS schemes by setting the `CookieSecure` attribute to `CookieSecureOption.Never`, as shown in the following `Startup.Auth.cs` file.

> [!Note]
> This workaround isn't recommended for production environments because it compromises security by allowing cookies to be sent over HTTP.

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

This issue is discussed also in [this ASP.NET Security Blog article (Issue #219)](https://github.com/aspnet/Security/issues/219).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
