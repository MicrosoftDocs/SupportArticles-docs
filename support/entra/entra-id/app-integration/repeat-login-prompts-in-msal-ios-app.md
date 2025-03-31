---
title: Why MSAL based iOS app keep asking for login with Microsoft Entra?
description: Provides guidance for troubleshooting repeated login prompts in iOS MSAL implementation
ms.date: 03/19/2025
ms.author: daga
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# Troubleshooting login prompt issues in iOS with MSAL SDK

This article provides guidance for troubleshooting repeated login prompts in an iOS app that uses Microsoft Authentication Library (MSAL).

## Symptoms

You [integrate Microsoft identity platform authentication](/azure/active-directory/develop/tutorial-v2-ios) in your iOS app by using the Microsoft Authentication Library (MSAL) SDK. However, after the initial login, users are unexpectedly prompted to sign in multiple times.

## Cause

This issue is typically caused by web browser configurations that do not allow cookie sharing.

The tutorial uses the MSAL to implement authentication. MSAL SDK facilitates authentication by automatically renewing tokens. It also enables single sign-on (SSO) between other apps on the device and manages user accounts.

For SSO to function correctly, tokens must be shared between apps. This requires a token cache or a broker application, such as Microsoft Authenticator for iOS. Interactive authentication in MSAL requires a web browser. On iOS, MSAL uses the system web browser by default for interactive authentication. This default setup supports SSO state sharing between apps.

However, if you customize the browser configuration for authentication, such as by using one of the following options, cookie sharing might not be enabled by default:

| **For iOS only** | **For iOS and macOS** |
| --- | --- |
| [SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession?language=objc) <br> [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller?language=objc) | [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession?language=objc) <br> [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview?language=objc) |

To customize the browser, you must allow cookie sharing to prevent repeated login prompts.

## Resolution

To enable SSO and cookie sharing between MSAL and your iOS app, use of the following solutions:

-	Use `ASWebAuthenticationSession` and system Safari browser (`UIApplication.shared.open`)

   - Use Case: Your app uses MSAL with the default `ASWebAuthenticationSession` instance, and you open external links or logout flows in the system Safari browser.
   - Note: `ASWebAuthenticationSession` is the recommended method for MSAL interactive auth on iOS 12+. It's the only supported method on iOS 13+. It is privacy-preserving and shares cookies with system Safari browser. SSO works between MSAL and system Safari browser because they share cookies through the system authentication session.
-	Use `WKWebView`
   - Use Case: You explicitly configure MSAL to use `WKWebView` and your app also uses `WKWebView` for related workflows.
   - Note: If you use `WKWebView` for a consistent experience within your app, note that it is sandboxed and does not share session cookies with Safari or other apps. This supports SSO only within your app.

   For more information, see [Customizing webviews and browsers](/azure/active-directory/develop/customize-webviews).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]


