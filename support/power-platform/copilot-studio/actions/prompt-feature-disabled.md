---
title: Troubleshoot Copilot Studio disabled AI prompts issue
description: Learn how to fix the "This feature has been disabled" error in Microsoft Copilot Studio by enabling the AI prompts feature in your Power Platform environment.
ms.date: 02/09/2026
ms.reviewer: camogas, erickinser, v-shaywood
ms.custom: sap:Actions\AI Actions
---

# "This feature has been disabled" error for AI prompts in Copilot Studio

## Summary

This article helps you resolve the "This feature has been disabled" error that occurs when you try to create [AI prompts](/microsoft-copilot-studio/create-custom-prompt) in Microsoft Copilot Studio. Typically, this error appears if the AI prompts feature is disabled at the environment level in Microsoft Power Platform admin center or is restricted by an organizational policy. Enabling the feature lets you create custom prompts for your Copilot Studio agents.

## Symptoms

When you try to [create a new prompt](/microsoft-copilot-studio/create-custom-prompt#create-a-new-prompt) in Copilot Studio, the following message appears in the **Custom prompt** window:

> This feature has been disabled

:::image type="content" source="media/prompt-feature-disabled/model-not-supported-error-message.png" alt-text="Screenshot of Copilot Studio interface that shows the disabled AI prompts feature with error notification at the top.":::

## Cause

An administrator disabled the AI prompts feature at the environment level in Power Platform admin center or restricted it by using an organizational policy. When this feature is disabled, you receive an error message when you try to create an AI prompt.

## Solution

To resolve this issue, an administrator must enable the AI prompts feature in Power Platform admin center:

1. Sign in to [Power Platform admin center](https://admin.powerplatform.microsoft.com/) by using administrator credentials.

1. Select **Manage** > **Environments**.

1. Select the environment in which the error occurs, and then select **Settings**.

1. Go to **Product** > **Features**.

1. Locate and turn on the **AI prompts** setting.

   :::image type="content" source="media/prompt-feature-disabled/power-platform-copilot-ai-prompts.png" alt-text="Screenshot of the AI prompts section in Power Platform that shows the enable toggle active, warning about device and data security, and info link.":::

1. Select **Save**.

1. Return to Copilot Studio, and verify that the **Custom prompt** window no longer shows the error message.

For more information, see [Enable or disable AI prompts in Power Platform and Copilot Studio](/ai-builder/administer#enable-or-disable-ai-prompts-in-power-platform-and-copilot-studio).

## Related content

- [Modify responses using custom instructions and prompt modification](/microsoft-copilot-studio/nlu-generative-answers-prompt-modification)
- [Understand error codes](../authoring/error-codes.md)
