---
title: Resolve Copilot Studio Usage Limit and Agent Unavailable Errors
description: Copilot Studio usage limit and agent unavailable errors can result from quotas or insufficient Copilot Credits. Learn how to restore access.
ms.date: 10/14/2026
ms.reviewer: 
  - camogas
  - erickinser
  - mapichle
  - v-shaywood
  - arielm
ms.custom: sap:Licensing\Quotas and limits
ai-usage: ai-assisted
---

# Copilot Studio usage limit and agent unavailable errors

## Summary

This article helps you resolve throttling, usage limit, and agent unavailable errors in Microsoft Copilot Studio. These errors occur when agent usage exceeds capacity or generative AI rate limits, or when an environment has no Copilot Credits to run agent flows or workflows. Use the resolution steps for the cause that matches your error.

## Symptoms

You might receive one or more of the following error messages or behaviors when interacting with an agent:

- **EnforcementMessage:** "This agent is currently unavailable. It has reached its usage limit. Please try again later."
- **GenAISearchandSummarizeRateLimitReached:** "The usage limit for search and summarize has been reached. Please try again later."
- **GenAIToolPlannerRateLimitReached:** "The usage limit for generative orchestration has been reached. Please try again later."
- **OpenAIRateLimitReached:** "The OpenAI usage limit has been reached. Please try again later."
- **FlowActionForbidden:** In an agent built with the standard harness, the conversation shows this error code. In the test chat, the error details can include "The environment '`<EnvironmentId>`' does not have sufficient Copilot Credits to run workflows."
- **InsufficientMcsCredits:** When you start an agent flow directly, the run fails with this error code and the message "The environment '`<EnvironmentId>`' does not have sufficient Copilot Credits to run workflows." When you test a workflow, the error details include `InsufficientMcsCredits`.
- **Tool call failure:** In an agent built with the GitHub Copilot harness, the tool call fails with the message "Your environment is out of Copilot Credits."

When an agent flow or workflow is blocked, the agent still answers questions that don't need the flow.

## Determine the cause of the problem

Match the error message to the appropriate cause:

