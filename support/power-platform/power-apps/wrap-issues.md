---
title: Troubleshoot wrap issues
description: Provides resolutions for wrap issues in Power Apps.
ms.reviewer: makolomi
ms.topic: troubleshooting
ms.date: 10/08/2022
ms.subservice: 
---
# Troubleshoot wrap issues in Power Apps

This article helps you resolve the most common warp issues in Microsoft Power Apps.

## Wrap build is failing

#### Verify that your images are in a PNG format

Ensure that the images you're using in wrap are in a PNG format. Using images in any format other than PNG in wrap will cause the build to fail. Use an image converter to save your images as .png files or ensure that your original image files are in a PNG format instead.

> [!IMPORTANT]
> Manually changing your image file extension from .jpeg or any other formats to .png will not automatically reformat the image to a PNG format.

#### Verify that your App Center is correctly configured

Your App Center link must be created as an App within an organization, and not a standalone App.

   :::image type="content" source="media/wrap-issues/add-new-organization.png" alt-text="Screenshot of how to add a new organization in App Center.":::

Check that the access token you've created is correct.

- Correct: Select your created **App** > **Settings** > **App API Tokens**
- Incorrect: **Account Settings** > **User API Tokens**

Verify that your iOS or Android App created has the right settings configurations.

- iOS: OS=Custom
- Android: OS=Android, Platform=React Native

For more information, see steps 8 and 9 in [Create an App Center container for your mobile app](/power-apps/maker/common/wrap/how-to#create-an-app-center-container-for-your-mobile-app).

#### Verify that your Keyvault configuration is correct

Make sure that Azure Service Principal was created and the role was added correctly. For more information, see steps 1 and 2 in [Set up KeyVault for automated signing](/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing).

Ensure that your Keyvault contains all necessary certificates, secrets, and tags for iOS and/or Android:

- iOS: two tags, one certificate, and one secret
- Android: one tag and one certificate

For more information, see [/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing).

#### Try again if you have all the proper configurations

If your wrap build still fails after you've verified that your wrap project has all the proper configurations, reach out to our support alias. See details at the end of this article.

## Wrap button is disabled for my App

You can only wrap Apps that you have **Edit** permissions for. Make sure you have **Edit** permissions for the App you want to wrap and try again.

## Can't save my project or trigger a wrap build

To resolve this issue, you can:

- Update to latest wrap solution version and try again.
- Ensure that no UI validation errors block the Save or Build submission.

## Can't install a wrapped mobile App on a device

Make sure that you've signed the outputted application. You can do so by configuring a Keyvault and providing it at build trigger time, or manually signing. For more information on code signing, see:

- [Setup Keyvault for Automated Signing](/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing)
- [Code sign for iOS](/power-apps/maker/common/wrap/code-sign-ios)
- [Code sign for Android](/power-apps/maker/common/wrap/code-sign-android)

Verify that your mobile device meets these [minimum requirements](/power-apps/maker/common/wrap/overview#software-and-device-requirements).

## Can't sign in to a wrapped mobile App or can't see data

If you can't sign in to your wrapped mobile App, verify that:

- Your Microsoft Azure Active Directory (AAD) app is properly configured.
- All API permissions for the App have been added correctly. For more information on how to see and configure API permissions for the App, see the below screenshot and [Configure API Permissions](/power-apps/maker/common/wrap/how-to#configure-api-permissions).

  :::image type="content" source="media/wrap-issues/api-permissions.png" alt-text="Screenshot of API permissions for the App." lightbox="media/wrap-issues/api-permissions.png":::

- Verify that admin `Add-AdminAllowedThirdPartyApps` script was run successfully. For more information, see [Allow registered apps in your environment](/power-apps/maker/common/wrap/how-to#allow-registered-apps-in-your-environment).
- Make sure that your AAD app type is Multi-tenant. Under your AAD app's Authentication tab, Supported account types should be **Accounts in any organizational directory (Any Azure AD directory – Multitenant**.
- Ensure that the proper Redirect URIs have been created for iOS and Android. For Android, check that the hash is provided correctly. For more information on Redirect URIs, see [these steps](/power-apps/maker/common/wrap/how-to#redirect-uri-format).

## Other issues in wrap

For all other issues, or if your issue persists after following these steps, reach out to Power Apps Mobile Support (pamobsup@microsoft.com), include a repro video and/or screenshots, and a session ID, which can be acquired in the following ways:

- On the sign-in screen, go to lower right to select the gear icon, and then select **Session Details**.
- In an opened app, you can shake your device, and then select **Session Details**.
