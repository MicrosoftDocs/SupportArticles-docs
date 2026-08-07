---
title: Get Price List
description: Learn how to view Dynamics 365 Sales price lists.
ms.date: 07/16/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Get Price List

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a seller needs details or product prices from a price list.

## What it does
The assistant reads a price list by GUID or unambiguous name and can include product price rows from that price list.

## Try prompts like
- Show me the Microsoft Eval Price List.
- Which products are on this price list?
- Get price list details before adding a product.

## What you'll see in chat
The assistant displays a text response directly in chat. There is no interactive app-in-chat component.

## Helpful tips
- Use `priceListId` when available; name resolution requires an unambiguous match.
- Limit returned products with `top` when the price list is large.

## What happens next
After price list details appear, use `get_product` (pricing rows included by default) or product-line tools as needed.

## Does this change data?
**No.** This tool is read-only.

## Prerequisites
This tool requires read access to price lists. Returning product price rows (`includeProducts` is true by default) additionally requires access to product price-list records, which Dataverse enforces at call time.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Get Price List |
| Internal tool name | `get_price_list` |
| Purpose | Read price list details and product prices. |

## Tool behavior
The tool resolves one price list and optionally returns bounded product price rows.

## Annotations
| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `true` | This tool does not modify data. |

## Input concepts
| Input | Description | Required |
|---|---|---|
| `priceListId` | Resolved price list GUID. | No |
| `priceListName` | Name to resolve when the GUID is not known. | No |
| `includeProducts` | Include product price rows. | No |
| `top` | Maximum product price rows to return. | No |

## Related tools
| Tool | Relationship |
|---|---|
| [`add_product`](add_product.md) | Adds products after pricing is confirmed. |

## Routing notes
Use `get_price_list` for price-list-level details. Use `get_product` for one product's price rows.

## Response and UI behavior
This tool returns a text-only response with structured content and no app-in-chat component.

## Data mutation classification
Read-only.
