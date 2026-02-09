---
title: Troubleshoot Copilot Studio AI Prompts Disabled Issue
description: Resolve the "This feature has been disabled" error in Copilot Studio by enabling AI prompts in the Power Platform admin center. Follow our step-by-step guide.
ms.date: 02/09/2026
ms.reviewer: camogas, erickinser, v-shaywood
ms.custom: sap:Actions\AI Actions
---

# "This feature has been disabled" error in Copilot Studio

## Summary

This article helps you resolve the "This feature has been disabled" error that occurs when you try to use AI prompts in Microsoft Copilot Studio agents. This error typically appears when the AI prompts feature is disabled in the Power Platform admin center.

## Symptoms

When you try to [create a new prompt](/microsoft-copilot-studio/create-custom-prompt#create-a-new-prompt) in Copilot Studio, the following message appears in the AI Prompt window:

> This feature has been disabled

:::image type="content" source="..\media\generative-answers\model-not-supported-error-message.png" alt-text="Screenshot of the Copilot Studio interface showing the disabled AI prompt feature with an error notification.":::

## Cause

This error occurs when you attempt to create an AI prompt but the AI prompts feature is disabled at the environment level in the Power Platform admin center or restricted by organizational policy.

## Solution

To resolve this issue, an administrator must enable the AI prompts feature in the Power Platform admin center:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/) with administrator credentials.

1. Go to **Manage** > **Environments**.

1. Select the environment where the error occurs, and then select **Settings**.

1. Go to **Product** > **Features**, locate the **AI prompts** section, and turn on the **AI prompts** toggle.

   :::image type="content" source="..\media\generative-answers\power-platform-copilot-ai-prompts.png" alt-text="Screenshot of the AI prompts section in Power Platform admin center with the enable toggle turned on.":::

1. Save your changes.

1. Return to Copilot Studio and confirm that the AI Prompt window no longer shows the error message.

For more information, see [Enable or disable AI prompts in Copilot Studio](/ai-builder/administer#enable-or-disable-ai-prompts-in-power-platform-and-copilot-studio).

## Related content

- [Use your prompt actions in Microsoft Copilot Studio](/ai-builder/use-a-custom-prompt-in-mcs)
- [Create a prompt](/microsoft-copilot-studio/create-custom-prompt)
- [Administer AI Builder](/ai-builder/administer)
