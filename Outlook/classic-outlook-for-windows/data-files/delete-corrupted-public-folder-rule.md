---
title: Can't access the Folder Assistant in Outlook
description: Use the MFCMAPI tool to delete corrupted public folder rules that prevent you from accessing the Folder Assistant to manage rules in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Rules, search and Printing\Error saving rules
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 162470
ms.reviewer: ezurita, batre
appliesto: 
  - Outlook 2016
  - Outlook 2019
  - Outlook for Microsoft 365
  - Outlook LTSC 2021
search.appverid: MET150
ms.date: 08/13/2024
---
# Can't access the Folder Assistant in Outlook

If you can't access the Folder Assistant to manage the rules for a public folder in Microsoft Outlook, it's possible that one or more of the rules are corrupted.

To resolve this issue, use the MFCMAPI tool to find and delete the corrupted rules.

## Delete a corrupted rule

1. Download the latest version of the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) tool.
1. Start the MFCMAPI tool, and then select **Tools** > **Options**.
1. Select the **Force the use of Outlook's MAPI files** check box, and then select **OK** to save the change.
1. On the **Session** menu, select **Logon**. If you receive an error message, select **OK** to load the public folder store.
1. Expand **Root Container** > **IPM_Subtree**.  
1. Right-click the affected public folder, and then select **Open associated contents table**.

1. Select the **Message Class** column header to sort the contents of the table by message class, and find the messages that display **IPM.Rule.Version2.Message** as the message class. These messages correspond to each rule that has been configured for the public folder.

1. For each message that has the **IPM.Rule.Version2.Message** message class, check the properties in the pane beneath it. Find the messages for which the **Properties** pane displays **cb: 0** in the **Value** column for the **PR_EXTENDED_RULE_MSG_CONDITION** and **PR_EXTENDED_RULE_MSG_ACTIONS** properties. Additionally, these properties might display **PT_ERROR** in the **Type** column and **0x0E9A000A** in the **Tag** column. These properties indicate a corrupted rule.

    :::image type="content" source="media/delete-corrupted-public-folder-rule/corrupted-rule.png" alt-text="Screenshot of messages that have properties that show a value of 'cb: 0' or an error in MFCMAPI.":::

1. For each message whose properties indicate a corrupted rule, right-click the message, and select **Delete Message** to delete the corrupted rule.

After the corrupted rules are deleted, try to access the Folder Assistant again.

If you're unable to identify the corrupted rule, or if the issue persists after deleting corrupted rules, follow the same steps to delete all the rules and then access the Folder Assistant again. 

Alternatively, you can use [Exchange Transport Rules](/exchange/security-and-compliance/mail-flow-rules/mail-flow-rules) to manage public folder rules. 
