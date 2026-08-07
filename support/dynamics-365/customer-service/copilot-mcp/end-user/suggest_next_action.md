---
title: Suggest Next Action
description: Learn how to use the Suggest Next Action capability for a Teams Voice live work item in Dynamics 365 Customer Service.
ms.date: 08/05/2026
ms.topic: reference
ms.service: dynamics-365-customer-service
author: gtpo
ms.author: gtpo
ms.reviewer: laalexan
---

# Suggest Next Action

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Customer Service. For the Teams Voice flow described here, runtime availability still depends on the applicable rollout and admin configuration gates. Until those gates are enabled for the selected environment, the tool can be hidden from the Service Agent catalog or rejected at call time. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you need help deciding what a representative should do next during an active Teams Voice conversation. The assistant analyzes the live work item transcript and returns the best next steps.

## What it does
The assistant reviews the ordered Teams Voice transcript, the live work item context, and any supplemental planner signals to recommend the best next actions to take. Suggestions can include replying to the customer or other context-specific steps for the current conversation.

When a widget appears, you can review the suggested actions and inspect the supporting details in chat.

## Try prompts like
- "What should the representative do next on this live call?"
- "Suggest the next best action for this Teams Voice conversation"
- "What is the best next step for this live work item?"
- "Help me triage this active customer call"
- "Suggest actions for this transcript"

## What you'll see in chat
The assistant displays an interactive next-best-action panel as an app-in-chat component. The panel shows AI-recommended steps for the current live conversation and can include draft reply content when available.

## Helpful tips
- This works best when the live work item has a complete, ordered transcript.
- Include supplemental context when you have it, such as planner signals or a resolved line of business.
- Use text-only mode when you only need the recommendations and not the interactive widget.
- Use proactive mode when you want risk and insight surfacing without a separate follow-up step.
- Use `suggest_next_action` for Teams Voice live work items, not Dataverse cases.

## What happens next
After the suggestions appear, you can continue with prompts like:

- "Draft a reply based on the top recommendation"
- "Summarize the current conversation"
- "Show the recommended next action as text only"

## Does this change data?
**This step is read-only, but follow-up actions from it may change data.**

Viewing the suggestions does not change any records. If you select or act on a follow-up step, that downstream action can modify data and can require confirmation.

## What you can do from the app-in-chat component
From the next-best-action panel, you can:

- Review the AI-suggested action steps
- Inspect supporting details for each recommendation
- Use the recommendations to guide your next follow-up prompt
- Request the same recommendation set as text only when needed

## Prerequisites
This tool requires the following:

- A Teams Voice live work item (`msdyn_ocliveworkitem`) with an ordered transcript
- Suggest Next Action to be enabled for the environment through the applicable rollout and admin configuration gates

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Suggest Next Action |
| Internal tool name | `suggest_next_action` |
| Purpose | Analyzes a Teams Voice live work item transcript and returns AI-suggested next-best-action steps |

## Tool behavior
Analyzes a Teams Voice live work item (`msdyn_ocliveworkitem`) by using its ordered transcript, the live work item identifier, and optional supplemental context to generate actionable next-step recommendations. This tool is for live conversation analysis. For Dataverse cases, use `suggest_next_action_for_case` instead.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | The tool reads conversation context and returns recommendations without modifying data. |
| `destructiveHint` | Not set | Not applicable. |
| `idempotentHint` | Not set | Not applicable. |
| `openWorldHint` | Not set | Uses default (queries Dataverse-backed services). |

## Input concepts
### Live work item context

| Input | Description | Required |
|---|---|---|
| `context.entity.entityId` | Dataverse GUID of the Teams Voice live work item. | Yes |
| `context.entity.entityLogicalName` | Must be `msdyn_ocliveworkitem`. | Yes |
| `context.entity.lineOfBusiness` | Optional resolved LOB / intent-family GUID. When present, the planner skips intent-family resolution. | No |

### Transcript turns

| Input | Description | Required |
|---|---|---|
| `context.messages` | Ordered Teams Voice transcript turns with unique IDs, strictly increasing `sequence` values, UTC timestamps, role, and content. Maximum 500 turns. Each `id` must be 1-200 characters and each `content` value can be up to 10,000 characters. | Yes |

### Supplemental planner context

| Input | Description | Required |
|---|---|---|
| `context.additionalContext` | Supplemental key/value planner signals to weigh alongside the transcript. Always send the field; use `[]` when there are no supplemental signals. Maximum 50 entries. Each `key` can be up to 200 characters and each string `value` can be up to 4,000 characters. | Yes |

### Response options

| Input | Description | Required |
|---|---|---|
| `userLanguage` | Optional BCP 47 locale of the representative, for example `en-US`. Maximum 20 characters. | No |

### Mode flags

| Input | Description | Required |
|---|---|---|
| `textOnly` | When `true`, returns a text-only response without the widget. | No |
| `proactiveMode` | When `true`, surfaces proactive risks and insights without a separate explicit follow-up prompt. Returns text-only. | No |

## Input limits and validation
- `context.messages` is required and accepts up to 500 ordered transcript turns.
- Every transcript turn must have a unique `id` and a strictly increasing `sequence` value.
- Each transcript `id` can be 1-200 characters, and each transcript `content` value can be up to 10,000 characters.
- `context.additionalContext` is required even when there are no supplemental signals; send `[]` in that case.
- `context.additionalContext` accepts up to 50 entries. Each `key` can be up to 200 characters, and each string `value` can be up to 4,000 characters.
- `userLanguage`, when present, can be up to 20 characters and must be a valid BCP 47 language tag such as `en-US`.

## Response and UI behavior
This tool renders an interactive next-best-action widget unless `textOnly` or `proactiveMode` is set.

This MCP tool is supported by an MCP App. [Learn more about MCP Apps](/dynamics365/customer-service/administer/use-mcp-apps-in-chat).

### Response type

Interactive component (app-in-chat) or text-only

When the widget renders, it displays AI-suggested next steps for the active Teams Voice conversation. In text-only mode, the recommendations are returned as plain text in the chat response.

## Routing notes
Use `suggest_next_action` when:

- The user asks what a representative should do next during an active Teams Voice conversation
- The caller can supply an `msdyn_ocliveworkitem` transcript
- The goal is live-conversation triage rather than case triage

Don't use `suggest_next_action` when:

- The user wants next steps for a Dataverse case - route to `suggest_next_action_for_case`
- The user explicitly wants a case summary - route to `summarize_case`
- The user wants to preview a specific response only - route to `get_response_preview`

## Related tools
| Tool | Relationship |
|---|---|
| [`suggest_next_action_for_case`](suggest_next_action_for_case.md) | Case-focused counterpart. Use it for Dataverse incident triage rather than Teams Voice live work items |
| [`get_response_preview`](get_response_preview.md) | Generates non-email reply previews for an intent-based suggestion |
| [`submit_feedback`](submit_feedback.md) | Records feedback on intent-based suggestions |

## Data mutation classification
Read-only entry point with downstream mutation potential.

The tool reads live conversation context and returns AI suggestions without modifying records. Downstream actions based on a recommendation can trigger separate write operations.
