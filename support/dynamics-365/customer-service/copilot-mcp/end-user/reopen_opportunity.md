---
title: Reopen Opportunity
description: Learn how to use the Reopen Opportunity capability in Dynamics 365 Sales.
ms.date: 07/21/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Reopen Opportunity

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a closed deal becomes active again and the seller wants to continue working it.

## What it does

The assistant returns a closed (won or lost) Dynamics 365 Sales opportunity to the Open state so the seller can keep working it. You provide the opportunity GUID; optionally you can set the open status reason.

## Try prompts like

- Reopen this opportunity
- The customer is back — reactivate this deal
- Move this closed opportunity back to open
- Reopen the deal as on hold

## What you'll see in chat

The assistant displays a text response confirming that the opportunity was reopened. There is no interactive app-in-chat component for this capability.

## Helpful tips

- Confirm with the seller before reopening a closed deal.
- Provide `statusCode` only when a specific open status (such as On Hold) is needed; otherwise the deal reopens as In Progress.
- Resolve the opportunity to its GUID before calling this tool.

## What happens next

- Summarize this opportunity
- Add or update products on the deal
- Draft a re-engagement email
- Update the sales stage

## Does this change data?

**Yes, this can change data.**

## Prerequisites

This tool requires permission to write the opportunity in the selected Dynamics 365 environment.

## Tool summary

| Property | Value |
|---|---|
| User-facing name | Reopen Opportunity |
| Internal tool name | `reopen_opportunity` |
| Purpose | Return a closed opportunity to the Open state. |

## Tool behavior

The tool sets the opportunity's state back to Open with the requested open status reason, defaulting to In Progress. It doesn't change products, revenue, or other opportunity fields.

## Annotations

| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `false` | This tool modifies data. |
| `destructiveHint` | `false` | This tool does not perform destructive changes. |
| `idempotentHint` | `true` | Reopening an already-open opportunity leaves it open. |
| `openWorldHint` | Not set | Uses default behavior. |

## Input concepts

### Opportunity

| Input | Description | Required |
|---|---|---|
| `opportunityId` | Dataverse GUID of the closed opportunity to reopen. | Yes |
| `statusCode` | Optional open status reason (for example, 1 for In Progress, 2 for On Hold). Defaults to In Progress. | No |

## Response and UI behavior

### Response type

Text-only

No interactive component is rendered.

## Routing notes

Use `reopen_opportunity` when the user wants to reactivate a closed deal. Don't use `reopen_opportunity` to close a deal or to update non-status fields (use `update_entity_record`).

## Related tools

| Tool | Relationship |
|---|---|
| [`get_opportunity_summary`](get_opportunity_summary.md) | Reviews the deal before or after reopening. |
| [`update_entity_record`](update_entity_record.md) | Updates other opportunity fields. |
| [`update_bpf_stage`](update_bpf_stage.md) | Moves the reopened deal to the right sales stage. |

## Data mutation classification

Write / mutation.

The tool changes Dataverse data when it returns the opportunity to the Open state. Repeating the same reopen is idempotent.
