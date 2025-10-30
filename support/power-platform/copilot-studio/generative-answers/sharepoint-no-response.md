---
title: "Generative answers pointing to SharePoint sources don't return results"
description: "Troubleshoot why generative answers nodes configured to use SharePoint knowledge sources don't return results."
ms.date: 07/01/2025
ms.reviewer: 
  - adileibowitz
  - erickinser
  - v-shaywood
ms.custom:
  - sfi-image-nochange
  - sap:Generative Answers\Generative answers do not return a response
---

# Generative answers pointing to SharePoint sources don't return results

Generative answers allow makers to create agents that respond to questions grounded in data sources, like public websites or SharePoint, by pointing the agent at those data sources. However, sometimes the agent doesn't provide a response and instead returns something like **'I'm not sure how to help with that. Can you try rephrasing?'** (The actual message depends on the implementation.)

When a SharePoint data source is configured, there could be several different factors preventing the **Create generative answers** node from returning a response, such as those described in the following sections.

> [!Note]
> Before continuing, please make sure you have followed the instructions on how to [set up generative answers over SharePoint](/microsoft-copilot-studio/nlu-boost-node).
>
> For better search results, we recommend a Microsoft 365 Copilot license within the same tenant as your agent.

## Search results are missing

When Copilot Studio searches SharePoint, only the top three search results are used to summarize and generate a response. If no search results are returned, the generative answers node doesn't provide a response.

### How to fix

1. Ensure that your Create generative answers node points to a SharePoint location with relevant content.

1. Only documents in [supported formats](/microsoft-copilot-studio/nlu-boost-node#supported-content) are used to generate responses.

    > [!Note]
    > Only modern SharePoint pages are supported.

1. It's possible that documents were only recently uploaded to SharePoint, but have yet to be indexed. It's also possible that there are settings that prevent some sites from appearing in search results. For more information, see [Search results missing in SharePoint Online](/sharepoint/troubleshoot/search/search-results-missing).

## Missing user permissions

Generative answers over SharePoint rely on [delegated permissions](/microsoft-copilot-studio/nlu-boost-node#authentication) when searching. At a minimum, a user must have read permissions on the relevant sites and files, or no search results will be returned.

If the user is missing permissions, no results are returned, nor any errors or exceptions. For a user with no permissions, it appears as if no documents were found.

### How to fix

Amend permissions so users can access the relevant sites and files. For more information, see [Sharing and permissions in the SharePoint modern experience](/sharepoint/modern-experience-sharing-permissions).

## The app registration or agent are misconfigured

When admins configure generative answers over SharePoint, admins are expected to set up authentication with a Microsoft Entra ID, and configure [extra scopes](/microsoft-copilot-studio/configuration-end-user-authentication#authenticate-manually). If scopes are missing from the app registration or from the agent authentication settings, or if consent wasn't granted to the required scopes, no results are returned, nor any errors or exceptions. For a user, it appears as if no documents were found.

### How to fix

Add the necessary scopes to the App Registration and/or the agent's authentication settings, and grant consent.

The following example is a reference to a well configured app registration:

:::image type="content" source="../media/generative-answers/app-registration.png" alt-text="Screenshot of app registration permissions.":::

The following example shows the required authentication settings in Copilot Studio:

:::image type="content" source="../media/generative-answers/copilot-auth.png" alt-text="Screenshot showing Copilot Studio authentication settings.":::

## File size support

For SharePoint sources, if you don't have a Microsoft 365 Copilot license in the same tenant as your agent, generative answers can only process files up to 7 MB in size. You must also turn off the [Enhanced search results](/microsoft-copilot-studio/knowledge-copilot-studio#tenant-graph-grounding) feature.

If you have a Microsoft 365 Copilot license in the same tenant as your agent, the maximum file size is 200 MB. You must also turn on the **Enhanced search results** feature.

Larger files can be stored in SharePoint and **are returned** by a Microsoft Graph search, but aren't processed by generative answers. As an alternative, you can upload your own [files](/microsoft-copilot-studio/knowledge-add-file-upload), which can be up to 512 MB in size.

For a list of limits and supported SharePoint functionality, see [Copilot Studio web app SharePoint limits](/microsoft-copilot-studio/requirements-quotas#copilot-studio-web-app-sharepoint-limits).

### How to fix

If files relevant for your conversational AI experience exceed the size limitation, you might want to explore alternative architectures, such as using [Microsoft 365 Semantic Indexing](/microsoftsearch/semantic-index-for-copilot) or [connect your data to Azure OpenAI for Generative answers](/microsoft-copilot-studio/nlu-generative-answers-azure-openai).

## Content blocked by content moderation

When they generate responses, Copilot Studio agents moderate content that falls under the [harm categories](/azure/ai-services/content-safety/concepts/harm-categories). When content gets moderated, generative answers doesn't provide a response or an indication that content was moderated. However, moderation events are logged when the agent is configured to [send telemetry data to Azure Applications Insights](/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry#connect-your-copilot-studio-agent-to-application-insights).

After connecting your agent to Azure App Insights, you can use the following Kusto Query Language (KQL) query to find out if content was filtered:

```kusto
customEvents
| extend cd = todynamic(customDimensions)
| extend conversationId = tostring(cd.conversationId)
| extend topic = tostring(cd.TopicName)
| extend message = tostring(cd.Message)
| extend result = tostring(cd.Result)
| extend SerializedData = tostring(cd.SerializedData)
| extend Summary = tostring(cd.Summary)
| extend feedback = tostring(todynamic(replace_string(SerializedData,"$","")).value)
| where name == "GenerativeAnswers" and result contains "Filtered"
| where cloud_RoleInstance == "myCopilot"
| project cloud_RoleInstance, name, timestamp, conversationId, topic, message, result, feedback, Summary
| order by timestamp desc
```

In the following example, the KQL query highlights an attempt to use generative answers filtered by content moderation:

:::image type="content" source="../media/generative-answers/content-filtered.png" alt-text="Screenshot of Azure Application Insights.":::

### How to fix

- Try to adjust [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation), but keep in mind that a lower level of content moderation might result in answers that are less accurate or relevant.

- If you think your content shouldn't be moderated, [raise a case with customer support](/power-platform/admin/get-help-support).
