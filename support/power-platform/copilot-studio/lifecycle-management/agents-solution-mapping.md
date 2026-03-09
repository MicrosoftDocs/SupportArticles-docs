---
title: Fix Missing Agent Components in Copilot Studio Solutions
description: Resolve missing agent components in Microsoft Copilot Studio solutions. Learn how to add topics, tools, and connectors that aren't syncing automatically.
ms.date: 03/09/2026
ms.reviewer: erickinser, v-shaywood
ms.custom: sap:Manage
ms.collection: CEnSKM-ai-copilot
---

# Agents missing components in a solution

## Summary

This article helps you resolve an issue in [Microsoft Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) where components you add to an agent aren't automatically added to a [solution](/microsoft-copilot-studio/authoring-solutions-overview). After you add an agent to a solution, new components such as topics, tools, actions, connectors, child agents, and Model Context Protocol (MCP) servers don't sync automatically to the solution. This article describes how to add the missing components and methods to prevent the issue.

## Symptoms

After you add new components to a Copilot Studio agent that's already part of a solution, you experience one or more of the following problems:

- Topics are missing in the target environment.
- Knowledge sources are missing in the target environment after Application Lifecycle Management (ALM).
- Environment variables are missing.
- Components or tools linked to the agent in a higher environment don't appear in the target environment.

## Cause

When you add an agent to a solution and later modify the agent, any new components added to the agent aren't automatically added to the solution. The solution only reflects the agent's state at the time you added it.

## Solution

Before you export the solution, add the required objects to ensure all current components are included:

1. Open the solution in the solution explorer.
1. In the **Objects** pane, locate your agent under **Agents**.
1. Select the three dots (**⋮**), select **Advanced**, and then select **Add required objects**.

For more information, see [Add components to an agent in a custom solution](/microsoft-copilot-studio/authoring-solutions-import-export#add-components-to-an-agent-in-a-custom-solution).

To prevent this problem going forward, use one of the following approaches to keep agent changes in sync with the solution.

### Create agents in the solution context

To create a new agent in the solution context, follow these steps:

1. From the **Home** page, select the gear icon in the description box.
1. In **Agent settings**, under **Advanced settings**, select the desired [solution](/microsoft-copilot-studio/authoring-solutions-overview).

If you already added the agent, open the agent from the solution (**Solutions** > *Your solution* > **Agent** > **Open**). Continue editing to keep the solution context. This method automatically updates agents changes in the solution.

### Use a preferred solution in Copilot Studio

Copilot Studio supports *solution-aware authoring* through preferred solutions. When you set a preferred solution, new agents and component edits are created directly in that solution.

To set a preferred solution:

1. Select ellipsis (**…**) on the sidebar.
1. Select **Solutions**.
1. Select **Set preferred solution** on the top menu bar.
1. Choose the solution in which you want to create agents by default.

For more information, see [Solution management in Copilot Studio](/microsoft-copilot-studio/authoring-solutions-overview#set-your-preferred-solution).

### Verify the solution context of the agent

To verify the solution mapping in Copilot Studio:

1. Open the agent.
1. Select **Settings** > **Agent details**.
1. Select **View solution**.

## Related content

- [Solution concepts in Power Platform ALM](/power-platform/alm/solution-concepts-alm)
- [Work with environments in Copilot Studio](/microsoft-copilot-studio/environments-first-run-experience)
