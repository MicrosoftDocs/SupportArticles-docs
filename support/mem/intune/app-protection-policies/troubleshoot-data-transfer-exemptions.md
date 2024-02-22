---
title: Troubleshooting exemptions to data transfer policies
description: Troubleshooting guidance for scenarios when an exemption to Microsoft Intune app protection policies (APP) doesn't work as expected.
ms.date: 12/05/2023
ms.reviewer: chauntain, roblane-msft, kkreh
search.appverid: MET150
---
# Troubleshooting exemptions to data transfer policies

This article gives troubleshooting guidance for scenarios where an exemption to a Microsoft Intune app protection policy (APP) doesn't work as intended. While data transfer settings enable you to limit the transfer of corporate data to Intune APP-managed apps, there may be scenarios where you want to allow users to transfer data to unmanaged apps. An example scenario would include when you wish to allow one of your managed applications to pass data to an unmanaged calendar app your users use. In this situation, a data transfer exception, or more commonly called an exemption, may be necessary.

> [!WARNING]
> You're responsible for making changes to the data transfer exception policy. Additions to this policy allow unmanaged apps (apps that are not managed by Intune) to access data protected by managed apps. This access to protected data may result in data security leaks. Only add exemptions for non-Intune managed apps that your organization must use, but do not support Intune APP. Additionally, only add exemptions for apps that you do not consider to be data leak risks.

When you have configured app exemptions, or universal link exemptions, you may run into a scenario where you're still unable to transfer data from your managed app to your exempted, unmanaged apps. In such scenarios, use the troubleshooting steps in this article to help diagnose and resolve the issue. For more information, see [Troubleshooting data transfer between apps](troubleshoot-data-transfer.md).

## Confirm the behavior you're testing

Data can be transferred between applications on both iOS and Android in multiple ways. That's why it's important to understand what an exemption affects.

- **Scenario:** You've exempted an unmanaged app but still can't copy and paste data from a managed app to your unmanaged app.

  - Cut, copy, and paste restrictions can't have exemptions and are separate from "send org data to other app" restrictions.

- **Scenario:** You've exempted an unmanaged app but still don't see it as a sharing option within your managed app.

  - Use the **Select apps to exempt** setting to transfer data between using the operating system's (OS) "Share" functionality.
  - For this scenario, continue onto the [Confirm the apps support data sharing](#confirm-the-apps-support-data-sharing) section of this document.

- **Scenario:** The unmanaged app shows up in the managed app's shared menu, but data isn't successfully transferred to the unmanaged app.

  - Review the "Confirm that the managed application supports sharing data to the targeted unmanaged app." section. If the problem persists, speak to the app developer (of the sending app) about integration with Intune App SDK. For more information about SDK integration, see the Intune App SDK Developer Guides.
    - [Intune App SDK for iOS Developer Guide](/mem/intune/developer/app-sdk-ios)
    - [Intune App SDK for Android Developer Guide](/mem/intune/developer/app-sdk-android)

- **Scenario:** You've exempted an unmanaged app but are unable to use the iOS "Open-in" functionality to open data in your unmanaged app.

  - Data transfer exemptions don't apply to iOS Open-In functionality. For more information about iOS Open-In functionality, see [Use app protection with iOS apps](/mem/intune/apps/data-transfer-between-apps-manage-ios#use-open-in-management-to-protect-ios-apps-and-data).

## Confirm the apps support data sharing

Several apps and services are exempted by default. To learn more about these apps, see [iOS/iPadOS app protection policy settings - Data transfer exemptions](/mem/intune/apps/app-protection-policy-settings-ios#data-transfer-exemptions) and [Android app protection policy settings - Data transfer exemptions](/mem/intune/apps/app-protection-policy-settings-android#data-transfer-exemptions).

Verify that the managed app that you're trying to send data from supports sending data to the receiving unmanaged app. If the sending app doesn't support sending data to the unmanaged app, then exempting the app won't change that behavior. For example, Microsoft Word can't send a text document to a music streaming app.

Determine whether the data transfer is possible by ensuring both apps aren't being managed by Intune and then testing the data transfer between them. Also, check the documentation provided by each apps' developer to confirm what data sharing options are supported.

Ensure that the receiving app not only shows up in the share menu, but also that a transfer can successfully occur when both apps are unmanaged.

## Confirm that the apps to exempt are formatted correctly for the OS type

App exemption policy is handled differently between iOS and Android due to the different methods that the operating systems handle their share functionality. If your app exemptions aren't the correct form for the respective OS, they won't work. Browse the Google Play store to find the package ID of an app. The package ID is contained in the URL of the app's page. Check the documentation provided by the developer of the app to find information about supported URL protocols for iOS apps. The following table provides example URL data applicable to your OS type for Microsoft Word.

|Operating system   |App to exempt   |Value type   |Value   |
|------------|-----|------|-----------------|
|Android|Microsoft Word|App Package ID|com.microsoft.office.word|
|iOS|Microsoft Word|URL protocol|ms-word|

## Verifying universal links to exempt (iOS)

While the URL protocol for iOS may be used to transfer data between apps, iOS also supports universal links to allow the user to directly launch an application associated with a web address instead of a protected browser specified by the **Restrict web content transfer with other apps** setting. For example, if a user is sent a link to a OneDrive file, when they select the link, the file opens in the OneDrive app on their device rather than on a browser window. For more information about universal link exemptions, see [iOS settings, Universal links](/mem/intune/apps/app-protection-policy-settings-ios#universal-links). Note, if you've configured the **App protection policy** > **Restrict web content transfer with other apps** settings to either "Microsoft Edge" or "Unmanaged browser," you may need to manually configure the universal links to exempt.

- **Scenario:** You've configured **Restrict web content transfer with other apps** and have added a URL into the **Exempt universal link** setting list, but the browser is still being launched when you select a link.

  - Verify with the app developer to determine the correct universal link for their application.
  - Ensure that the app is installed on the device.
  - Confirm that the formatting of the link in your application matches the formatting provided by the app developer.
