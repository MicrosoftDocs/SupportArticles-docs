---
title: Voice call greeting messages delay connection between agents and customers
description: Resolves an issue where voice call greeting messages delay an agent's ability to connect to a customer in the voice channel in Omnichannel for Customer Service.
ms.reviewer: laalexan
ms.author: srubinstein
ms.date: 02/16/2024
---
# Incoming voice calls with long greeting messages cause connection delays

This article provides a solution to an issue where Omnichannel for Customer Service voice calls that are configured with a greeting message cause a connection delay between the agent and the customer.

## Symptoms

As an agent or supervisor, you notice that incoming voice calls that are configured with a greeting message experience a delay before agents can connect to their customers.

## Cause

After [setting up a greeting message for a channel](/dynamics365/customer-service/administer/configure-automated-message), the call is intended to transfer to an agent once a greeting message ends for the customer. However, in some cases, the call is transferred to the agent while the greeting message is still playing. This results in the agent having to wait until the greeting message is completed before being correctly connected to the customer.

## Resolution

To resolve this issue, try the following workarounds:

- You can shorten the greeting message configured for your voice channel.
- If shortening the message isn't possible, you can introduce a [Copilot Studio bot](/dynamics365/customer-service/administer/overview-bots) to welcome the customer instead of using a greeting message. You'll need to configure a delay to prevent the call from being transferred to an agent. There are two ways you can choose to create a delay:
   - [Add a Power Automate delay flow](#add-a-power-automate-delay-flow)
     or
   - [Add a message delay](#add-a-message-delay)
  
### Introduce a Copilot Studio bot to greet customers

1. Add a bot and connect it to your workstream. For more information, see [Manage your bots](/dynamics365/customer-service/administer/manage-your-bots#add-a-bot).

1. Ensure that your bot is connected to Omnichannel for Customer Service. For more information, see [Configure Copilot Studio bots for voice](/dynamics365/customer-service/administer/voice-channel-pva-bots#configure-handoff-from-copilot-studio-to-omnichannel-for-customer-service).

1. In the [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) app, open your copilot and go to the **Topics & Plugins** page.
1. Under **System**, select the **Conversation start** topic.
1. In the **Message** node, add the greeting message that you want to be played before a call is transferred (or escalated) to an agent. Make sure the message node is set to **Speech**.
1. Create a delay either by [adding a Power Automate delay flow](#add-a-power-automate-delay-flow) or by [adding a message delay](#add-a-message-delay).

### Add a Power Automate delay flow

Add a new node to create a delay flow.

1. Select the "plus" icon, and then select **Call an action** > **Create a flow**. Power Automate opens, where you can see your delay flow.
1. Open a blank automated cloud flow, set your flow trigger to **When Power Virtual Agents calls a flow**, and then select **Create**.
   
  :::image type="content" source="media/greeting-message-delay-agent-connection/automated-cloud-flow-voice-message.png" alt-text="Screenshot that shows the trigger for when Power Agents calls a flow.":::
  
   Your flow editor page opens.
   
1. Select the "plus" icon, and then select **Add an action**.
1. Search for the **Delay** action, and then select it.
1. Type a number for **Count**, and select the **Unit** for how long you want the delay to be. Ideally, the delay should be the same length of time as your message to prevent the call from being prematurely transferred.
   
   :::image type="content" source="media/greeting-message-delay-agent-connection/pva-delay-action.png" alt-text="Screenshot that the delay action in the Power Automate delay flow.":::
   
1. Select the "plus** icon, and then select **Add an action**.
1. Search for the **Return value(s) to Power Virtual Agents** action, and then select it.

   :::image type="content" source="media/greeting-message-delay-agent-connection/return-value-pva.png" alt-text="Screenshot that the flow action for Return value(s) to Power Virtual Agents.":::
   
1. Save your flow, and then go back to Copilot Studio and add it after the **Greeting Message** node.
1. Add a new node to transfer the conversation to the agent: Select the "plus" icon, and then select **Topic Management** > **Transfer conversation**.

   :::image type="content" source="media/greeting-message-delay-agent-connection/transfer-conversation-node.png" alt-text="Screenshot that shows the transfer conversation node in Copilot Studio.":::
   
1. Test your copilot to make sure the message works as expected, and then publish the change.

### Add a message delay

Add another **Message** node to explain that the call will be transferred to an agent. This ensures that the call won't be transferred to the agent until both messages play.

1. Select the "plus" icon, and then select **Topic management** > **Transfer conversation**.
1. Type the message you want the agent to hear. For more information about creating and editing topics, see [Use topics to design a copilot conversation](/microsoft-copilot-studio/authoring-create-edit-topics).
   
    :::image type="content" source="media/greeting-message-delay-agent-connection/configure-voice-message.png" alt-text="Screenshot that shows how to configure a voice bot in Copilot Studio.":::

1. Test your copilot to make sure the message works as expected, and then publish the change. 
