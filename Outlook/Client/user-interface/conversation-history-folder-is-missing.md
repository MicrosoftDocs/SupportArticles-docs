---
title: Conversation History folder is missing in Outlook
description: Describes an issue that causes the Outlook Conversation History folder to go missing. A resolution is provided.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Conversation view
  - CSSTroubleshoot
appliesto:
- Skype for Business
- Microsoft Lync 2013
- Lync 2010
search.appverid: MET150
ms.reviewer: tasitae, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Conversation History folder is missing in Outlook

## Symptoms

Scenario 1

There is no the **Conversation History** folder in Microsoft Outlook.

Scenario 2

The **Conversation History** folder is stored as a subfolder in the **Inbox** folder, and you cannot move the **Conversation History** folder to its original location.

## Resolution

To resolve this issue, recreate the Conversation History folder. To do this, follow these steps:

1. Exit Outlook on all the devices that connect to the user mailbox.
2. Download [MFCMAPI](https://github.com/stephenegriffin/mfcmapi).
3. Run MFCMAPI.exe.
4. On the **Tools** menu, select **Options**.
5. Enable the following option:

    **Use MDB_ONLINE when calling OpenMsgStore**

6. Select **OK**.
7. On the **Session** menu, select **Logon**.
8. If you are prompted for a profile, select the profile name for your mailbox, and then select **OK**.
9. In the top pane, double-click the line that corresponds to your mailbox.
10. In the navigation pane (on the left), expand **Root Container** > **Top of Information Store**.
11. Select **Inbox**.
12. In the **Tag** column, locate **0x35E90102**. This is the **Conversation History** folder EntryId.

13. Delete this line item, and then close MFCMAPI. When Skype For Business or Lync notices that the **Conversation History** folder EntryId is deleted, it will recreate the **Conversation History** folder.
