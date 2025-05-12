---
title: Use Serilog to Troubleshoot Protected Web API Authentication or Authorization Errors
description: Provides a sample web API application to troubleshoot Microsoft Entra protected Web API authentication or authorization errors using Serilog logs.
ms.date: 05/12/2025
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
ms.reviewer: bachoang, v-weizhu
---
# Use Serilog to troubleshoot Microsoft Entra protected Web API authentication or authorization errors

When a web API application calls a web API that's protected with Microsoft Entra ID, authentication or authorization errors might occur due to JwtBearer event validation failures. To troubleshoot this issue, this article introduces a sample web API application named [Net6WebAPILogging](https://github.com/bachoang/Net6WebAPILogging) to set and collect logs for JwtBearer events.

## Net6WebAPILogging sample application

This sample web API application assumes you already have a web API registered in Microsoft Entra ID. It uses Microsoft .NET 6 Framework and [Microsoft Identity Web](/entra/msal/dotnet/microsoft-identity-web/) NuGet package.

It uses the following methods to set and collect logs for JwtBearer events:

- Use the [JwtBearerEvents class](/dotnet/api/microsoft.aspnetcore.authentication.jwtbearer.jwtbearerevents) to configure middleware events. JWT Bearer token might fail to validate `OnTokenValidated`, `OnMessageReceived`, `OnAuthenticationFailed`, and `OnChalleenge` events.
- [Set up logging for JwtBearer events](#set-up-logging-for-jwtbearer-events).
- Use the [Serilog](https://serilog.net/) framework to log the `Debug` output to the console window and the local file whose path is specified in the **appsettings.json** file.

## Run the sample application

To run the sample application, you must perform the following steps:

### Step 1: Configure the application ID URI for a protected web API

To add the application ID URI for a web API, follow these steps:

1. In the Azure portal, navigate to the app registration of the web API.
2. Select **Expose an API** under **Manager**.
3. At the top of the page, select **Add** next to **Application ID URI**. The default is `api://<application-client-id>`.
4. Select **Save**.

:::image type="content" source="media/serilog-protected-web-api-authentication-authorization-errors/application-id-uri.png" alt-text="Screenshot that shows how to set the application ID URI in an app registration.":::

### Step 2: Change the sample application configuration

Change the following information in the `AzureAd` section in the **appsettings.json** file with your own app registration information:

```json
"AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "Domain": "<tenant name>.onmicrosoft.com", // for example contoso.onmicrosoft.com
    "TenantId": "<tenant ID>",
    "ClientId": "<application-client-id>"
  },
```

### Step 3: Change the sample application code

Change the `ValidAudiences` and `ValidIssuers` properties of the [TokenValidationParameters](/dotnet/api/microsoft.identitymodel.tokens.tokenvalidationparameters) class in the **Program.cs** file.

### Step 4: Configure Serilog

Configure Serilog in the `Serilog` section in the **appsettings.json** file as follows:

```json
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft": "Debug",
        "Microsoft.Hosting.Lifetime": "Information"
      }
    },
```

## Set up logging for JwtBearer events

Here's the sample **Program.cs** file that shows how to set up logging for the preceding events:

```csharp
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Identity.Web;
using Microsoft.IdentityModel.Logging;
using System.Diagnostics;
using Serilog;


// https://github.com/datalust/dotnet6-serilog-example

Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .CreateBootstrapLogger();

Log.Information("starting up");
try
{
    var builder = WebApplication.CreateBuilder(args);

    builder.Host.UseSerilog((ctx, lc) => lc
        .WriteTo.Console()
        .ReadFrom.Configuration(ctx.Configuration));

    // Add services to the container.
    builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddMicrosoftIdentityWebApi(builder.Configuration.GetSection("AzureAd"));

    // Enable PII for logging
    IdentityModelEventSource.ShowPII = true;
    // Configure middleware events
    builder.Services.Configure<JwtBearerOptions>(JwtBearerDefaults.AuthenticationScheme, options =>
    {
        options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
        {
            ValidAudiences = new List<string> { "api://<application-client-id>", "<application-client-id>" },
            ValidIssuers = new List<string> { "https://sts.windows.net/<tenant ID>/", "https://login.microsoftonline.com/<tenant ID>/v2.0" }
        };
        options.Events = new JwtBearerEvents
        {
            OnTokenValidated = ctx =>
            {
                string message = "[OnTokenValidated]: ";
                message += $"token: {ctx.SecurityToken.ToString()}";
                Log.Information(message); 
                return Task.CompletedTask;
            },
            OnMessageReceived = ctx =>
            {
                string message = "[OnMessageReceived]: ";
                ctx.Request.Headers.TryGetValue("Authorization", out var BearerToken);
                if (BearerToken.Count == 0)
                    BearerToken = "no Bearer token sent\n";
                message += "Authorization Header sent: " + BearerToken + "\n";
                Log.Information(message);
                return Task.CompletedTask;
            },
            OnAuthenticationFailed = ctx =>
            {
                ctx.Response.StatusCode = StatusCodes.Status401Unauthorized;
                string message = $"[OnAuthenticationFailed]: {ctx.Exception.ToString()}";
                Log.Error(message);
                // Debug.WriteLine("[OnAuthenticationFailed]: Authentication failed with the following error: ");
                // Debug.WriteLine(ctx.Exception);
                return Task.CompletedTask;
            },
            OnChallenge = ctx =>
            {
                // Debug.WriteLine("[OnChallenge]: I can do stuff here! ");
                Log.Information("[OnChallenge]");
                return Task.CompletedTask;
            },
            OnForbidden = ctx =>
            {
                Log.Information("[OnForbidden]");
                return Task.CompletedTask;
            }
        };
    });

    builder.Services.AddControllers();
    // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
    // builder.Services.AddEndpointsApiExplorer();
    // builder.Services.AddSwaggerGen();

    var app = builder.Build();

    app.UseSerilogRequestLogging();
    // Configure the HTTP request pipeline.
    if (app.Environment.IsDevelopment())
    {
        // app.UseSwagger();
        // app.UseSwaggerUI();
        // do something
    }

    app.UseHttpsRedirection();

    app.UseAuthentication();
    app.UseAuthorization();

    app.MapControllers();

    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "Unhandled exception");
}
finally
{
    Log.Information("Shut down complete");
    Log.CloseAndFlush();
}
```

## References

[Tutorial: Build and secure an ASP.NET Core web API with the Microsoft identity platform](/entra/identity-platform/tutorial-web-api-dotnet-core-build-app)

[!INCLUDE [Azure Help Support](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
