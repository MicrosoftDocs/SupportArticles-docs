---
title: Troubleshoot Managed Google Play apps on Intune-managed devices
description: Troubleshoot common issues with Managed Google Play for Android Enterprise devices enrolled in Microsoft Intune.
ms.date: 11/07/2025
search.appverid: MET150
ms.reviewer: kaushika, v-six, esalter
ms.custom: sap:AppDeployment - Android\ManagedGooglePlay
---
# Troubleshoot Managed Google Play apps on Intune-managed devices

This article gives information and troubleshooting steps for common issues with Managed Google Play app on Intune-managed Android Enterprise devices.

## Managed Google Play apps that aren't deployed through Intune are displayed in the work profile

System apps can be enabled in the work profile by the device OEM at the time that the work profile is created. This isn't controlled by the MDM provider.

To troubleshoot, follow these steps:

  1. Collect Company Portal logs.
  2. Note apps that appear in the work profile unexpectedly.
  3. Unenroll the device from Intune and uninstall Company Portal.
  4. Install the [Test DPC](https://play.google.com/store/apps/details?id=com.afwsamples.testdpc) app, which allows creation of a work profile without an EMM for testing.
  5. Follow the instructions in [Test DPC](https://play.google.com/store/apps/details?id=com.afwsamples.testdpc) to create a work profile on the device.
  6. Review apps that appear in the work profile.
  7. If the same applications show in the Test DPC app, the apps are expected by the OEM for that device.

## Unapproved Managed Google Play for Work store apps aren't being removed from the Client Apps page in Intune

This is expected behavior.

## Managed Google Play apps aren't reported under the Discovered Apps blade in the Intune portal

This is expected behavior. Only system apps installed in the Work Profile are inventoried in the Discovered Apps blade. To see installed Managed Google Play apps, use the **Managed Apps** blade.

## I need to customize how apps are updated for Android Enterprise

See the blog post [Best practices for updating your Android Enterprise apps](https://techcommunity.microsoft.com/t5/intune-customer-success/best-practices-for-updating-your-android-enterprise-apps/ba-p/3038520) to learn about best practices and options for configuring app updates for your corporate-owned devices. This includes using network preferences, maintenance windows, and high-priority update mode Which bypasses all regular constraints so you can apply and update as fast as possible.

## I want to stay updated on any Google service issues that may cause impact

Google releases [service announcements](https://www.androidenterprise.community/t5/service-announcements/tkb-p/Announcements) containing details about issues that may impact Android Enterprise management. Follow the [instructions to subscribe](https://www.androidenterprise.community/t5/news-info/new-community-board-subscribe-to-the-new-service-announcements/ba-p/1044) and receive notifications for new posts.

## Newly approved Managed Google Play apps don't appear in the Play Store

<!-- 33632857 -->

When you approve a Managed Google Play app, it might not appear in the Play Store for users. This behavior occurs when your tenant is in Custom mode.

Custom mode is enabled automatically when you edit collections in the Managed Google Play iFrame. In this mode, newly approved apps remain hidden until you manually add them to a collection.

To resolve the issue, use one of the following options:

- **Add the app to a collection:** In the Managed Google Play iFrame, add the app to an existing or new collection.
- **Reset the Play Store layout to Basic:**  
  1. In the Intune admin center, go to **Apps** > **All apps** > **Create Managed Google Play app**.  
  2. Select **Reset to Basic**.  
  3. Confirm the action.

> [!IMPORTANT]
> Resetting to Basic deletes all existing collections. After the reset, all approved apps become visible in the Play Store automatically. Any future changes to collections switch the store back to Custom mode.

Allow a few minutes for the change to propagate. If the reset fails, retry and confirm that you have the correct permissions. If the issue continues, capture the error details and contact Microsoft Support.

For more information, see [Add Managed Google Play apps to Android Enterprise devices with Intune](/mem/intune/apps/apps-add-android-for-work).


[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
