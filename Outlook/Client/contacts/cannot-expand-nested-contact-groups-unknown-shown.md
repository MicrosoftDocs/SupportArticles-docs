---
title: Unknown is shown in group name when expanding
description: Provides a resolution for the issue that the text <unknown> is shown when you try to expand a contact group in Microsoft Outlook.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
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
- Outlook for Office 365
search.appverid: MET150
---
# You can't expand a nested contact group and Unknown is displayed in the group name in Outlook

_Original KB number:_ &nbsp; 4293589

## Symptoms

In Microsoft Outlook, you try expand a contact group in a public folder that contains a nested contact group. However, the contact group does not expand, and the text **\<Unknown>** appears at the end of the group name.

:::image type="content" source="media/cannot-expand-nested-contact-groups-unknown-shown/unknown-shown-for-nested-contact-group.png" alt-text="Nested Contact Group":::

## Resolution

To resolve this issue, right-click the Contact folder in the Public Folder, and then select **Properties**. On the Outlook **Address Book** tab, select the **Show this folder as an email address book** option.

## More information

A similar issue occurs if another user adds a contact group from their own contacts to the public folder contact group, and then a different user tries to send an email message to that contact group. This scenario is not resolved by the **Show this folder as an email address book** option.
