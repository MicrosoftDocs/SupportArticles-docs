---
title: Configure ASP.NET or ASP.NET Core App Session to Last Longer Than Entra ID Tokens
description: Describes how to configure ASP.NET or ASP.NET Core App session to last longer than Microsoft Entra ID token.
ms.date: 05/31/2025
ms.reviewer: willfid
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Customize Middleware authentication ticket to extend user sign-in time

Microsoft Entra ID tokens (ID tokens, access tokens, and SAML tokens) by default expire after one hour. ASP.NET and ASP.NET Core Middleware set their authentication ticket to the expiration of these tokens by default. If you don't want your web application to redirect users to Microsoft Entra ID to sign in again, you can customize the Middleware authentication ticket.

This customization can also help resolve AJAX issues (such as CORS errors to `login.microsoftonline.com`) where your app is both a Web App and Web API.

## For ASP.NET

In the `ConfigureAuth` method of your `Startup.Auth.cs` file, update the `app.UseCookieAuthentication()` method to:

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
Then, decouple the token lifetime from the Web App:

```csharp
app.UseOpenIdConnectAuthentication(
                new OpenIdConnectAuthenticationOptions
                {
                    UseTokenLifetime = false,
                    ...

```

## For ASP.NET Core

In ASP.NET Core, you need to add the `OnTokenValidated` event to update the ticket properties. This sets the ticket expiration time before the application redirects to Microsoft Entra ID for reauthentication.

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

Here are a few examples of how to do this:

**If you're using code similar to the following to add Microsoft Entra ID authentication**:

```
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
Your configuration in Startup.cs should look something like this:

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

**If you're using `Microsoft.Identity.Web` to add your Microsoft Entra ID configuration:**

```
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

**If you're implementing your own custom `OpenIdConnectOptions` to configure Microsoft Entra ID authentication:**

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

If you're integrating an ASP.NET Core WS-Fed application, then it might look something like the following:

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

These settings control the expiration of the authentication ticket, which determines how long a user stays signed in. You can configure this expiration to suit your requirement.

>[!NOTE]
> If you modify the ticket expiration, users may still have access to your application even if they've been deleted or disabled in Microsoft Entra ID, until the ticket expires.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

