---
title: Troubleshoot Common Issues When Using Wrap Feature
description: Provides solutions to common issues when using the wrap feature in Power Apps.
ms.reviewer: sitaramp, koagarwa
ms.author: arijitba
author: arijitba
ms.date: 07/23/2025
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sap:App Management\Wrap an app
---
# Troubleshoot common issues when using the wrap feature

This guide provides solutions to common issues you might encounter when using the [wrap](/power-apps/maker/common/wrap/overview) feature in Microsoft Power Apps.

## Issue 1: Wrap build fails

If your wrap build fails, try the following actions:

### Verify image formats

Ensure that all images in your wrap project are in PNG format. Using other formats can cause the build to fail. Use an image converter to convert images to `.png`.

> [!IMPORTANT]  
> Renaming a file extension to `.png` doesn't convert the image to PNG format.

### Check Azure key vault setup

- Ensure you create an Azure service principal and assign the correct role.
- For more information, see [Create Azure key vault for wrap in Power Apps](/power-apps/maker/common/wrap/create-key-vault-for-code-signing).

Your key vault must contain:

- **For iOS**: Two tags, one certificate, and one secret.
- **For Android**: One tag and one certificate.

---

## Issue 2: Wrap button is disabled

Confirm you have edit permissions for the app and try again. For a list of requirements, see [Permission and access requirements for wrap](/power-apps/maker/common/wrap/prerequisites#permissions-and-access-requirements).

---

## Issue 3: Unable to save your wrap project or trigger a build

Update to the latest version of the wrap solution and try again.

---

## Issue 4: Unable to install wrapped mobile app

Ensure your app is properly signed by configuring a key vault during the build process, or signing the app manually.

For more information, see:

- [Set up Key vault for automated signing](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform)
- [Code sign for iOS](/power-apps/maker/common/wrap/code-sign-ios)
- [Code sign for Android](/power-apps/maker/common/wrap/code-sign-android)

In addition, verify your device meets the [minimum requirements](/power-apps/maker/common/wrap/overview#software-and-device-requirements).

---

## Issue 5: Can't sign in or see data in wrapped app

If you can't sign in or see data in your wrapped app, try the following actions:

### Verify API permissions and access

- Ensure all required API permissions are configured and admin permissions are granted.

  :::image type="content" source="media/wrap-issues/api-permissions-2.png" alt-text="Screenshot that shows the API permissions for the app." lightbox="media/wrap-issues/api-permissions-2.png":::

- Ensure the `Add-AdminAllowedThirdPartyApps` script runs successfully.  
  For more information, see [Allow registered apps in your environment](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

### Check account type and redirect URIs

- Verify the Microsoft Entra app type is set to **Multitenant** and the supported account type is **Accounts in any organizational directory (Any Microsoft Entra ID tenant)**.

- Configure proper redirect URIs for iOS and Android:
  - For Android, confirm the hash is correct.  
  - For more information, see [Configure platform settings and redirect URIs](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

---

## Issue 6: Fail to sign in to wrapped app

1. Ensure the user has access to the app. For more information, see [Share a canvas app with your organization](/power-apps/maker/canvas-apps/share-app).

2. If the user has app access but still can't sign in, check the [Conditional Access policies in Microsoft Entra admin center](/entra/identity/monitoring-health/how-to-view-applied-conditional-access-policies).

3. To troubleshoot sign-in errors, copy the correlation ID from the mobile screen where the sign-in is failing and refer [How to troubleshoot Microsoft Entra sign-in errors](/entra/identity/monitoring-health/howto-troubleshoot-sign-in-errors) to understand the error and the failing policies.

4. Check [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes).

---

## Other issues

If your issue isn't covered here, or if the preceding steps don't resolve your problem, [search for more support resources](https://powerapps.microsoft.com/support) or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support) and provide detailed steps to reproduce the problem.

### Collecting diagnostic information

For sign-in issues, you can collect session details and include it when you contact Microsoft support:

- For wrap wizard: On the sign-in screen, tap the gear icon in the upper-right corner and select **Session Details**.
- For mobile devices: After opening the app, press and hold the screen, and then select **Session Details**.
