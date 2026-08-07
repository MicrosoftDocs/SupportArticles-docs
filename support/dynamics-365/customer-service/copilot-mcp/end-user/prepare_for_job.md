---
title: Prepare for a job
description: Get a pre-job readiness briefing for a Field Service work order or booking — an AI recap plus what to check before you start, shown as a card in chat.
ms.date: 07/15/2026
ms.topic: reference
ms.service: dynamics-365-field-service
author: cvermander
ms.author: cvermander
ms.reviewer: cvermander
---

# Prepare for a job

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Field Service. [Learn more about adding this tool to other MCP servers](/dynamics365/field-service/configure-field-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you're about to start a job and want a quick, evidence-backed readiness check — what the job involves and what deserves your attention — before you head out or begin work.

## What it does
The assistant returns a pre-job briefing for a work order (or the work order linked to a booking). The briefing combines two things:

- An **AI recap** of the job (from Field Service's built-in Copilot Recap), summarizing the work and its context.
- **Attention items** — deterministic readiness checks over the work order's own data: linked procedures, listed parts and services, open and inspection tasks, priority, SLA promised-time risk, repeat visits to the same site, and recurring issues on the same asset.

You can start the briefing two ways:

- By booking — the assistant briefs the work order linked to that booking (the preferred entry when you start from your schedule).
- By work order — the assistant briefs that work order directly.

If the AI recap can't be generated, the briefing still returns the deterministic readiness checks, with a note that the recap was unavailable.

## Try prompts like
- "What should I know before I start booking f026b8f5-d0a9-eb11-8237-000d3a1a367b?"
- "Prepare me for work order 3c24bfb3-cd6c-eb11-a812-000d3a1865e0"
- "What should I know before I start Sample_WO00001?" — refer to the job by its work-order number
- "What do I need to check before my job for Contoso Coffee?" — refer to the job by customer name
- "Give me a pre-job briefing for booking f026b8f5-d0a9-eb11-8237-000d3a1a367b"

You can identify the job by its ID (the work order's `msdyn_workorderid` GUID or a booking's ID) or by a free-form reference — a work-order number, a customer name, or one of your booking names. A reference is matched against the jobs assigned to you; if more than one matches, the assistant asks which one you mean, and if none match it asks for the ID.

## What you'll see in chat
The assistant opens a briefing card that shows the job headline, a short summary, counts (tasks, parts, services, procedures), and a ranked list of attention items — the things worth checking before you start — plus suggested next steps. The assistant briefly acknowledges that the card is ready; the card itself carries the details and suggested next steps.

## Helpful tips
- Provide the work order's ID (its GUID), a booking's ID, or a free-form reference (work-order number, customer name, or booking name) — references are matched against the jobs assigned to you.
- Start from a booking to have the assistant resolve the linked work order for you.
- Attention items are ordered by importance: high-priority signals (priority, SLA breach, recurring asset issues) appear first.
- If a booking isn't linked to a work order, the assistant tells you there's nothing to prepare for.
- The briefing reflects the data on the record at the time you ask; refresh by asking again after updates.

## What you can do from the app-in-chat component
From the briefing card in chat, you can:

- Read the job headline and a short summary (the AI recap when available)
- See counts at a glance — tasks, parts, services, and linked procedures
- Review the ranked attention items, ordered by importance (high-priority signals first)
- See suggested next steps for the job
- Use follow-up prompts to get the full recap, open the work order, or act on the job

## What happens next
After the briefing appears, you can continue with prompts like:

- "Give me the full recap of this work order"
- "What parts are needed?"
- "Show me the linked procedure"
- "Open this work order in Field Service"

## Does this change data?
**No, preparing for a job does not change data.**

The briefing is read-only. It reads work order, booking, task, product, service, asset, and procedure information to compose the briefing and never modifies any record.

## Prerequisites

This tool is available on the Dynamics 365 Field Service MCP server. See the availability note at the top of this page for details. The work order recap experience (Copilot Recap) enriches the briefing when provisioned; if it isn't available, the briefing still returns the deterministic readiness checks. No additional configuration is required to call the tool.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Prepare for a job |
| Internal tool name | `prepare_for_job` |
| Purpose | Returns a pre-job readiness briefing for a work order (or the work order linked to a booking): an AI recap plus deterministic attention items and next steps, rendered as an in-chat card |

## Tool behavior
Resolves the work order (directly, or from a booking's linked work order), then composes bounded, precondition-pruned Dataverse reads (bookings, service tasks, products, services, linked knowledge-article procedures, priority band, and prior work orders at the same site and on the same asset). It runs nine deterministic readiness detectors over those facts, ranks the resulting attention items, and attempts the Field Service Copilot Recap. Recap composition is fail-open: if the recap fails, the briefing still returns from the deterministic sections.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | This tool does not modify data. |
| `destructiveHint` | Not set | Not applicable (read-only tool). |
| `idempotentHint` | Not set | Not applicable (read-only tool). |
| `openWorldHint` | `true` | Reads Dataverse and calls a backend AI service to generate the recap. |

## Input concepts
### Booking

| Input | Description | Required |
|---|---|---|
| `bookingId` | The booking (bookableresourcebooking) GUID; the linked work order is briefed, resolved server-side. Preferred entry point. | One of bookingId or workOrderId |

### Work order

| Input | Description | Required |
|---|---|---|
| `workOrderId` | The work order (msdyn_workorder) GUID to brief directly. | One of bookingId, workOrderId, or reference |

### Reference

| Input | Description | Required |
|---|---|---|
| `reference` | A free-form work-order reference — a work-order number, a customer/account name fragment, or one of your booking names. Matched against the jobs assigned to you; ignored when `bookingId` or `workOrderId` is supplied. | One of bookingId, workOrderId, or reference |

At least one of `bookingId`, `workOrderId`, or `reference` is required. A GUID (`bookingId` or `workOrderId`) wins over a `reference`; when both `bookingId` and `workOrderId` are supplied, the booking takes precedence (its linked work order is resolved from it). A `reference` that matches more than one of your jobs prompts you to pick one; a reference that matches none asks for the ID.

## Response and UI behavior
This tool renders an in-chat briefing card.

### Response type

Briefing card (app-in-chat)

The card shows the job headline, a short summary (the AI recap when available), counts, a ranked list of attention items, and suggested next steps. If the briefing can't be generated — for example, the booking has no linked work order, or no ID was provided — the card shows an error state with a support code, and the assistant explains why.

## Routing notes
Use `prepare_for_job` for:

- "What should I know / check / prepare before starting (or arriving at) a job or booking?"
- A pre-job readiness briefing with attention items and next steps

Don't use `prepare_for_job` when the prompt asks to:

- **Just summarize or recap a work order** with no readiness checks — that's the work-order recap tool (`summarize_work_order`), which returns a plain narrative recap.
- **See the raw work order record or a specific status field** — that's the work order detail view (`wo-detail`), a field-by-field record card.
- **Get an end-of-day report across multiple jobs** — that's the shift report (`generate_shift_report`), which aggregates every job in the shift window.
- **Change the work order** (update status, book a resource, add a task) — those are separate write tools.

## Related tools
- `summarize_work_order` — a plain AI recap of a single work order or booking, with no readiness checks or widget.

## Data mutation classification
Read-only.

Preparing for a job does not change data. The tool only reads work order and related information to compose the briefing.
