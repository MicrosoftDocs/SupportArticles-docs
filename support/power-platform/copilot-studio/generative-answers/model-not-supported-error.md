---
title: AI prompts error in Copilot Studio
description: Resolve the "This feature has been disabled" error in Microsoft Copilot Studio by enabling AI prompts in the Power Platform admin center.
ms.reviewer: 
  - camogas
  - erickinser
ms.date: 02/06/2026
---

# AI prompts error in Copilot Studio

This article provides steps to diagnose and resolve the "This feature has been disabled" error message that occurs when you attempt to use AI prompts in Copilot Studio agents.

## Symptoms

When you try to [create a new prompt[(/microsoft-copilot-studio/create-custom-prompt#create-a-new-prompt) in Copilot Studio, you see the following message displayed in the AI Prompt window:

*"This feature has been disabled"*

:::image type="content" source="..\media\generative-answers\model-not-supported-error-message.png" alt-text="Screenshot of Copilot Studio interface showing disabled AI prompt feature with error notification at the top.":::

## Cause

The message usually indicates that the AI prompts feature is disabled at the environment level in the Power Platform Admin Center or restricted by organizational policy. When the setting is disabled, you will receive the "This feature has been disabled" error when you attempt to create an AI prompt.

## Solution

To resolve the issue, an administrator must enable the AI prompts feature in the Power Platform Admin Center by following these steps:

1. Sign in to [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/) with administrator credentials.

1. Select **Manage** > **Environments**.

1. Choose the environment where the error occurs and go to **Settings**.

1. Under **Product** > **Features**, locate the **AI prompts** section, and turn on the **AI prompts** feature.

   :::image type="content" source="..\media\generative-answers\power-platform-copilot-ai-prompts.png" alt-text="Screenshot of AI prompts section in Power Platform with enable toggle active, warning about device and data security, and info link.":::

1. Save the changes and return to Copilot Studio and confirm that the AI prompt window no longer shows the "This feature has been disabled" message.

For more information, see [enable or disable AI prompts in Copilot Studio](/ai-builder/administer#enable-or-disable-ai-prompts-in-power-platform-and-copilot-studio).

## Related information

- [Use your prompt actions in Microsoft Copilot Studio](/ai-builder/use-a-custom-prompt-in-mcs)
