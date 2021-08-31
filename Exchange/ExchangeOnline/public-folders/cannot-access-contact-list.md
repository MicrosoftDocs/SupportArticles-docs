---
title: Can't access a contact list from public folder
description: Describes an issue in which you can't access a contact list from a public folder in Outlook.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom:
- CI 155696
- Exchange Online
- CSSTroubleshoot
ms.reviewer: haembab; meerak; batre
appliesto: 
- Exchange Online
search.appverid: MET150
---

# "Out of memory or system resources" error when you access a contact list from a public folder in Outlook

## Symptoms

You have a public folder that contains a contact list in Exchange Server. When you try to access the contact list in Microsoft Outlook in online mode, you receive the following error message:

> Sorry, we're having trouble opening this item. This could be temporary, but if you see it again you might want to restart Outlook. Out of memory or system resources. Close some windows or programs and try again.

:::image type="content" source="media/cannot-access-contact-list/cannot-access-contact-list-error.png" alt-text="Screenshot of the error message.":::

## Cause

There is no specific contacts number limit for a contact list. However, there is a memory limit to allocate on retrieving contact list members properties (such as DisplayName or EmailAddresses) in Exchange Server. If contact list members have long names or email addresses, more memory is required to retrieve the properties in Outlook in online mode. This issue occurs if the memory limit is exceeded.

## Workaround

To work around this issue, use one of the following methods:

### Method 1: Use Outlook on the web to access the contact list

In Outlook on the web, [add the public folder to Favorites](/exchange/collaboration-exo/public-folders/use-favorite-public-folders#add-favorite-public-folders-in-outlook-on-the-web) and then access the contact list.

### Method 2: Use Outlook in Cached Exchange Mode

**Note** Outlook will retrieve the information from the local data file (.ost) in Cached Exchange Mode.

1. [Download public folders in Cached Exchange Mode](https://support.microsoft.com/office/download-public-folders-in-cached-exchange-mode-39807488-8098-4a9c-b246-4c25e3e20510).
1. [Add public folders to Favorites in Outlook](/exchange/collaboration-exo/public-folders/use-favorite-public-folders#add-public-folders-to-favorites-in-outlook) and then access the contact list.

### Method 3: Use the MFCMAPI tool to split the contact list

Use the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi) tool to split the contact list and try to access the list again.

1. Start the MFCMAPI tool.
1. Select **Session** > **Logon**.
1. Double-click **Public Folders**, expand the **IPM_SUBTREE list**, and then double-click the public folder that has the contact list.
1. Select the contact list, and then select **Actions** > **Export message**.
1. Export the contact list in the **MSG file (UNICODE)** format (for example, brokenlist.msg).
:::image type="content" source="media/cannot-access-contact-list/msg-file-format.png" alt-text="Screenshot of exporting contact list with the MSG file format.":::
1. Double-click to open the exported item and edit the contact list, remove some members from the contact list and change its name (for example, splittedlist.msg).
1. Double-click the public folder in the **IPM_SUBTREE** list, and then select **Folder** > **Import** > **From MSG** to import the updated contact list.

To edit the rest of contacts under the contact list, repeat steps 4-7.