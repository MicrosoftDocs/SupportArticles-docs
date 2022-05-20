---
title: Delete corrupted public folder rules
description: Use the MFCMAPI tool to delete public folder corrupted rules that prevent you from accessing the Folder Assistant to manage the rules in Outlook.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 162470
ms.reviewer: ezurita, batre
appliesto: 
  - Outlook 2016
  - Outlook 2019
  - Outlook for Office 365
  - Outlook LTSC 2021
search.appverid: MET150
ms.date: 5/12/2022
---
# Can't access Folder Assistant in Outlook

If you're unable to access the Folder Assistant to manage the rules for a public folder in Microsoft Outlook, it might be because one of the rules is corrupted.

To resolve this issue, use the MFCMAPI tool to find and delete the corrupted rules.

## Solution: Delete a corrupted rule

1. Download the latest version of the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) tool.
1. Start the MFCMAPI tool, and then select **Tools** > **Options**.
1. Select the **Force the use of Outlook's MAPI files** check box, and then select **OK** to save the change.
1. On the **Session** menu, select **Logon**. If you receive an error, select **OK** to load the public folder store.
1. Expand **Root Container** > **IPM_Subtree**.  
1. Right-click the affected public folder, and then select **Open associated contents table**.

1. Select the **Message Class** column header to sort the contents of the table by message class, and find the messages that display **IPM.Rule.Version2.Message** as the message class. These set of messages correspond to each rule that has been configured for the public folder.

1. For each message with the **IPM.Rule.Version2.Message** message class, check the properties in the pane below. Find the messages for which the Properties pane displays **cb: 0** in the **Value** column for the **PR_EXTENDED_RULE_MSG_CONDITION** and **PR_EXTENDED_RULE_MSG_ACTIONS** properties. Additionally, these properties might display **PT_ERROR** in the **Type** column and **0x0E9A000A** in the **Tag** column. This information in the Properties pane for a message indicates a corrupted rule.

    :::image type="content" source="media/delete-corrupted-public-folder-rule/corrupted-rule.png" alt-text="Screenshot of the messages that have the properties with the empty value in MFCMAPI.":::

1. For each message whose properties indicate a corrupted rule, right-click the message, and select **Delete Message** to delete the corrupted rule.

After the corrupted rules are deleted, try to access the Folder Assistant again.
