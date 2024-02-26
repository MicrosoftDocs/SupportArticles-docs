---
title: Troubleshoot data transfer and Intune app protection policies
description: General steps to help troubleshoot when Microsoft Intune app protection policies (APP) to not control data transfer as expected.
ms.date: 12/05/2023
ms.reviewer: kaushika, roblane
search.appverid: MET150
---
# Troubleshooting data transfer between apps

This article gives troubleshooting guidance for scenarios where a Microsoft Intune app protection policy (APP) designed to allow data transfer doesn't work as intended. The most common uses of the Intune APP are for data protection, to control the transfer of corporate data between APP managed applications (apps), and to restrict data transfer to unmanaged apps. For example, users can transfer corporate data from the Microsoft Outlook app to the Microsoft Excel app (both policy-managed) but not to the Dropbox mobile app (an unmanaged app).

When applying Intune APP for data protection, a major unexpected behavior would be seeing your users cannot transfer data between managed apps, such as Outlook and Teams. In such scenarios, use the troubleshooting steps in this article to help diagnose and resolve the problem. For general APP troubleshooting, see [Troubleshooting app protection policy deployment in Intune](troubleshoot-app-protection-policy-deployment.md).

## Confirm you're using supported platforms, OS versions, and apps

Confirm that you've met the prerequisites for using app protection policies. There are some requirements for supported platforms, operating system (OS) versions, and apps.

