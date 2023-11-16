---
title: Error (Failed to send) when sending messages to a group chat in Microsoft Teams
description: This article provides information to an issue in which a chat creator can't send messages to a group chat if more than 200 members were added to the chat group at once. This is by design.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 125835
  - CSSTroubleshoot
ms.reviewer: kellybos
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Error when sending messages to a group chat in Teams: Failed to send

In Microsoft Teams, the chat creator receives the following error message if more than 200 members are added concurrently to a group chat:

> Failed to send

:::image type="content" source="./media/unable-send-message-group-chat/teams-error.png" alt-text="Screenshot that shows the Teams Failed to send error message.":::

This behavior is by design. Although group chats can have up to 250 members, no more than 200 members can be added at the same time.

