---
title: Power Virtual Agents bot conversations are active after a chat has ended
description: Provides a resolution for the issue where Power Virtual Agents bot conversations remain active on the Omnichannel for Customer Service dashboard after a user ends a chat.
ms.reviewer: nenellim
ms.author: yangao
ms.date: 05/23/2023
---
# Power Virtual Agents bot conversations appear as active on the dashboard after a user ends a chat

This article provides a resolution for the issue where Power Virtual Agents bot conversations are shown as active on the Omnichannel for Customer Service dashboard even though a user has ended a chat.

## Symptoms

After a conversation has ended, the Power Virtual Agents bot conversations are still showing as active on the dashboard.

## Cause

Conversations for Power Virtual Agents bot can't be ended in Omnichannel for Customer Service. Therefore, they will be seen as active on the supervisor dashboard even after they've been closed.

## Resolution

You can configure a context variable that will explicitly end the bot conversation in Omnichannel for Customer Service after users close the chat window. In Power Virtual Agents, create a standalone topic for the `CloseOmnichannelConversation` context variable with the variable property set to `global`. Invoke the topic in another topic that you've configured for the bot.

Though the conversation will be closed in Omnichannel for Customer Service, it won't be closed in Power Virtual Agents and appear in the **Escalation rate drivers** KPI in the **Power Virtual Agents Analytics** dashboard.

> [!IMPORTANT]
> Make sure that you have access to Power Automate to configure a flow so that the bot conversation in Omnichannel for Customer Service can be ended.

To configure ending a bot conversation, take the following steps:

1. In Power Virtual Agents, for the selected bot, configure a new topic.
2. Select **Go to authoring canvas**, and in **Add node**, select **Call an action**, and then select **Create a flow**.
3. On the Power Automate window that opens on a new tab, take the following steps:
   1. In the **Return value(s) to Power Virtual Agents** box, select **Add an input**, and then select **Yes/No**.
   2. In the **Enter title** box, enter *CloseOmnichannelConversation*, which is the Omnichannel for Customer Service context variable name.
   3. In the **Enter a value to respond** box, select the **Expression** tab, and then enter *bool(true)* to build the expression, and select **OK**.
   4. Save the changes, and then exit Power Automate.

4. In the topic you were editing, select **Call an action** again, and then in the list, select the flow you created.
5. In **Add node**, select **End the conversation** > **Transfer to agent**.

   :::image type="content" source="media/pva-conversations-active-dashboard/end-bot-conversation.png" alt-text="Screenshot that shows how to configure an end-conversation topic.":::

6. Go to the topic in which you need to invoke the topic for ending the bot conversation in Omnichannel for Customer Service, and use the **Go to another topic** option in **Add a node**.
7. Select the topic that you created for ending the bot conversation.
8. Save and publish the changes.

Additionally, you can configure automated messages in Omnichannel for Customer Service that will be displayed to the user after the conversation ends.
