---
title: "Debug insights when generative answers don't return a response"
description: "Troubleshoot your agent when generative answers don't return results by using debug insights in Microsoft Copilot Studio."
ms.date: 06/17/2025
ms.topic: troubleshooting
ms.author: mboninco
ms.reviewer: erickinser
manager: kjette
author: iaanw
ms.custom:
  - guidance
  - sap:Generative Answers\Generative answers do not return a response
---

# Debug insights when generative answers don't return a response

Generative answers allow makers to create agents that respond to questions grounded in knowledge sources, like public websites or SharePoint. However, sometimes the agent doesn't provide a response. When an agent doesn't return a result, the test chat's debug mode provides insights on why a response wasn't returned.

## Debug insights in the test chat

When debug mode is enabled, insights are displayed in the test chat when the generative answers feature doesn't return any results for a query. Debug insights only show in the test chat and aren't shown to users in a published agent.

When there's no response, a debug insight appears in the test chat and provides an indication why no response was provided. If applicable, a suggested action to improve the likelihood that a response is returned is given.

:::image type="content" source="../media/debug-insights/content-moderation.png" alt-text="Screenshot showing a debug insight when a response was filtered due to content moderation.":::

## Disable debug insights

Debug insights are enabled by default. To stop the display of debug insights, select the three dots at the top of the test panel and turn off **Debug mode**.

### Related content

- [Generative answers pointing to SharePoint sources don't return results](../generative-answers/sharepoint-no-response.md)
