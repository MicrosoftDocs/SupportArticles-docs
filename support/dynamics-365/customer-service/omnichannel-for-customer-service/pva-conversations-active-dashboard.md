---
title: Copilot Studio agent conversations are active after a chat ends
description: Provides a resolution for the issue where Copilot Studio agent conversations remain active on the Omnichannel for Customer Service dashboard after a user ends a chat.
ms.reviewer: nenellim
ms.author: yangao
ms.date: 11/20/2024
ms.custom: sap:Copilot Studio\End conversation
ms.collection: CEnSKM-ai-copilot
---
# Copilot Studio agent conversations appear as active on the dashboard after a user ends a chat

This article provides a resolution for the issue where Copilot Studio agent conversations are shown as active on the Omnichannel for Customer Service dashboard even though a user has ended a chat.

> [!IMPORTANT]
> Power Virtual Agents capabilities and features are [now part of Microsoft Copilot Studio](https://www.microsoft.com/microsoft-copilot/blog/copilot-studio/microsoft-power-virtual-agents-now-part-of-microsoft-copilot-studio/) following significant investments in generative AI and enhanced integrations across Microsoft Copilot.
>
> Some articles and screenshots might refer to Power Virtual Agents while we update documentation and training content.

## Symptoms

After a conversation has ended, the Copilot Studio agent conversations are still showing as active on the dashboard.

## Cause

Conversations for Copilot Studio agent can't be ended in Omnichannel for Customer Service. Therefore, they will be seen as active on the supervisor dashboard even after they've been closed.

## Resolution

You can configure a context variable that will explicitly end the agent conversation in Omnichannel for Customer Service after users close the chat window. In Copilot Studio, create a standalone topic for the `CloseOmnichannelConversation` context variable with the variable property set to `global`. Invoke the topic in another topic that you've configured for the Copilot Studio agent.

Though the conversation will be closed in Omnichannel for Customer Service, it won't be closed in Power Virtual Agents and appear in the **Escalation rate drivers** KPI in the **Power Virtual Agents Analytics** dashboard.

> [!IMPORTANT]
> Make sure that you have access to Power Automate to configure a flow so that the agent conversation in Omnichannel for Customer Service can be ended.

To configure ending an agent conversation, perform the steps in the [End bot conversation](/dynamics365/customer-service/administer/configure-bot-virtual-agent) section.

You can also configure automated messages in Omnichannel for Customer Service that are displayed to the user after the conversation ends.
