---
title: Outlook search folders aren't populated in Online mode after migration from Exchange 2013 to 2010
description: Describes problems in Outlook after your mailbox is migrated from Exchange Server 2013 or Exchange Online to Exchange Server 2010. These problems involve a missing SEARCH_RUNNING flag. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Rules, search and Printing\Search folders
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: comat
appliesto: 
  - Microsoft Outlook 2010
  - Outlook 2013
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook search folders aren't populated in Online mode after migration from Exchange 2013 to Exchange 2010

_Original KB number:_ &nbsp;3056652

## Symptoms

Assume that your mailbox is migrated from Microsoft Exchange Server 2013 or Exchange Online to Exchange 2010, and your Microsoft Outlook profile is configured in Online mode. In this situation, you may experience one or more of the following symptoms:

- Reminders aren't delivered.
- Flagged items don't appear in the **To-Do** list.
- Items that have an MRM tag don't expire or aren't deleted when the Managed Folder Assistant runs.

## Cause

This issue occurs when the hidden SEARCH_RUNNING flag isn't set on some folders in your mailbox.

## Resolution

To resolve this issue, use the MFCMapi utility to restart the search service for each affected folder. To download MFCMapi, go to [April 2017 Release of MFCMAPI and MrMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).

To configure and use MFCMapi to restart the search service, follow these steps:

1. Start mfcmapi.exe.
2. On the **Tools** menu, click **Options**.
3. Click to enable the option: **Use the MDB_ONLINE flag when calling OpenMsgStore**.
4. On the **Session** menu, click **Logon**.
5. If you're prompted for a profile, select your profile name, and then click **OK**.
6. In the top pane, locate the line that corresponds to your mailbox, and then double-click it.

    Your mailbox will typically be listed by your email address, as shown in the following screenshot.

    :::image type="content" source="media/outlook-search-folders-issue-online-mode/email-address.png" alt-text="Screenshot locating the email address.":::

7. In the navigation pane on the left, expand **Root Container**.
    - For the Reminders issue, right-click the **Reminders** folder, and then select **Edit Search Criteria**.
    - For the To-Do issue, right-click the **To-Do Search** folder, and then select **Edit Search Criteria**.
    - For the MRM issue, right-click the **AllItems** folder, and then select **Edit Search Criteria**.

        For example, the following screenshot shows the **AllItems** folder under **Root Container**.

        :::image type="content" source="media/outlook-search-folders-issue-online-mode/allitems-folder.png" alt-text="Screenshot of the AllItems folder under Root Container.":::

8. In the second **Search State** box, look for the SEARCH_RUNNING value. If you don't see SEARCH_RUNNING, go to the next step.

    :::image type="content" source="media/outlook-search-folders-issue-online-mode/search-running.png" alt-text="Screenshot of the SEARCH_RUNNING value in the second Search State box.":::

9. In the first **Search Flags** box, replace the existing text with the *0x2* value. As soon as you finish typing *0x2*, you'll see the second **Search Flags** box populated with "RESTART_SEARCH," as shown in the following screenshot. Click **OK** at the bottom of the window. This restarts the search service for this folder.

    :::image type="content" source="media/outlook-search-folders-issue-online-mode/search-flags.png" alt-text="Screenshot of the second Search Flags box populated with RESTART_SEARCH after you finish typing 0x2 in the first Search Flags box.":::

## More information

If you do see "SEARCH_RUNNING" in the second **Search State** field when you complete step 8, you're not experiencing the issue that's described in the "Symptoms" section.
