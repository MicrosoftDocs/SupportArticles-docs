---
title: Enable webview2 in Power Automate for desktop login
description: Provides a resolution to a login issue in Power Automate for desktop.
ms.reviewer: pefelesk
ms.date: 02/10/2023
ms.subservice: power-automate-desktop-flows
---

# Enable webview2 in Power Automate for desktop login

This article provides a resolution to a login issue in Power Automate for desktop.

## Symptoms

- The current Power Automate for desktop login browser sends an invalid "user agent" header, causing some two factor authentications to identify it as a security issue.

- Attempting to log in shows a JavaScript error.

## Verify the issue

To verify the issue, you need to install and use a network tracing tool, such as Fiddler.

## Workaround

1. Install [Webview2 Runtime](https://go.microsoft.com/fwlink/p/?LinkId=2124703).

1. Add a **REG_DWORD** registry key in **Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Power Automate Desktop**. 

    - **Key name**: UseMsalDesktopFeatures
    - **Value**: 1

Find more details about Webview2 in the following links:

- [Webview2 official website](https://developer.microsoft.com/en-us/microsoft-edge/webview2/)
- [Webview2 wiki](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet/wiki/WebView2)
