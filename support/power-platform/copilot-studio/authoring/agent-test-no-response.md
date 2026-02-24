---
title: Fix agent not responding in Test your agent panel
description: Resolve an issue that makes Microsoft Copilot Studio agents unresponsive in the Test your agent panel, and learn how to fix connection problems.
ms.date: 02/24/2026
ms.reviewer: erickinser, v-shaywood
ms.custom: sap:Authoring\Agent doesn't show responses in Test your agent
---

# Agent doesn't respond in the Test your agent panel

## Summary

This article helps you resolve an issue in [Microsoft Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) in which an agent stops responding after the first interaction in the [Test your agent](/microsoft-copilot-studio/authoring-test-bot) panel. This issue typically occurs when a corporate firewall or proxy interferes with real-time message delivery by blocking or delaying the connection that Copilot Studio relies on.

## Symptoms

After you add an [existing Copilot Studio agent](/microsoft-copilot-studio/add-agent-copilot-studio-agent) or a [Microsoft Fabric Data agent](/microsoft-copilot-studio/add-agent-fabric-data-agent), and you interact with the agent in the **Test your agent** panel, you experience the following behavior:

- The agent doesn't respond after the first interaction.
- Messages appear in the conversation transcript but don't appear in the test chat.

## Cause

A corporate firewall or proxy that performs traffic inspection and filtering can cause this issue. The firewall or proxy caches the response until the request finishes. This caching prevents real-time message delivery through the `/subscribe` connection that Copilot Studio uses.

## Solution

To identify and resolve the issue, follow these steps:

1. Open your browser's developer tools (select <kbd>F12</kbd> or <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>I</kbd>).
1. Select the **Network** tab.
1. Start a new conversation in the **Test your agent** panel.
1. Look for a `/subscribe` request, and check that it's healthy. The request path should resemble the following URL:

   `https://pvaruntime.{geo}-il{island}.gateway.prod.island.powerapps.com/environment/{EnvironmentId}/{BotId}/test/conversations/{ConversationId}/subscribe`

1. If the `/subscribe` request is missing, blocked, or stuck in a pending state, set up a firewall allow list, bypass, or exempt rule for the Copilot Studio request path.

For a full list of domains and services that Copilot Studio requires, see [Required services](/microsoft-copilot-studio/requirements-quotas#required-services).

## Related content

- [Understand error codes](error-codes.md)
