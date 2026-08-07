---
title: Plan your work day
description: See your scheduled Field Service bookings for the day — active, upcoming, and completed jobs, with the recommended next job to open — right in chat.
ms.date: 07/16/2026
ms.topic: reference
ms.service: dynamics-365-field-service
author: cvermander
ms.author: cvermander
ms.reviewer: cvermander
---

# Plan your work day

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Field Service. [Learn more about adding this tool to other MCP servers](/dynamics365/field-service/configure-field-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability at the start of your day, or any time you want to orient yourself: it answers "what's on my plate today, and what should I do next?".

## What it does
The assistant loads your scheduled bookings for the day and returns a ranked day plan. It shows how many jobs you have, which ones are active or in progress, which are coming up, and which are done, and it recommends the single next job to open. It reads your schedule as a field technician — your bookings, their status, the linked work order, customer, and time — and orders them so the most actionable job surfaces first.

It normalizes booking statuses so the plan reads consistently even when your organization customizes its status names, and it ranks the next job deterministically by schedule and priority — it never guesses.

## Try prompts like
- "What's on my plate today?"
- "What's my schedule?"
- "What should I do next?"
- "Plan my work day"
- "What jobs do I have this morning?"

You don't need to provide anything for the default case — the assistant uses your own bookable resource and today's date automatically.

## What you'll see in chat
The assistant replies with a written day plan in the conversation. This tool is text-only — there's no separate app-in-chat card in this version. The plan summarizes your bookings (active, upcoming, completed, and canceled counts) and calls out the recommended next job to open so you can decide what to do next. Booking times are shown in **your own local timezone** (the timezone in your Field Service user settings), with the timezone noted alongside the plan — so you can act on them directly without converting from UTC. Times stay anchored to *your* timezone even when you plan another technician's day, so double-check the offset if that technician works in a different region.

## Helpful tips
- Ask with no details for the common case — the assistant plans *your* day automatically.
- The plan covers today by default. Ask for a specific window (for example, "what's on for this afternoon?") to narrow or widen it, or ask for "the next 3 days" to plan a multi-day window.
- To plan another technician's day, name them — for example, "plan Jordan's day".
- If your schedule is clear, the assistant tells you so and offers to widen the window.
- The plan calls out useful signals when they apply — jobs running late, high-priority jobs, tight turnarounds between stops, newly booked jobs, and days that span more than one service territory.
- A booking with no linked work order is kept in the plan and flagged for attention rather than recommended as your next job.

## What happens next
After the plan appears, you can continue with prompts like:

- "Open the next job"
- "Give me a recap of that work order"
- "What should I know before I start?"
- "Show me my afternoon jobs"

## Does this change data?
**No, planning your work day does not change data.**

The day plan is read-only. It reads your bookings and their related records to build the plan and never modifies a booking, work order, or any related record.

## Prerequisites

This tool is available on the Dynamics 365 Field Service MCP server. See the availability note at the top of this page for details. Your user must be linked to an active bookable resource (a Field Service technician resource) so the assistant can find your bookings. No additional configuration is required to call the tool.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Plan your work day |
| Internal tool name | `plan_work_day` |
| Purpose | Returns a ranked, text-first day plan of the technician's bookings for a day window, with a recommended next job to open |

## Tool behavior
Resolves the signed-in user's bookable resource (or another technician's, when named), reads the bookings that overlap the day window (default today; a multi-day window when a number of days is requested) in one bounded query, normalizes each booking's status to a stable value, groups the bookings (active, upcoming, proposed, completed, canceled, needs-review), computes a few day-level highlights (late, high-priority, tight turnarounds, newly booked, multiple territories), and deterministically ranks the next-best job across the window. It returns the plan as chat narration plus a compact structured summary; it changes nothing.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | This tool does not modify data. |
| `destructiveHint` | Not set | Not applicable (read-only tool). |
| `idempotentHint` | Not set | Not applicable (read-only tool). |
| `openWorldHint` | `true` | Reads Field Service data from the Dataverse environment. |

## Input concepts
### Resource
| Input | Description | Required |
|---|---|---|
| `resourceId` | The bookable resource (bookableresourceid) GUID whose day to plan. Defaults to the current user's bookable resource. | No |
| `resourceName` | The name of another technician's bookable resource to plan, when you don't know its GUID. Ignored when `resourceId` is set. If the name matches more than one resource, the assistant asks you to be more specific. | No |

### Window
| Input | Description | Required |
|---|---|---|
| `windowStart` | ISO 8601 start of the day window. Defaults to the start of today in the user's timezone. | No |
| `windowEnd` | ISO 8601 end of the day window. Defaults to the end of today in the user's timezone. An explicit start and end together override `days`. | No |
| `days` | Number of local calendar days to plan, starting from the window start (or today). Use it for requests like "the next 3 days". Defaults to 1 (a single day) and is capped at 14. | No |

### Options
| Input | Description | Required |
|---|---|---|
| `includeCompleted` | When true, completed and canceled bookings are listed as well as counted. Default false. | No |

No input is required — the default call plans the current user's day for today.

## Response and UI behavior
This tool is text-only. The day plan is returned as chat narration; there is no app-in-chat component in this version.

### Response type

Text day plan

The assistant relays the day plan and the recommended next job in the conversation. If your schedule is empty, or your resource isn't set up, the assistant explains that instead.

## Routing notes
Use `plan_work_day` for:

- "what's on my plate today", "my schedule", "what should I do next" — day orientation across your bookings
- Deciding which job to open next

Don't use `plan_work_day` when the prompt asks to:

- **Open or hydrate a single booking's full detail** — that will be the booking-detail tool (`get_booking`); it is not yet available.
- **Get an AI recap of one work order** — that's the work order recap tool (`summarize_work_order`).
- **Prepare for a job with readiness checks and recommended actions** — that's the job-preparation tool (`prepare_for_job`).
- **Get an end-of-day report across multiple jobs** — that will be the shift report (`generate_shift_report`); it is not yet available.
- **Reschedule, reassign, or optimize routes** — those are dispatcher/scheduling tools, not day orientation.

## Related tools
`plan_work_day` orients and routes; it does not brief, diagnose, update, or close work. It routes into `summarize_work_order` (recap a job) and `prepare_for_job` (pre-job readiness briefing), both available today. The booking-detail tool (`get_booking`, for opening the next job) is not yet shipped; it will be cross-linked here when it lands.

## Data mutation classification
Read-only.

Planning your work day does not change data. The tool only reads your bookings and their related records to build the plan.
