---
title: Get Product
description: Learn how to search the Dynamics 365 Sales product catalog and view product details.
ms.date: 07/16/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Get Product

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a seller needs to find a product in the catalog, or read a product's details and pricing.

## What it does
The assistant searches the Dynamics 365 Sales product catalog by name, product number, SKU, or keyword, and reads a product record with its price-list rows. Provide either `searchText` (to search) or `productId` (to read one product) — not both.

## Try prompts like
- Search the catalog for Microsoft 365 products.
- Which Teams calling and voice products are in our catalog?
- Show details for Microsoft 365 E5.
- What does Microsoft 365 E5 cost?
- Include pricing for this product on the Microsoft Eval Price List.

## What you'll see in chat
The assistant displays a text response directly in chat. There is no interactive app-in-chat component.

## Helpful tips
- When the seller names a product in natural language, pass `searchText` — the response includes each match's `productId`.
- Pass that `productId` back to this tool to read details and pricing for one product.
- Use `priceListId` only after the price list is resolved.

## What happens next
After details appear, use `add_product` to add the product to an opportunity.

## Does this change data?
**No.** This tool is read-only.

## Prerequisites
This tool requires access to Dynamics 365 Sales product records.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Get Product |
| Internal tool name | `get_product` |
| Purpose | Search the product catalog, or read product details and optional pricing. |

## Tool behavior
The tool has two mutually exclusive modes. In search mode it returns bounded catalog matches. In read mode it returns one product record and can include bounded product price-list rows.

## Annotations
| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `true` | This tool does not modify data. |

## Input concepts
| Input | Description | Required |
|---|---|---|
| `searchText` | Product name, product number, SKU, or keyword to search the catalog for. | One of `searchText` or `productId` |
| `productId` | Resolved product GUID. | One of `searchText` or `productId` |
| `priceListId` | Optional price list GUID to filter pricing. Read mode only. | No |
| `includePricing` | Include product price-list rows (default true). Read mode only. | No |
| `pricingOnly` | Return only price-list rows and skip the product-detail fetch. Read mode only. | No |
| `includeInactive` | Include inactive products. Search mode only. | No |
| `top` | Maximum rows — products in search mode (default 10), pricing rows in read mode (default 20). Max 50. | No |

## Related tools
| Tool | Relationship |
|---|---|
| [`add_product`](add_product.md) | Adds a resolved product to an opportunity. |
| [`get_price_list`](get_price_list.md) | Reads a price list and the products on it. |

## Routing notes
Use `get_product` for every product-catalog question: searching by description or keyword, reading product details after resolution, and pricing questions for a named product (pricing rows are included by default; pass `pricingOnly: true` for pricing-only requests). Use `get_price_list` instead when the seller asks for the contents of a named price list rather than for one product.

## Response and UI behavior
This tool returns a text-only response with structured content and no app-in-chat component.

## Data mutation classification
Read-only.
