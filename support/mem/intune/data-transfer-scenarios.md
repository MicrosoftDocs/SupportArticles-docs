---
title: Common issues when using Intune app protection policies to control data transfer
description: Learn how to diagnose and troubleshoot some common issues and misconfigurations when using Microsoft Intune app protection policies (APP) to control data transfer.
ms.date: 04/12/2022
ms.reviewer: roblane-msft
---
# Common data transfer issues and scenarios

This article gives troubleshooting checks for common scenarios in which data transfer is not restricted as expected with Intune app protection policies (APP). For general troubleshooting guidance related to data transfer and Intune APP, see [Troubleshooting data transfer between apps](troubleshoot-data-transfer.md).

## User can transfer corporate files, or copy/paste corporate data, to unmanaged apps

In this scenario, a user can unexpectedly transfer corporate files to unmanaged apps or copy and paste data from a corporate document to unmanaged apps.

- Check the **Send org data to other apps** setting value in both the Microsoft Endpoint Manager admin center and on the device side using Microsoft Edge. If it is set to **All apps**, users can transfer files to any apps. For instructions, see [Link to section in other article: Confirm the expected app protection policy settings are applied to the apps].

- Confirm that the user is working with corporate accounts and corporate data. Personal accounts and data are not protected by app protection policies. Office files such as Word, Excel, and PowerPoint files are not treated as corporate data unless they are saved to managed locations such as OneDrive for Business.

## User can receive files from unmanaged apps

In this scenario, a user can unexpectedly receive files from unmanaged apps. Files can be inserted from Camera/OneDrive for Business/SharePoint.

- Check the **Receive data from other apps** setting value in both the Microsoft Endpoint Manager admin center and on the device side using Microsoft Edge. If it is set to **All apps**, users can transfer files from any apps. For instructions, see [Link to section in other article: Confirm the expected app protection policy settings are applied to the apps].

- Also, check the setting values for  **Open data into Org documents** and **Allow users to open data from selected services** to restrict the data source you block/allow. Currently, you cannot control **Camera** and **Photo Library** data sources separately.

    :::image type="content" source="media/data-transfer-scenarios/open-data-from-services.png" alt-text="Dropdown options for 'Allow users to open data from selected services' in the admin center.":::

## User can transfer files to unmanaged apps even if data transfer if restricted

In this scenario, a user can transfer files to policy unmanaged apps even though you have set **Send org data to other apps** to ‘Policy managed apps’.

- Check the **Select apps to exempt** setting value and make sure the receiver app is not set as a data transfer exemption.

    :::image type="content" source="media/data-transfer-scenarios/select-apps-to-exempt.png" alt-text="Image showing the 'Select apps to exempt' option under 'Send org data to other apps'.":::

- If the file is still encrypted once transferred to unmanaged apps, this is expected behavior as explained in [Confirm the data is encrypted once files are transferred](troubleshoot-data-transfer.md#confirm-the-data-is-encrypted-once-files-are-transferred). The files are encrypted and cannot be opened with unmanaged apps.

## Users can save corporate files to local storage when it should be blocked

In this scenario, a user can save files to local storage even though **Save copies of org data** is set to 'Block'. Like the previous scenario, this is also expected behavior as long as the saved files are encrypted. Some apps implement data sharing with the Files app. In this case you can transfer corporate data to Files app.

## TO DO: The policy is applied, but iOS users can still transfer work files to unmanaged apps

Add this in after review (and delete from original article)

## I want to customize the apps available in the iOS Share extension

A common scenario admins want to apply is to filter the list of apps displayed in the iOS Share extension (receiver apps) to prevent data transfer to unmanaged apps. There are two methods to control which apps are available in the share extension. You can combine both methods if you are using Intune mobile device management (MDM).

### Option A: Restrict sharing for Intune-managed devices

- Set the MDM device restriction setting **Block viewing corporate documents in unmanaged apps** to 'Yes'.
- Use Intune MDM to deploy the apps you want to allow data sharing between.
- Do not deploy other apps and instead have your users install them from the Apple App Store.

With this configuration, only MDM managed apps are displayed in the sharing extension if the sender app is MDM managed. Here is an example how apps in the sharing extension change with the MDM setting. In this example the Teams app is not deployed with Intune, so the app is not displayed in the share extension.

:::image type="content" source="media/data-transfer-scenarios/block-viewing-corporate-docs.png" alt-text="Side-by-side screenshots showing the different options for apps you can use to open a document, before and after applying the MDM setting.":::

### Option B: Restrict sharing for unenrolled devices

- Set the app protection setting **Send org data to other apps** to 'Policy managed app with Open-In/Share filtering'.

With this configuration, the share extension is filtered to show only apps that support Intune APP. This method can be used for [Application management without enrollment scenario](/mem/intune/fundamentals/deployment-guide-enrollment-mamwe). The following example shows how available apps in the share extension will change once you set the policy setting to **Policy managed app with Open-In/Share filtering**. In this example, the Dropbox app is not displayed in the share extension because it does not support Intune APP. Also, the **Save to Files** option is filtered out to prevent data transfer using the local Files app.

:::image type="content" source="media/data-transfer-scenarios/send-data-to-other-apps.png" alt-text="Side-by-side screenshots showing the different options for apps you can send a file to, before and after applying the MDM setting.":::

For more information, see [How to manage data transfer between iOS apps in Microsoft Intune](/mem/intune/apps/data-transfer-between-apps-manage-ios).

## I want to customize the apps users can share to on Android devices

On Android work profile and fully managed devices, there are some considerations for controlling which apps your users can share files to (receiver apps). For fully managed devices, use managed Google Play to deploy the apps you want to allow data sharing between. Do not deploy other apps with Intune MDM. For Android work profile devices, users can share files only between apps installed in the work profile.

## Users can install and share to unapproved Google Play apps

In this scenario, users are manually installing unapproved apps from Google Play to Android Enterprise fully managed devices, and they can share files to the apps.

Check the MDM device restriction setting **Allow access to all apps in Google Play store**. If you do not want to explicitly allow app installation, it should be set to Not configured, which is the default value. If the setting is set to Allow, users can install any apps using managed Google Play and use them on fully managed devices.

:::image type="content" source="media/data-transfer-scenarios/allow-access-to-google-play.png" alt-text="Image showing the option 'Allow access to all apps in Google Play store' in the admin center":::

## Universal links in policy-managed apps are opened in an app instead of Microsoft Edge

In this scenario, if a user selects a universal link, it opens in an unmanaged app instead of the protect browser, Microsoft Edge. For more information on this topic, see [iOS app protection policy settings](/mem/intune/apps/app-protection-policy-settings-ios).

- Check that the **Restrict web content transfer with other apps** dropdown setting is set to 'Microsoft Edge'.

- Check if the link addresses are listed in the **Select universal links to exempt** and **Select managed universal links settings**. The universal links specified in these lists can be opened with other apps instead of Microsoft Edge. Remove the links from these lists to open the universal links with Microsoft Edge.

    :::image type="content" source="media/data-transfer-scenarios/universal-link-settings.png" alt-text="Image showing the 'Send org data to other apps' settings, which includes two universal link settings to review.":::

## Universal links in policy managed apps are unexpectedly opened in Microsoft Edge

This scenario is the opposite of the previous scenario: you want a universal link to open in the corresponding, managed app but instead it opens in Microsoft Edge.

- Check if the links are listed in the **Select universal links to exempt** and **Select managed universal links** settings. If not, add them so they will open in the specified app.
