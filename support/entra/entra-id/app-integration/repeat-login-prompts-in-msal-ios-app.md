---
title: Why MSAL based iOS app keep asking for login with Microsoft Entra?
description: Provides guidance for troubleshooting repeated login prompts in iOS MSAL implementation
ms.date: 03/19/2025
ms.author: bachoang
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
| [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession?language=objc) <br> [SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession?language=objc) <br> [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller?language=objc) | [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview?language=objc) |

To customize the browser, you must allow cookie sharing to prevent repeated login prompts.

## Resolution

To enable cookie sharing and prevent repeated login prompts, use one of the following configurations:

- **ASWebAuthenticationSession in MSAL** + **openURL in Safari browser** (the full Safari browser, not SafariViewController).
- **SFSafariViewController in MSAL** + **SFSafariViewController in your app**.
- **WKWebView in MSAL** + **WKWebView in your app**.

For more information, see [Customizing webviews and browsers](/azure/active-directory/develop/customize-webviews).

> [!Note]
> For Xamarin.iOS, several additional factors need to be considered, including enabling token caching and using Microsoft Authenticator. For more information, see [Xamarin.iOS MSAL considerations](/azure/active-directory/develop/msal-net-xamarin-ios-considerations).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]


