---
title: Chat isn't initiated when starting a new chat from portal
description: Provides a solution for when chats aren't initiated when starting a new chat from the portal in Omnichannel for Customer Service .
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Chat isn't initiated when starting a new chat from portal

This article provides a solution to an issue where Chat isn't initiated when starting a new chat from the portal in Omnichannel for Customer Service.

## Symptom

A message stating, "Sorry, we're not able to serve you at the moment" is shown to the customers when they start a chat on the portal. 

## Cause

The issue might be caused by one of the following scenarios:

- Agents aren't configured in the queue.
- Allowed Presence is not updated in the work stream: The default work streams that are shipped out-of-the-box don't have **Allowed Presence** values in the workstream.

   > [!div class=mx-imgBorder]
   > ![Sorry, we are not able to serve you at this moment message on portal chat widget.](media/chat-widget-not-able-serve.png "Sorry, we are not able to serve you at this moment")

## Resolution

As an administrator, make sure of the following details:

- Check that agents have been added to the queues. For information on adding agents to queues, see [Create queues in Omnichannel admin center](queues-omnichannel.md#create-a-queue-for-unified-routing)

- For the associated workstream, check that the **Allowed Presence** option has values in the **Work distribution** area. More information: [Configure work distribution](create-workstreams.md#configure-work-distribution)
