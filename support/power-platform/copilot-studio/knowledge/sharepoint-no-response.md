---
title: "SharePoint Knowledge Sources Don't Return Results"
description: "Learn how to fix SharePoint knowledge sources that don't return results in Microsoft Copilot Studio. Check indexing, permissions, and file size limits."
ms.date: 08/05/2026
ms.reviewer: 
  - adileibowitz
  - erickinser
  - somyabagai
  - v-shaywood
ms.custom:
  - sfi-image-nochange
  - sap:Knowledge\SharePoint as Knowledge Source
ai-usage: ai-assisted
---

# SharePoint knowledge sources don't return results in Copilot Studio

## Summary

This article helps you troubleshoot and resolve issues where SharePoint knowledge sources don't return results in Microsoft Copilot Studio. When you configure a SharePoint data source, several factors can prevent the agent from providing a response. These factors include missing search results, user permissions, protected content, app registration problems, file size limitations, filter conditions, or content moderation filtering. In such instances, the agent might return a message like **"I'm not sure how to help with that. Can you try rephrasing?"**

Copilot Studio provides two ways to configure SharePoint as a knowledge source, and this article covers both methods:

- **Agent-level knowledge source.** Add from the **Add knowledge** dialog on the agent's **Overview**, **Knowledge**, or **Properties** pages. This path supports SharePoint sites (URLs) and SharePoint lists, sensitivity-label trimming, and filter conditions. For more information, see [Add SharePoint as a knowledge source](/microsoft-copilot-studio/knowledge-add-sharepoint).
- **Topic-level knowledge source.** Add inside a **Create generative answers** node in a topic. This path pairs the node with a SharePoint URL. For more information, see [Use SharePoint content for generative answers](/microsoft-copilot-studio/nlu-generative-answers-sharepoint-onedrive).

> [!NOTE]
> Before continuing, make sure you follow the setup instructions for the configuration path that your agent uses: [Add SharePoint as a knowledge source](/microsoft-copilot-studio/knowledge-add-sharepoint) for the agent-level path, or [Use SharePoint content for generative answers](/microsoft-copilot-studio/nlu-generative-answers-sharepoint-onedrive) for the topic-level generative answers node.
>
> For better search results, use a Microsoft 365 Copilot license within the same tenant as your agent.

## Search results are missing from SharePoint

When Copilot Studio searches SharePoint, it uses only the top three search results to summarize and generate a response. If no search results are returned, the agent doesn't provide a response. Copilot Studio relies on Microsoft Search indexing and enforces specific constraints on the page layouts, components, and file formats that are used to generate responses.

### Fix missing SharePoint search results

1. Ensure that your SharePoint knowledge source (agent-level source or **Create generative answers** node) points to a SharePoint location with relevant content.

