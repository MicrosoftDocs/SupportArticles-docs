---
title: Generative AI isn't available error message
description: Learn how to identify, troubleshoot, and resolve the generative AI not available error message in Copilot Studio by using Power Platform.
ms.date: 09/09/2025
ms.reviewer: 
  - camogas
  - erickinser
  - v-shaywood
ms.custom: sap:Generative Answers\Generative answers do not return a response
---

# Generative AI not available error message

This article provides steps to resolve the "Generative AI not available" error in Microsoft Copilot Studio agents.

## Symptoms

Users receive the following error message when they interact with the Copilot Studio agent:

"Error message: Features with generative AI are not available in your environment. Error code: GenerativeAINotAvailable"

:::image type="content" source="../media/generative-ai-not-available/error-code-gen-ai-not-available.png" alt-text="Chat window displaying the GenerativeAINotAvailable error code.":::

Agent makers also receive the following warning message in Copilot Studio on the **Generative AI** settings page:

"Features with generative AI are not available in your environment. Please contact your admin."

:::image type="content" source="../media/generative-ai-not-available/gen-ai-features-unavailable-environment.png" alt-text="Generative AI settings page, highlighting the error message Features with generative AI aren't available in your environment.":::

## Cause

Generative AI features aren't accessible in all regions and languages. In some cases, data might have to move outside the region for these features to become available or to rely on other Microsoft services outside the environment region.

If data movement across regions is disabled in an environment that needs it for generative AI features, then these features aren't available for agents. If the environment requires cross-geo calls, users receive an error message when they try to use generative AI tools or orchestration.

## Solution

To fix this error, enable data movement across regions for the environment. Alternatively, change your agent behavior to avoid using generative AI features for responses or topic orchestration.

Enable generative AI features:

1. Access the [Microsoft Power Platform admin center](https://admin.powerplatform.microsoft.com/).

1. Select the respective environment.

1. Under **Generative AI features**, select **Edit**.

1. Enable **Move data across regions**.

1. Select **Save**.

:::image type="content" source="../media/generative-ai-not-available/gen-ai-features.png" alt-text="Generative AI features terms and conditions message.":::

If you can't turn on this setting, you have to adapt your agent's behavior. Turn off generative AI features (such as generative orchestration, web search, AI general knowledge, and AI tools) to prevent users from seeing this message when they chat with your agent.

## Related information 

To understand which features and regions require data movement, review the following information:

- [Move data across regions for Copilots and generative AI features](/power-platform/admin/geographical-availability-copilot?tabs=new)

- [Regions where data is processed for Copilots and generative AI features](/power-platform/admin/geographical-availability-copilot?tabs=new#regions-where-data-is-processed-for-copilots-and-generative-ai-features)
