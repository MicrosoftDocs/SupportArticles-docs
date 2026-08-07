---
title: Link Competitor to Opportunity
description: Learn how to use the Link Competitor to Opportunity capability in Dynamics 365 Sales.
ms.date: 07/21/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Link Competitor to Opportunity

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a seller identifies a competitor on a deal and wants it recorded on the opportunity.

## What it does

The assistant associates a competitor with a Dynamics 365 Sales opportunity, or removes that association when `unlink` is set to true. You provide the opportunity and competitor GUIDs.

## Try prompts like

- Link Salesforce as a competitor on this opportunity
- Add this competitor to the deal
- Remove the competitor from this opportunity
- Track a competitor against this deal

## What you'll see in chat

The assistant displays a text response confirming that the competitor was linked or unlinked. There is no interactive app-in-chat component for this capability.

## Helpful tips

- Resolve both the opportunity and the competitor to their GUIDs before calling this tool.
- Set `unlink` to true to remove a competitor that was linked in error.
- Use record-view tools to inspect the competitors already associated with a deal.

## What happens next

- Show competitor research for this deal
- Summarize this opportunity
- Add a note about the competitive situation
- Draft a differentiation email

## Does this change data?

**Yes, this can change data.**

## Prerequisites

This tool requires permission to append to the opportunity and to append the competitor — that is, to associate the two records — in the selected Dynamics 365 environment.

## Tool summary

| Property | Value |
|---|---|
| User-facing name | Link Competitor to Opportunity |
| Internal tool name | `link_competitor_to_opportunity` |
| Purpose | Associate or disassociate a competitor with an opportunity. |

## Tool behavior

The tool adds a competitor to the opportunity's competitor relationship, or removes it when `unlink` is true. It doesn't create the competitor record or modify other opportunity fields.

## Annotations

| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `false` | This tool modifies data. |
| `destructiveHint` | `false` | Removing a link doesn't delete the competitor record. |
| `idempotentHint` | `true` | Linking an already-linked competitor leaves the same association. |
| `openWorldHint` | Not set | Uses default behavior. |

## Input concepts

### Opportunity and competitor

| Input | Description | Required |
|---|---|---|
| `opportunityId` | Dataverse GUID of the opportunity. | Yes |
| `competitorId` | Dataverse GUID of the competitor to link or unlink. | Yes |
| `unlink` | Set to true to remove the association instead of adding it. Defaults to false. | No |

## Response and UI behavior

### Response type

Text-only

No interactive component is rendered.

## Routing notes

Use `link_competitor_to_opportunity` when the user wants to record or remove a competitor on a deal. Don't use `link_competitor_to_opportunity` to create a new competitor record (use `create_entity_record`) or to research a competitor.

## Related tools

| Tool | Relationship |
|---|---|
| [`get_opportunity_summary`](get_opportunity_summary.md) | Reviews the deal, including competitive context. |
| [`create_entity_record`](create_entity_record.md) | Creates a competitor record when one doesn't exist. |
| [`update_entity_record`](update_entity_record.md) | Updates other opportunity fields. |

## Data mutation classification

Write / mutation.

The tool changes Dataverse data when it adds or removes the opportunity-competitor association. Repeating the same link is idempotent.
