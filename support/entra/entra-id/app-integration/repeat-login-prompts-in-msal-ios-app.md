---
title: Why does an MSAL-based iOS app keep asking for credentials with Microsoft Entra?
description: Provides guidance for troubleshooting repeated sign-in prompts in an iOS MSAL implementation
ms.date: 03/19/2025
ms.author: daga
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# Troubleshoot sign-in prompt issues in iOS with MSAL SDK

This article provides guidance for troubleshooting repeated sign-in prompts in an iOS app that uses Microsoft Authentication Library (MSAL).

## Symptoms

You [follow this tutorial](/azure/active-directory/develop/tutorial-v2-ios) to integrate Microsoft identity platform authentication in your iOS app by using the Microsoft Authentication Library (MSAL) SDK. However, after the initial login, users are unexpectedly prompted to sign in multiple times.

## Cause

This issue is typically caused by the web browser used by MSAL does not allow cookie sharing.

The tutorial uses the MSAL to implement authentication. MSAL SDK facilitates authentication by automatically renewing tokens. It also enables single sign-on (SSO) between other apps on the device and manages user accounts.

For SSO to function correctly, tokens must be shared between apps. To meet this requirement, you must use a token cache or a broker application, such as Microsoft Authenticator for iOS. Interactive authentication in MSAL requires a web browser. On iOS, MSAL uses the Safari system browser by default for interactive authentication. This default setup supports SSO state sharing between apps.

However, if you customize the browser configuration for authentication, such as by using one of the following options, cookie sharing might not be enabled by default.

| **For iOS only** | **For iOS and macOS** |
| --- | --- |
| [SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession?language=objc) <br> [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller?language=objc) | [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession?language=objc) <br> [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview?language=objc) |


## Resolution

To prevent repeated login prompts, you must allow cookie sharing when you customize the browser. To enable SSO and cookie sharing between MSAL and your iOS app, use one of the following solutions:

Use `ASWebAuthenticationSession` and Safari system browser (`UIApplication.shared.open`)

   - Use Case: Your app uses MSAL together with the default `ASWebAuthenticationSession` instance, and you open external links or logout flows in Safari system browser.
   - **Note:** `ASWebAuthenticationSession` is the recommended method for MSAL interactive authentication on iOS 12+. It's the only supported method on iOS 13+. This method is privacy-preserving and shares cookies with system browser. SSO works between MSAL and Safari browser application because they share cookies through the system authentication session.

Use `WKWebView`

   - Use Case: You explicitly configure MSAL to use `WKWebView`, and your app also uses `WKWebView` for related workflows.
   - **Note:** You can use `WKWebView` for a consistent experience within your app. However, because it's sandboxed, `WKWebView` doesn't share session cookies with Safari system browser or other apps. In this condition, SSO support is limited to use within your app.

   For more information, see [Customizing webviews and browsers](/azure/active-directory/develop/customize-webviews).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
