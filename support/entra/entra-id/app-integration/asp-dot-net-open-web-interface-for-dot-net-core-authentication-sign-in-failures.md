---
title: Troubleshoot ASP.NET OWIN and ASP.NET Core authentication sign-in failures
description: Helps you expose hidden error messages that can guide you toward resolving ASP.NET OWIN and ASP.NET Core authentication sign-in failures with Microsoft Entra ID.
ms.reviewer: willfid, v-weizhu
ms.service: entra-id
ms.date: 06/27/2025
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Troubleshoot ASP.NET OWIN and ASP.NET Core authentication sign-in failures with Microsoft Entra ID

When you develop an ASP.NET Open Web Interface for .NET (OWIN) or ASP.NET Core Authentication web application and integrate it with Microsoft Entra ID, you encounter some issues during the sign-in process without any error messages or hint about what the problem might be. This article doesn't focus on direct solutions to sign-in failures but aims to help you expose hidden error messages that can guide you toward resolving the issue.

> [!NOTE]
> This article assumes you use your own code to perform the authentication to Microsoft Entra ID. If you use the Azure App Services or Azure Function Apps authentication and authorization feature, this article doesn't apply to your scenario.

## Symptoms

You might see some common sign-in failure behaviors as follows:

- Infinite loop between your web application and Microsoft Entra ID.
- After signing into Microsoft Entra ID, you're redirected to your web application like it never signed in.
- You land on your error page, but it doesn't provide useful error messages.

## Expose hidden errors by using the OnAuthenticationFailed event

To expose hidden errors during the sign-in process, use the `OnAuthenticationFailed` event.

### For ASP.NET OWIN

Ensure your code for the `AuthenticationFailed` event in the *Startup.Auth.cs* file follows this structure:

```csharp
public void ConfigureAuth(IAppBuilder app)
{
    app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType);

    app.UseCookieAuthentication(new CookieAuthenticationOptions());

    app.UseOpenIdConnectAuthentication(
        new OpenIdConnectAuthenticationOptions
        {
            ResponseType = OpenIdConnectResponseType.CodeIdToken,
            ClientId = clientId,
            Authority = Authority,
           //...

            Notifications = new OpenIdConnectAuthenticationNotifications()
            {
                // If there is a code in the OpenID Connect response, redeem it for an access token
                AuthorizationCodeReceived = (context) =>
                {
                    // ...
                },

                // On Authentication Failed
                AuthenticationFailed = (context) =>
                {
                    String ErrorMessage = context.Exception.Message;
                    String InnerErrorMessage = String.Empty;

                    String RedirectError = String.Format("error_message={0}", ErrorMessage);

                    if (context.Exception.InnerException != null)
                    {
                        InnerErrorMessage = context.Exception.InnerException.Message;
                        RedirectError = String.Format("{0}&inner_error={1}", RedirectError, InnerErrorMessage);
                    }

                    // or you can just throw it
                  // throw new Exception(RedirectError);

                    RedirectError = RedirectError.Replace("\r\n", "  ");

                    context.Response.Redirect("/?" + RedirectError);
                    context.HandleResponse();
                    return Task.FromResult(0);
                }
            }

      });

// ...
```

### For ASP.NET Core

Ensure your code for the `AuthenticationFailed` event in the *Startup.cs* file follows this structure:

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.Configure<CookiePolicyOptions>(options =>
    {
        // ...
    });

    services.AddAuthentication(AzureADDefaults.AuthenticationScheme)
        .AddAzureAD(options => Configuration.Bind("AzureAd", options));

    // ...

    services.Configure<OpenIdConnectOptions>(AzureADDefaults.OpenIdScheme, options =>
    {
    options.Authority = options.Authority;

    // Token Validation
    options.TokenValidationParameters.IssuerValidator = AadIssuerValidator.ValidateAadIssuer;

    // Response type
    options.ResponseType = "id_token code";

    // On Authorization Code Received
    options.Events.OnAuthorizationCodeReceived = async context =>
    {
        // ...
    };

    // On Authentication Failed
    options.Events.OnAuthenticationFailed = async context =>
    {
        String ErrorMessage = context.Exception.Message;
        String InnerErrorMessage = String.Empty;

        String RedirectError = String.Format("?error_message={0}", ErrorMessage);

        if (context.Exception.InnerException != null)
        {
            InnerErrorMessage = context.Exception.InnerException.Message;
            RedirectError = String.Format("{0}&inner_error={1}", RedirectError, InnerErrorMessage);
        }

       // or you can just throw it
       // throw new Exception(RedirectError);

        RedirectError = RedirectError.Replace("\r\n", "  ");

        context.Response.Redirect(RedirectError);
        context.HandleResponse();
    };

    // ...
```

You can modify this to send the error message to your logs or send it to a custom error page. At a minimum, the error message should be displayed in the browser's address bar.

:::image type="content" source="media/asp-dot-net-open-web-interface-for-dot-net-core-authentication-sign-in-failures/error-message-in-address-bar.png" alt-text="Screenshot that shows the error message in the browser address bar.":::

If there's an infinite loop, the error message should be visible in the Fiddler capture.

:::image type="content" source="media/asp-dot-net-open-web-interface-for-dot-net-core-authentication-sign-in-failures/error-message-in-fiddler-capture.png" alt-text="Screenshot that shows the error message in the Fiddler capture.":::

For more information about using Fiddler, see [Collect HTTPS traffic using Fiddler for Microsoft Entra ID apps](capture-https-traffic-fiddler-entra-id-app.md).

## Microsoft Entra authentication and authorization error codes

For a list of Microsoft Entra authentication and authorization errors, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes).


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
