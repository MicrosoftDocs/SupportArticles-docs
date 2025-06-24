---
title: Duplicate Outlook contacts appear in iOS Contacts app
description: Describes a known issue in which duplicate Outlook contacts might appear in the native iOS Contacts app if the Save Contacts setting is enabled.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - CI 144749
  - Outlook for iOS
  - CSSTroubleshoot
ms.reviewer: dlaughli
appliesto: 
  - Outlook for iOS
search.appverid: MET150
ms.date: 01/24/2024
---
# Duplicate Outlook contacts appear in iOS Contacts app

If the **[Save Contacts](https://support.microsoft.com/office/outlook-for-ios-and-android-faq-65a01e26-e3c2-4067-bd05-0db6220e5c34#bkmk_savecontacts)** setting is enabled in Outlook for iOS, duplicate Outlook contacts might appear in the native iOS Contacts app on your device. This issue tends to occur frequently if you have a large list of contacts.

Your Outlook contacts might be affected by this issue if the following conditions are true:

- The **[Save Contacts](https://support.microsoft.com/office/outlook-for-ios-and-android-faq-65a01e26-e3c2-4067-bd05-0db6220e5c34#bkmk_savecontacts)** setting is enabled for your Outlook account.

- The **Save Contacts** setting is enabled on multiple iOS devices, such as an iPad and an iPhone.

    If you have multiple iOS devices, we recommend that you [use an iCloud account to sync your contacts](https://support.microsoft.com/office/how-do-i-save-my-contacts-to-my-device-0c914099-a1a5-4ae3-93d6-f9c85465dc9a) across the devices instead of enabling the **Save Contacts** setting on individual devices.

- Duplicate contacts don't appear when you search for them in the Outlook app by using **Search** > **People**. They appear only in the native iOS Contacts app.

- Duplicate contacts appear in only iOS clients and not in other Outlook clients, such as Outlook on the web and Outlook.com.

- Duplicates appear for Outlook contacts only and not for contacts created outside Outlook.

    In the iOS Contacts app, when you open a contact that was created from Outlook, you see the "Outlook ms-outlook://people/\<account>" field that's shown in the following screenshot.

    :::image type="content" source="media/duplicate-contacts-in-ios-contacts-app/outlook-contact.png" alt-text="Screenshot of the contact info that's created from Outlook.":::

## Why Outlook contacts are duplicated

Because of the current design of iOS and the contact synchronization feature in Outlook for iOS, syncs often don't finish. The sync process cannot run continuously in the background to ensure a consistent steady state. This causes sync errors. Over time, the accumulated errors cause duplicate contacts to be created.

The process to export contacts begins only when Outlook is in the foreground. It continues while Outlook is in active memory, even if the user switches between apps. Because of [limitations in iOS](https://www.microsoft.com/microsoft-365/blog/2017/06/05/improving-people-in-outlook-for-ios-and-android/) when syncing with iCloud, the process might not finish and this situation can cause data inconsistencies. When Outlook detects these inconsistencies the next time that it syncs, it triggers a reconciliation to remove duplicate contacts that are exported from a previous export activity. If the reconciliation also doesn't finish, you might still see duplicate contacts. In this case, you can remove the duplicates manually.

## Remove duplicates manually

To remove duplicate Outlook contacts, do the following:

1. Disable the **Save Contacts** setting for the affected mail account.
2. Verify that all Outlook contacts have been removed from the iOS Contacts app for the affected account. If duplicate contacts remain, do the following:

    1. Navigate to **Settings** > **Help & Feedback** > **Delete All Saved Contacts**.
    1. Select **Delete** to remove all duplicate contacts.
    1. Verify that the duplicate contacts are deleted from the iOS Contacts app.

3. Re-enable the **Save contacts** setting for the affected account. You might be prompted to keep the phone on and plugged in during the sync process.

**Note:** Although these steps successfully remove the duplicate contacts, the issue might reoccur if you have a large list of contacts. If the issue does reoccur, you will have to repeat these steps for each occurrence of the issue.

## Status

The resolution steps in this article provide the only available help for this issue until better sync support is available in iOS.
