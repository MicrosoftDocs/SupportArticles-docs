---
title: Agents missing components in a solution
description: Learn how to resolve missing components in Copilot Studio agents when added to a solution. Follow best practices to ensure all components sync correctly.
ms.date: 03/04/2026
ms.reviewer: erickinser, v-shaywood
ms.custom: sap:Manage
ms.collection: CEnSKM-ai-copilot
---

# Agents missing components in a solution

When you add a Copilot Studio agent to a solution, later changes to the agent aren’t included automatically. Any components added afterward, such as topics, tools, actions, connectors, child agents, MCPs, and so on, don't automatically appear in the solution. The newly added components only appear after you manually select **Add required objects** in the solution explorer in Copilot Studio.

In this scenario, you might encounter some of the following problems:

- Missing topics in the target environment after deployment

- Missing knowledge sources in the target environment after Application Lifecycle Management (ALM)

- Missing environment variables

- Missing any components or tools that are linked to the agent in the higher environment

Always use **Add required objects** on the agent before exporting. For more information, see [Add components to an agent in a custom solution](/microsoft-copilot-studio/authoring-solutions-import-export#add-components-to-an-agent-in-a-custom-solution).

## Approaches to edit an agent and maintain changes

### Create agents in the solution context

When you select **Solutions** > **New** > **Agent**, you go to Copilot Studio. If you already added the agent, open the agent from the solution (**Solutions** > *Your solution* > **Agent** > **Open**). Continue with the edit to persist the solution context. This method automatically updates the changes.

### Use Preferred solution in Copilot Studio

Copilot Studio supports *solution‑aware authoring* through preferred solutions.

To go to the solution explorer in Copilot Studio:

1. Select the three dots (…) on the side bar.

1. Select **Solutions**.

1. Select **Set preferred solution** on the top menu bar, above the list of solutions.

1. Choose the solution in which you want agents to be created, by default.

1. Create or edit agents and components.

1. Create new components directly under the selected solution.

This method reduces, but doesn't completely eliminate, manual re‑sync work. For more information, see [Solution management in Copilot Studio](/microsoft-copilot-studio/authoring-solutions-overview#set-your-preferred-solution).

## Verify the solution context of the agent in Copilot Studio

You can verify solution mapping directly inside Copilot Studio.

1. Open **Copilot Studio**.

1. Open the **Agent**.

1. Select **Settings** > **Agent details**.

1. Select **View solution**.
