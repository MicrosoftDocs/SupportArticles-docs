---
title: Update Products
description: Learn how to update Dynamics 365 Sales opportunity product lines.
ms.date: 07/16/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Update Products

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a seller confirms changes to existing opportunity product lines.

## What it does
The assistant updates one or more opportunity product lines, such as quantity, unit, product, unit price, discount, or line description.

## Try prompts like
- Change the Microsoft 365 E5 line to 250 users.
- Update this opportunity product line with a manual discount.
- Change the product line description.

## What you'll see in chat
The assistant displays a text response directly in chat. There is no interactive app-in-chat component.

## Helpful tips
- Confirm the exact product line before updating it.
- Use `opportunityId` to verify updates are scoped to the intended opportunity.

## What happens next
After updating lines, use `recalculate_opportunity_price` when updated opportunity totals are needed.

## Does this change data?
**Yes.** This tool updates opportunity product lines.

## Prerequisites
This tool requires read/write access to opportunity product lines and read access to the opportunity.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Update Products |
| Internal tool name | `update_products` |
| Purpose | Update opportunity product lines. |

## Tool behavior
The tool patches existing opportunity product lines and returns the refreshed line summaries.

## Annotations
| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `false` | This tool changes data. |
| `destructiveHint` | `false` | It updates lines; it does not delete data. |
| `idempotentHint` | `true` | Repeating the same update leaves the same values. |

## Input concepts
| Input | Description | Required |
|---|---|---|
| `opportunityId` | Optional opportunity GUID to verify line ownership. | No |
| `updates` | Array of product-line updates keyed by `opportunityProductId`. | Yes |

## Related tools
| Tool | Relationship |
|---|---|
| [`add_product`](add_product.md) | Adds a new product line. |
| [`recalculate_opportunity_price`](recalculate_opportunity_price.md) | Refreshes totals after updating lines. |

## Routing notes
Use `update_products` for existing opportunity product lines. Use `add_product` to create a new line.

## Response and UI behavior
This tool returns a text-only response with structured content and no app-in-chat component.

## Data mutation classification
Updates existing opportunity product lines.
