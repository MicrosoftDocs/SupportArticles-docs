---
title: Grant Foreign Namespace
description: Learn how to add another product's whole toolset to an agent in Dynamics 365 Customer Service.
ms.date: 06/25/2026
ms.topic: reference
ms.service: dynamics-365-customer-service
author: dleblond
ms.author: dleblond
ms.reviewer: laalexan
---

# Grant Foreign Namespace

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Customer Service. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you want to add another product's entire toolset to an agent, such as adding all Sales tools to a Service agent.

## What it does
This tool grants or revokes an entire foreign product namespace at the organization or profile level. When you grant a namespace, all of its tools become visible to the agent. Granting only changes visibility — a granted tool that the user lacks Dataverse privilege for stays hidden.

## Try prompts like
- "Add all the sales tools to my service agents"
- "Give my service agents the field-service toolset"
- "Grant the WEM tools at the org level"
- "Remove the sales tools"
- "Add the whole sales namespace for this profile"

## What you'll see in chat
The assistant confirms which namespace was granted or revoked, the scope that was updated, and the net set of foreign tools now available.

## Helpful tips
- Use `level: org` to grant a namespace organization-wide.
- Use `level: profile` when the grant should apply to one profile only. Profile level requires the service app.
- Include `profileId` when `level` is `profile`.
- Granting is visibility scoping only. Role-based access control (RBAC) still applies.

## What happens next
- "List cross-namespace grants to verify the change"
- "Grant just one more foreign tool"
- "Reset cross-namespace grants"

## Does this change data?
**Yes, this changes configuration data.**

It updates the stored cross-namespace grants for the selected scope.

## Prerequisites

This tool is available on the Dynamics 365 Customer Service MCP server. See the availability note at the top of this page for details. No additional configuration is required.

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Grant Foreign Namespace |
| Internal tool name | `save_cross_namespace_grant` |
| Purpose | Grants or revokes a whole foreign namespace at the organization or profile level |

## Tool behavior
Grants or revokes an entire foreign product namespace (for example, adding the whole Sales toolset to a Service agent) at org or profile level. The change is visibility scoping only — a granted tool the user lacks Dataverse privilege for stays hidden. Profile level requires the service app.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `false` | This tool modifies data. |
| `destructiveHint` | `false` | Updates grants without deleting the scope. |
| `idempotentHint` | `true` | Granting the same namespace twice produces the same result. |
| `openWorldHint` | `false` | Does not call external systems outside the configured Dynamics 365 scope. |

## Input concepts
### Level

| Input | Description | Required |
|---|---|---|
| `level`, `org`, `profile` | `level` (`org` or `profile`, required). Chooses the scope for the grant. Profile is service-app only. | Yes |

### Profile ID

| Input | Description | Required |
|---|---|---|
| `profileId` | `profileId` (UUID string, optional). Required when `level` is `profile`. | Varies |

### Patches

| Input | Description | Required |
|---|---|---|
| `patches` | `patches` (array, required). Array of whole-namespace grant patches. | Yes |

### Namespace

| Input | Description | Required |
|---|---|---|
| `namespace` | `namespace` (`service`, `sales`, `field-service`, `wem`, or `customer-insights`, required in each patch). The foreign product namespace to grant or revoke. | Yes |

### Action

| Input | Description | Required |
|---|---|---|
| `action`, `add`, `remove` | `action` (`add` or `remove`, required in each patch). Grants the whole namespace or revokes it. | Yes |

## Response and UI behavior
### Response type

Text-only

No interactive component is rendered. Returns a confirmation with the updated scope, the granted or revoked namespaces, and the net resolved foreign tool set.

## Routing notes
Use `save_cross_namespace_grant` when:

- The user wants to add or remove an entire foreign product's toolset
- The user wants to change grants at org scope or profile scope
- The user refers to a whole product area rather than individual tools

Don't use `save_cross_namespace_grant` when:

- The user wants to grant or exclude individual tools. Use `save_cross_namespace_tools`.
- The user only wants to inspect grants. Use `list_cross_namespace_grants`.
- The user wants to remove all grants. Use `delete_cross_namespace_grants`.

## Related tools
| Tool | Relationship |
|---|---|
| [`save_cross_namespace_tools`](save_cross_namespace_tools.md) | Grants or revokes individual foreign tools |
| [`list_cross_namespace_grants`](list_cross_namespace_grants.md) | Lists granted namespaces and tools |
| [`delete_cross_namespace_grants`](delete_cross_namespace_grants.md) | Removes all cross-namespace grants |

## Data mutation classification
Write.

Creates or updates whole-namespace grants for the selected scope.
