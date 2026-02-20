---
title: Agent doesn't show responses in Test your agent
description: Learn how to identify, troubleshoot, and resolve a lack of responses in the Microsoft Copilot Studio Test your agent panel.
ms.date: 02/20/2026
ms.reviewer: 
  - erickinser
ms.custom: sap:Authoring\Agent doesn't show responses in Test your agent
---

# Agent doesn't show responses in Test your agent

This article helps you diagnose and provide a workaround in scenarios where an agent only displays an initial response in the [Test your agent](/microsoft-copilot-studio/authoring-test-bot) panel.

## Symptom

After you add an [existing Copilot Studio agent](/microsof-copilot-studio/add-agent-copilot-studio-agent) or a [Microsoft Fabric Data agent](microsoft-copilot-studio/add-agent-fabric-data-agent), and you interact with the agent in the **Test your agent** panel, the agent shows no further responses after your first interaction. However, you can view messages in the transcript.

## Cause

A corporate firewall or other proxy that performs traffic inspection and filtering might cause the problem. The firewall or proxy might cache the response until the request ends, so it prevents message delivery in real-time.

## Solution

To identify the problem, inspect the Copilot Studio traffic by using the browser's developer tools. Make sure that a `/subscribe` request exists and that it's healthy. In the network tab, you should see a `/subscribe` request triggered after starting a new conversation in the **Test your agent** panel. The `/subscribe` request path should look like the following URL: `https://pvaruntime.{geo}-il{island}.gateway.prod.island.powerapps.com/environment/{EnvironmentId}/{BotId}/test/conversations/{ConversationId}/subscribe`

Set up a firewall allow list or a bypass or exempt rule for the Copilot Studio request path.
