---
title: Resolve throttling errors in agents
description: Learn how to identify and resolve throttling errors in Microsoft Copilot Studio agents, including error codes, causes, and solutions.
author: carolinamogas
ms.topic: troubleshooting
ms.date: 09/09/2025
ms.author: camogas
ms.reviewer: erickinser
ms.custom: sap:Licensing\Quotas and limits
---

# Resolve throttling errors in agents

This article describes the causes of throttling errors and how to overcome them when interacting with Copilot Studio agents.

## Symptoms

Users might receive the following error messages when interacting with a Copilot Studio agent:

- **GenAISearchandSummarizeRateLimitReached**: "The usage limit for search and summarize has been reached. Please try again later."

- **GenAIToolPlannerRateLimitReached**: "The usage limit for generative orchestration has been reached. Please try again later."

- **OpenAIRateLimitReached**: "Your agent reached the maximum number of generative answers responses."

## Cause

Copilot Studio has default constraints applied to agents that limit how often messages can be sent to the agent. These constraints exist primarily to protect against unexpected usage surges that otherwise might impact the functionality of the application.

For messages generated with the usage of generative AI and for topic orchestration, quotas limit how many requests can be sent per hour and minute per Dataverse environment. Once the limit is reached, a message is sent to the user interacting with the agent when they try to send a new message.

## Solution

If you see these error messages due to reaching the agent rate limit, review your licensing model to determine how many extra capacity packs you should acquire to cover your consumption quota, or if you should change to a pay-as-you-go model. For more information about quotas and tenant billing capacity, see [Quotas and limits](requirements-quotas.md#generative-ai-messages-to-an-agent).

### Increase the rate limit
 
Another option is to contact Microsoft Support and request a rate limit increase. However, this option doesn't guarantee that an exception or increase is granted. Each request is subject to review and approval based on eligibility and current licensing. Requests are only assessed if the environment has pay-as-you-go for Copilot Studio. Environments operating solely on message-based functionality aren't eligible for consideration.

## Related information 

For further information on rate limits and consumption of generative answers for Copilot Studio agents, review the following documentation:

- [Quotas and limits](requirements-quotas.md#generative-ai-messages-to-an-agent)

- [Generative AI messages to an agent](requirements-quotas.md#generative-ai-messages-to-an-agent)
