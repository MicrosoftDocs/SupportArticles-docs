---
title: Recalculate Opportunity Price
description: Learn how to recalculate Dynamics 365 Sales opportunity pricing totals.
ms.date: 07/16/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Recalculate Opportunity Price

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability after product-line changes when a seller needs refreshed opportunity totals.

## What it does
The assistant calls Dynamics 365 Sales price calculation for the opportunity and returns updated totals.

## Try prompts like
- Recalculate pricing for this opportunity.
- Refresh totals after adding the product.
- What's the new opportunity total?

## What you'll see in chat
The assistant displays a text response directly in chat. There is no interactive app-in-chat component.

## Helpful tips
- Recalculate after adding or updating product lines when the seller asks for totals.
- This tool does not choose products or prices; it refreshes current opportunity totals.

## What happens next
Use the returned totals in the seller response or continue with product-line updates.

## Does this change data?
**Yes.** This tool updates calculated opportunity pricing totals.

## Prerequisites
This tool requires read/write access to the opportunity.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Recalculate Opportunity Price |
| Internal tool name | `recalculate_opportunity_price` |
| Purpose | Refresh opportunity pricing totals. |

## Tool behavior
The tool invokes Dynamics 365 Sales price calculation for the opportunity and returns updated totals.

## Annotations
| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `false` | This tool updates calculated data. |
| `destructiveHint` | `false` | It does not delete data. |
| `idempotentHint` | `true` | Repeating the call recalculates the same current lines. |

## Input concepts
| Input | Description | Required |
|---|---|---|
| `opportunityId` | Resolved opportunity GUID. | Yes |

## Related tools
| Tool | Relationship |
|---|---|
| [`add_product`](add_product.md) | Adds lines before recalculation. |
| [`update_products`](update_products.md) | Updates lines before recalculation. |

## Routing notes
Use `recalculate_opportunity_price` only for opportunity pricing totals. Use `get_product` to inspect catalog pricing.

## Response and UI behavior
This tool returns a text-only response with structured content and no app-in-chat component.

## Data mutation classification
Updates calculated opportunity pricing totals.
