---
title: Troubleshooting 401 Unauthorized errors in ASP.NET Core Web API with Microsoft Entra ID Authentication
description: Provides guidance on troubleshooting and resolving 401 Unauthorized errors in an ASP.NET Core Web API using Microsoft Entra ID authentication.
ms.date: 04/28/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---

# 401 Unauthorized errors in ASP.NET Core Web API with Microsoft Entra ID 

When you call an ASP.NET Core Web API secured with Microsoft Entra ID authentication, you might encounter a 401 Unauthorized error. This article provides guidance on using `JwtBearerEvents to capture detailed logs for troubleshooting these errors.

## Symptoms

You use the `[Authorize]` attribute to [secure your ASP.NET Core Web API](/entra/identity-platform/tutorial-web-api-dotnet-core-build-app?tabs=workforce-tenant) as the following. When you call the web API, a 401 Unauthorized response is returned without any error details.

```csharp
[Authorize]
public class MyController : ControllerBase
{
    ...
}

```

Or

```csharp

public class MyController : ControllerBase
{
   [Authorize]
   public ActionResult<string> Get(int id)
   {
       return "value";
   }
   ...
}
```

## Cause

 The API might return 401 Unauthorized responses in the following scenarios:

- The request doesn't include a valid Authorization: Bearer token header.
- Token is expired or incorrect.
    - The token being issued for a different resource.
    - Token claims not meeting the application's token validation criteria as defined in the [JwtBearerOptions.TokenValidationParameters](/dotnet/api/microsoft.aspnetcore.authentication.jwtbearer.jwtbeareroptions.tokenvalidationparameters) class.

## Solution

To debug and resolve 401 Unauthorized errors, you can use the `JwtBearerEvents` callbacks to capture and log detailed error information. Follow these steps to implement a custom error handling mechanism.

The `JwtBearerEvents` class has the following callback properties (invoked in the following order) that can help us debug these 401 Access Denied or UnAuthorization issues:

- [`OnMessageRecieved`](/dotnet/api/microsoft.aspnetcore.authentication.jwtbearer.jwtbearerevents.onmessagereceived#Microsoft_AspNetCore_Authentication_JwtBearer_JwtBearerEvents_OnMessageReceived) is called first for every request.
- [`OnAuthenticationFailed`](/dotnet/api/microsoft.aspnetcore.authentication.jwtbearer.jwtbearerevents.onauthenticationfailed) is called when the token doesn't pass the application's token validation criteria.
- [`OnChallenge`](/dotnet/api/microsoft.aspnetcore.authentication.jwtbearer.jwtbearerevents.onchallenge) is called last before a 401 response is returned.

### Step 1: Enable PII logging

By default, personally identifiable information (PII) logging is disabled. Enable it in the Configure method of the Startup.cs file for debugging purposes.

> [!Caution]
> Uses 'Microsoft.IdentityModel.Logging.IdentityModelEventSource.ShowPII = true' only in development environment for debugging purposes. Do not use it in a production environment.

```csharp
public void Configure(IApplicationBuilder app, IHostingEnvironment env)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }
    else
    {
        // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
        app.UseHsts();
    }
    // turn on PII logging
    Microsoft.IdentityModel.Logging.IdentityModelEventSource.ShowPII = true;

    app.UseHttpsRedirection();
    app.UseAuthentication();
    app.UseMvc();
}  
```

### Step 2: Create a utility method to format exception messages

Add a method to format and flatten exception messages for better readability.

```csharp
public static string FlattenException(Exception exception)
{
    var stringBuilder = new StringBuilder();
    while (exception != null)
    {
        stringBuilder.AppendLine(exception.Message);
        stringBuilder.AppendLine(exception.StackTrace);
        exception = exception.InnerException;
    }
    return stringBuilder.ToString();
}
```
### Step 3: Implement JwtBearerEvents callbacks

Configure the `JwtBearerEvents` callbacks in the `ConfigureServices` method of *Startup.cs* to handle authentication events and log error details.

```csharp
public void ConfigureServices(IServiceCollection services)
{
....
    .AddJwtBearer(options =>
    {
        options.Authority = "https://login.microsoftonline.com/<Tenant>.onmicrosoft.com";
        // if you intend to validate only one audience for the access token, you can use options.Audience instead of
        // using options.TokenValidationParameters which allow for more customization.
        // options.Audience = "10e569bc5-4c43-419e-971b-7c37112adf691";

        options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
        {
            ValidAudiences = new List<string> { "<Application ID URI>", "10e569bc5-4c43-419e-971b-7c37112adf691" },
            ValidIssuers = new List<string> { "https://sts.windows.net/<Directory ID>/", "https://sts.windows.net/<Directory ID>/v2.0" }
        };
                
        options.Events = new JwtBearerEvents
        {
            OnAuthenticationFailed = ctx =>
            {
                ctx.Response.StatusCode = StatusCodes.Status401Unauthorized;
                message += "From OnAuthenticationFailed:\n";
                message += FlattenException(ctx.Exception);
                return Task.CompletedTask;
            },

            OnChallenge = ctx =>
            {
                message += "From OnChallenge:\n";
                ctx.Response.StatusCode = StatusCodes.Status401Unauthorized;
                ctx.Response.ContentType = "text/plain";
                return ctx.Response.WriteAsync(message);
            },

            OnMessageReceived = ctx =>
            {
                message = "From OnMessageReceived:\n";
                ctx.Request.Headers.TryGetValue("Authorization", out var BearerToken);
                if (BearerToken.Count == 0)
                    BearerToken = "no Bearer token sent\n";
                message += "Authorization Header sent: " + BearerToken + "\n";
                return Task.CompletedTask;
            },
#For completeness, the sample code also implemented the OnTokenValidated property to log the token claims. This method is invoked when authentication is successful
            OnTokenValidated = ctx =>
            {
                Debug.WriteLine("token: " + ctx.SecurityToken.ToString());
                return Task.CompletedTask;
            }
        };
    });
...
}
```
### Sample results

With the implementation, when a 401 Unauthorized error occurs, the response output should include detailed error messages, such as:

```Output
OnMessageRecieved:

Authorization Header sent: no Bearer token sent.
```

If you use API development tool to debug the request, you should receive the detail errors such as the following:

:::image type="content" source="media/401-unauthorized-aspnet-core-web-api/wrong-token.png" alt-text="Screenshot of detail error in API development tool." lightbox="media/401-unauthorized-aspnet-core-web-api/wrong-token.png":::



[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

