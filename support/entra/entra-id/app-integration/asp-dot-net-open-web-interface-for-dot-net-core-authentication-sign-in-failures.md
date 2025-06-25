---
title: Troubleshoot ASP.NET OWIN and ASP.NET Core authentication sign-in failures
description: Helps you expose hidden error messages that can guide you toward resolving ASP.NET OWIN and ASP.NET Core authentication sign-in failures with Microsoft Entra ID.
ms.reviewer: willfid, v-weizhu
ms.service: entra-id
ms.date: 06/25/2025
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

Ensure your code for handling the `AuthenticationFailed` event in the *Startup.Auth.cs* file follows a structure similar to the following:

[ASPNET\_OWIN\_OnAuthenticationFailed.cs](https://gist.github.com/ms-willfid/813dd19091dfa8650895182cb45d5d1c)

### For ASP.NET Core

Ensure your code for handling the `AuthenticationFailed` event in the *Startup.cs* file follows a structure similar to the following:

[ASPNETCore\_Auth\_OnAuthenticationFailed.cs](https://gist.github.com/ms-willfid/813dd19091dfa8650895182cb45d5d1c)

You can modify this to send the error message to your logs or send it to a custom error page. At a minimum, the error message should be displayed in the browser's address bar.

:::image type="content" source="media/asp-dot-net-open-web-interface-for-dot-net-core-authentication-sign-in-failures/error-message-in-address-bar.png" alt-text="Screenshot that shows the error message in the browser address bar.":::

If there's an infinite loop, the error message should be visible in the Fiddler capture.

:::image type="content" source="media/asp-dot-net-open-web-interface-for-dot-net-core-authentication-sign-in-failures/error-message-in-fiddler-capture.png" alt-text="Screenshot that shows the error message in the Fiddler capture.":::

For more information about using Fiddler, see [Collect HTTPS traffic using Fiddler for Microsoft Entra ID apps](capture-https-traffic-fiddler-entra-id-app.md).

## Microsoft Entra authentication and authorization error codes

For a list of Microsoft Entra authentication and authorization errors, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes).
