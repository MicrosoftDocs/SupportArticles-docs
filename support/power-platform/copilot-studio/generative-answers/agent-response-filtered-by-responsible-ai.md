---
title: Resolve responsible AI content filter errors
description: Learn how to identify, troubleshoot, and resolve Responsible AI content filter errors in Microsoft Copilot Studio using Application Insights and conversation transcripts.
author: carolinamogas
ms.topic: troubleshooting
ms.date: 09/09/2025
ms.author: camogas
ms.reviewer: erickinser
---

# Resolve responsible AI content filter errors

Use the steps in this article to identify and clarify why Responsible AI guidelines filter Copilot Studio agent messages.

## Symptoms 

If an agent identifies a scenario that goes against Responsible AI guidelines, it triggers the following error message:

```
Error Message: The content was filtered due to Responsible AI restrictions.
Error Code: ContentFiltered
```

:::image type="content" source="media/troubleshoot-agent-response-filtered-by-responsible-ai/responsible-ai-content-filtered.png" alt-text="Screenshot of an error message warning that the content was filtered due to Responsible AI restrictions.":::

## Cause 

Copilot Studio enforces content moderation policies on all generative AI requests to help ensure that admins, makers, and users aren't exposed to potentially offensive or harmful material.

These policies also address actions such as jailbreaking, prompt injection, prompt exfiltration, and copyright infringement.

Content is evaluated twice: once at the stage of user input and again before the agent provides a response. If harmful, offensive, or malicious content is detected, the system blocks the agent from responding and displays an error message to the user.

## Troubleshooting 

### Check error exceptions with Azure Application Insights

With Azure Application Insights, you can review telemetry from agent events, including triggered exceptions.

> [!NOTE]
> To use Application Insights, your tenant requires an active Azure subscription and you need to have the necessary roles to create Azure resources.

To learn how to connect Application Insights with your agent, see [Create and configure Application Insights resources](/azure/azure-monitor/app/create-workspace-resource?tabs=portal) and [Capture telemetry with Application Insights](advanced-bot-framework-composer-capture-telemetry.md).

Once Azure Application Insights is available and connected to your agent, you can analyze the telemetry, including Responsible AI exceptions. To review if your agent contains these exceptions or to understand if a specific conversation ID was affected, you can use the following KQL queries:

- Validate if your agent ran into any RAI exceptions:

```
customEvents
> \| where customDimensions contains "ContentFiltered"
\| project timestamp, name, itemType, customDimensions, session_Id,
user_Id, cloud_RoleInstance
```

#### Example output

:::image type="content" source="media/troubleshoot-agent-response-filtered-by-responsible-ai/kql-query-output-exceptions.png" alt-text="Screenshot of an Azure Application Insights table filtered by a KQL query to determine if there were RAI exceptions.":::

- Validate if the same scenario occurred for a specific conversation ID:

```
customEvents
\| where customDimensions contains "***conversationID***"
\| where customDimensions contains "ContentFiltered" \| project
timestamp, name, itemType, customDimensions, session_Id, user_Id,
cloud_RoleInstance
```

#### Example output

:::image type="content" source="media/troubleshoot-agent-response-filtered-by-responsible-ai/kql-query-results-conversation-id.png" alt-text="Screenshot of an Azure Application Insights table filtered by a KQL query to validate based on a specific conversation ID.":::

### Analyze responsible AI errors with conversation transcripts

You can also review conversation transcripts to understand what was the message that triggered a Responsible AI filter response. For more information, see [how to download conversation transcripts](analytics-transcripts-studio.md#download-agent-session-transcripts).

#### Example of conversation transcript excerpt

:::image type="content" source="media/troubleshoot-agent-response-filtered-by-responsible-ai/conversation-transcript-example.png" alt-text="Screenshot illustrating an example of a conversation transcript excerpt.":::

## Solution

If your agent responses are being filtered due to Responsible AI guardrails, and based on the information retrieved from conversation transcripts, you can reinforce responsible AI guidelines with your agent users to avoid this situation.

Optionally, you can also update the agent [content moderation](knowledge-copilot-studio.md#content-moderation) policies.

## Related information

- [Responsible AI FAQs](responsible-ai-overview.md)

- [FAQ for generative answers](faqs-generative-answers.md)

- [Application Insights telemetry with Microsoft Copilot Studio - Dynamics 365](/dynamics365/guidance/resources/copilot-studio-appinsights)

- [Content moderation](knowledge-copilot-studio.md#content-moderation)
