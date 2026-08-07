---
title: Summarize a work order
description: Use the Field Service agent to get an AI recap of a work order or booking — its job, history, tasks, parts, and notes — directly in chat.
ms.date: 07/31/2026
ms.topic: reference
ms.service: dynamics-365-field-service
author: cvermander
ms.author: cvermander
ms.reviewer: cvermander
---

# Summarize a work order

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Field Service. [Learn more about adding this tool to other MCP servers](/dynamics365/field-service/configure-field-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you want a fast, evidence-backed recap of a work order before you act on it — without opening the record.

## What it does
The assistant returns an AI-generated recap of a work order, drawn from the work order's own data: its job and description, service account and contact, booking status, service tasks, products and services, and timeline notes. The recap is produced by Field Service's built-in Copilot Recap.

You can ask for a recap three ways:

- By work order — the assistant summarizes that work order.
- By booking — the assistant summarizes the work order linked to that booking.
- By reference — provide an exact work-order number, or name an assigned job conversationally by customer or booking name.

## Try prompts like
- "Give me a recap of work order 3c24bfb3-cd6c-eb11-a812-000d3a1865e0"
- "Give me the rundown on this work order" — the assistant asks for the work order's ID if it doesn't already have one
- "Recap the work order for booking 5e5160cd-d0a9-eb11-8237-000d3a1a367b"
- "Summarize booking 5e5160cd-d0a9-eb11-8237-000d3a1a367b"
- "Give me a recap of Sample_WO00001" — refer to the job by its work-order number
- "Summarize my job for Contoso Coffee" — refer to the job by customer name

You can identify the job by its ID (the work order's `msdyn_workorderid` GUID or a booking's ID) or by a free-form reference. An exact work-order number can resolve any work order that you have permission to read, including an unassigned, older, or closed work order. Customer-name fragments, booking names, and partial work-order numbers are matched against your **current assigned jobs** (active bookings scheduled within about a week either side of today). If more than one job matches, the assistant asks which one you mean; if none match, it asks for the ID.

## What you'll see in chat
The assistant replies with a written recap in the conversation. This tool is text-only — there's no separate app-in-chat card. The recap summarizes the job, bookings, tasks, parts, and recent notes so you can decide what to do next.

## Helpful tips
- Provide the work order's ID (its GUID), a booking's ID, or a free-form reference. Use the complete work-order number to identify an older, closed, or unassigned work order that you can read.
- To recap the work order behind a booking, give the booking's ID — the assistant resolves the linked work order automatically.
- If a booking isn't linked to a work order, the assistant tells you there's nothing to summarize.
- The recap reflects the data on the record at the time you ask; refresh by asking again after updates.

## What happens next
After the recap appears, you can continue with prompts like:

- "What parts are needed?"
- "Are there any open service tasks?"
- "Draft a status update for the customer"
- "Open this work order in Field Service"

## Does this change data?
**No, summarizing a work order does not change data.**

The recap is read-only. It reads work order information to generate a summary and never modifies the work order, booking, or any related record.

## Prerequisites

This tool is available on the Dynamics 365 Field Service MCP server. See the availability note at the top of this page for details. The work order recap experience (Copilot Recap) must be provisioned in the environment. No additional configuration is required to call the tool.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Summarize a work order |
| Internal tool name | `summarize_work_order` |
| Purpose | Returns an AI-generated recap of a work order (or the work order linked to a booking) as chat narration, using the Field Service Copilot Recap custom API |

## Tool behavior
Generates a work order recap by calling the Field Service Dataverse custom API for record summarization on its default work order recap configuration. The recap is composed server-side from the work order's bookings, activities, notes, products, services, service tasks, and asset history. When the user supplies a free-form reference, the tool first performs a bounded exact-number lookup across visible work orders, then falls back to bounded matching over the caller's assigned bookings for contextual descriptions. The recap itself composes no queries of its own and is returned as plain narration.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | This tool does not modify data. |
| `destructiveHint` | Not set | Not applicable (read-only tool). |
| `idempotentHint` | Not set | Not applicable (read-only tool). |
| `openWorldHint` | `true` | Calls a backend AI service to generate the recap. |

## Input concepts
### Work order

| Input | Description | Required |
|---|---|---|
| `workOrderId` | The work order (msdyn_workorder) GUID to summarize. | One of workOrderId, bookingId, or reference |

### Booking

| Input | Description | Required |
|---|---|---|
| `bookingId` | The booking (bookableresourcebooking) GUID; the linked work order is summarized, resolved server-side. | One of workOrderId, bookingId, or reference |

### Reference

| Input | Description | Required |
|---|---|---|
| `reference` | A free-form work-order reference — a complete or partial work-order number, a customer/account name fragment, or one of your booking names. Complete work-order numbers search visible work orders; contextual and partial references match current assigned jobs. Ignored when `workOrderId` or `bookingId` is supplied. | One of workOrderId, bookingId, or reference |

At least one of `workOrderId`, `bookingId`, or `reference` is required. A GUID (`workOrderId` or `bookingId`) wins over a `reference`; when both `workOrderId` and `bookingId` are supplied, the work order is summarized. An exact work-order number resolves only when one visible record matches. Any ambiguous reference prompts you to clarify; a reference that matches none asks for the ID.

## Response and UI behavior
This tool is text-only. The recap is returned as chat narration; there is no app-in-chat component.

### Response type

Text recap

The assistant relays the generated recap in the conversation. If the recap can't be generated — for example, the content was withheld by content-safety rules, the booking has no linked work order, or you lack permission — the assistant explains why instead. If a free-form reference matches more than one of your jobs, the assistant lists the matches and asks which one you mean; if it matches none, it asks for the ID.

## Routing notes
Use `summarize_work_order` for:

- "summarize", "recap", or "give me the rundown on" a single work order or booking
- A quick narrative read of one work order before acting on it

Don't use `summarize_work_order` when the prompt asks to:

- **Prepare for a job / get a briefing with recommended actions or readiness checks** — that's a job-preparation tool (`prepare_for_job`), which runs readiness detectors and returns attention items and next actions, not just a recap.
- **See the raw work order record or a specific status field** — that's the work order detail view (`wo-detail`), a field-by-field record card, not a narrative summary.
- **Get an end-of-day report across multiple jobs or bookings** — that's the shift report (`generate_shift_report`), which aggregates every job in the shift window.
- **Change the work order** (update status, book a resource, add a task) — those are separate write tools.

## Related tools
- `prepare_for_job` — a pre-job readiness briefing for a work order or booking: an AI recap plus deterministic attention items and next steps, rendered as an in-chat card. It accepts the same free-form `reference` and resolves it the same way.

## Data mutation classification
Read-only.

Summarizing a work order does not change data. The tool only reads work order information to produce a recap.