- For `EnforcementMessage`, `GenAISearchandSummarizeRateLimitReached`, `GenAIToolPlannerRateLimitReached`, or `OpenAIRateLimitReached`, see [Cause: Agent usage exceeds the environment's capacity or generative AI rate limits](#cause-agent-usage-exceeds-the-environments-capacity-or-generative-ai-rate-limits).
- For `FlowActionForbidden`, `InsufficientMcsCredits`, or the message "Your environment is out of Copilot Credits," see [Cause: The environment doesn't have Copilot Credits to run agent flows or workflows](#cause-the-environment-doesnt-have-copilot-credits-to-run-agent-flows-or-workflows).

> [!NOTE]
> `FlowActionForbidden` is also returned when a flow call is denied for other reasons, such as permissions. Check the error details for the message about Copilot Credits before you continue.

## Cause: Agent usage exceeds the environment's capacity or generative AI rate limits

Copilot Studio enforces default rate and usage constraints to protect against unexpected usage surges that might affect the functionality of the application. Agent usage is measured in Copilot credits. The number of credits an agent consumes depends on the design and features of the agent. When consumption exceeds available capacity in an environment, the environment is in overage. Once overage enforcement is triggered, you see the message, "This agent is currently unavailable. It has reached its usage limit. Please try again later." For more information on credits and overage enforcement, see [Overage enforcement](/microsoft-copilot-studio/requirements-messages-management#overage-enforcement).

For messages generated with the usage of generative AI and for topic orchestration, quotas limit the number of requests that you can send per minute and per hour. Once you reach the limit, subsequent agent messages are blocked, resulting in one of the listed symptoms. These quotas and limits apply per Dataverse environment. For more information, see [Quotas and limits for Copilot Studio](/microsoft-copilot-studio/requirements-quotas).

### Solution: Review quotas and Copilot credit consumption

Review the [Copilot Studio quotas and limits](/microsoft-copilot-studio/requirements-quotas) that apply to your environment, and compare them against your recent usage. To view consumption in the Power Platform admin center, see [View Copilot Credit consumption](/microsoft-copilot-studio/requirements-messages-management#view-copilot-credit-consumption).

If your usage reaches these limits, an administrator can review the capacity options available to your organization. For licensing and capacity details, see [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing) and [Manage Copilot Credits and capacity for Copilot Studio](/power-platform/admin/manage-copilot-studio-copilot-credits-capacity).

If the environment is in overage, the steps in [Solution: Make Copilot Credits available to the environment](#solution-make-copilot-credits-available-to-the-environment) also apply to the "This agent is currently unavailable" error.

### Solution: Request a rate-limit increase for Copilot Studio

[Contact Microsoft Support](/microsoft-copilot-studio/fundamentals-support#microsoft-support) and request a rate-limit increase. This option doesn't guarantee that an exception or increase is granted. Each request is subject to review and approval, and eligibility depends on your environment's licensing configuration. For licensing details, see [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing).

### Solution: Plan agent deployments for throughput and rate limits

Proactive throughput planning before user acceptance testing (UAT), load testing, or production launch can help you avoid throttling errors. Review the rate limits that apply across Copilot Studio, Power Automate, Dataverse, connectors, and any downstream APIs your agent uses. Estimate peak traffic windows rather than relying on monthly averages, and consider design optimizations to reduce throughput pressure before requesting a limit increase.

For more information, see [Plan Copilot Studio agent deployments for throughput and rate limits](/microsoft-copilot-studio/guidance/plan-agent-throughput-rate-limits).

## Cause: The environment doesn't have Copilot Credits to run agent flows or workflows

The environment had no Copilot Credits available when the run started. Not every agent flow run is blocked in this situation (see the following table). New agent flow and workflow runs are blocked until credits are available to the environment. Runs that already started finish normally. For more information, see [Agent flow enforcement](/microsoft-copilot-studio/requirements-messages-management#agent-flow-enforcement). For licensing details, see [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing).

### Check whether the agent flow run is blocked

| How the agent flow run started | Blocked when the environment has no credits |
| --- | --- |
| An agent calls an agent flow that uses the **When an agent calls the flow** trigger, while a user who is authenticated with Microsoft Entra ID is interacting with the agent | Depends on the licensing that applies to that user. See [Agent flow enforcement](/microsoft-copilot-studio/requirements-messages-management#agent-flow-enforcement). |
| The same, but the user isn't authenticated with Microsoft Entra ID, for example an anonymous website visitor, a phone caller, or a user who signs in through a different identity provider | Yes |
| An agent calls an agent flow while it runs autonomously, for example after an event trigger or a Power Automate flow starts the agent | Yes |
| An agent calls an agent flow from its test chat | No |
| You test an agent flow in the flow designer | No |
| An agent flow starts from its own trigger, such as a schedule or a new email | Yes |

This table covers agent flows. For workflows that you build in the workflows experience, see [Manage workflow capacity usage](/microsoft-copilot-studio/workflows-experience/flows-overview#manage-workflow-capacity-usage).

As the table shows, a flow that works in the test chat can still be blocked in Teams, on a website, or when the agent runs autonomously. A flow that works in one environment can still be blocked in another environment that has no credits available.

### Solution: Make Copilot Credits available to the environment

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), go to **Licensing** > **Copilot Studio** > **Environments**, select the environment, and review the **Agent flow actions** row in the **Copilot credit consumption details** grid.
1. Make credits available to the environment in one of these ways:

   - Allocate Copilot Credits to the environment. Go to **Licensing** > **Copilot Studio**, and then select **Manage Copilot Credits**.
   - Under **Capacity overages**, select **Draw from the available capacity in my tenant**. For the other option in this panel, see [Overage management](/power-platform/admin/manage-copilot-studio-copilot-credits-capacity#overage-management).

   If no credits are available to allocate, see [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing) for the options available to your organization.

1. Wait up to 15 minutes for the credit availability to refresh, and then try again from the channel where the run failed.
1. If runs are blocked while users interact with the agent, make sure the agent is configured to authenticate users with Microsoft Entra ID and that the flow uses the **When an agent calls the flow** trigger. For the conditions that apply to those runs, see [Agent flow enforcement](/microsoft-copilot-studio/requirements-messages-management#agent-flow-enforcement).

> [!NOTE]
> Agent limits that you set in **Manage Agents** in the Power Platform admin center don't stop or unblock agent flow runs. For more information, see [Manage monthly consumption limits for Copilot Studio agents](/power-platform/admin/manage-copilot-studio-copilot-credits-capacity#manage-monthly-consumption-limits-for-copilot-studio-agents).

## Related content

- [Copilot Studio licensing](/microsoft-copilot-studio/billing-licensing)
- [Quotas and limits](/microsoft-copilot-studio/requirements-quotas#generative-ai-messages-to-an-agent)
- [Understand agent error codes](../authoring/error-codes.md)
- [Manage Copilot Credits and capacity for Copilot Studio](/power-platform/admin/manage-copilot-studio-copilot-credits-capacity)
