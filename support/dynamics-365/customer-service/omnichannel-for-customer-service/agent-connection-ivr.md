---
title: Voice call greeting messages delay connection between agents and customers
description: Provides a resolution for when voice call greeting messages delay an agent's ability to connect with a customer in Omnichannel for Customer Service voice.
ms.reviewer: laalexan
ms.author: srubinstein
ms.date: 02/02/2024
---

# Incoming voice calls with long greeting messages cause connection delays

This article provides a solution for when Omnichannel for Customer Service voice calls that are configured with a greeting message cause a connection delay for the agent and customer.

## Symptoms

As an agent or supervisor, you notice that incoming voice calls that are configured with a greeting message experience delays before agents are able to connect with their customers.

## Cause

After setting up a greeting message for a channel, the call is intended to transfer to an agent once a greeting message concludes for the customer. However, in certain cases, the call is transferred to the agent while the greeting message is still playing. This results in the agent having to wait until the greeting message completes before they're correctly connected to the customer.

## Resolution

There are a couple of workarounds that can help resolve this issue.

- You can shorten the greeting message that's configured for your voice channel.
- If shortening the message isn't possible, you can introduce a Copilot Studio bot to welcome the customer instead of using a greeting message. The bot plays the same message, waits for the message to end, and then transfers the call to the agent. This method reduces the waiting time for the agent to be connected to the call.

To introduce a Copilot Studio bot to greet customers, complete the following steps:

1. Add a bot and connect it to your workstream. More information: [Manage your bots](/dynamics365/customer-service/administer/manage-your-bots#add-a-bot)
1. Ensure that your bot is connected to Omnichannel for Customer Service. More information: [Configure Copilot Studio bots for voice](/dynamics365/customer-service/administer/voice-channel-pva-bots#configure-handoff-from-copilot-studio-to-omnichannel-for-customer-service)
1. In the Copilot Studio app, open your copilot and go to the **Topics & Plugins** page.
1. Under **System**, select the **Conversation start** topic.
1. In the **Message** node, add the greeting message that you want to be played before a call transfers (or escalates) to an agent. Make sure the message node is set to **Speech**.
1. Add a new node: Select the plus icon, and then select **Topic management** > **Transfer conversation**. This action transfers the conversation to the agent.
1. Enter the message you want the agent to hear. For more information about creating and editing topics, see [Use topics to design a copilot conversation](/microsoft-copilot-studio/authoring-create-edit-topics).

    :::image type="content" source="media/configure-voice-message.png" alt-text="Screenshot that shows how to configure a voice bot in Copilot Studio.":::
   
1. Test your copilot to make sure the message works as expected, and then publish the change.
