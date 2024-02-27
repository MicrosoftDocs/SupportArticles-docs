---
title: Unknown is shown in group name when expanding
description: Provides a resolution for the issue that the text <unknown> is shown when you try to expand a contact group in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, gbratton
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# You can't expand a nested contact group and Unknown is displayed in the group name in Outlook

_Original KB number:_ &nbsp; 4293589

## Symptoms

In Microsoft Outlook, you try to expand a contact group in a public folder that contains a nested contact group. However, the contact group doesn't expand, and the text **\<Unknown>** appears at the end of the group name.

:::image type="content" source="media/cannot-expand-nested-contact-groups-unknown-shown/unknown-shown-for-nested-contact-group.png" alt-text="Screenshot of email address bar in Outlook when you expand two contact groups and the text Unknown appears at the end of the group name.":::

## Resolution 
  
### Method 1

To resolve this issue, right-click the Contact folder in the Public Folder, and then select **Properties**. On the Outlook **Address Book** tab, select the **Show this folder as an email address book** option.
  
### Method 2
  
1. Open the contact group, and select **Update now**. If there are members that can't be found, Outlook will prompt you to select one of the following options:
  
  - Remove the lost members.
  - Try to repair the lost members and remove only those that cannot be resolved.
  - Cancel this operation and do not change any members.
 
2. Select **Try to repair the lost members and remove only those that cannot be resolved**, and then select **OK**.

## More information

A similar issue occurs if another user adds a contact group from their own contacts to the public folder contact group, and then a different user tries to send an email message to that contact group. This scenario is not resolved by the **Show this folder as an email address book** option.
