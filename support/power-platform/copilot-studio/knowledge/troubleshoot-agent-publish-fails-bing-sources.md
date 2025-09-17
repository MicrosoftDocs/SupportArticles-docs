---
title: Publish agent fails due to Bing sources
description: Learn how to identify, troubleshoot, and resolve the exceeded limit of Bing sources error message in Microsoft Copilot Studio.
author: carolinamogas
ms.topic: troubleshooting
ms.date: 09/09/2025
ms.author: camogas
ms.reviewer: erickinser
---

# Publish agent fails due to Bing sources

This article provides steps to resolve the "You've exceeded the limit of Bing sources (4)" in Copilot Studio agents. This error might also apply to other knowledge sources, if the knowledge limit is reached. 

## Symptoms

Users receive the following error message when attempting to publish their Copilot Studio agent:

**"ErrorCode: TooManyPublicSiteSearchSources**

**ErrorMessage: “You’ve exceeded the limit of Bing sources (4)"**

:::image type="content" source="media/troubleshoot-agent-publish-fails-limitation-bing-sources/exceeded-limit-bing-sources-message.png" alt-text="Screenshot of the raw response displaying the 'you've exceeded the limit of Bing sources error message'.":::

## Cause

Each orchestration mode in Copilot Studio has specific limitations on the number of knowledge sources that can be uploaded. Specifically for public websites, the limit is 25 in generative orchestration and four in classic orchestration.

However, if knowledge sources are also defined at the topic level using a generative answers node (identified as search and summarize), the limit becomes four, regardless of the orchestration mode. The generative answers node has this limitation because it uses classic orchestration to process requests, even if generative orchestration is enabled for the agent.

## Solution

If you're running into this issue and are unable to publish the agent due to this error, ensure that the **Create generative answers** node respects the maximum number of knowledge sources allowed: 

1. Open your agent in Copilot Studio.

1. Go to **Topics**.

1. Access the topic that contains a **Create generative answers** node or see which topics contain errors.

1. In the **Create generative answers** node, you should see the following errors:

   :::image type="content" source="media/troubleshoot-agent-publish-fails-limitation-bing-sources/bing-knowledge-sources.png" alt-text="Screenshot of a generative answers node highlighting more than four selected Bing sources.":::

1. Adjust the number of knowledge sources to the maximum allowed limit (for public sources, this limit is 4) and save the topic.

1. Ensure that you don't have any other topics with incorrectly configured generative answers nodes.

You should now be able to publish your agent successfully.

## Related information

- [Knowledge sources overview](knowledge-copilot-studio.md#supported-knowledge-sources)
