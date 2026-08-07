---
title: Account Catch-up
description: Learn how to use the Account Catch-up capability in Dynamics 365 Sales.
ms.date: 07/28/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Account Catch-up

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a seller needs to catch up on recent account context before acting.

## What it does
The assistant catches the seller up on recent account context before action and returns a text response with structured content for agent orchestration.

## Try prompts like
- Catch me up on what changed in the Northpeak Manufacturing account this week
- What's changed recently on this account?
- Anything new on Contoso since my last engagement?
- Show me recent account activity before I follow up

## What you'll see in chat
The assistant displays a text response directly in chat. There is no interactive app-in-chat component for this capability.

## Helpful tips
- Resolve ambiguous record names before calling tools that require identifiers.
- Use related record-view tools when you need to inspect the full Dataverse form.
- Confirm write actions before changing account or sales record data.

## What happens next
After the response appears, you can continue with prompts like:

- Open this account
- Show the account summary
- Add a note
- Draft a follow-up email

## Does this change data?
**No, get_account_catchup does not change data.**

This tool is read-only and does not modify records.

## Prerequisites
This tool requires access to Dynamics 365 Sales records for the selected environment.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Account Catch-up |
| Internal tool name | `get_account_catchup` |
| Purpose | catches the seller up on recent account context before action. |

## Tool behavior
The tool catches the seller up on recent account context before action. It is text-only and returns structured content for the requested Sales operation.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | This tool does not modify data. |
| `destructiveHint` | Not set | Not applicable. |
| `idempotentHint` | Not set | Not applicable. |
| `openWorldHint` | Not set | Uses default (queries Dataverse). |

## Input concepts
### Sales context

| Input | Description | Required |
|---|---|---|
| `accountId` | Resolved account GUID to catch up on. Resolve names before calling this tool. | Yes |
| `since` | Optional ISO 8601 date-time with an explicit timezone offset (for example, `2026-07-01T00:00:00Z`). Bounds the catch-up to account changes after that instant. When omitted, the catch-up covers the last 7 days. | No |

> [!NOTE]
> When you supply `since`, Dynamics 365 treats it as your last-seen point and phrases the response as changes "since you last logged in" rather than repeating the date. Omit `since` and the response is phrased as "for the last 7 days".

## Response and UI behavior
This tool returns a text-only response with no app-in-chat component.

This MCP tool is supported by an MCP App. [Learn more about MCP Apps](/dynamics365/customer-service/administer/use-mcp-apps-in-chat).

### Response type

Text narrative

The response includes structured content from the SalesAccountCatchup custom API.

## Routing notes
Use `get_account_catchup` when the user asks for this specific Sales capability. Don't use `get_account_catchup` for support case workflows or unrelated customer-service records.

## Related tools
| Tool | Relationship |
|---|---|
| [`get_account`](get_account.md) | Opens the full Dataverse account form |
| [`list_entity_records`](list_entity_records.md) | Finds sales records by entity type |
| [`get_account_summary`](get_account_summary.md) | Provides a stable account brief |

## Data mutation classification
Read-only.
