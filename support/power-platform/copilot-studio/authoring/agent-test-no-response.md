---
title: Fix Copilot Studio Agent Not Responding in Test Your Agent Panel
description: Resolve unresponsive Copilot Studio agents in the Test your agent panel. Discover how to fix firewall buffering that blocks real-time message delivery.
ms.date: 07/15/2026
ms.reviewer: erickinser, v-shaywood
ms.custom: sap:Authoring
ai-usage: ai-assisted
---

# Agent doesn't respond in the Test your agent panel

## Summary

This article helps you resolve an issue in [Microsoft Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) where an agent stops responding after the first interaction in the [Test your agent](/microsoft-copilot-studio/authoring-test-bot) panel. This issue typically occurs when a corporate firewall or proxy interferes with real-time message delivery by blocking or delaying the connection that Copilot Studio relies on.

## Symptoms

When you interact with the agent in the **Test your agent** panel, you experience the following behavior:

- The agent doesn't respond to user input after the first welcome message.
- Messages appear in the **Activity** tab or conversation transcript but don't appear in the test chat.

This behavior occurs when the agent uses any of the following features:

- Connect to an [existing Copilot Studio agent](/microsoft-copilot-studio/add-agent-copilot-studio-agent)
- [Microsoft Fabric Data agent](/microsoft-copilot-studio/add-agent-fabric-data-agent)
- [Microsoft Foundry agent](/microsoft-copilot-studio/add-agent-foundry-agent)
- [Computer-using agents (CUA)](/microsoft-copilot-studio/computer-use)
- [Agent flows](/microsoft-copilot-studio/advanced-flow)
- Certain connectors
- Other features that rely on the same real-time delivery mechanism

## Cause

Copilot Studio relies on the `/subscribe` API to push messages to the client in real time, which uses Server-Sent Events (SSE). A corporate firewall or proxy that performs traffic inspection and filtering can buffer the response until the request finishes. This buffering prevents real-time message delivery through the `/subscribe` connection that Copilot Studio uses. As a result, the test panel appears unresponsive.

For some firewall products, when you enable HTTPS/TLS traffic inspection, scanning, or filtering for the request, the request can behave as if it failed, because of buffering, even when the request is ultimately allowed.

## Solution

To identify and resolve the issue, follow these steps:

1. Open your browser's developer tools (select <kbd>F12</kbd> or <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>I</kbd>).
1. Select the **Network** tab.
1. Start a new conversation in the **Test your agent** panel.
1. Look for a `/subscribe` request, and check that it's healthy. The request path should resemble the following URL:

   `https://pvaruntime.<Geo>-il<Island>.gateway.prod.island.powerapps.com/environment/<EnvironmentId>/<BotId>/test/conversations/<ConversationId>/subscribe`

1. If the request is healthy, its **Size** column isn't `0` and its **Time** column isn't stuck at **Pending**. Select the request to view messages under the **EventStream** or **Response** tab.
1. If the `/subscribe` request is missing, blocked, or stuck in a pending state, the firewall is likely making the API nonfunctional. To address this, set up a firewall allow, bypass, or exempt rule for the Copilot Studio request path.

For a full list of domains and services that Copilot Studio requires, see [Required services](/microsoft-copilot-studio/requirements-quotas#required-services).

## Related content

- [Understand error codes](error-codes.md)
