---
title: Copy Reply
description: Learn how to preview and copy a drafted reply in Dynamics 365 Customer Service.
ms.date: 06/25/2026
ms.topic: reference
ms.service: dynamics-365-customer-service
author: dleblond
ms.author: dleblond
ms.reviewer: laalexan
---

# Copy Reply

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Customer Service. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability to preview and copy a non-email reply (such as a chat message, phone-call talking points, or internal note) that the assistant has drafted for your case.

## What it does
When you select a non-email reply action from the next-best-action suggestions, the assistant generates a draft reply and shows it for your review. The reply is copied to your clipboard so you can paste it into the appropriate channel (chat window, phone script, internal note field).

No record is created automatically - the assistant prepares the content and lets you decide where to use it.

## Try prompts like
This capability is typically triggered from the next-best-action widget rather than by typing a prompt directly. You'll see it when:

- You select a chat reply action from the suggested next steps
- You select a phone-call talking points action
- You select an internal note response action

## What you'll see in chat
The assistant shows a preview of the drafted reply inside the next-best-action widget. The reply is automatically copied to your clipboard, and a brief "Copied" confirmation appears.

## Helpful tips
- The reply is copied to your clipboard automatically - just paste it where needed.
- Review the draft before pasting. You can edit it in the destination field.
- This only generates non-email replies. For email drafts, use the email draft capability.
- The draft is based on the case context and the suggestion type selected.

## What happens next
After the reply is previewed and copied, you can:

- "Paste and send in the chat window"
- "Draft an email instead"
- "Suggest another action for this case"

## Does this change data?
**No, this does not change data.**

The reply preview is generated for your review only. No Dataverse records are created or modified. You control where and when to paste the content.

## Prerequisites
This tool requires the following:

- This tool is widget-invoked
- Requires the Dynamics 365 Customer Service MCP server
- Customer Intent Agent (or Case Management Agent) to be configured. It calls the msdyn_GetAutonomousDraftContent API, which requires the intent-assist infrastructure to be active

Learn more in [Manage Customer Intent Agent](/dynamics365/contact-center/administer/manage-customer-intent-agent).

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Copy Reply |
| Internal tool name | `get_response_preview` |
| Purpose | Generates a non-email reply (chat message, phone-call talking points, internal note) from a V2 next-best-action step's draft context via the `msdyn_GetAutonomousDraftContent` API |

## Tool behavior
Generates a non-email reply (chat message, phone-call talking points, internal note) from a V2 next-best-action step's draft context via the `msdyn_GetAutonomousDraftContent` API. Returns the composed reply text for inline preview and clipboard copy without creating any Dataverse Activity record.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | This tool does not modify data. |
| `destructiveHint` | Not set | Not applicable (read-only tool). |
| `idempotentHint` | Not set | Not applicable (read-only tool). |
| `openWorldHint` | Not set | Uses default. |

## Input concepts
### Case identifier

| Input | Description | Required |
|---|---|---|
| `caseId` | `caseId` (required). The Dataverse incidentid (GUID) of the open case. | Yes |

### Suggestion type

| Input | Description | Required |
|---|---|---|
| `suggestionSubtype` | `suggestionSubtype` (required). Must be `Interview` or `SolutionResponse`. Determines the type of reply content generated. | Yes |

### Reply content

| Input | Description | Required |
|---|---|---|
| `suggestionResponse` | `suggestionResponse` (required). The LLM-composed reply content from the V2 step's draft generation context. | Yes |

### Intent family

| Input | Description | Required |
|---|---|---|
| `intentFamilyId` | `intentFamilyId` (optional). Resolved per-case line-of-business family GUID. Omit when not resolved. | No |

### Reply mode

| Input | Description | Required |
|---|---|---|
| `replyActivityType` | `replyActivityType` (required). The non-email reply mode (e.g. `chat`, `phonecall`, `task`). Echoed to the widget for display. | Yes |

## Response and UI behavior
### Response type

Text-only (inline in widget overlay)

No standalone interactive component is rendered. The response is consumed by the intent-assist widget, which displays a preview overlay with the composed reply and a clipboard-copy action.

## Routing notes
Use `get_response_preview` when:

- The intent-assist widget needs a non-email reply preview
- The V2 NBA step's `replyActivityType` is anything other than `email`

Don't use `get_response_preview` when:

- The user wants to **compose an email** - route to email draft tools
- The user wants a **general case summary** - route to `summarize_case`

## Related tools
| Tool | Relationship |
|---|---|
| [`suggest_next_action_for_case`](suggest_next_action_for_case.md) | Parent tool that generates the NBA steps. `get_response_preview` is invoked from its widget |
| [`submit_feedback`](submit_feedback.md) | Records feedback on the generated reply |

## Data mutation classification
Read-only.

No Dataverse records are created or modified. The generated reply is displayed for preview and copied to the clipboard for the agent to paste into the downstream surface.
