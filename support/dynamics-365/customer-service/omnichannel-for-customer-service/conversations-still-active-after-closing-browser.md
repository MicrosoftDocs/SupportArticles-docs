---
title: Active Conversation Isn't Changed to Closed or Wrap-up the Browser Closure
description: Solves an issue encountered in Dynamics 365 Customer Service or Dynamics 365 Contact Center, where active conversations remain unresolved after a browser tab or the entire browser is closed during an ongoing session.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/25/2025
ms.custom: sap:Customer summary and Closed conversation form, DFM
---
# Conversations remain active after an agent closes the browser in Dynamics 365 Customer Service

This article provides a resolution for an issue where active conversations remain **Active** even though an agent closes the browser or browser tab in Dynamics 365 Customer Service or Dynamics 365 Contact Center.

## Symptoms

When an agent closes the browser tab or the entire browser during an active conversation, the following issues might occur:

- The conversation remains active, preventing the agent from continuing or ending the session.
- The user doesn't receive responses within the interface.
- The conversation can't be monitored or closed from the session panel.

## Cause

The issue occurs because the system doesn't detect the disconnection properly, causing the conversation to remain in an **Active** state instead of transitioning to the **Closed** or **Wrap-up** state.

## Resolution

To solve this issue,

1. Ensure the agent closes the conversation in the session panel. This action will transition the conversation from the **Wrap-up** state to the **Closed** state. For more information, see [Manage sessions in the workspace app](/dynamics365/customer-service/use/oc-manage-sessions#close-a-session).

1. Enable reconnection settings to allow users to reconnect to the previous chat session. For more information, see [Configure reconnection to a chat session](/dynamics365/customer-service/administer/configure-reconnect-chat) for detailed instructions.

## More information

- [Understand conversation states in Omnichannel for Customer Service](/dynamics365/customer-service/use/oc-conversation-state)
- [Conversation is stuck in the Wrap-up state](../omnichannel-for-customer-service/conversation-stuck-wrap-up-state.md)
