---
title: Resolve usage limit and agent unavailable errors in Copilot Studio agents
description: Learn how to identify and resolve usage limit errors that occur due to quotas and limits in Microsoft Copilot Studio agents.
ms.date: 09/09/2025
ms.reviewer: 
  - camogas
  - erickinser
  - v-shaywood
ms.custom: sap:Licensing\Quotas and limits
---

# Resolve usage limit errors in agents

This article describes common throttling errors you might encounter when using Copilot Studio agents. It explains the underlying causes, which typically stem from capacity limitations or licensing constraints, and outlines solutions for resolving these issues.

## Symptoms

You might receive one or more of the following error messages when interacting with an agent:

- **EnforcementMessage:** "This agent is currently unavailable. It has reached its usage limit. Please try again later."
- **GenAISearchandSummarizeRateLimitReached:** "The usage limit for search and summarize has been reached. Please try again later."
- **GenAIToolPlannerRateLimitReached:** "The usage limit for generative orchestration has been reached. Please try again later."
- **OpenAIRateLimitReached:** "Your agent reached the maximum number of generative answers responses."

## Cause

Copilot Studio enforces default rate and usage constraints to protect against unexpected usage surges that might affect the functionality of the application. Agent usage is measured in Copilot credits. The number of credits an agent consumes depends on the design and features of the agent. When consumption exceeds available capacity in an environment, the environment is in overage. Once overage enforcement is triggered, you see the message, "This agent is currently unavailable. It has reached its usage limit. Please try again later." For more information on credits and overage enforcement, see [Overage enforcement](/microsoft-copilot-studio/requirements-messages-management#overage-enforcement).

For messages generated with the usage of generative AI and for topic orchestration, quotas limit the number of requests that you can send per minute and per hour. Once you reach the limit, subsequent agent messages are blocked, resulting in one of the listed symptoms. These quotas and limits apply per Dataverse environment. For more information, see [Quotas and limits for Copilot Studio](/microsoft-copilot-studio/requirements-quotas).

## Solution

### Confirm the licensing and capacity model

Review the [Copilot Studio quotas and limits](/microsoft-copilot-studio/requirements-quotas) for the plan you're using, and compare it against your recent usage. To view consumption in the Power Platform admin center, see [View Copilot Credit consumption](/microsoft-copilot-studio/requirements-messages-management#view-copilot-credit-consumption).

If you reach the limits, an administrator can either:

- [Purchase additional capacity packs to cover your consumption quota](/power-platform/admin/manage-copilot-studio-messages-capacity)
- Switch to [pay as you go billing plan](/microsoft-copilot-studio/billing-licensing#copilot-studio-pay-as-you-go)
  > [!NOTE]
  > Currently, only production and sandbox environments support pay-as-you-go.

### Request a rate-limit increase

[Contact Microsoft Support](/microsoft-copilot-studio/fundamentals-support#microsoft-support) and request a rate-limit increase. This option doesn't guarantee that an exception or increase is granted. Each request is subject to review and approval based on eligibility and current licensing. Only pay-as-you-go environments are eligible; environments operating solely on message-based functionality aren't eligible for consideration.

## Related information

- [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing)
- [Quotas and limits](/microsoft-copilot-studio/requirements-quotas#generative-ai-messages-to-an-agent)
- [Understand agent error codes](~/power-platform/copilot-studio/authoring/error-codes.md)
