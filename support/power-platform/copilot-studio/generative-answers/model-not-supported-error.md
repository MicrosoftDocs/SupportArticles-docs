---
title: Troubleshoot Copilot Studio AI Prompts Disabled Issue
description: Learn how to fix the "This feature has been disabled" error in Microsoft Copilot Studio by enabling the AI prompts feature in your Power Platform environment.
ms.date: 02/09/2026
ms.reviewer: camogas, erickinser, v-shaywood
ms.custom: sap:Actions\AI Actions
---

# "This feature has been disabled" error for AI prompts in Copilot Studio

## Summary

This article helps you resolve the "This feature has been disabled" error that occurs when you try to create [AI prompts](/microsoft-copilot-studio/create-custom-prompt) in Microsoft Copilot Studio. This error typically appears when the AI prompts feature is disabled at the environment level in Power Platform admin center or is restricted by an organizational policy. Enabling the feature allows you to create custom prompts for your Copilot Studio agents.

## Symptoms

When you try to [create a new prompt](/microsoft-copilot-studio/create-custom-prompt#create-a-new-prompt) in Copilot Studio, the following message appears in the AI Prompt window:

> This feature has been disabled

:::image type="content" source="..\media\generative-answers\model-not-supported-error-message.png" alt-text="Screenshot of Copilot Studio interface showing disabled AI prompt feature with error notification at the top.":::

## Cause

An administrator has disabled the AI prompts feature at the environment level in Power Platform admin center or restricted it by an organizational policy. When this feature is disabled, you receive an error when you try to create an AI prompt.

## Solution

To resolve this issue, an administrator must enable the AI prompts feature in Power Platform admin center:

1. Sign in to [Power Platform admin center](https://admin.powerplatform.microsoft.com/) with administrator credentials.

1. Select **Manage** > **Environments**.

1. Select the environment where the error occurs, and then select **Settings**.

1. Go to **Product** > **Features**, locate the **AI prompts** section, and turn on the **AI prompts** toggle.

   :::image type="content" source="..\media\generative-answers\power-platform-copilot-ai-prompts.png" alt-text="Screenshot of AI prompts section in Power Platform with enable toggle active, warning about device and data security, and info link.":::

1. Select **Save**.

1. Return to Copilot Studio and confirm that the AI Prompt window no longer shows the error.

For more information, see [Enable or disable AI prompts in Power Platform and Copilot Studio](/ai-builder/administer#enable-or-disable-ai-prompts-in-power-platform-and-copilot-studio).

## Related content

- [Modify responses using custom instructions and prompt modification](/microsoft-copilot-studio/nlu-generative-answers-prompt-modification)
- [Understand error codes](../authoring/error-codes.md)
