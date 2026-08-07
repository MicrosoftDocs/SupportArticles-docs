---
title: List customer work orders
description: Use the Field Service agent to retrieve an account's past work orders — with their incidents, products, services, and service tasks — directly in chat.
ms.date: 07/16/2026
ms.topic: reference
ms.service: dynamics-365-field-service
author: cvermander
ms.author: cvermander
ms.reviewer: cvermander
---

# List customer work orders

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Field Service. [Learn more about adding this tool to other MCP servers](/dynamics365/field-service/configure-field-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you want to see the past Field Service work for an account before you act — its previous work orders, what was done, and what was used.

## What it does

The assistant retrieves the work-order history for an account. You can anchor the request on a work order, a customer asset, or the account itself; the assistant resolves the anchor to its account and returns that account's past work orders, most recent first. Each work order includes its incidents (cases), products, services, and service tasks.

When you anchor on an asset, the assistant resolves the asset to its owning account and returns that **account's** full history — all of the account's work orders, not only the work performed on that specific asset. Asset-scoped service history isn't available in this version.

This is a read-only lookup. In this version, it retrieves and lists the history — it doesn't score recurrence, judge which fix worked, or recommend next steps.

## Try prompts like

- "What's the service history for this account?"
- "Has this account had work done before?"
- "Show past work orders for account 00000000-0000-0000-0000-000000000000"
- "What work has been done at this site?"

The assistant needs a work order, asset, or account ID (its Dataverse GUID). It can't look one up by name yet — if you refer to a record that way, it asks you for the ID.

## What you'll see in chat

The assistant replies with a written summary of the account's work-order history in the conversation. This tool is text-only — there's no separate app-in-chat card. Each work order is listed with its status, incident type, and a count of related cases, products, services, and tasks.

## Helpful tips

- Provide a work order, asset, or account ID (its GUID) — the assistant can't look one up by name yet, and asks you for the ID if you refer to it another way.
- Anchoring on a work order or asset resolves to its account automatically; the anchor work order itself is listed separately from the history.
- If the record has no associated account, the assistant tells you there's no account history to retrieve.
- For an account with a very long history, the most recent work orders are shown; if you're checking whether something ever happened and don't see it, ask again scoped to a specific site.
- The history reflects the records at the time you ask; refresh by asking again after updates.

## What happens next

After the history appears, you can continue with prompts like:

- "Which of these were completed?"
- "What parts were used on the most recent one?"
- "Open the account in Field Service"

## Does this change data?

**No, listing customer work orders does not change data.**

The lookup is read-only. It reads work order and related records to assemble the history and never modifies any record.

## Prerequisites

This tool is available on the Dynamics 365 Field Service MCP server. See the availability note at the top of this page for details. No additional configuration is required to call the tool.

## Tool summary

| Property           | Value                                                                                                                                                                  |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| User-facing name   | List customer work orders                                                                                                                                               |
| Internal tool name | `list_customer_work_orders`                                                                                                                                             |
| Purpose            | Retrieves an account's past work orders — with their incidents, products, services, and service tasks — as chat narration, anchored on a work order, asset, or account |

## Tool behavior

Resolves the supplied anchor (work order, asset, or account) to its Dataverse account, then reads that account's work orders ranked by recency, expanding each work order's incidents, products, services, and service tasks in a single bounded query. Returns the assembled history as plain narration.

## Annotations

| Annotation        | Value   | Meaning                          |
| ----------------- | ------- | -------------------------------- |
| `readOnlyHint`    | `true`  | This tool does not modify data.  |
| `destructiveHint` | Not set | Not applicable (read-only tool). |
| `idempotentHint`  | Not set | Not applicable (read-only tool). |
| `openWorldHint`   | `true`  | Reads live Dynamics 365 data.    |

## Input concepts

### Anchor

| Input         | Description                                                                          | Required                                  |
| ------------- | ------------------------------------------------------------------------------------ | ----------------------------------------- |
| `workOrderId` | The work order (msdyn_workorder) GUID to anchor on; resolves to its service account. | One of workOrderId, assetId, or accountId |
| `assetId`     | The customer asset (msdyn_customerasset) GUID; resolves to its owning account. History is account-wide, not asset-specific.       | One of workOrderId, assetId, or accountId |
| `accountId`   | The account (account) GUID whose history to retrieve.                                | One of workOrderId, assetId, or accountId |

### Optional scope

| Input                  | Description                                                                               | Required |
| ---------------------- | ----------------------------------------------------------------------------------------- | -------- |
| `functionalLocationId` | The functional location (msdyn_functionallocation) GUID to scope the history to one site. | No       |
| `question`             | The user's natural-language history question, preserved for context.                      | No       |

At least one of `workOrderId`, `assetId`, or `accountId` is required. When several are supplied, `accountId` takes precedence, then `workOrderId`, then `assetId`.

## Response and UI behavior

This tool is text-only. The history is returned as chat narration; there is no app-in-chat component.

### Response type

Text history

The assistant relays the account's work-order history in the conversation. If it can't retrieve the history — for example, the record has no associated account, the record can't be found, or you lack permission — the assistant explains why instead.

## Routing notes

Use `list_customer_work_orders` for:

- "service history", "work history", or "past work orders" for an account, site, or work order
- Retrieving the list of prior Field Service work related to an account before acting

Don't use `list_customer_work_orders` when the prompt asks to:

- **Determine whether one specific asset was serviced** — results are account-wide, not scoped to a single asset. Asset-scoped service history isn't available in this version.
- **Summarize or recap a single work order** — that's a recap tool (`summarize_work_order`), which returns a narrative AI summary of one work order, not a list of related history.
- **See the raw work order record or a specific status field** — field-by-field record viewing isn't available in this version.
- **Prepare for a job / get a briefing with recommended actions** — that's a job-preparation tool (`prepare_for_job`), which returns readiness checks and next actions.
- **Change any record** — those are separate write tools.

## Related tools

`list_customer_work_orders` retrieves the history; `summarize_work_order` recaps a single work order. As related Field Service history and diagnostic tools ship, they'll be cross-linked here.

## Data mutation classification

Read-only.

Listing customer work orders does not change data. The tool only reads work order and related records to assemble the history.
