---
title: Generative AI isn't available error message
description: Learn how to identify, troubleshoot, and resolve the generative AI not available error message in Microsoft Copilot Studio using Power Platform.
ms.date: 09/09/2025
ms.reviewer: 
  - camogas
  - erickinser
  - v-shaywood
ms.custom: sap:Generative Answers\Generative answers do not return a response
---

# Generative AI isn't available error message

This article provides steps to resolve the "Generative AI not available error message" in Copilot Studio agents.

## Symptoms

Users receive the following error message when interacting with the Copilot Studio agent:

"Error message: Features with generative AI are not available in your environment. Error code: GenerativeAINotAvailable"

:::image type="content" source="../media/generative-ai-not-available/error-code-gen-ai-not-available.png" alt-text="Screenshot of a chat window displaying the GenerativeAINotAvailable error code.":::

Agent makers also receive the following warning message in Copilot Studio in the **Generative AI** settings page:

"Features with generative AI are not available in your environment. Please contact your admin."

:::image type="content" source="../media/generative-ai-not-available/gen-ai-features-unavailable-environment.png" alt-text="Screenshot of the Generative AI settings page, highlighting the error message Features with generative AI aren't available in your environment.":::

## Cause

Generative AI features aren't accessible in all regions and languages. In some cases, data might need to move outside the region for these features to be available or to rely on other Microsoft services outside the environment region.

If data movement across regions is disabled in an environment that needs it for generative AI features, then these features aren't available for agents. If the environment requires cross-geo calls, users see an error message when they try to use generative AI tools or orchestration.

## Solution

To fix this error, enable data movement across regions for the environment. Another option is to change your agent behavior to avoid using generative AI features for responses or topic orchestration.

Enable generative AI features:

1. Access the [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/).

1. Select the respective environment.

1. Under **Generative AI features**, select **Edit**.

1. Enable **Move data across regions**.

1. Select **Save**.

:::image type="content" source="../media/generative-ai-not-available/gen-ai-features.png" alt-text="Screenshot of the Generative AI features terms and conditions message.":::

If you can't turn on this setting, you need to adapt your agent's behavior. Turn off generative AI features (like generative orchestration, web search, AI general knowledge, and AI tools) to prevent users from seeing this message when they chat with your agent.

## Related information 

To understand what features and regions require data movement, review the following information:

- [Move data across regions for Copilots and generative AI features](/power-platform/admin/geographical-availability-copilot?tabs=new)

- [Regions where data is processed for Copilots and generative AI features](/power-platform/admin/geographical-availability-copilot?tabs=new#regions-where-data-is-processed-for-copilots-and-generative-ai-features)
