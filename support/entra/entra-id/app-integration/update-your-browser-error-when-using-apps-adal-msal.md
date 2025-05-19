---
title: Your browser is not supported or up-to-date error in MSAL app
description: This article describes how to resolve the "Your browser is not supported or up-to-date" error when you use an app that integrates with MSAL.
author: genlin
ms.author: willfid
ms.service: entra-id
ms.date: 01/11/2025
ms.custom: sap:Issues signing into application
---

# Your browser is not supported or up-to-date error in MSAL app

This article describes how to resolve the "Your browser is not supported or up-to-date" error that occurs in an Microsoft Authentication Library (MSAL) based app.

## Symptoms

When you open an app that integrates with MSAL and try to register Microsoft Entra ID Multifactor Authentication (MFA), you might see the following error message:

>Your browser is not supported or up-to-date. Try updating it, or else download and install the latest version of Microsoft Edge.
You could also try to access https://aka.ms/mysecurityinfo from another device.

## Cause

This issue occurs when the MSAL app uses outdated web browser controls, such as WebView1. These older controls do not support Microsoft Entra ID MFA registration or the self-service password reset wizard.


## Resolution

### For end users

To work around this issue, register for Microsoft Entra ID Multifactor Authentication (MFA) using a supported browser before you use the app:

1. Open [My Apps](https://myapps.microsoft.com) in Microsoft Edge or another supported browser.
2. Complete the MFA registration process.
3. After successful registration, open your app.

## For developers

To resolve the issue, enable broker authentication by using [Web Account Manager](/entra/identity-platform/scenario-desktop-acquire-token-wam) in your app.

 The following is a sample code that creates a client to use Broker Authentication.

```csharp
var pca = PublicClientApplicationBuilder.Create("client_id").WithBroker(new BrokerOptions(BrokerOptions.OperatingSystems.Windows))
```

If Web Account Manager is unavailable (such as on Windows Server 2012), consider the following options:

- Use WebView2 (Edge-based Embedded WebView)

    To enable WebView2, the app must target .NET 6+ Windows. Configure this setting in the project file:

    ```xml
    <TargetFramework>net6.0-windows10.0.22621.0</TargetFramework>
    ```

- Use the System Browser

    If WebView2 cannot be used or your app can't target .NET 6+ Windows, then use the [default system browser for authentication](/entra/msal/dotnet/acquiring-tokens/using-web-browsers#how-to-use-the-default-system-browser).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]