---
title: Troubleshoot data transfer and Intune app protection policies
description: General steps to help troubleshoot when Microsoft Intune app protection policies (APP) to not control data transfer as expected.
ms.date: 04/26/2022
ms.reviewer: roblane-msft
search.appverid: MET150
---
# Troubleshooting data transfer between apps

This article gives troubleshooting guidance for scenarios where a Microsoft Intune app protection policy (APP) designed to block data transfer doesn't work as intended. One of the most common uses of Intune APP is for data protection, to control the transfer of corporate data between Intune APP-managed apps and restrict data transfer to unmanaged apps. For example, users can transfer corporate data from the Microsoft Outlook app to the Microsoft Excel app (both are policy-managed apps) but not to the Dropbox mobile app (an unmanaged app).

When you apply Intune APP for data protection, a major unexpected behavior would be seeing your users transfer data from a managed app, such as Outlook, to an unmanaged app, such as Dropbox. In such scenarios, use the troubleshooting steps in this article to help diagnose and resolve the problem. For general APP troubleshooting, see [Troubleshooting app protection policy deployment in Intune](troubleshoot-app-protection-policy-deployment.md).

## Confirm you're using supported platforms, OS versions, and apps

You can start by confirming that you've met the prerequisites for using app protection policies. There are some requirements for supported platforms, OS versions, and apps.

