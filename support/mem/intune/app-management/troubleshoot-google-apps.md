---
title: Troubleshoot Managed Google Play apps on Intune-managed devices
description: Troubleshoot common issues with Managed Google Play for Android Enterprise devices enrolled in Microsoft Intune.
ms.date: 12/21/2021
search.appverid: MET150
ms.reviewer: kaushika
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

### I want to stay updated on any Google service issues that may cause impact

Google releases [service announcements](https://www.androidenterprise.community/t5/service-announcements/tkb-p/Announcements) containing details about issues that may impact Android Enterprise management. Follow the [instructions to subscribe](https://www.androidenterprise.community/t5/news-info/new-community-board-subscribe-to-the-new-service-announcements/ba-p/1044) and receive notifications for new posts.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
