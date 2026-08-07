---
title: Close Opportunity
description: Learn how to use the Close Opportunity capability in Dynamics 365 Sales.
ms.date: 07/21/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Close Opportunity

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a seller has reached the end of a deal and wants to close the opportunity as won or lost.

## What it does

The assistant closes a Dynamics 365 Sales opportunity as **won** or **lost**, using the WinOpportunity or LoseOpportunity messages. It records the outcome and, optionally, the actual revenue, close date, a closure note, and the winning or losing competitor. You provide the opportunity's GUID and the outcome.

## Try prompts like

- Close this opportunity as won for $240,000
- Mark this deal as lost — we lost to the competitor
- Close the opportunity as won with today's date
- Close this deal as lost, out-sold

## What you'll see in chat

The assistant displays a text response confirming that the opportunity was closed as won or lost. There is no interactive app-in-chat component for this capability.

## Helpful tips

- Confirm the outcome with the seller before closing — this is a lifecycle change.
- Supply `actualRevenue` for won deals so pipeline reporting stays accurate.
- Provide `competitorId` when a competitor won or lost the deal, and `statusCode` only for a specific status reason (for example, Out-Sold).

## What happens next

- Summarize this opportunity
- Draft a thank-you or follow-up email
- Reopen this opportunity

## Does this change data?

**Yes, this can change data.**

## Prerequisites

This tool requires permission to write the opportunity and to create the opportunity closure activity in the selected Dynamics 365 environment.

## Tool summary

| Property | Value |
|---|---|
| User-facing name | Close Opportunity |
| Internal tool name | `close_opportunity` |
| Purpose | Close an opportunity as won or lost. |

## Tool behavior

The tool invokes WinOpportunity (won) or LoseOpportunity (lost), creating the opportunity closure activity with the supplied revenue, close date, competitor, and note, and setting the opportunity's state and status accordingly. It doesn't create quotes, orders, or follow-up activities.

## Annotations

| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `false` | This tool modifies data. |
| `destructiveHint` | `false` | Closing is a state transition; the record isn't deleted. |
| `idempotentHint` | `false` | Closing an already-closed opportunity isn't a repeatable no-op. |
| `openWorldHint` | Not set | Uses default behavior. |

## Input concepts

### Opportunity and outcome

| Input | Description | Required |
|---|---|---|
| `opportunityId` | Dataverse GUID of the open opportunity to close. | Yes |
| `status` | Close outcome: `won` or `lost`. | Yes |
| `actualRevenue` | Optional actual revenue booked at close (non-negative). Typically supplied for a won deal. | No |
| `closeDate` | Optional close date as an ISO 8601 string. Defaults to now. | No |
| `competitorId` | Optional winning/losing competitor GUID to record on the closure. | No |
| `description` | Optional closure note recorded on the closure activity's description. The subject is set automatically from the outcome. | No |
| `statusCode` | Optional status reason override (for example, 3 = Won, 4 = Canceled, 5 = Out-Sold). Defaults by outcome: won closes as Won; lost closes as Out-Sold when a competitor is named, otherwise Canceled. | No |

## Response and UI behavior

### Response type

Text-only

No interactive component is rendered.

## Routing notes

Use `close_opportunity` when the user wants to finalize a deal as won or lost. Don't use `close_opportunity` to reopen a closed deal (use `reopen_opportunity`), to move sales stages (use `update_bpf_stage`), or to update ordinary fields (use `update_entity_record`).

## Related tools

| Tool | Relationship |
|---|---|
| [`reopen_opportunity`](reopen_opportunity.md) | Reopens a closed opportunity. |
| [`get_opportunity_summary`](get_opportunity_summary.md) | Reviews the deal before closing. |
| [`link_competitor_to_opportunity`](link_competitor_to_opportunity.md) | Records a competitor on an open opportunity. |

## Data mutation classification

Write / mutation.

The tool changes Dataverse data when it closes the opportunity and creates the closure activity. Closing is a one-way lifecycle transition (use `reopen_opportunity` to reverse it), so it isn't marked idempotent.
