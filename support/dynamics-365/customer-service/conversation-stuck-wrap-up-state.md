---
title: Conversation stuck in wrap-up state
description: Provides a solution to issue when a conversation is stuck in a wrap-up state in Dynamics 365 Omnichannel for Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
---

# Conversation is stuck in wrap-up state

This article provides a solution to an issue when a conversation is stuck in a wrap-up state in Omnichannel for Customer Service.

## Issue

As an agent or a supervisor, you see that some conversations are stuck in the wrap-up state in your Omnichannel Agent Dashboard or Omnichannel Ongoing Conversations Dashboard.

## Cause

The primary agent assigned to the conversation may not have closed it in the session panel.

## Resolution

When conversations are ended by the agent or customer, they transition to the wrap-up state. In order to close the conversation, the primary agent assigned to the conversation needs to close the conversation in the session panel. To learn more about closing sessions, see [Manage sessions in Omnichannel for Customer Service](./oc-manage-sessions.md#close-a-session). To learn more about the wrap-up conversation state, see [Understand conversation states in Omnichannel for Customer Service](./oc-conversation-state.md#wrap-up).
