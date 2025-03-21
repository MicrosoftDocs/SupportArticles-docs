---
title: Sentiment Analysis Not Reflecting Positive Sentiment or Capitalization
description: Solves an issue where sentiment analysis not reflecting positive sentiment or capitalization when expressing gratitude in Microsoft Dynamics 365 Customer Service.
author: Yerragovula
ms.author: srreddy
ms.date: 03/20/2025
ai-usage: ai-assisted
ms.custom: sap:Dynamics 365 Customer Service\Cases or Incidents
---
# Sentiment analysis not reflecting positive sentiment or capitalization

This article provides information about issues related to sentiment analysis algorithms not accurately reflecting positive sentiment when you express gratitude using phrases such as "Thank You" or make use of capitalization and punctuation like exclamation marks in Microsoft Dynamics 365 Customer Service.

## Cause

The sentiment analysis algorithm may not recognize basic gratitude phrases like "Thank You" as sufficiently positive. It's designed to evaluate sentiment based on a broader context or more specific expressions, such as "Thank You So Much." Additionally, the algorithm doesn't account for capitalization or punctuation as indicators of sentiment.

### Solution

This behavior is by design, and the sentiment analysis algorithm can't be modified to suit individual preferences or use cases. Certain expressions might not align with the algorithm's default sentiment categorization. To improve the accuracy of sentiment analysis, consider the following suggestions:

- Use language that's more explicitly positive or detailed, such as "Thank You So Much" or "I'm extremely grateful," to better align with how the algorithm interprets sentiment.
- Familiarize yourself with the supported expressions of the sentiment analysis tool and adjust your phrasing accordingly.

## More information

[Sentiment monitoring](/dynamics365/customer-service/use/supervisor-sentiment-monitoring)
