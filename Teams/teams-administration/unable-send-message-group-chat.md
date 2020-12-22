---
title: Error (Failed to send) when sending messages to a group chat in Microsoft Teams
description: This article provides information to an issue in which a chat creator can't send messages to a group chat if more than 200 members were added to the chat group at once. This is by design.
author: TobyTu
ms.author: kellybos
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom: 
- CI 125835
- CSSTroubleshoot
ms.reviewer: kellybos
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# Error when sending messages to a group chat in Microsoft Teams: Failed to send

The chat creator will receive the following error message if more than 200 members are added to the chat group at once during the creation of the chat:

:::image type="content" source="./media/unable-send-message-group-chat/teams-error.png" alt-text="Screenshot of Teams error":::

This behavior is by design. Group chats can have up to 250 members but a maximum of 200 members can be added at a time.

To avoid this error, add no more than 200 members to the group chat at once.
