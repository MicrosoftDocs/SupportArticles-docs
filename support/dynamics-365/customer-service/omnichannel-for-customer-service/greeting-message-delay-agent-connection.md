---
title: Voice call greeting messages delay connection between agents and customers
description: Resolves an issue where voice call greeting messages delay a representative's ability to connect to a customer in the voice channel in Omnichannel for Customer Service.
ms.reviewer: laalexan
ms.author: srubinstein
ms.date: 12/12/2024
ms.update-cycle: 180-days
ms.custom: sap:Voice channel
ms.collection: CEnSKM-ai-copilot
---
# Incoming voice calls with long greeting messages cause connection delays

This article provides a solution to an issue where Omnichannel for Customer Service voice calls that are configured with a greeting message cause a connection delay between the customer service representative and the customer.

## Symptoms

As a service representative or supervisor, you notice that incoming voice calls that are configured with a greeting message experience a delay before the service representatives can connect to their customers.

## Cause

After [setting up a greeting message for a channel](/dynamics365/customer-service/administer/configure-automated-message), the call is intended to transfer to a service representative after the greeting message ends for the customer. However, in some cases, the call is transferred to the representative while the greeting message is still playing. This results in the representative having to wait until the greeting message is completed before being correctly connected to the customer.

## Resolution

To resolve this issue, try the following workarounds:

- You can shorten the greeting message configured for your voice channel.
- If shortening the message isn't possible, you can [introduce a Copilot Studio agent](#introduce-a-copilot-studio-agent-to-greet-customers) to welcome the customer instead of using a greeting message. You'll need to configure a delay to prevent the call from being transferred to a representative. There are two ways to create a delay:
  - [Add a Power Automate delay flow](#add-a-power-automate-delay-flow)
  - [Add a message delay](#add-a-message-delay)
  
### Introduce a Copilot Studio agent to greet customers

1. Add a [Copilot Studio agent](/microsoft-copilot-studio/authoring-first-bot) and connect it to your workstream. For more information, see [Manage your bots](/dynamics365/customer-service/administer/manage-your-bots#manage-your-bots).

1. Ensure that your agent is connected to Omnichannel for Customer Service. For more information, see [Configure Copilot Studio agents for voice](/dynamics365/customer-service/administer/voice-channel-pva-bots).

1. In the [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) app, open your copilot and go to the **Topics & Plugins** page.
1. Under **System**, select the **Conversation start** topic.
1. In the **Message** node, add the greeting message that you want to be played before a call is transferred (or escalated) to a representative. Make sure the message node is set to **Speech**.
1. Create a delay either by [adding a Power Automate delay flow](#add-a-power-automate-delay-flow) or by [adding a message delay](#add-a-message-delay).

### Add a Power Automate delay flow

To add a new node to create a delay flow, follow these steps:

1. Select the "plus" icon, and then select **Call an action** > **Create a flow**. When Power Automate opens, you can see your delay flow.
1. Open a blank automated cloud flow, set your flow trigger to **When Power Virtual Agents calls a flow**, and then select **Create**.

   :::image type="content" source="media/greeting-message-delay-agent-connection/automated-cloud-flow-voice-message.png" alt-text="Screenshot that shows the When Power Virtual Agents calls a flow trigger.":::
  
   Your flow editor page opens.

1. Select the "plus" icon, and then select **Add an action**.
1. Search for the **Delay** action, and then select it.
1. Type a number for **Count**, and select the **Unit** for how long you want the delay to be. Ideally, the delay should be the same length of time as your message to prevent the call from being prematurely transferred.

   :::image type="content" source="media/greeting-message-delay-agent-connection/pva-delay-action.png" alt-text="Screenshot that shows the Delay action in the Power Automate delay flow.":::

1. Select the "plus*" icon, and then select **Add an action**.
1. Search for the **Return value(s) to Power Virtual Agents** action, and then select it.

   :::image type="content" source="media/greeting-message-delay-agent-connection/return-value-pva.png" alt-text="Screenshot that shows the Return value(s) to Power Virtual Agents flow action.":::

1. Save your flow, go back to Copilot Studio, and add the flow after the **Greeting Message** node.
1. Add a new node to transfer the conversation to the representative by selecting the "plus" icon and then selecting **Topic Management** > **Transfer conversation**.

   :::image type="content" source="media/greeting-message-delay-agent-connection/transfer-conversation-node.png" alt-text="Screenshot that shows the Transfer conversation node in Copilot Studio.":::

1. Test your copilot to make sure the message works as expected, and then publish the change.

### Add a message delay

You can add another **Message** node to explain that the call will be transferred to a representative. This ensures that the call won't be transferred to the representative until both messages play.

1. Select the "plus" icon, and then select **Topic management** > **Transfer conversation**.
1. Type the message you want the representative to hear. Learn more about creating and editing topics, see [Use topics to design a copilot conversation](/microsoft-copilot-studio/authoring-create-edit-topics).

    :::image type="content" source="media/greeting-message-delay-agent-connection/configure-voice-message.png" alt-text="Screenshot that shows how to configure a voice agent in Copilot Studio.":::

1. Test your Copilot agent to make sure the message works as expected, and then publish the change.
