---
title: List work order service tasks
description: Use the Field Service agent to see the service tasks on a work order in an interactive, sortable grid directly in chat.
ms.date: 07/15/2026
ms.topic: reference
ms.service: dynamics-365-field-service
author: neilhughes
ms.author: neilhughes
ms.reviewer: neilhughes
---

# List work order service tasks

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Field Service. [Learn more about adding this tool to other MCP servers](/dynamics365/field-service/configure-field-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you want to review the service tasks — the checklist of work to perform — on a single work order, without opening the record.

## What it does
The assistant shows the service tasks for one work order in an interactive grid. Each task is a line item on the job, and the grid shows the columns from the environment's published service-task view — typically the task name, completion percentage, and estimated and actual duration. Tasks are listed in their work-order sequence.

Results appear in a sortable, filterable app-in-chat grid. Alongside the grid, the assistant knows how many tasks there are and how many are complete, so you can ask follow-up questions.

## Try prompts like
- "List the service tasks for this work order"
- "Show the tasks on work order 3c24bfb3-cd6c-eb11-a812-000d3a1865e0"
- "What's on the checklist for this job?"
- "Show me the tasks I still need to do on this work order"

The assistant needs the work order's ID (its `msdyn_workorderid` GUID). It can't look a work order up by name or number yet — if you refer to one that way, it asks you for the ID.

## What you'll see in chat
The assistant displays the work order's service tasks as an app-in-chat component: an interactive grid with the columns from the environment's published service-task view. You can sort and filter the grid to find the task you care about. If the work order has no service tasks, the grid shows an empty state that says so rather than a blank card.

## Helpful tips
- Provide the work order's ID (its GUID) — the assistant can't look one up by name or number yet, and asks you for the ID if you refer to it another way.
- The grid reflects the tasks on the work order at the time you ask; ask again after updates to refresh.
- The columns shown come from the environment's published "Active Work Order Service Tasks" view, so an administrator can change which columns appear by configuring that view.
- Sort by completion percentage to see which tasks are done and which are still outstanding.

## What happens next
After the task list appears, you can continue with prompts like:

- "Which of these tasks aren't finished yet?"
- "Summarize this work order"
- "Open this work order in Field Service"

## Does this change data?
**No, listing work order service tasks does not change data.**

The task list is read-only. It reads the work order's service tasks to display them and never modifies the work order, its tasks, or any related record.

## What you can do from the app-in-chat component
From the service-task grid in chat, you can:

- Scan and review the work order's service tasks in a sortable grid
- Sort by any column, such as completion percentage or duration
- Filter the grid to narrow down the tasks shown
- Choose which columns are visible
- Continue working with the tasks in chat using follow-up prompts

## Prerequisites

This tool is available on the Dynamics 365 Field Service MCP server. See the availability note at the top of this page for details. The environment must have a published public view for the work order service task (`msdyn_workorderservicetask`) entity — the default "Active Work Order Service Tasks" view ships with Field Service. No additional configuration is required to call the tool.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | List work order service tasks |
| Internal tool name | `list_work_order_service_tasks` |
| Purpose | Lists the service tasks of a single work order and renders them in an interactive grid-style app-in-chat experience, driven by the environment's published service-task view |

## Tool behavior
Lists the service tasks (`msdyn_workorderservicetask`) for the work order identified by `workOrderId`, scoped with the `_msdyn_workorder_value` lookup and ordered by `msdyn_lineorder`. The columns come from the environment's published service-task view (`savedquery`), resolved at runtime — they are not hardcoded. The tasks render through the shared entity grid (`skill://entity-grid/ui`); no bespoke widget is used. The response also carries a concise summary — the total task count, the completed count (tasks with `msdyn_percentcomplete` equal to 100), and the active view name — for the model and follow-up prompts.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | This tool does not modify data. |
| `destructiveHint` | `false` | Not applicable (read-only tool). |
| `idempotentHint` | Not set | Not applicable (read-only tool). |
| `openWorldHint` | `true` | Queries Dataverse for the work order's service tasks and view metadata. |

## Input concepts
### Work order

| Input | Description | Required |
|---|---|---|
| `workOrderId` | The work order (`msdyn_workorder`) GUID whose service tasks to list. | Yes |

`workOrderId` is required and must be a valid GUID. It is validated at the data-access boundary before any Dataverse query is built.

## Response and UI behavior
This tool renders an interactive app-in-chat grid of work order service tasks.

This MCP tool is supported by an MCP App. [Learn more about MCP Apps](/dynamics365/field-service/configure-field-service-mcp-server).

### Response type

Interactive grid (list view)

The grid displays the columns from the environment's published service-task view — typically task name, completion percentage, and estimated and actual duration. When the work order has no service tasks, the grid renders a localized empty state. If the tasks can't be retrieved — for example, you lack permission — the assistant shows an actionable error with a support code instead.

## Routing notes
Use `list_work_order_service_tasks` for:

- "list", "show", or "see the tasks / checklist" for a work order
- Reviewing the service tasks to perform on a single job

Don't use `list_work_order_service_tasks` when the prompt asks to:

- **Get a narrative AI recap of the whole work order** — that's `summarize_work_order`, which returns a written summary of the job, not a task grid.
- **See the raw work order record or a specific status field** — that's a work order detail view, a field-by-field record card, not a list of tasks.
- **List bookings, incidents, or products on the work order** — those are different related lists, not service tasks.
- **Change a task** (update status or completion) — that's a separate write tool.

## Related tools
| Tool | Relationship |
|---|---|
| [`summarize_work_order`](summarize_work_order.md) | Generates an AI-powered recap of the whole work order (or the work order behind a booking) |

## Data mutation classification
Read-only.

Listing work order service tasks does not change data. The tool only reads the work order's service tasks and view metadata to render the grid.
