---
title: Troubleshoot agent error in Microsoft Teams
description: Learn how to fix the "FlowActionBadRequest" error in Microsoft Teams by updating the agent correctly in Microsoft Copilot Studio.
ms.date: 03/05/2026
ms.reviewer: camogas, erickinser, v-shaywood
ms.custom: sap:Channels
---

# Troubleshoot agent error in Microsoft Teams

This article addresses the `FlowActionBadRequest` error you might encounter in Microsoft Teams when using Copilot Studio. It provides actionable steps to diagnose and resolve the issue related to input/output schema mismatches in flow actions, helping you restore proper agent functionality.

## Symptoms

You might see an error message in Teams when interacting with an agent integrated with Power Automate flows. The following example shows the error message: `FlowActionBadRequest Conversation Id: xxxxxx_rYcg4Z9DFNp_rP-RkQraV5IPMFu-KRlt4UE Time (UTC): 2024-12-02T00:44:24.873Z.`

## Cause

This error happens because of a schema mismatch between the flow's input/output parameters and what the agent expects. This problem often occurs when you update or modify the flow in Copilot Studio but don't refresh or republish the changes properly. As a result, Teams sends or receives unexpected data formats. Null or missing input values can also trigger this error.

## Solution

To resolve the FlowActionBadRequest error, follow these steps:

### Refresh and update the flow in Copilot Studio

The most common cause is that the flow no longer matches the schema expected by the agent. Refresh the flow in Copilot Studio to update the input/output schema:

1. Open the topic that contains the flow in Copilot Studio.

1. Select the three dots (**&hellip;**) of the **Action** node and select **Refresh**.

   :::image type="content" source="media/action-node-refresh.png" alt-text="Screenshot of a topic focusing on an Action node and highlighting the node's Refresh option.":::

1. Verify the input and output parameters in Copilot Studio match the input and output parameters in Power Automate.

1. Save and republish the agent.

### Check for any null input values

If the error persists after refreshing the flow, verify if the input parameters being passed from Copilot Studio agent to the Power Automate flow are valid.

1. Compare input values in Copilot Studio and in Power Automate to identify discrepancies:

:::image type="content" source="media/power-automate-inputs.png" alt-text="Screenshot of a Power Automate flow, highlighting the inputs.":::

:::image type="content" source="media/flow-actions.png" alt-text="Screenshot of the Power Automate flow, highlighting what the agent peforms when the flow is called.":::

1. If any input value is null, add a **Message** action in the flow to capture and return the input values so you can debug and validate what is returned to Teams.

1. Add logic or expressions in the flow to handle null or missing inputs gracefully.

### Refresh the conversation in Teams

There might be situations where Microsoft Teams caches an outdated version of the agent conversation. This error continues to occur even after you perform the previous steps. To refresh the conversation, follow these steps:

1. In the Teams chat with the agent, type the keyword **start over**, **goodbye**, or other phrases that trigger topics to end the conversation.

1. Restart the conversation to load the latest flow version.

### Clear the conversation state

If the previous steps don't resolve the issue, clear the conversation state in Teams:

1. Run the command `/debug clearstate` in the Teams chat with the agent.

1. This command resets the conversation context and forces Teams to reload the agent state.

By following these steps, you can resolve the `FlowActionBadRequest` error and restore normal agent operation in Teams.

## Related content

- [Agent flows overview](/microsoft-copilot-studio/flows-overview)
- [Use input and output variables to pass information](/microsoft-copilot-studio/advanced-flow-input-output)
