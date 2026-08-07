---
title: Summarize a closed conversation
description: Learn how to use the Summarize a closed conversation capability in Dynamics 365 Customer Service.
ms.date: 06/25/2026
ms.topic: reference
ms.service: dynamics-365-customer-service
author: dleblond
ms.author: dleblond
ms.reviewer: laalexan
---

# Summarize a closed conversation

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Customer Service. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you want the assistant to help you summarize a closed conversation from chat.

## What it does
Generates an AI-powered summary for a closed omnichannel chat or voice conversation.

## Try prompts like
- "Summarize conversation 00000000-0000-0000-0000-000000000000"
- "Recap this closed chat"
- "Give me a brief for this voice conversation"
- "Summarize the omnichannel conversation"

## What you'll see in chat
The assistant shows a summary card with the conversation subject, channel, customer, owning agent, and generated summary.

## Helpful tips
- Use this only for closed conversations.
- Use a conversation ID, not a case ID.
- For in-progress conversations, wait until the conversation ends before summarizing.

## What happens next
- "Open the conversation record for more details"
- "Use the summary to update the related case"
- "Ask follow-up questions about the customer issue"

## Does this change data?
**No, summarizing a conversation does not change Dynamics 365 data.**

## What you can do from the app-in-chat component
From the component in chat, you can:

- Review the current result or state
- Open the related Dynamics 365 record when the component provides a link
- Continue the workflow with the available component actions

## Prerequisites
This tool requires the following:

- Copilot conversation summaries to be enabled

Learn more in , [Provision channels in Dynamics 365 Contact Center](/dynamics365/contact-center/implement/provision-channels), and [Enable Copilot case and conversation summaries](/dynamics365/contact-center/administer/copilot-enable-summary).

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Conversation Summary |
| Internal tool name | `summarize_conversation` |
| Purpose | Generates an AI-powered summary of a CLOSED omnichannel chat or voice conversation (`msdyn_ocliveworkitem`) via the Copilot intelligence backend |

## Tool behavior
Generates an AI-powered summary of a CLOSED omnichannel chat or voice conversation (`msdyn_ocliveworkitem`) via the Copilot intelligence backend. Renders a standalone summary card with subject, channel, customer, and owning agent. Only summarizes closed conversations (`statecode === 1`); for in-progress conversations the widget surfaces an info banner directing the user to wait until the conversation ends.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | This tool does not modify data. |
| `destructiveHint` | Not set | Not applicable. |
| `idempotentHint` | Not set | Not applicable. |
| `openWorldHint` | `true` | Calls an external intelligence backend outside Dataverse. |

## Input concepts
### Conversation ID

| Input | Description | Required |
|---|---|---|
| `conversationId` | `conversationId` (GUID, required). The `msdyn_ocliveworkitemid` of the closed conversation to summarize. | Yes |

## Response and UI behavior
This MCP tool is supported by an MCP App. [Learn more about MCP Apps](/dynamics365/customer-service/administer/use-mcp-apps-in-chat).

### Response type

Interactive (widget)

Renders a summary card with conversation subject, channel, customer, and owning agent. For in-progress conversations, surfaces an info banner indicating the conversation is still active.

## Routing notes
Use `summarize_conversation` when:

- The user asks to summarize, recap, or brief a specific omnichannel conversation by ID
- Pre-check `check_summary_enabled` to confirm `conversationSummaryEnabled: true`

Don't use `summarize_conversation` when:

- The entity is a **case (incident)** - route to `summarize_case` or `summarize_case_text`
- The conversation is still open/active (the tool will surface an info banner, but is not useful for in-progress sessions)

## Related tools
| Tool | Relationship |
|---|---|
| [`check_summary_enabled`](check_summary_enabled.md) | Pre-check to confirm conversation summary is enabled |
| [`summarize_case`](summarize_case.md) | AI summary for cases (incidents). Use for case entities, not conversations |

## Data mutation classification
**Read-only.** Reads conversation data and calls the AI intelligence backend; does not create or modify records.
