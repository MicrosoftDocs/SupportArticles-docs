---
title: Common issues when using Intune app protection policies to control data transfer
description: Learn how to diagnose and troubleshoot some common issues and misconfigurations when using Microsoft Intune app protection policies (APP) to control data transfer.
ms.date: 12/05/2023
ms.reviewer: kaushika, roblane-msft
search.appverid: MET150
---
# Common data transfer issues and scenarios

This article gives troubleshooting guidance for common scenarios in which data transfer isn't restricted as expected with Intune app protection policies (APP). For general troubleshooting guidance related to data transfer and Intune APP, see [Troubleshooting data transfer between apps](troubleshoot-data-transfer.md).

## Users cannot transfer corporate files, or copy/paste corporate data between managed apps

In this scenario, a user can't transfer corporate files between managed apps or copy and paste data from a corporate document to a managed app.

- Check the **Send org data to other apps** setting in both the Microsoft Intune admin center and on the device side is using Microsoft Edge. If it is set to **None**, users cannot transfer files to any apps.

## Users cannot receive files from unmanaged apps

In this scenario, a user can't receive files from unmanaged apps. For example, files can't be inserted into a document from the Camera, OneDrive for Business, or SharePoint app.

- Check the **Receive data from other apps** setting in both the Microsoft Intune admin center and on the device side is using Microsoft Edge. If it is set to **None**, users can't transfer files from any apps.

- Check the settings for **Open data into org documents** and select **Allow users to open data from selected services** to restrict the data source you block or allow.

    :::image type="content" source="media/data-transfer-scenarios/open-data-from-services-options.png" alt-text="Dropdown options for 'Allow users to open data from selected services' in the admin center.":::

## User needs to transfer corporate data to unmanaged apps

In this scenario, a user needs to transfer files to unmanaged apps even though you have set **Send org data to other apps** to **Policy managed apps**.

- Check the **Select apps to exempt** setting and make sure the receiving app is set as a data transfer exemption.

    :::image type="content" source="media/data-transfer-scenarios/select-apps-to-exempt.png" alt-text="A screenshot of the 'Select apps to exempt' setting under 'Send org data to other apps'.":::

For more information, see [Troubleshooting exemptions to data transfer policies](troubleshoot-data-transfer-exemptions.md).

## Users cannot save corporate files to local storage

In this scenario, a user can't save files to local storage. Typically, this occurs because either (or both) of the settings below are configured.

- **Send org data to other apps** is set to **None** in app protection policies.
- The **Allow user to save copies to selected services** is not set to **local storage** in app protection policies.

## I want to customize the apps available in the iOS Share extension

Oftentimes, admins want to filter the list of apps displayed in the iOS Share extension (receiving apps) to prevent data transfer to unmanaged apps. There are two methods to control which apps are available in the Share extension. You can combine both methods if you're using an Mobile Device Management (MDM) solution.

### Option A: Restrict sharing for MDM managed devices

- Set the device restriction setting **Block viewing corporate documents in unmanaged apps** to **Yes**.
- Use Intune to deploy the apps you want to allow data sharing between.
- Don't deploy other apps and instead have your users install them from the Apple App Store.

With this configuration, if the sender app is MDM managed, only managed apps will display in the sharing extension. In the example below, the Teams app isn't deployed with Intune, so the app isn't displayed in the Share extension.

:::image type="content" source="media/data-transfer-scenarios/block-viewing-corporate-docs.png" alt-text="An example showing how the Teams app doesn't appear in the iOS Share extension when it is not deployed with Intune.":::

### Option B: Restrict sharing for devices with APP managed apps

- Set the app protection setting **Send org data to other apps** to **Policy managed app with Open-In/Share filtering**.

With this configuration, the share extension is filtered to show only apps that support Intune APP. This method can be used for an [Application management without enrollment scenario](/mem/intune/fundamentals/deployment-guide-enrollment-mamwe). The following example shows how available apps in the share extension will change once the policy is set to **Policy managed app with Open-In/Share filtering**. In this example, the Dropbox app isn't displayed in the share extension because it doesn't support Intune APP. Also, the **Save to Files** option is filtered out to prevent data transfer using the local Files app.

:::image type="content" source="media/data-transfer-scenarios/send-data-to-other-apps.png" alt-text="An example of how the Policy managed app with Open-In/Share filtering alters the ability to save files to the Dropbox app in the Share extension.":::

For more information, see [How to manage data transfer between iOS apps in Microsoft Intune](/mem/intune/apps/data-transfer-between-apps-manage-ios).

## I want to customize the apps users can share to on Android devices

On Android work profile and fully managed devices, there are some considerations for controlling which apps your users can share files to (receiving apps). Use managed Google Play to deploy the apps you want to allow data sharing between. Don't deploy other unnecessary apps. For Android work profile devices, users can share files only between apps installed in the work profile.

## Universal links (URLs) in policy-managed apps cannot be opened in Microsoft Edge

If the Microsoft Edge app is not installed on your device, clicking on URLs from policy managed apps won't work. In the case of Android Enterprise WorkProfile scenarios, the app needs to be installed in the WorkProfile region on the device. If the Microsoft Edge app is not present, you will see an error message indicating your organization requires the application to view the link.

- iOS/iPadOS

    :::image type="content" source="media/data-transfer-scenarios/ms-edge-required-message-ios.png" alt-text="The Microsoft Edge Required error message that displays on iOS devices when clicking URLs from policy managed apps.":::

- Android

    :::image type="content" source="media/data-transfer-scenarios/ms-edge-required-message-android.png" alt-text="The Get Microsoft Edge error message that displays on Android devices when clicking URLs from policy managed apps.":::
