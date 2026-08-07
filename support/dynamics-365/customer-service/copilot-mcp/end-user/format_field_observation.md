---
title: Format Field Observation
description: Learn how to use the Format Field Observation capability in Dynamics 365 Field Service.
ms.date: 07/31/2026
ms.topic: reference
ms.service: dynamics-365-field-service
author: karthiks
ms.author: karthiks
ms.reviewer: laalexan
---

# Format Field Observation

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Field Service. [Learn more about adding this tool to other MCP servers](/dynamics365/field-service/administer/configure-field-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability to organize raw field observations into a clean, structured format before saving them to the work order timeline.

## What it does
The assistant takes your raw observation text - such as what you saw on site, actions taken, and outstanding items - and returns the formatted text for your review before saving. A future release will add intelligence-powered structuring into Problem, Action, and Outcome sections.

This is useful when you have quick notes from a job site visit and want to create an organized record before adding them to the work order timeline.

## Try prompts like
- "Format my field observation for this work order"
- "Structure these notes: found corroded pipe, replaced section, pressure test passed, recommend follow-up inspection in 6 months"
- "Organize my site visit notes"
- "Clean up these observations before I save them"
- "Format what I found on the job today"
- "Structure my technician notes for the work order"

## What you'll see in chat
The assistant returns the formatted observation as text in the chat. You can review the structured output and approve it before saving. The assistant also asks which work order to save it to if a work order reference wasn't provided.

## Helpful tips
- Include as much detail as possible - what you saw (Problem), what you did (Action), and what's left (Outcome).
- You can ask the assistant to save the formatted note to a work order by saying "save this to the work order" after reviewing.
- Use this after completing a job to document your observations before moving to the next appointment.
- For typed exceptions like unsafe conditions or missing parts that need escalation, use "record a work exception" instead.

> [!TIP]
> Combine this with your daily workflow: format your observations after each job, review them, then say "save this note to the work order."

## What happens next
After the formatted observation appears, you can continue with prompts like:

- "Save this note to the work order"
- "Edit the observation and add more details"
- "Also update the booking status to completed"

## Does this change data?
**No, this does not change data.**

Formatting the observation is read-only. The formatted text is returned for your review. To save it, you need to use a follow-up action like adding a note to the work order.

## Prerequisites
This tool requires the following:

- Copilot features to be enabled

Learn more in [Manage Copilot features in Field Service](/dynamics365/field-service/administer/configure-copilot-features).

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Format Field Observation |
| Internal tool name | `format_field_observation` |
| Purpose | Accepts raw technician observations and returns them as structured text with organized sections (Problem, Action, Outcome) |

## Tool behavior
Accepts raw technician field observations and returns them as structured text with organized sections. Currently passes the text through for the model to structure; a future release will add intelligence API-powered reformatting into Problem/Action/Outcome sections.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | Does not modify any records. |
| `destructiveHint` | Not set | Not applicable. |
| `idempotentHint` | Not set | Not applicable. |
| `openWorldHint` | `false` | Does not use external data sources. |

## Input concepts
### Source text

| Input | Description | Required |
|---|---|---|
| `text` | `text` (required). Raw observation text to structure - what was seen, done, and outstanding on the job. | Yes |

### Work order context

| Input | Description | Required |
|---|---|---|
| `workOrderId`, `bookingId` | `workOrderId` (optional) or `bookingId` (optional). Used for narration context. Neither is required - the tool can format text without a work order reference. | Varies |

## Response and UI behavior
### Response type

Text-only

No interactive component is rendered. The formatted observation is returned as text in the chat for the technician to review and approve before saving.

## Routing notes
Use `format_field_observation` when:

- The technician has raw observations and asks to "structure", "format", or "organize" them
- The technician wants to document what they observed or did on a job
- The technician wants to clean up notes before adding them to the work order timeline

Don't use `format_field_observation` when:

- The technician wants to **save a note to the work order** - route to `create_note` after formatting
- The technician is reporting a **typed exception** (unsafe condition, missing parts) that triggers status changes or escalation - route to `record_work_exception`
- The technician wants a **work order summary** - route to `summarize_work_order`

## Related tools
| Tool | Relationship |
|---|---|
| [`create_note`](create_note.md) | Saves a note to the work order timeline. Use after `format_field_observation` to persist the formatted text |
| [`summarize_work_order`](summarize_work_order.md) | Provides a recap of the work order. Different purpose - summarizes existing data rather than formatting new observations |

## Data mutation classification
Read-only.

No data is modified. The formatted text is returned for review. The technician must use `create_note` or another tool to persist the result.
