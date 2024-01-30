---
title: Troubleshoot Android Enterprise device enrollment in Microsoft Intune
description: Suggestions for troubleshooting some of the most common problems when you enroll Android devices in Intune.
ms.date: 12/02/2021
ms.reviewer: kaushika, joelste
search.appverid: MET150
---
# Troubleshooting Android Enterprise device enrollment in Intune

This article helps administrators understand and troubleshoot common scenarios when enrolling Android Enterprise devices in Microsoft Intune. See [Troubleshoot device enrollment in Microsoft Intune](troubleshoot-device-enrollment-in-intune.md) for additional, general troubleshooting scenarios.

## Device management

### Managed Google Play Last Sync time hasn't been updated in days

This is expected behavior. You must manually trigger a sync.

### Encryption is required when a device is enrolled

This is expected behavior. You can't turn off encryption: Google requires that the device be encrypted to create a work profile.

## Remote actions

### Wipe (Factory Reset) option isn't available for work profile enrolled device

This is expected behavior. In the work profile scenario, the MDM provider doesn't have full control over the device. The only option available is Retire (Remove Company Data) which removes the whole work profile and all its contents.

Wipe is supported for [Android Enterprise corporate-owned with work profile devices](/mem/intune/enrollment/android-corporate-owned-work-profile-enroll).

### Device passcode reset not supported

For personally owned work profile enrolled devices, you can only reset the work profile passcode on devices running Android 8.0 or later if the following conditions are met:

- The work profile passcode is managed.
- The device user has allowed you to reset it.

For corporate-owned work profile enrolled devices, you can only reset the work profile passcode.
For Android Enterprise dedicated devices and fully managed devices, device passcode reset is supported.

## Duo devices

### Company Portal not prompting users to enroll

In some cases, the enrollment checklist may not be displayed as expected when users launch the Company Portal app.

If users aren't seeing the enrollment checklist, they can navigate to it. To bring up the enrollment checklist, tap on the notification bell in the upper-right corner of the Company Portal app and then tap the notification.

### Users unable to find or launch the Microsoft Launcher app

The Microsoft Launcher app is the default launcher app on Duo devices, so the app icon has been hidden from the apps list and in the personal and work Google Play stores. This will be fixed in a coming update.

### Microsoft Edge sign-in prompt during enrollment

When an unenrolled user tries to access corporate data in an app protected by conditional access (CA), the user will be guided to enroll their device. During this enrollment flow, the Microsoft Edge app is launched to open the Company Portal website. In some cases, the Microsoft Edge app may prompt the user to sign into Microsoft Edge, which diverts the user from the enrollment flow.

To avoid this entirely, tell users to enroll in the Company Portal before trying to access their organization's data. If a user does try to access their organization's data before enrolling, when Microsoft Edge prompts the user to sign in, they should skip the Microsoft Edge sign-in step in order to proceed with the enrollment flow. Users can always initiate enrollment in the preinstalled Company Portal app.

## Service issues

### Users want to stay updated on any Google service issue that may cause impact

Google releases [service announcements](https://www.androidenterprise.community/t5/service-announcements/tkb-p/Announcements) containing details about issues that may impact its service. Follow the [instructions to subscribe](https://www.androidenterprise.community/t5/news-info/new-community-board-subscribe-to-the-new-service-announcements/ba-p/1044) and receive notifications for new posts.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
