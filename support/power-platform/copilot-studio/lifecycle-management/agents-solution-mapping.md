---
title: Fix Missing Agent Components in Copilot Studio Solutions
description: Resolve missing agent components in Microsoft Copilot Studio solutions. Learn how to add topics, tools, and connectors that aren't syncing automatically.
ms.date: 03/10/2026
ms.reviewer: erickinser, marcelbf, liprakash, v-shaywood
ms.custom: sap:Lifecycle Management\Export or import copilots through solutions
ms.collection: CEnSKM-ai-copilot
---

# Agents missing components in a solution

## Summary

This article helps you resolve a problem in [Microsoft Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) in which an agent is missing components in a target environment. After you import an agent's [solution](/microsoft-copilot-studio/authoring-solutions-overview) into a target environment, new components that you add to the agent's source solution don't automatically appear in the imported version of the agent. Such new components could include [topics](/microsoft-copilot-studio/authoring-create-edit-topics), tools, actions, [connectors](/microsoft-copilot-studio/advanced-connectors), child agents, or Model Context Protocol (MCP) servers. This article describes how to add the missing components and how to avoid the problem.

## Symptoms

After you import an agent's solution into a target environment, and then you add new components to the agent in the source solution, you experience one or more of the following problems:

- Topics are missing from the agent in the target environment.
- [Knowledge sources](/microsoft-copilot-studio/knowledge-copilot-studio) are missing from the agent in the target environment.
- [Environment variables](/microsoft-copilot-studio/authoring-variables) are missing from the agent in the target environment.
- Components or tools that are linked to the agent in the source environment don't appear in the target environment.

## Cause

When you import an agent's solution into a target environment, and you later modify the agent's source solution, the imported solution in the target environment doesn't automatically include any components that are added to the agent's source solution. The imported solution reflects the agent's state only at the time that you originally exported it.

## Solution

To sync new components from the agent's source solution to the imported agent in the target environment:

1. In Copilot Studio, go to **Solutions**, and then open the agent's source solution.
1. In the **Objects** pane, locate your agent under **Agents**.
1. Open the overflow menu (**⋮**), select **Advanced**, and then select **Add required objects**.
1. [Export the source solution](/microsoft-copilot-studio/authoring-solutions-import-export#export-the-solution-with-your-agent).
1. [Import the updated solution](/microsoft-copilot-studio/authoring-solutions-import-export#import-the-solution-with-your-agent) into your target environment.

For more information, see [Export and import agents using solutions](/microsoft-copilot-studio/authoring-solutions-import-export).

> [!NOTE]
> If you add new components to the agent, repeat the previous steps to add required objects before you export the solution.

To prevent this problem, use one of the following approaches to keep agent changes in sync with the target environment's solution.

### Create agents in the solution context

When you create an agent in a solution's context, Copilot Studio automatically adds new agent components to that solution. To create a new agent in your target environment's context, follow these steps:

1. On the **Home** page of Copilot Studio, select the gear icon in the description box.
1. In **Agent settings**, under **Advanced settings**, select the desired [solution](/microsoft-copilot-studio/authoring-solutions-overview) in your target environment.

If you already added the agent to your environment, open the agent from your target environment's solution (**Solutions** > *Your Solution* > **Agent** > **Open**), and then continue editing from that context.

### Use a preferred solution in Copilot Studio

Copilot Studio supports *solution-aware authoring* through preferred solutions. When you set a preferred solution, new agents and component edits are created directly in that solution.

To set a preferred solution:

1. On the sidebar, select the ellipsis (**…**).
1. Select **Solutions**.
1. On the top menu bar, select **Set preferred solution**.
1. Choose the solution in your target environment that you want to create agents in by default.

For more information, see [Solution management in Copilot Studio](/microsoft-copilot-studio/authoring-solutions-overview#set-your-preferred-solution).

### Verify the solution context of the agent

To verify that the agent is correctly mapped to your solution so that new components sync automatically:

1. Open the agent.
1. Select **Settings** > **Agent details**.
1. Select **View solution**.
1. Verify that the solution that's shown is your desired solution. If the agent isn't mapped to the correct solution, follow the steps in [Create agents in the solution context](#create-agents-in-the-solution-context) or [Use a preferred solution in Copilot Studio](#use-a-preferred-solution-in-copilot-studio) to update the mapping.

## Related content

- [Application lifecycle management for Copilot Studio](/microsoft-copilot-studio/admin-alm)
- [Work with environments in Copilot Studio](/microsoft-copilot-studio/environments-first-run-experience)
