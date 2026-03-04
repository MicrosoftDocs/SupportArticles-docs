---
title: Agents missing components in a solution
description: 
ms.date: 03/04/2026
ms.reviewer: erickinser, v-shaywood
ms.custom: sap:Manage
---

# Agents missing components in a solution

When you create a Copilot Studio agent, add it to a Solution, and later add new components (topics, tools, actions, connectors, child agents, MCPs, etc.), those new components do **not** automatically appear in the solution. You only see them after manually doing Add required objects on the Agent in solution.

Usual issues reported:

- Missing topics in my target environment post deployment

- Missing Knowledge source in my target environment post alm

- Missing environment variable

- Missing any components or tools that are linked to agent in the higher environment can be due to below scenario.

Mitigation:

Always use **Add required Objects on the Agent before exporting**. For more information, see [Add components to an agent in a custom solution](/microsoft-copilot-studio/authoring-solutions-import-export#add-components-to-an-agent-in-a-custom-solution).

## Recommended Approaches when editing Agent in source to hold solution context

1. Agents are created in the solution context

    - When start from **Solutions → New → Agent**, the UI redirects you to Copilot Studio.

    - Open Agent from the Solution (Solutions → *Your solution* → Agent → Open) if already added and continue with the edit to persist the solution context

    - The above scenario will get the changes updated automatically.

1. Use “Preferred Solution” in Copilot Studio (Best Practice)

    - Copilot Studio supports **solution‑aware authoring** via Preferred Solutions.

    - **Steps:**

    - Open **Copilot Studio**

    - Go to **Solution manager**

    - Set your solution as the **Preferred solution**

    - Create or edit agents/components

    - New components are created directly under the selected solution

    - Reduces (but does not completely eliminate) manual re‑sync work

    - [Microsoft documentation: Solution management in Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/authoring-solutions-overview#set-your-preferred-solution)

## Where to Check Which Solution context Agent has in Copilot Studio

You can verify solution mapping directly inside Copilot Studio:

1. Open **Copilot Studio**

1. Open the **Agent**

1. Go to **Settings → Agent details**

1. Select **View solution**
