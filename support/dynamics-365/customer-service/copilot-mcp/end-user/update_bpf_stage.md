---
title: Update Business Process Flow Stage
description: Learn how to use the Update Business Process Flow Stage capability in Dynamics 365 Sales.
ms.date: 07/21/2026
ms.topic: reference
ms.service: dynamics-365-sales
author: ridarbar
ms.author: ridarbar
ms.reviewer: tmanchanda
---

# Update Business Process Flow Stage

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Sales. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when a seller wants to advance a record through its business process flow, such as moving an opportunity to the next sales stage.

## What it does

The assistant sets the active stage on a record's business process flow instance. You provide the business process flow entity logical name, the BPF instance record GUID, and the target stage GUID. The target stage is validated against the instance's process, and the traversal history is derived server-side.

## Try prompts like

- Move this opportunity to the Propose stage
- Advance the deal to the next sales stage
- Set the business process flow stage
- Move this lead to Qualify

## What you'll see in chat

The assistant displays a text response confirming that the stage was updated. There is no interactive app-in-chat component for this capability.

## Helpful tips

- Resolve the business process flow instance and target stage GUIDs first, using record-view tools on the BPF entity.
- Confirm the target stage with the seller before moving the record.
- The target stage must belong to the instance's process; the ordered list of visited stages is recorded automatically.

## What happens next

- Summarize this opportunity
- Add products to the deal
- Draft a next-step email
- Review the activity timeline for this deal

## Does this change data?

**Yes, this can change data.**

## Prerequisites

This tool requires permission to write the business process flow instance record in the selected Dynamics 365 environment.

## Tool summary

| Property | Value |
|---|---|
| User-facing name | Update Business Process Flow Stage |
| Internal tool name | `update_bpf_stage` |
| Purpose | Set the active stage on a record's business process flow. |

## Tool behavior

The tool updates the active stage lookup on the specified business process flow instance and records a server-derived traversal history (built from the instance's current stage and existing path plus the validated target). It doesn't move the underlying record's other fields or validate stage-entry business rules beyond what Dataverse enforces.

## Annotations

| Annotation | Value | Meaning |
|---|---|---|
| `readOnlyHint` | `false` | This tool modifies data. |
| `destructiveHint` | `false` | This tool does not perform destructive changes. |
| `idempotentHint` | `true` | Setting the same active stage again leaves the same stage. |
| `openWorldHint` | Not set | Uses default behavior. |

## Input concepts

### Business process flow

| Input | Description | Required |
|---|---|---|
| `bpfEntityLogicalName` | Logical name of the business process flow entity, such as `opportunitysalesprocess` or `leadtoopportunitysalesprocess`. | Yes |
| `bpfInstanceId` | Dataverse GUID of the active business process flow instance record. | Yes |
| `targetStageId` | Dataverse GUID of the process stage to make active. Must belong to the instance's process. | Yes |

## Response and UI behavior

### Response type

Text-only

No interactive component is rendered.

## Routing notes

Use `update_bpf_stage` when the user wants to move a record through its business process flow. Don't use `update_bpf_stage` to update ordinary fields (use `update_entity_record`) or to close or reopen a deal.

## Related tools

| Tool | Relationship |
|---|---|
| [`get_entity_record`](get_entity_record.md) | Reads the BPF instance and stage records to resolve GUIDs. |
| [`list_entity_records`](list_entity_records.md) | Finds the business process flow instance for a record. |
| [`update_entity_record`](update_entity_record.md) | Updates non-stage fields on the record. |

## Data mutation classification

Write / mutation.

The tool changes Dataverse data when it sets the active stage on a business process flow instance. Repeating the same stage update is idempotent.
