---
title: Add Product
description: Learn how to add products to a Dynamics 365 Sales opportunity.
ms.date: 07/16/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Add Product

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a seller has confirmed the opportunity, product, and quantity to add.

## What it does
The assistant creates an opportunity product line in Dynamics 365 Sales. It can use the product default unit and lets Dataverse price the line unless the seller explicitly provides a unit-price override.

## Try prompts like
- Add 200 Microsoft 365 Copilot seats to this opportunity.
- Add the selected product to the Northpeak E5 Rollout opportunity.
- Add this product with a price override of 360.

## What you'll see in chat
The assistant displays a text response directly in chat. There is no interactive app-in-chat component.

## Helpful tips
- Confirm the product, opportunity, and quantity before calling this tool.
- Omit price overrides unless the seller explicitly provides them.

## What happens next
After adding a line, use `recalculate_opportunity_price` when updated opportunity totals are needed.

## Does this change data?
**Yes.** This tool creates an opportunity product line.

## Prerequisites
This tool requires write access to opportunity product lines plus read access to the opportunity and product.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Add Product |
| Internal tool name | `add_product` |
| Purpose | Add a product line to an opportunity. |

## Tool behavior
The tool creates an opportunity product line and returns the created line summary.

## Annotations
| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `false` | This tool changes data. |
| `destructiveHint` | `false` | It adds a line; it does not delete data. |
| `idempotentHint` | `false` | Repeating the call can create another line. |

## Input concepts
| Input | Description | Required |
|---|---|---|
| `opportunityId` | Resolved opportunity GUID. | Yes |
| `productId` | Resolved product GUID. | Yes |
| `quantity` | Quantity to add. | No |
| `unitId` | Unit GUID; omit to use the product default unit. | No |
| `pricePerUnit` | Unit price override. | No |
| `manualDiscountAmount` | Manual discount amount. | No |
| `description` | Optional line description. | No |

## Related tools
| Tool | Relationship |
|---|---|
| [`get_product`](get_product.md) | Finds products to add. |
| [`recalculate_opportunity_price`](recalculate_opportunity_price.md) | Refreshes totals after adding a line. |

## Routing notes
Use `add_product` only for confirmed product-line creation. Use `update_products` for existing lines.

## Response and UI behavior
This tool returns a text-only response with structured content and no app-in-chat component.

## Data mutation classification
Creates an opportunity product line.