- Supported platforms: App protection policies are supported on iOS, iPadOS, and Android. However, [Shared iPad devices](/mem/intune/enrollment/device-enrollment-shared-ipad) and [Android Enterprise dedicated devices](/mem/intune/apps/app-protection-policy#app-protection-experience-for-android-devices) aren't supported.

- Supported OS versions: Check that you're working with a supported OS and version, and note any special version requirements for app protection policies: [Supported operating systems and browsers in Intune](/mem/intune/fundamentals/supported-devices-browsers). Supported OSes will change in the future and older versions will become non-supported. Also, you need to meet requirements of each app you use, such as Office apps.

- Supported apps: Apps need to be integrated with the [Microsoft Intune App SDK](/mem/intune/developer/app-sdk-get-started) to support app protection policies. For a list of supported Microsoft apps and partner apps, see [Microsoft Intune protected apps](/mem/intune/apps/apps-supported-intune-apps).

## Verify that the account is a corporate account and that the file is corporate data

The scope of Intune app protection policies is corporate accounts and corporate data. In other words, you can't use APP to protect personal accounts or manage the transfer of personal data. To apply APP correctly, you need to make sure the account you're using is a corporate account and the data you're trying to share is corporate data. Review the following:

- **Corporate accounts:** The user accounts belong to your company's Azure Active Directory (Azure AD) tenant. The accounts can be synced with on-premises Active Directory using Azure AD Connect. You must assign Intune licenses to your users to use APP.

- **Corporate data:** The data stored in managed locations, such as OneDrive for business or SharePoint Online. Data stored in personal, local storage locations aren't treated as corporate data. For Microsoft Office apps (such as Word or Excel), blank files aren't treated as corporate data. If you save Office files to OneDrive for Business, they'll be treated as corporate data. If you save Office files to local storage, they'll be treated as personal data. For the Outlook app, received, sent, and draft emails are treated as corporate data if they were created while signed in with a corporate account.

- **Multi-identity apps:** Some apps such as Outlook and OneDrive support multi-identity and you can add both corporate and personal accounts to the apps at the same time. In this scenario, files, emails, and documents under the corporate accounts are treated as corporate data and protected by APP. For example, files stored in the OneDrive for business storage are corporate data. Outlook emails and attachments in the corporate email account are also treated as corporate data. You can restrict data transfer of these data using APP. On the other hand, OneDrive files and Outlook emails under personal accounts are treated as personal data. Data transfer for these accounts isn't restricted by APP.

## Check that the apps are in the work profile

If you're using [Android work profile devices](/mem/intune/user-help/enroll-device-android-work-profile), make sure your users are using apps in the work profile when working with corporate data, instead of apps in the personal profile. To apply Intune APP to these devices, you must install the Intune Company Portal app in the work profile.

Apps in the work profile are identified with a briefcase badge on the app icons.

:::image type="content" source="media/troubleshoot-data-transfer/android-work-profile-icons.png" alt-text="Android work profile app icons showing briefcase badge.":::

## Confirm the expected APP settings are applied to the apps

The next step is checking app protection policy settings in both the Microsoft Endpoint Manager admin center and also on the device side. Below are some general checks to see if you've configured settings correctly in the admin center and then confirm the same settings are applied to apps on the devices.

### Review APP settings in Endpoint Manager

In the [Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), you can create and manage your app protection policies under **Apps** > **App protection policies**. The **Data protection** section includes important settings for data-transfer scenarios, which you should review if you're seeing unexpected behavior. The following table lists common APP settings for data protection and their use cases.

|Setting name in admin center|Setting value|Use case|
|------------|---------|-----------------|
|Send org data to other apps|Policy managed apps|Restrict data transfer to policy managed apps. Data can be transferred to unmanaged apps but the data is encrypted and can't be opened.|
||Policy managed apps with OS sharing*|Similar to 'Policy managed apps' but exempt policy managed apps from the restriction by applying 'IntuneMAMUPN' app config policy.|
||Policy managed app with Open-In/Share filtering*|Restrict data transfer by filtering apps displayed in sharing extensions.|
|Select apps to exempt|(iOS) custom URI schemes|Allowing data transfer to specific unmanaged apps.|
||(Android) app packageIDs|Allowing data transfer to specific unmanaged apps.|
|Select universal links to exempt*|URL strings|URL links that you want to open with unmanaged apps instead of Microsoft Edge.|
|Select managed universal links*|URL strings|URL links that you want to open with managed apps instead of Microsoft Edge.|
|Save copies of org data|Block|Block or restrict locations you can save files to.|
|Allow user to save copies to selected services|OneDrive for Business, SharePoint, Box, Local Storage|Select locations that you want to set as a managed location. You can save files to selected locations. Other locations are blocked or data is kept encrypted.|
|Receive data from other apps|All apps|Allow receiving incoming data from any apps including unmanaged apps.|
||All apps with incoming org Data*|Allow receiving incoming data from any apps including unmanaged apps.|
||Policy managed apps|Receiving data only from policy managed apps.|
||None|Block incoming data from any apps.|
|Open data into Org documents|Allow|Allow opening data from any data sources.|
||Block|Restrict opening data from specific data sources.|
|Allow users to open data from selected services|OneDrive for Business, SharePoint, Camera|Select data sources that you want to allow opening data from.|
|Restrict web content transfer with other apps|Microsoft Edge|Protect web contents by opening URL links with Microsoft Edge app that is a policy managed app.|

*Available for iOS/iPadOS only

For more information, see [iOS/iPadOS app protection policy settings](/mem/intune/apps/app-protection-policy-settings-ios#data-protection) and [Android app protection policy settings](/mem/intune/apps/app-protection-policy-settings-android#data-protection).

## Review APP settings on the device side with Microsoft Edge

You can run Intune diagnostics in Microsoft Edge to check each APP setting applied to each app on a device. Open Microsoft Edge on the device, and enter the following URL: **about:intunehelp**

**Intune Diagnostics** will open, as shown in the examples below. Tap **View Intune App Status** (iOS/iPad) or **VIEW APP INFO** (Android) to see APP settings applied to each app on the device. You can compare values of settings in this view with the ones configured in Endpoint Manager. For an explanation of these settings' values, see [Review client app protection logs](/mem/intune/apps/app-protection-policy-settings-log).

:::image type="content" source="media/troubleshoot-data-transfer/intune-diagnostics.png" alt-text="Side-by-side screenshots of Intune Diagnostics on an iOS/iPadOS device (left) and an Android device (right).":::

You can also check the app version info and Intune App SDK version info in this view.

## Compare the behavior with other devices, users, apps, and patterns

Compare behaviors between devices, users, apps, and operations to help separate and narrow down the root cause. Try to identify or reproduce the issue on other devices and with other users to understand if the issue is specific to one device or a subset of devices. If you don't see the issue on other devices, try to identify what is different about the problematic device, for example, user groups, device models, OS versions, etc.

It also helps to compare behaviors between apps. An issue you see with the Excel app may not happen with the Word app. When you do these comparisons, it's important to note app versions and Intune App SDK versions because the unexpected behavior might occur only with specific versions. We recommend you regularly update apps to the latest version available.

## Confirm the data is encrypted once files are transferred

In some scenarios for iOS or iPadOS devices, files can be transferred to unmanaged apps even when you set **Send org data to other apps** to 'Policy managed apps' and **Save copies of org data** to 'Block'. For example, a user can use sharing options to transfer corporate word files from the Word app to the Dropbox app.

This is expected behavior because setting **Send org data to other apps** to 'Policy managed apps' doesn't filter out apps displayed in the sharing extension. And although **Save copies of org data** can 'Block' Save operations, it doesn't block sharing options. As a result, users can still transfer corporate data to unmanaged apps with these settings. However, the data is still encrypted with APP once transferred, so the transferred files can't be opened with unmanaged apps.

For more details please refer [this FAQ](/mem/intune/apps/mam-faq#i-am-able-to-use-the-ios-share-extension-to-open-work-or-school-data-in-unmanaged-apps--even-with-the-data-transfer-policy-set-to--managed-apps-only--or--no-apps---doesn-t-this-leak-data).
