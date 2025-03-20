---
title: WebAssembly App Error - These requirements were not Met RolesAuthorizationRequirement in Microsoft Entra ID
description: This article provides guidance to resolve role-based access control issues in developing WebAssembly authentication apps.
ms.date: 03/20/2025
ms.author: willfid
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# Add role claim support in WebAssembly authentication in Microsoft Entra ID

This article provides guidance to resolve role-based access control issues in developing WebAssembly authentication apps.

## Symptoms

When you build a WebAssembly authentication app and try to implement role-based access control in the app, you receive the following error messages:
- You are not authorized to access this resource.
- Microsoft.AspNetCore.Authorization.DefaultAuthorizationService[2]Authorization failed. These requirements were not met: RolesAuthorizationRequirement:User.IsInRole must be true for one of the following roles: (ROLE_NAME)

## Cause

The WebAssembly authentication stack might cast role claims into a single string. This prevents proper role-based access control.

## Solution

You can implement a custom user factory to modify the behavior of role claims mapping. To do this, follow these steps.

#### Step 1: Create a custom user factory

Create a custom User Factory (CustomUserFactory.cs):

```csharp
using Microsoft.AspNetCore.Components.WebAssembly.Authentication;
using Microsoft.AspNetCore.Components.WebAssembly.Authentication.Internal;
using System.Security.Claims;
using System.Text.Json;

public class CustomUserFactory : AccountClaimsPrincipalFactory<RemoteUserAccount>
{
    public CustomUserFactory(IAccessTokenProviderAccessor accessor)
        : base(accessor)
    {
    }

    public async override ValueTask<ClaimsPrincipal> CreateUserAsync(
        RemoteUserAccount account,
        RemoteAuthenticationUserOptions options)
    {
        var user = await base.CreateUserAsync(account, options);
        var claimsIdentity = (ClaimsIdentity?)user.Identity;

        if (account != null && claimsIdentity != null)
        {
            MapArrayClaimsToMultipleSeparateClaims(account, claimsIdentity);
        }

        return user;
    }

    private void MapArrayClaimsToMultipleSeparateClaims(RemoteUserAccount account, ClaimsIdentity claimsIdentity)
    {
        foreach (var prop in account.AdditionalProperties)
        {
            var key = prop.Key;
            var value = prop.Value;
            if (value != null && (value is JsonElement element && element.ValueKind == JsonValueKind.Array))
            {
                // Remove the Roles claim with an array value, and create new claims with the same key
                claimsIdentity.RemoveClaim(claimsIdentity.FindFirst(prop.Key));
                var claims = element.EnumerateArray().Select(x => new Claim(prop.Key, x.ToString()));
                claimsIdentity.AddClaims(claims);
            }
        }
    }
}
```

#### Step 2: Add role mapping and custom user factory to your authentication middleware

If you're using `AddOidcAuthentication`:

```csharp

builder.Services.AddOidcAuthentication(options =>
{
    builder.Configuration.Bind("AzureAd", options.ProviderOptions);
    options.ProviderOptions.AdditionalProviderParameters.Add("domain_hint", "contoso.com");
    options.ProviderOptions.DefaultScopes.Add("User.Read");
    options.UserOptions.RoleClaim = "roles";
    options.ProviderOptions.ResponseType = "code";
}).AddAccountClaimsPrincipalFactory<CustomUserFactory>();
```

If you're using `AddMsalAuthentication`:

```csharp
builder.Services.AddMsalAuthentication(options =>
{
    builder.Configuration.Bind("AzureAd", options.ProviderOptions.Authentication);
    options.ProviderOptions.AdditionalScopesToConsent.Add("user.read");
    options.ProviderOptions.DefaultAccessTokenScopes.Add("api://{your-api-id}");
    options.UserOptions.RoleClaim = "roles";
}).AddAccountClaimsPrincipalFactory<CustomUserFactory>();
```

#### Step 3: Add the `Authorize` attribute to Blazor pages

```csharp
@attribute [Authorize(Roles="access_as_user")]
```

Next, add app roles to your app registration, assign a user to the app role, and then configure your app to use the assigned app role.

## References

- [Secure an ASP.NET Core Blazor WebAssembly standalone app with the Authentication library](/aspnet/core/blazor/security/webassembly/standalone-with-authentication-library)

- [GitHub project: Sample that has this solution implemented](https://github.com/willfiddes/aad-webassembly-auth)
