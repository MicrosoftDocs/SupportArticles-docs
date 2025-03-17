---
title: Troubleshooting repeated login prompts in iOS MSAL implementation
description: Provides guidance for troubleshooting repeated login prompts in iOS MSAL implementation
ms.date: 12/26/2024
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# Troubleshooting repeated login prompts in iOS MSAL implementation

This article provides guidance for troubleshooting repeated login prompts in an iOS app that uses Microsoft Authentication Library (MSAL).

## Symptoms

You implements mobile authentication in your iOS app using the Microsoft Authentication Library (MSAL) SDK, following the [official tutorial](/azure/active-directory/develop/tutorial-v2-ios). The user is unexpectedly prompted to log in multiple times after the initial login.

## Cause

This MSAL SDK library facilitates authentication by renewing tokens automatically, enabling single sign-on (SSO) between other apps on the device, and managing user accounts. For SSO to function correctly, tokens need to be shared between apps, which requires a token cache or a broker application like Microsoft Authenticator for iOS.

This issue is often caused by web browser configurations that do not allow cookie sharing. Interactive authentication in MSAL requires a web browser. On iOS, MSAL uses the system web browser by default for interactive authentication. This default setup supports SSO state sharing between applications and web apps.

However, if you customize the browser configuration for authentication, such as redirecting to one of the following options, cookie sharing might not be enabled:

| **For iOS only** | **For iOS and macOS** |
| --- | --- |
| [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession?language=objc) <br> [SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession?language=objc) <br> [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller?language=objc) | [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview?language=objc) |

Customizing the browser is acceptable, but it must be configured to allow cookie sharing to prevent repeated login prompts.

## Resolution

To enable cookie sharing and resolve this issue, use one of the following configurations:

- **ASWebAuthenticationSession in MSAL** + **openURL in Safari browser** (the full Safari browser, not SafariViewController).
- **SFSafariViewController in MSAL** + **SFSafariViewController in your app**.
- **WKWebView in MSAL** + **WKWebView in your app**.

Refer to [customizing webviews](https://docs.microsoft.com/en-us/azure/active-directory/develop/customize-webviews) for additional guidance on configuring webviews and browsers.

### Note for Xamarin.iOS users

If you are implementing MSAL in Xamarin.iOS, additional considerations are required for token caching and using the Microsoft Authenticator app. These considerations are separate from the cookie-sharing issue discussed here. For detailed instructions, refer to [Xamarin.iOS MSAL considerations](https://docs.microsoft.com/en-us/azure/active-directory/develop/msal-net-xamarin-ios-considerations).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
