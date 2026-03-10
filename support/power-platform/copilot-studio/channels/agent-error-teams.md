---
title: FlowActionBadRequest Error Fix for Agents
description: Resolve the FlowActionBadRequest error in channels, such as Microsoft Teams, by fixing schema mismatches in Power Automate flows and republishing your Copilot Studio agent.
ms.date: 03/09/2026
ms.reviewer: camogas, erickinser, v-shaywood
ms.custom: sap:Channels\Microsoft Teams
ms.collection: CEnSKM-ai-copilot
---

# FlowActionBadRequest agent error in channels

## Summary

This article helps you resolve the `FlowActionBadRequest` error that occurs in channels, such as Microsoft Teams, when a [Microsoft Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) agent calls a [Power Automate flow](/microsoft-copilot-studio/advanced-flow). The error typically results from input or output schema mismatches in flow actions.

## Symptoms

When you interact with a Copilot Studio agent that's integrated with Power Automate flows in channels such as Microsoft Teams, you see the following error message:

`FlowActionBadRequest Conversation Id: xxxxxx_rYcg4Z9DFNp_rP-RkQraV5IPMFu-KRlt4UE Time (UTC): 2024-12-02T00:44:24.873Z.`

## Cause

This error happens because of a schema mismatch between the flow's input or output parameters and what the agent expects. It often occurs when you modify the flow in Copilot Studio but don't refresh or republish the changes. As a result, Teams sends or receives unexpected data formats. Null or missing input values can also trigger this error.

## Solution

### Refresh and update the flow in Copilot Studio

The most common fix is to refresh the flow in Copilot Studio so the input and output schema matches the agent:

1. Open the topic that contains the flow in Copilot Studio.

1. Select the ellipsis (**...**) on the **Action** node, and then select **Refresh**.

   :::image type="content" source="media/agent-error-teams/action-node-refresh.png" alt-text="Screenshot of a topic focusing on an Action node and highlighting the node's Refresh option.":::

1. Verify that the input and output parameters in Copilot Studio match the parameters in Power Automate.

1. Save and republish the agent.

### Check for any null input values

If the error persists after you refresh the flow, verify that the input parameters passed from the Copilot Studio agent to the Power Automate flow are valid.

1. Compare input values in Copilot Studio and in Power Automate to identify discrepancies:

   :::image type="content" source="media/agent-error-teams/power-automate-inputs.png" alt-text="Screenshot of a Copilot Studio Action node, highlighting the Power Automate inputs.":::

   :::image type="content" source="media/agent-error-teams/flow-actions.png" alt-text="Screenshot of the Power Automate flow, highlighting what the agent performs when the flow is called.":::

1. If any input value is null, add a **Message** action in the flow to capture and return the input values. This step helps you debug and validate what's returned to Teams.

1. Add logic or expressions in the flow to handle null or missing inputs.

### Refresh the conversation in Teams

Microsoft Teams sometimes caches an outdated version of the agent conversation. This caching can cause the error to persist even after you complete the previous steps.

1. In the Teams chat with the agent, enter **start over**, **goodbye**, or another phrase that triggers the end-of-conversation topic.

1. Start a new conversation to load the latest flow version.

### Clear the conversation state

If the previous steps don't resolve the issue, clear the conversation state in Teams:

- In the Teams chat with the agent, enter `/debug clearstate` to reset the conversation context and force Teams to reload the agent state.

## Related content

- [Agent flows overview](/microsoft-copilot-studio/flows-overview)
- [Use input and output variables to pass information](/microsoft-copilot-studio/advanced-flow-input-output)
- [Understand error codes](../authoring/error-codes.md)
