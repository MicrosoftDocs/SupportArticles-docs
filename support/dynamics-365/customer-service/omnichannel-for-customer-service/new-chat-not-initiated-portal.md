---
title: Chat isn't initiated when starting a new chat from the portal
description: Provides a resolution for the issue where chats aren't initiated when starting a new chat from the portal in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: yangao
ms.date: 05/23/2023
---
# Chat isn't initiated when starting a new chat from the portal

This article provides a resolution for the issue where a chat isn't initiated when starting a new chat from the portal in Omnichannel for Customer Service.

## Symptoms

A message that states, "Sorry, we're not able to serve you at the moment," is shown when you start a chat on the portal.

:::image type="content" source="media/new-chat-not-initiated-portal/chat-widget-not-able-serve.png" alt-text="Screenshot that shows the details of the message.":::

## Cause

The issue might occur in the following scenarios:

- Agents aren't configured in the queue.
- The **Allowed Presence** option isn't updated in the workstream: The default workstreams shipped out-of-the-box don't have **Allowed Presence** values.

## Resolution

As an administrator, you need to:

- Check that agents have been added to the queues. For information about adding agents to queues, see [Create queues in Omnichannel admin center](/dynamics365/customer-service/queues-omnichannel?tabs=customerserviceadmincenter#create-a-queue-for-unified-routing).
- For the associated workstream, check that the **Allowed Presence** option has values in the **Work distribution** area. For more information, see [Configure work distribution](/dynamics365/customer-service/create-workstreams#configure-work-distribution).
