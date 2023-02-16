---
title: Enable WebView2 in Power Automate for desktop login
description: Provides a resolution for a login issue in Power Automate for desktop.
ms.reviewer: pefelesk
author: georgiostrantzas
ms.author: gtrantzas
ms.date: 02/14/2023
ms.subservice: power-automate-desktop-flows
---

# Enable WebView2 in Power Automate for desktop login

This article provides a resolution for a login issue in Power Automate for desktop.

## Symptoms

Consider the following scenario in Power Automate for desktop:

- The current Power Automate for desktop login browser sends an invalid "user agent" header, which causes some two-factor authentications (2FA) to identify it as a security issue.
- Attempting to log in to Power Automate for desktop shows a JavaScript error.

## Verify the issue

To verify the issue, you need to install and use a network tracing tool, such as Fiddler.

:::image type="content" source="media/enable-webview-pad-login/fiddler.png" alt-text="Screenshot presenting how to verify the issue with Fiddler." lightbox="media/enable-webview-pad-login/fiddler.png":::

## Resolution

1. Install [WebView2 Runtime](https://go.microsoft.com/fwlink/p/?LinkId=2124703).

1. Add a REG_DWORD registry key in _Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Power Automate Desktop_.

    - Key name: UseMsalDesktopFeatures
    - Value: 1

## More information

- [Microsoft Edge WebView2](https://developer.microsoft.com/microsoft-edge/webview2/)
- [WebView2 wiki](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet/wiki/WebView2)
