---
title: No account or login hint was passed to the AcquireTokenSilent
description: Provides solutions to an error that occurs when web applications using Microsoft Authentication Library (MSAL) or Microsoft Identity Web acquire a token silently.
ms.service: entra-id
ms.date: 06/16/2025
ms.reviewer: willfid, v-weizhu
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Error "No account or login hint was passed to the AcquireTokenSilent" in web applications without persistent token cache

This article offers solutions for the error "No account or login hint was passed to the AcquireTokenSilent" that occurs with a web application using Microsoft Authentication Library (MSAL) or Microsoft Identity Web.

## Symptoms

Assume that your web applications authenticate users using MSAL or Microsoft Identity Web and don't use persistent token caches. When MSAL tries to pull a user account and acquire a token silently from its token cache, the following error message is displayed:

> No account or login hint was passed to the AcquireTokenSilent

## Cause

This issue occurs because MSAL looks for a account that no longer exists in the token cache based on the existing authentication cookie. The authentication cookie is created only after a interactive sign-in and contains information about the user. This issue occurs in the following scenarios:

- After the web application has restarted.
- Memory is cleared due to high memory usage or a set period of inactivity.
- MSAL has a default cache size limit that automatically removes older entries.

## Solution 1 (recommended): Implement a persistent token cache

You can implement a persistent token cache in a durable location such as SQL Server or a file-based storage. A persistent token cache ensures that tokens are retained even when the application restarts or memory is cleared.

## Solution 2: Reject the authentication cookie

You can implement a cookie authentication event to validate whether the current signed-in user is present in the MSAL token cache. If the user isn't present, reject the authentication cookie and force the current user to sign in again. For more information about how to implete the custom persistent token cache, see [Token cache serialization](/entra/msal/dotnet/how-to/token-cache-serialization).

### For ASP.NET web applications using MSAL

Create a cookie authentication event:

```csharp
app.UseCookieAuthentication(new CookieAuthenticationOptions
{
    Provider = new CookieAuthenticationProvider()
    {
        OnValidateIdentity = async context =&gt;
        {
            IConfidentialClientApplication clientApp = MsalAppBuilder.BuildConfidentialClientApplication();
        
                var signedInUserIdentity = new ClaimsPrincipal(context.Identity);
        
                if (await clientApp.GetAccountAsync(signedInUserIdentity.GetAccountId()) == null)
        
                {
        
                    context.RejectIdentity();
        
                }
    
        }
    
    }

});
```

> [!NOTE]
> To implement a cookie authentication event, the web application must have the following helper classes and the `Microsoft.Identity.Web.TokenCache` NuGet package installed.
>
> - `MsalAppBuilder.cs`
> - `AuthenticationConfig.cs`

### For ASP.NET Core web applications using MSAL

1. Create a custom cookie authentication event:

    ```csharp
    using Microsoft.AspNetCore.Authentication.Cookies;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Identity.Client;
    using System.Threading.Tasks;
    using System.Security.Claims;
    
    namespace SampleApp.Services
    {
        internal class RejectSessionCookieWhenAccountNotInCacheEvents : CookieAuthenticationEvents
        {
            public async override Task ValidatePrincipal(CookieValidatePrincipalContext context)
            {
                var msalInstance = context.HttpContext.RequestServices.GetRequiredService();
                IConfidentialClientApplication msalClient = msalInstance.GetClient();
                
                        var accounts = await msalClient.GetAccountsAsync();
                
                        var account = await msalClient.GetAccountAsync(accounts.FirstOrDefault());
                
                        if (account == null)
                
                        {
                
                            context.RejectPrincipal();
                
                        }
                
                        await base.OnValidatePrincipal(context);
                
                }
        
        }
    
    }
    ```

2. Register the custom cookie authentication event:

    ```csharp
    Services.Configure<CookieAuthenticationOptions>(cookieScheme, options=>options.Events=new RejectSessionCookieWhenAccountNotInCacheEvents());
    ```

### For web applications using Microsoft Identity Web

Microsoft Identity Web provides built-in mechanisms to manage token cache. For more information, see [Managing incremental consent and conditional access](https://github.com/AzureAD/microsoft-identity-web/wiki/Managing-incremental-consent-and-conditional-access). If this document doesn't help you resolve the issue, you can manually clear the authentication cookie using a custom cookie authentication event:

1. Create a custom cookie authentication event:

    ```chsarp
    using Microsoft.AspNetCore.Authentication.Cookies;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Identity.Client;
    using Microsoft.Identity.Web;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    
    namespace SampleApp.Services
    {
        internal class RejectSessionCookieWhenAccountNotInCacheEvents : CookieAuthenticationEvents
        {
            public async override Task ValidatePrincipal(CookieValidatePrincipalContext context)
            {
                try
                {
                    var tokenAcquisition = context.HttpContext.RequestServices.GetRequiredService();
                    string token = await tokenAcquisition.GetAccessTokenForUserAsync(
                    scopes: new[] { "profile" },
                    user: context.Principal);
                }
                catch (MicrosoftIdentityWebChallengeUserException ex)
                when (AccountDoesNotExistInTokenCache(ex))
                {
                    context.RejectPrincipal();
                }
            }
                
            private static bool AccountDoesNotExistInTokenCache(MicrosoftIdentityWebChallengeUserException ex)
            {
                return ex.InnerException is MsalUiRequiredException
        
                       && (ex.InnerException as MsalUiRequiredException).ErrorCode == "user\_null";
        
            }
        
        }
    
    }
    ```

2. Register the custom cookie authentication event:

    ```chsarp
    // Add Microsoft Identity Web
    services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
                        .AddMicrosoftIdentityWebApp(Configuration.GetSection("AzureAd"))
                            .EnableTokenAcquisitionToCallDownstreamApi(initialScopes)
                               .AddMicrosoftGraph(Configuration.GetSection("GraphBeta"))
                               .AddInMemoryTokenCaches();
    
    // Register the Custom Cookie Authentication event
    Services.Configure<CookieAuthenticationOptions>(cookieScheme, options=>options.Events=new RejectSessionCookieWhenAccountNotInCacheEvents());
    ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
