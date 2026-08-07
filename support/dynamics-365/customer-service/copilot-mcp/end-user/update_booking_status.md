---
title: Update a booking status
description: Use the Field Service agent to change your status on a booking — travel, arrive, take a break, complete, or cancel — directly in chat.
ms.date: 07/21/2026
ms.topic: reference
ms.service: dynamics-365-field-service
author: cvermander
ms.author: cvermander
ms.reviewer: cvermander
---

# Update a booking status

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Field Service. [Learn more about adding this tool to other MCP servers](/dynamics365/field-service/configure-field-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you want to move a booking to a new status from chat — say you're traveling, you've arrived, you're taking a break, or the job is done — without opening the booking record.

## What it does

The assistant changes the booking status of a bookable resource booking to the status you name. It matches the status you ask for against the statuses your organization actually has set up, so both the out-of-the-box statuses (Scheduled, Traveling, In Progress, On Break, Completed, Canceled) and any custom statuses your organization defines work.

You can name the booking two ways:

- By booking — pass the booking's ID, or refer to it conversationally by its name, work order number, or customer name.
- By your schedule — if you don't name a booking, the assistant offers the bookings on your schedule for today so you can pick the right one.

Ending statuses like Completed and Canceled close downstream work, so the assistant previews the change and asks you to confirm before it applies.

## Try prompts like

- "Mark me on break"
- "Start travel to my next booking"
- "I've arrived at the Chen install"
- "Set my booking to In Progress"
- "I'm done — complete the booking" — the assistant previews the change and asks you to confirm
- "Cancel this booking — customer isn't home"

If more than one booking or status could match, the assistant asks which one you mean before making a change.

## What you'll see in chat

The assistant replies with a written confirmation in the conversation. This tool is text-only — there's no separate app-in-chat card. After a successful change, the reply names the booking and the status it moved from and to, and offers a few suggested follow-up prompts as chips.

## Helpful tips

- Name the status the way your organization labels it — the assistant matches against your live status list, so custom statuses work.
- To move an ending status (Completed or Canceled), expect a confirmation step — the assistant previews the change first and only applies it after you confirm.
- If you refer to a booking by customer or work order, the assistant matches against your bookings for today; give the booking's ID if you want to be exact.
- If the status you name isn't set up in your organization, the assistant tells you which statuses are available so you can pick one.

## What happens next

After the status changes, you can continue with prompts like:

- "Complete the booking"
- "Resume work"
- "Open my next booking"
- "What's next on my schedule?"

## Does this change data?

**Yes, updating a booking status changes data.**

The tool changes the status on the booking record. It doesn't delete anything, and ending statuses (Completed, Canceled) require an explicit confirmation before they're applied. Re-issuing the same status change is safe — the booking simply stays at that status.

## Prerequisites

This tool is available on the Dynamics 365 Field Service MCP server. See the availability note at the top of this page for details. Your Dynamics 365 user must have permission to update bookable resource bookings, and you must be set up as a bookable resource for the assistant to find the bookings on your schedule. No additional configuration is required to call the tool.

## Tool summary

| Property           | Value                                                                                                                                                                                    |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| User-facing name   | Update a booking status                                                                                                                                                                  |
| Internal tool name | `update_booking_status`                                                                                                                                                                  |
| Purpose            | Transitions a bookable resource booking to a named booking status, resolving the target against the organization's live status set and gating ending statuses behind a confirmation step |

## Tool behavior

Resolves the requested status against the organization's live `bookingstatus` records and resolves the target booking from a GUID or a free-form reference (booking name, work order number, or customer name) against the caller's bookings for today. Terminal statuses (Completed, Canceled) return a preview outcome on the first call and only update the record after the assistant re-calls with confirmation. On success it PATCHes the booking's status lookup and returns the previous and new status as chat narration with suggested follow-up prompts. Dataverse status-transition rule errors are surfaced back to the user.

## Annotations

| Annotation        | Value   | Meaning                                                                                                          |
| ----------------- | ------- | ---------------------------------------------------------------------------------------------------------------- |
| `readOnlyHint`    | `false` | This tool modifies data (it changes the booking status).                                                         |
| `destructiveHint` | `false` | The change updates one status lookup; it never deletes a record, and ending statuses require confirmation first. |
| `idempotentHint`  | `true`  | Re-issuing the same status change converges on the same result.                                                  |
| `openWorldHint`   | Not set | Reads and writes Dataverse booking records in the connected environment.                                         |

## Input concepts

### Booking

| Input              | Description                                                                                                                   | Required                                                                                 |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `bookingId`        | The bookable resource booking (bookableresourcebooking) GUID. Pass this when you already hold a GUID.                         | No — if you name no booking, the assistant lists today's bookings for you to choose from |
| `bookingReference` | A free-form identifier — booking name, work order number, or customer name — used when you name the booking conversationally. | No — if you name no booking, the assistant lists today's bookings for you to choose from |

### Target status

| Input          | Description                                                                                                                                                  | Required |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| `targetStatus` | The name of the status to move the booking to (for example, "On Break", "Traveling", "In Progress"). Matched against the organization's live status records. | Yes      |
| `confirm`      | Set after you've confirmed a preview for an ending status (Completed, Canceled). Omit on the first call.                                                     | No       |

If you don't provide a booking, the assistant offers the bookings on your schedule for today so you can pick one.

## Response and UI behavior

This tool is text-only. The confirmation is returned as chat narration; there is no app-in-chat component.

### Response type

Text confirmation

The assistant relays the outcome in the conversation. Depending on what happened, the reply is one of: a confirmation of the status change, a preview asking you to confirm an ending status, a clarification asking which booking or status you mean, or an explanation of why the change couldn't be made (for example, the status isn't set up in your organization, or Dataverse rejected the transition).

## Routing notes

Use `update_booking_status` for:

- Changing your state on a booking — "mark me on break", "start travel", "I've arrived", "complete the booking", "cancel this booking", or any custom status the organization defines
- Moving a single booking to a named status

Don't use `update_booking_status` when the prompt asks to:

- **Recap or summarize a work order or booking** — that's the work order summary tool (`summarize_work_order`), which returns a narrative recap, not a status change.
- **See the raw booking or work order record** — that's a record detail view, not a status change.
- **Update fields other than status** (reschedule, reassign a resource, add a task) — those are separate write tools.

## Related tools

`update_booking_status` is a Field Service booking tool. It pairs with `summarize_work_order` for a recap of the work behind a booking before you change its status. As related booking and work order tools ship, they'll be cross-linked here.

## Data mutation classification

Write.

Updating a booking status changes data — it sets the status on the booking record. The change is non-destructive (no records are deleted), ending statuses require an explicit confirmation, and repeating the same change is safe.
