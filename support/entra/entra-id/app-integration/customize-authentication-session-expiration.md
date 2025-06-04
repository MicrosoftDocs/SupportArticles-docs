---
title: Configure ASP.NET or ASP.NET Core App Session to Last Longer Than Entra ID Tokens
description: Discusses how to configure ASP.NET or ASP.NET Core App session to last longer than Microsoft Entra ID token.
ms.date: 05/31/2025
ms.reviewer: willfid
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Customize middleware authentication ticket to extend user sign-in duration

By default, Microsoft Entra ID tokens (ID tokens, access tokens, and SAML tokens) expire after one hour. Also by default, ASP.NET and ASP.NET Core middleware set their authentication tickets to the expiration of these tokens. If you don't want your web application to redirect users to Microsoft Entra ID to have them sign in again, you can customize the middleware authentication ticket.

This customization can also help resolve AJAX-related issues, such as coss-origin resource sharing (CORS) errors to login.microsoftonline.com. These issues often occur when your app functions as both a web application and a web API.
## For ASP.NET

In the `ConfigureAuth` method of the `Startup.Auth.cs` file, update the `app.UseCookieAuthentication()` method to:

```csharp
app.UseCookieAuthentication(new CookieAuthenticationOptions()
{
  CookieManager = new Microsoft.Owin.Host.SystemWeb.SystemWebChunkingCookieManager(),
  Provider = new CookieAuthenticationProvider()
  {
    OnResponseSignIn = (context) =>
    {
      context.Properties.ExpiresUtc = DateTimeOffset.UtcNow.AddHours(12);
    }
  }
});
```

Then, decouple the token lifetime from the web app:

```csharp
app.UseOpenIdConnectAuthentication(
                new OpenIdConnectAuthenticationOptions
                {
                    UseTokenLifetime = false,
                    ...
```

## For ASP.NET Core

In ASP.NET Core, you have to add the `OnTokenValidated` event to update the ticket properties. This addition sets the ticket expiration time to occur before the application redirects to Microsoft Entra ID for reauthentication.

```csharp
services.Configure<OpenIdConnectOptions>(AzureADDefaults.OpenIdScheme, options =>
{
    // decouple the token lifetime from the Web App
    options.UseTokenLifetime = false;

    // other configurations...
    // ...

    var onTokenValidated = options.Events.OnTokenValidated;
    options.Events ??= new OpenIdConnectEvents();
    options.Events.OnTokenValidated = async context =>
    {
        await onTokenValidated(context);
        context.Properties.ExpiresUtc = DateTimeOffset.UtcNow.AddHours(12);
    };
});
```

### Examples

Here are a few examples of how to do make this setting:

If you're using code similar to the following example to add Microsoft Entra ID authentication:

```csharp
services.AddAuthentication(AzureADDefaults.AuthenticationScheme)
  .AddAzureAD(options => Configuration.Bind("AzureAd", options))
```

Then add the following code:

```csharp
services.Configure<OpenIdConnectOptions>(AzureADDefaults.OpenIdScheme, options =>
{
  // decouple the id_token lifetime from the Web App
  options.UseTokenLifetime = false;

  //…

    var onTokenValidated = options.Events.OnTokenValidated;
    options.Events ??= new OpenIdConnectEvents();
    options.Events.OnTokenValidated = async context =>
    {
        await onTokenValidated(context);
        context.Properties.ExpiresUtc = DateTimeOffset.UtcNow.AddHours(12);
    };
});
```

Your configuration in Startup.cs should resemble the following example:

```csharp
public void ConfigureServices(IServiceCollection services)
{
  //...

  services.AddAuthentication(AzureADDefaults.AuthenticationScheme)
    .AddAzureAD(options => Configuration.Bind("AzureAd", options))
    .AddCookie();

  //...

  services.Configure<OpenIdConnectOptions>(AzureADDefaults.OpenIdScheme, options =>
  {
    // decouple the token lifetime from the Web App
    options.UseTokenLifetime = false;

    //...
    var onTokenValidated = options.Events.OnTokenValidated;
    options.Events ??= new OpenIdConnectEvents();
    options.Events.OnTokenValidated = async context =>
    {
        await onTokenValidated(context);
        context.Properties.ExpiresUtc = DateTimeOffset.UtcNow.AddHours(12);
    };
  });

  //...
}
```

If you're using `Microsoft.Identity.Web` to add your Microsoft Entra ID configuration:

```csharp
//…
using Microsoft.Identity.Web;
//…
public class Startup
{
  // ...
  public void ConfigureServices(IServiceCollection services)
  {
    // ...
    services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
      .AddMicrosoftIdentityWebApp(options =>
      {
        Configuration.Bind("AzureAD", options);

        // decouple the token lifetime from the Web App
        options.UseTokenLifetime = false;

        var onTokenValidated = options.Events.OnTokenValidated;
        options.Events ??= new OpenIdConnectEvents();
     
        options.Events.OnTokenValidated = async context =>
        {
            await onTokenValidated(context);
            context.Properties.ExpiresUtc = DateTimeOffset.UtcNow.AddHours(12);
        };
      });
    // ...
}			
```

If you're implementing your own custom `OpenIdConnectOptions` to configure Microsoft Entra ID authentication:

```csharp
services.Configure<OpenIdConnectOptions>(options =>
{
  //…
  options.Events.OnTokenValidated = async context =>
  {
    context.Properties.ExpiresUtc = DateTimeOffset.UtcNow.AddHours(12);
  };
});
```

If you're integrating an ASP.NET Core WS-Fed application:

```csharp
public void ConfigureServices(IServiceCollection services)
{
  services.AddAuthentication(WsFederationDefaults.AuthenticationScheme)  
    .AddCookie()
    .AddWsFederation(options =>
    {
      options.SignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;

      // decouple the token lifetime from the Web App
      options.UseTokenLifetime = false;

      // MetadataAddress for your Azure Active Directory instance.
      options.MetadataAddress = "https://login.microsoftonline.com/common/federationmetadata/2007-06/federationmetadata.xml";

      // Wtrealm is the app's identifier in the Active Directory instance.
      // For ADFS, use the relying party's identifier, its WS-Federation Passive protocol URL:
      options.Wtrealm = "https://localhost:44307/";

      // For AAD, use the Application ID URI from the app registration's Overview blade:
      options.Wtrealm = "https://contoso.onmicrosoft.com/wsfedapp";

      // Set the Authentication Ticket to expire at a custom time      
      var onTokenValidated = options.Events.OnTokenValidated;
      options.Events ??= new OpenIdConnectEvents();
      
      options.Events.OnSecurityTokenValidated = async context =>
      {
        context.Properties.ExpiresUtc = DateTimeOffset.UtcNow.AddHours(12);
      }
```
## More information

These settings control the expiration of the authentication ticket that determines how long a user stays signed in. You can configure this expiration to suit your requirement.

> [!NOTE]
> If you modify the ticket expiration, users might still have access to your application even if they're deleted or disabled in Microsoft Entra ID. This condition remains true until the ticket expires.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