1. Only documents in [supported formats](/microsoft-copilot-studio/nlu-boost-node#supported-content) are used to generate responses.

1. Verify that the SharePoint pages you expect the agent to use meet the following constraints:

   - **Modern pages:** Only modern SharePoint pages are supported. Modern pages that contain SharePoint Framework (SPFx) components aren't supported.
   - **Classic pages:** Content from classic `.aspx` pages on SharePoint isn't used to generate answers.
   - For a full list of technical boundaries, see [SharePoint web app limits](/microsoft-copilot-studio/requirements-quotas#sharepoint-web-app-limits).

1. It's possible that documents were recently uploaded to SharePoint, and have not yet been indexed. It's also possible that some settings prevent some sites from appearing in search results. For more information, see [Search results missing in SharePoint Online](/troubleshoot/sharepoint/search/search-results-missing).

    **How to verify**

    - In the SharePoint portal search bar, enter a unique keyword from the target document, and verify that the file appears in the search results. If the file doesn't appear, indexing is incomplete.

    **How to fix**

    - Wait for the automated indexing cycle to complete.
    - For urgent updates, SharePoint site administrators can manually trigger a reindex. In SharePoint settings, go to **Site Information** > **View all site settings** > **Search and offline availability** > **Re-index site**. For more information, see [Manually request crawling and reindexing of a site, a library or a list](/sharepoint/crawl-site-content).

## Missing user permissions for SharePoint

Copilot Studio respects Microsoft 365 security trimming. At a minimum, a user must have read permissions on the relevant sites and files, or no search results are returned.

If the user is missing permissions, the system returns no results, nor any errors or exceptions. For a user with no permissions, it appears as if no documents were found.

> [!NOTE]
> When a user lacks permission, the system doesn't throw an error or exception. Instead, it behaves silently as if the document doesn't exist. Don't rely solely on folder-level inheritance structures to grant access.

### Verify SharePoint user permissions

1. Have the affected user go directly to the exact SharePoint document path to verify they can open the file.
1. Test the query by using the same user account in Microsoft 365 Copilot Chat. If Microsoft 365 Copilot Chat can't retrieve a response, it confirms a permission or search indexing barrier.

### Fix missing SharePoint user permissions

Amend permissions so users can access the relevant sites and files. For more information, see [Sharing and permissions in the SharePoint modern experience](/sharepoint/modern-experience-sharing-permissions).

## Content is protected by sensitivity labels, DKE, or a password

The agent-level SharePoint knowledge source respects sensitivity labels for permission trimming and only surfaces label-permitted content for the signed-in user. However, the agent can't extract or ground on content whose protection encrypts the file. This limitation includes sensitivity labels that apply encryption, Double Key Encryption (DKE), and password-protected files.

Such documents might show as **Ready** in the knowledge source list, and might be openable by the user in SharePoint, but still return "no response" when the agent is asked about their contents.

### Verify protected SharePoint content

1. Open the file directly in SharePoint or its desktop app and check whether it prompts for a password, indicates DKE protection, or shows an encrypting sensitivity label.
1. Ask about content that is known to appear only in unprotected files in the same source. If those queries succeed while queries scoped to protected files return no response, protection is the cause.

### Fix protected SharePoint content

- Remove the encrypting sensitivity label, DKE protection, or password from the file, if your organization's policies allow it.
- Publish an unprotected copy of the required content to a SharePoint location that the agent can access.
- Point the knowledge source to a SharePoint location that doesn't contain encrypted content.

## The SharePoint source link is broken after a rename

If you rename a SharePoint site or folder that an agent-level knowledge source uses, the existing source link can break and cause a permission gap. When this happens, the agent might fail to access the knowledge base and return no response.

### Fix a broken SharePoint source link

1. Ask your SharePoint administrator to grant the appropriate permissions on the renamed location and to generate a new source link.
1. Open the agent and update the SharePoint knowledge source with the newly generated link.

## The app registration or agent is misconfigured for SharePoint

When admins configure SharePoint knowledge sources, they need to set up authentication by using a Microsoft Entra ID app registration, and configure [extra scopes](/microsoft-copilot-studio/configuration-end-user-authentication#authenticate-manually). At a minimum, the app registration must specify the `Sites.Read.All` and `Files.Read.All` scopes, and add those scopes to the agent's authentication settings alongside `profile` and `openid`. If scopes are missing from the app registration or from the agent authentication settings, or if consent isn't granted to the required scopes, the agent returns no results, nor any errors or exceptions. For a user, it appears as if no documents were found.

> [!IMPORTANT]
> If [Restricted SharePoint Search](/sharepoint/restricted-sharepoint-search) is turned on for your tenant, use of SharePoint as a knowledge source is blocked regardless of app registration or agent configuration, and no results are returned. Confirm with your SharePoint administrator that Restricted SharePoint Search isn't turned on, or add the relevant sites to the allowed list.
>
> Generative answers from SharePoint sources also aren't available to _guest_ users in SSO-enabled apps.

### Fix misconfigured app registration or agent authentication

Add the necessary scopes to the app registration and the agent's authentication settings, and grant consent.

The following example is a reference to a well configured app registration:

:::image type="content" source="../media/generative-answers/app-registration.png" alt-text="Screenshot of the Configured permissions page for an app registration with the delegated Files.Read.All and Sites.Read.All permissions granted.":::

The following example shows the required authentication settings in Copilot Studio:

:::image type="content" source="../media/generative-answers/copilot-auth.png" alt-text="Screenshot of the Copilot Studio Authentication pane with Authenticate manually selected and the required scopes entered.":::

## File size limits for SharePoint generative answers

For SharePoint sources, if you don't have a Microsoft 365 Copilot license in the same tenant as your agent, generative answers can only process files up to 7 MB in size. You must also turn off the [Tenant graph grounding with semantic search](/microsoft-copilot-studio/knowledge-copilot-studio#tenant-graph-grounding-with-semantic-search) setting.

If you have a Microsoft 365 Copilot license in the same tenant as your agent, the maximum file size is 200 MB. You must also turn on the **Tenant graph grounding with semantic search** setting.

Larger files can be stored in SharePoint and _are returned_ by a Microsoft Graph search, but aren't processed by generative answers. As an alternative, you can upload your own [files](/microsoft-copilot-studio/knowledge-add-file-upload), which can be up to 512 MB in size.

For a list of limits and supported SharePoint functionality, see [SharePoint web app limits](/microsoft-copilot-studio/requirements-quotas#sharepoint-web-app-limits).

### Fix file size issues for SharePoint generative answers

If files relevant for your conversational AI experience exceed the size limitation, you might want to explore alternative architectures, such as using [Microsoft 365 Semantic Indexing](/microsoftsearch/semantic-index-for-copilot) or [connect your data to Azure OpenAI for Generative answers](/microsoft-copilot-studio/nlu-generative-answers-azure-openai).

## SharePoint list source returns no results

For agent-level knowledge sources that use SharePoint lists, several list-specific factors can cause the agent to return no response even though the list contains relevant data.

- **Dataverse search is required.** Copilot Studio agents require Dataverse search to use a SharePoint list as a knowledge source. If Dataverse search is turned off in the environment, the list can't be queried and no results are returned. For more information about how to turn on Dataverse search, see [Configure Dataverse search for your environment](/power-platform/admin/configure-relevance-search-organization#select-searchable-fields-and-filters-for-each-table-for-global-search).
- **List size affects quality and latency.** Lists that contain more than 35,000 rows can degrade the quality of results and increase latency, which can present as no response for otherwise-valid queries.
- **Too many lists on one agent.** You can select up to 10 lists at a time and, for the best results, use no more than 10 lists per agent. Adding more lists increases the chance that relevant content isn't surfaced.
- **List doesn't appear in Recent Lists.** If a SharePoint list with shared access doesn't appear in **My Lists** or **Recent Lists** in the browser, open the list in SharePoint once so it appears in **Recent Lists**, or paste the list URL directly into the URL selection when you add the source.

### Fix SharePoint list source issues

1. Ask your administrator to turn on Dataverse search in the environment where the agent runs.
1. Reduce the number of rows in the list, or split large lists into smaller focused lists.
1. Reduce the number of lists attached to the agent to 10 or fewer, keeping only the lists that are relevant to the topics the agent supports.
1. Re-add lists by pasting their URL when they don't appear automatically in **Recent Lists**.

## Filter conditions exclude the expected content

Both configuration paths let you narrow which SharePoint content the agent can use. If those filters are too restrictive or misconfigured, the agent returns no response even when matching content exists.

- **Agent-level source, Advanced settings filters.** In an agent-level SharePoint knowledge source, filters based on **Title**, **Author**, **Modified by**, or **Modified on** can exclude the content that the user is asking about. Filters bound to a custom variable, system variable, or environment variable might resolve to an unintended value at runtime.
- **Topic-level generative answers node, Search only selected sources.** When **Search only selected sources** is turned on for a **Create generative answers** node, only the sources selected on that node are used. If the expected SharePoint source isn't in the selection, the agent returns no response instead of falling back to other knowledge sources.

### Verify filter conditions

1. On the **Knowledge** page, select your SharePoint source, and then select **Edit** > **Advanced settings** to review any active filter conditions and the values they resolve to.
1. In the topic that hosts the **Create generative answers** node, open the node's **Properties** > **Data source** and confirm both the **Search only selected sources** setting and the specific sources selected.

### Fix filter conditions

- Relax or remove filter conditions that exclude the expected content.
- If a filter uses a variable, add a debug step in the conversation to confirm the variable resolves to the value you expect at runtime.
- On the topic-level node, either add the expected SharePoint source to the selected sources or turn off **Search only selected sources** so agent-level knowledge sources are also queried.

## Content blocked by content moderation in Copilot Studio

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

:::image type="content" source="../media/generative-answers/content-filtered.png" alt-text="Screenshot of an Application Insights query result showing a generative answers event with a result of Filtered by content moderation.":::

### Fix content moderation blocking generative answers

- Try to adjust [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#moderation), but keep in mind that a lower level of content moderation might result in answers that are less accurate or relevant.

- If you think your content shouldn't be moderated, [contact Microsoft customer support](/power-platform/admin/get-help-support).

## Related content

- [Add SharePoint as a knowledge source](/microsoft-copilot-studio/knowledge-add-sharepoint)
- [Use SharePoint content for generative answers](/microsoft-copilot-studio/nlu-generative-answers-sharepoint-onedrive)
- [Set up generative answers over SharePoint](/microsoft-copilot-studio/nlu-boost-node)
- [SharePoint web app limits](/microsoft-copilot-studio/requirements-quotas#sharepoint-web-app-limits)
- [Sharing and permissions in the SharePoint modern experience](/sharepoint/modern-experience-sharing-permissions)
- [Resolve responsible AI content filter errors](~/power-platform/copilot-studio/generative-answers/agent-response-filtered-by-responsible-ai.md)
