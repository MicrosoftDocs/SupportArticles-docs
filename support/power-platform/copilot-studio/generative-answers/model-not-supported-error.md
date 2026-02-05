---
title: ModelNotSupported error in Copilot Studio
description: Resolve the "ModelNotSupported" error in Microsoft Copilot Studio by enabling AI prompts in the Power Platform admin center.
ms.reviewer: 
  - camogas
  - erickinser
ms.date: 02/05/2026
---

# ModelNotSupported error in Copilot Studio

This article provides steps to diagnose and resolve the "ModelNotSupported" error message when attempting to use AI prompts in Copilot Studio agents.

## Symptoms

Users see the following message displayed in the AI Prompt window:

*"This feature has been disabled"*

:::image type="content" source="..\media\generative-answers\model-not-supported-error-message.png" alt-text="Screenshot of Copilot Studio interface showing disabled AI prompt feature with error notification at the top.":::

## Cause

The error occurs because the Power Platform admin didn't enable the AI prompts feature in the Power Platform Admin Center. Without this setting enabled, every time a user attempts to create an AI prompt, they receive the "ModelNotSupported" error.

## Solution

To resolve the "ModelNotSupported" error and re-enable AI prompt functionality, the administrator must enable the AI prompts feature in the Power Platform admin center. The following steps guide you through this process:

1. Access the [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/) and sign in with administrator credentials.

1. Open environment settings and select **Manage**.

1. Select **Environments** and choose the environment where the error occurs and go to **Settings**.

1. Under **Product** > **Features**, locate the **AI prompts** section, and turn on the **AI prompts** feature.

   :::image type="content" source="..\media\generative-answers\power-platform-copilot-ai-prompts.png" alt-text="Screenshot of AI prompts section in Power Platform with enable toggle active, warning about device and data security, and info link.":::

1. Save your changes and return to Copilot Studio and confirm that the AI prompt window no longer shows the "This feature has been disabled" message.

## Related information

- [Use your prompt actions in Microsoft Copilot Studio](/ai-builder/use-a-custom-prompt-in-mcs)
