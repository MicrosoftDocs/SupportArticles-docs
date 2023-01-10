---
title: Microsoft Teams Channel notifications settings can't be managed
description: Discusses an issue that Microsoft Teams Channel notifications can't be managed by the User notification settings when it's modified.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 121590
  - CSSTroubleshoot
ms.reviewer: kellybos
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 3/31/2022
---

# Microsoft Teams Channel notifications settings can't be managed

## Symptoms

After selecting the option **Reset to Default** in the **Channel notification** setting of Microsoft Teams, the **Channel notification** settings don't reflect changes made in the **User notification** settings.

## Status

Microsoft is researching this problem and will post more information in this article when it becomes available.

## More information

**User notification** settings are the default notifications used by a user's Teams client. When a new team is added or a new channel created, the notifications settings will align to the user's notification settings.

When a user changes the notification setting for a channel, this setting overrides the default user settings.

For example, a newly created or newly added team will have the same **Channel mentions** notification setting set in the user notification settings.

:::image type="content" source="media/notifications-cannot-manage/notifications-setting.png" alt-text="Screenshot that shows the settings page of a newly created team.":::

In this example, the setting overrides the user notification settings for **Channel mentions**.

:::image type="content" source="media/notifications-cannot-manage/default-setting.png" alt-text="Screenshot that shows the default setting page for a team.":::

There's an option to **Reset to default** in the channel notification settings. This will update the settings to mirror the current user settings. If the user notification settings are changed again, the change won't be reflected in the channel notification settings.
