---
title: Update a work order
description: Use the Field Service agent to update work-order details, custom fields, status, or substatus directly in chat.
ms.date: 07/31/2026
ms.topic: reference
ms.service: dynamics-365-field-service
author: cvermander
ms.author: cvermander
ms.reviewer: cvermander
---

# Update a work order

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Field Service. [Learn more about adding this tool to other MCP servers](/dynamics365/field-service/configure-field-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability to change details on one existing work order without opening the full work-order form.

## What it does

The assistant updates writable fields on a Dynamics 365 Field Service work order. It uses your organization's live Dataverse metadata, so it can understand standard fields and customer-added fields by logical name or localized display label.

The tool can also change open work-order lifecycle states and resolve active work-order substatuses by ID or exact name. Completing a work order requires a separate preview and confirmation. Posted and Canceled transitions aren't supported by this capability.

## Try prompts like

- "Change work order 13729 to High priority."
- "Set the gate access code to 4182."
- "Mark this work order as awaiting parts."
- "Move the promised time to tomorrow afternoon."
- "Clear the secondary contact."
- "Complete this work order." — the assistant previews the change and asks you to confirm

If a work order, field label, choice, lookup, or substatus is ambiguous, the assistant asks you to clarify before changing data.

## What you'll see in chat

The assistant replies with a written outcome in the conversation. This tool is text-only, with no separate app-in-chat component. A successful response lists the requested changes and the values Dataverse ultimately applied, including any lifecycle changes derived by Field Service. If the update is saved but the follow-up read fails, the reply says the change was accepted and that the final values could not be confirmed — reopen the work order to see what Field Service applied.

## Helpful tips

- Name the work order by ID, booking ID, or a reference such as its work-order number.
- Use the field labels shown in your environment. Customer-added fields work when their metadata marks them as updateable.
- Use `null` only when you intend to clear a field.
- Expect a preview before completion. No completion write occurs until you confirm.
- Use an explicit work-order or booking ID for unassigned or historical work orders that aren't among your current bookings.

## What happens next

After an update, you can continue with prompts like:

- "Summarize the work order."
- "Show me what changed."
- "Update my booking status."
- "Prepare me for this job."

## Does this change data?

**Yes, updating a work order changes data.**

The tool updates one existing work-order record. It doesn't delete records, post or cancel work orders, reassign ownership, or update child tasks, bookings, products, services, notes, or time entries. Repeating the same request converges on the same value.

## Prerequisites

This tool is available on the Dynamics 365 Field Service MCP server. Your Dynamics 365 user must be able to read and write the target work order and read any referenced booking, substatus, or lookup record. Field-level security and Dataverse business rules continue to apply.

## Tool summary

| Property | Value |
| --- | --- |
| User-facing name | Update a work order |
| Internal tool name | `update_work_order` |
| Purpose | Updates validated fields and supported lifecycle values on one `msdyn_workorder` record using live Dataverse metadata |

## Tool behavior

The tool resolves the work order from `workOrderId`, `bookingId`, or a free-form reference, in that order. It resolves submitted field names against live `msdyn_workorder` metadata, parses each value according to the attribute type, rejects protected or unsupported fields, and reads the current record before writing.

Ordinary changes are applied in one atomic PATCH after standard host mutation consent. Completion requests return a preview until `confirm` is true. The write uses optimistic concurrency, then re-reads the record and reports requested and platform-derived changes; if that re-read fails the change still stands and the response reports the requested values as unconfirmed rather than as applied. Concurrent edits return a conflict instead of overwriting another user's work.

## Annotations

| Annotation | Value | Meaning |
| --- | --- | --- |
| `readOnlyHint` | `false` | This tool modifies one work-order record. |
| `destructiveHint` | `false` | It doesn't delete records or perform Posted or Canceled transitions. |
| `idempotentHint` | `true` | Repeating the same value-setting request converges on the same final state. |
| `openWorldHint` | Not set | Reads and writes Dataverse records in the connected environment. |

## Input concepts

### Work-order identity

| Input | Description | Required |
| --- | --- | --- |
| `workOrderId` | Work-order (`msdyn_workorder`) GUID. Takes precedence when supplied. | One identity input is required |
| `bookingId` | Booking GUID whose linked work order should be updated. | One identity input is required |
| `reference` | Work-order number, customer/account fragment, or booking name resolved against the caller's current Field Service work. | One identity input is required |

### Changes

| Input | Description | Required |
| --- | --- | --- |
| `fields` | Field updates keyed by Dataverse logical name or localized display label. Values are parsed from live attribute metadata. | At least one change input is required |
| `systemStatus` | Target open lifecycle state: Unscheduled, Scheduled, In Progress, or Completed. | At least one change input is required |
| `substatus` | Active work-order substatus GUID or exact name. | At least one change input is required |
| `confirm` | Set only after confirming a completion preview. Ordinary updates ignore it. | No |

## Response and UI behavior

This tool is text-only. Outcomes are returned as chat narration and concise structured data; there is no app-in-chat component.

### Response type

Text outcome

The response can confirm an update, preview completion, report no change, ask for clarification, report a concurrent-edit conflict, or explain a user-safe Dataverse validation error.

## Routing notes

Use `update_work_order` when the user wants to:

- Change one or more header fields on a single work order
- Set a work-order substatus such as Awaiting Parts
- Move the work order among supported open system statuses
- Preview and confirm completion of one work order

Don't use `update_work_order` when the user wants to:

- **Change a booking status** — use `update_booking_status`.
- **Update child tasks, products, services, notes, or time entries** — these mutations aren't yet routed in the Field Service agent.
- **Post, cancel, or reassign a work order** — those operations need separate contracts.
- **Apply a compound multi-entity progress update** — use `capture_work_progress` when available.
- **Update an unrelated Dataverse entity** — use the appropriate domain tool or `update_entity_record`.

## Related tools

| Tool | Relationship |
| --- | --- |
| [`update_booking_status`](update_booking_status.md) | Changes a booking lifecycle state rather than the work-order header. |
| [`summarize_work_order`](summarize_work_order.md) | Returns a narrative recap without changing data. |
| [`prepare_for_job`](prepare_for_job.md) | Returns a pre-job readiness briefing without changing data. |

## Data mutation classification

Write.

The tool performs a non-destructive, idempotent update to one work-order record. Completion requires explicit confirmation, and Dataverse remains authoritative for permissions, field-level security, and Field Service transition rules.
