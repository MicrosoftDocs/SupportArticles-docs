---
title: Knowledge Articles Not Supporting Multilingual Search
description: Provide troubleshooting steps to ensure knowledge articles are properly configured to support multilingual search in Microsoft Dynamics 365 Customer Service.
ms.reviewer: atrinassa
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/22/2025
ms.custom: sap:Knowledge Management, DFM
---
# Knowledge articles don't support multilingual search

This article provides troubleshooting steps for issues where knowledge articles originally authored in English are sometimes not discoverable using search terms in other languages, such as Chinese.

## Symptoms

You might encounter the following issues when searching for knowledge articles in Dynamics 365 Customer Service:

- Knowledge articles authored in English aren't consistently discoverable using search terms in other languages (for example, Chinese).
- Some articles are successfully retrieved using multilingual search terms, while others aren't.

## Cause

The issue might be related to the language preferences or translation configurations of the knowledge articles. Specifically:

1. The preferred language of the knowledge articles might not match the language of the search query.
2. Translations for the knowledge articles might not have been properly configured or enabled.

## Troubleshooting steps

### Verify the preferred language of the knowledge articles

1. Open the knowledge article that doesn't appear in the multilingual search.
2. Check the preferred language setting for the article. Ensure that it matches the language in which the article was originally authored.

3. If the preferred language is incorrect, [update it to the correct language](/dynamics365/customer-service/use/set-knowledge-article-authoring-language#personalize-your-language-preferences-for-authoring-knowledge-articles) and save the changes.

### Configure translations for the knowledge articles

1. Open the knowledge article that doesn't appear in the multilingual search.

2. Check if translations are already configured for the article.

3. If translations aren't configured, [set the translation language for the article](/dynamics365/customer-service/use/translate-ka#select-a-language-for-your-knowledge-article-translation).

4. Save and [publish the knowledge article](/dynamics365/customer-service/use/publish-ka#publish-knowledge-articles).

## More information

For detailed steps on configuring language preferences and translations, see:

- [Configure a default knowledge article authoring language for your organization](/dynamics365/customer-service/use/set-knowledge-article-authoring-language)
- [Translate knowledge articles](/dynamics365/customer-service/use/translate-ka)