- **Supported platforms:** App protection policies are supported on iOS, iPadOS, and Android. However, [Shared iPad devices](/mem/intune/enrollment/device-enrollment-shared-ipad) and [Android Enterprise dedicated devices](/mem/intune/apps/app-protection-policy#app-protection-experience-for-android-devices) aren't supported.

- **Supported OS versions:** Check that you're working with a supported OS and version. Note any special version requirements for app protection policies as described in [Supported operating systems and browsers in Intune](/mem/intune/fundamentals/supported-devices-browsers). Supported operating systems will change over time and older versions will become non-supported. Also, ensure your OS meets the requirements of each app you use, as well.

- **Supported apps:** Apps need to be integrated with the [Microsoft Intune App SDK](/mem/intune/developer/app-sdk-get-started) to support app protection policies. For a list of supported Microsoft and partner applications, see [Microsoft Intune protected apps](/mem/intune/apps/apps-supported-intune-apps).

## Verify that the account is a corporate account and that the file is corporate data

The scope of Intune app protection policies (APP) covers corporate accounts and data only. You cannot use APP to protect personal accounts or manage the transfer of personal data. To apply APP correctly, you need to ensure the account you're using to sign into the managed app is a corporate account and the data you're trying to share is corporate data. Review the following:

- **Corporate accounts:** User accounts belong to your company's Microsoft Entra tenant and are considered corporate accounts. These accounts can be synced with on-premises Active Directory using Microsoft Entra Connect. You must assign Intune licenses to your users to use APP.

- **Corporate data:** The data stored in managed locations, such as OneDrive for Business or SharePoint Online, are considered corporate data. Data stored in personal, local storage locations are not treated as corporate data. Files created with managed Microsoft Office apps (such as Word or Excel), are considered corporate data only when saved to a managed location (OneDrive for Business and SharePoint Online). If you save Office files to OneDrive for Business, they'll be treated as corporate data. Files saved to local storage or in other non-managed locations are treated as personal data and not protected by APP. Draft, sent, and received emails in the Microsoft Outlook app are treated as corporate data if they were created while signed in with a corporate account.

- **Multi-identity apps:** Some applications, such as Outlook and OneDrive, support multi-identity, allowing  you to add both corporate and personal accounts to the apps at the same time. In this scenario, files, emails, and documents under corporate accounts are treated as corporate data and protected by APP. For example, files stored in the OneDrive for Business and Outlook emails and attachments are treated as corporate data. You can restrict the transfer data of this data using APP. On the other hand, OneDrive files and Outlook emails under personal accounts are treated as personal data and are not protected by APP. You cannot restrict data transfer for these accounts with APP.

## For Android, check that the apps are in the work profile

If you're using [Android work profile devices](/mem/intune/user-help/enroll-device-android-work-profile), make sure your users are using work profile apps when working with corporate data. To apply Intune APP to these devices, you must install the Intune Company Portal app in the work profile. For information about installing the Company Portal app, see [Add the Windows 10 Company Portal app by using Microsoft Intune](/mem/intune/apps/store-apps-company-portal-app).

Apps in the work profile are identified with a briefcase badge on the app icons.

:::image type="content" source="media/troubleshoot-data-transfer/android-work-profile-icons.png" alt-text="Android work profile app icons showing a briefcase badge.":::

For more information on Android work profile, see [Introduction to Android work profile](/mem/intune/user-help/what-happens-when-you-create-a-work-profile-android).

## Confirm the expected APP settings are applied to the apps

Check app protection policy settings in both Intune and on those configured on the device side. The table in the Review APP settings in Intune section of this document provides general guidelines to confirm that you've correctly configured settings in the admin center.  Once confirmed, verify that the same settings are applied to apps on the devices.

### Review APP settings in Intune

In the [Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), you can create and manage your app protection policies under **Apps** > **App protection policies**. The **Data protection** section includes important settings for data-transfer scenarios, which you should review if you're seeing unexpected behavior. The following table lists common APP settings for data protection and their use cases.

|Setting name   |OS   |Setting value   |Use case   |
|------------|-----|------|-----------------|
|Send org data to other apps|Android|Policy managed apps|Restrict data transfer to policy managed apps. Data can be transferred to unmanaged apps but the data is encrypted and can't be opened.|
||iOS/iPadOS|Policy managed apps with OS sharing|Data transfer may be restricted to policy managed and unmanaged apps by applying "IntuneMAMUPN" app configuration policy. </br></br>Refer to [iOS/iPadOS security app configuration policies](/mem/intune/enrollment/ios-ipados-app-configuration-policies) and [How to manage data transfer between iOS apps in Microsoft Intune](/mem/intune/apps/data-transfer-between-apps-manage-ios).|
||iOS|Policy managed app with Open-In/Share filtering|Restrict data transfer by filtering apps displayed in sharing extensions. Sharing files with this setting restricts the available apps to those that support Intune APP only.|
|Select apps to exempt|iOS|Custom URI schemes|Allow data transfer to specific unmanaged apps.|
||Android|App packageIDs|Allow data transfer to specific unmanaged apps.|
|Select universal links to exempt|iOS/iPadOS|URL strings|Specify unmanaged apps to open URL links instead of Microsoft Edge.|
|Select managed universal links|iOS/iPadOS|URL strings|Specify managed apps to open URL links instead of Microsoft Edge.|
|Save copies of org data|All|Block|Block or restrict file save locations.|
|Allow user to save copies to selected services|All|OneDrive for Business, SharePoint, Box, Local Storage, Photo Library|Specify managed file save locations. Other locations are blocked or data is kept encrypted.|
|Receive data from other apps|All|All apps|Allow managed apps to receive data from any app, including unmanaged apps.|
||iOS/iPadOS|All apps with incoming org data|Allow managed apps to receive data from any app, including unmanaged apps.|
||All|Policy managed apps|Allow apps to Receive data only from policy managed apps.|
||All|None|Block incoming data from any app.|
|Open data into Org documents|All|Allow|Allow opening data from any data sources.|
||All|Block|Restrict opening data from specific data sources.|
|Allow users to open data from selected services|All|OneDrive for Business, SharePoint, Camera, Photo Library|Select data sources apps are allowed to open data from.|
|Restrict web content transfer with other apps|All|Microsoft Edge|Specify the policy-managed Microsoft Edge app to open URL links.|

For more information, see [iOS/iPadOS app protection policy settings](/mem/intune/apps/app-protection-policy-settings-ios#data-protection) and [Android app protection policy settings](/mem/intune/apps/app-protection-policy-settings-android#data-protection).

## Review APP settings on the device side with Microsoft Edge

Run Intune diagnostics in Microsoft Edge to check the APP setting applied to each managed application on a device.

1. Open Microsoft Edge on the device and enter the URL, *about:intunehelp*. **Intune Diagnostics** will open, as shown in the examples below.

1. Tap **View Intune App Status** (iOS/iPadOS) or **VIEW APP INFO** (Android) to see APP settings applied to each app on the device.

1. Compare setting values in this view with those configured in Intune.

    For an explanation of these settings' values, see [Review client app protection logs](/mem/intune/apps/app-protection-policy-settings-log).

:::image type="content" source="media/troubleshoot-data-transfer/intune-diagnostics-ios-and-android.png" alt-text="Side-by-side screenshots of Intune Diagnostics on an iOS/iPadOS device (left) and an Android device (right).":::

Note: You can also verify the app version and the Intune App SDK version in this view.

## Compare the behavior with other devices, users, apps, and patterns

Troubleshoot issues by comparing behaviors on devices, users, apps, and operations to help separate and narrow down the root cause. Try to identify or reproduce the issue on other devices and with other users to understand if the issue is specific to one device or a subset of devices. If you don't see the issue on other devices, try to identify what is different about the problematic device, such as user groups, device models, OS versions, etc.

It also helps to compare behaviors between apps. An issue you see with the Excel app may not happen with the Word app. When you do these comparisons, it's important to note app versions and Intune App SDK versions as the unexpected behavior might be specific to versions. We recommend you regularly update apps to the latest version available.
