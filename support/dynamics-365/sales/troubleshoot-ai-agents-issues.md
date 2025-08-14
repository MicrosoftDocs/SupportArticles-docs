---
title: Troubleshoot Activation Issues With Dynamics 365 Sales AI Agents
description: Solves activation issues related to Sales Qualification Agent and Opportunity Research Agent in Microsoft Dynamics 365 Sales.
ms.reviewer: aam, lavanyakr, pachatte
ms.date: 08/14/2025
ms.custom: 
---
# Dynamics 365 Sales AI agent is stuck during activation

This article provides guidance to resolve issues where the AI agents ([Sales Qualification Agent](/dynamics365/sales/sales-qualification-agent) and [Opportunity Research Agent](/dynamics365/sales/opportunity-research-agent)) in Dynamics 365 Sales get stuck during the activation process or revert to a draft state.

## Symptoms

As an administrator, you may encounter the following symptoms when you try to configure or activate AI agents:

- When you try to test, start, or update the agent's configuration, it remains in the **Starting Agent**, **Starting Test**, or **Applying changes** state for more than 10 minutes.
- You receive error messages, such as:
  - > Something went wrong. Please try again.
  - > Couldn't start the agent. Please try again.
- The agent's state reverts to its previous status, such as **Draft** or **On**.

## Cause

This issue occurs when the agent can't start the Power Automate flow required for activation. To check if the problem is related to the Power Automate flow, run the following query in your browser or API tool, replacing \<ORGURL> with your organization's URL:

`<ORGURL>/api/data/v9.0/callbackregistrations?$filter=entityname eq 'msdyn_salesagentprofile'&$select=name,filteringattributes,softdeletestatus`

If the query returns no results or if `softdeletestatus` is set to **1**, the issue is related to the Power Automate flow.

[Learn more about callbackregistration EntityType](/power-apps/developer/data-platform/webapi/reference/callbackregistration).

## Solution

Follow these steps to resolve the issue:

1. Go to the [Power Automate portal](https://make.powerautomate.com).
2. Select the environment where the agent is published.
3. Navigate to **My Flows**.
4. Open the **Activate Sales Agent Profile Flow**.
5. Turn off the flow, then turn it back on.
6. Run the query again in your browser or API tool:

   `<ORGURL>/api/data/v9.0/callbackregistrations?$filter=entityname eq 'msdyn_salesagentprofile'&$select=name,filteringattributes,softdeletestatus`

7. Confirm that `softdeletestatus` is **0**.
8. Open the Sales Hub app and start the agent.

If the issue persists after following these steps, verify your flow configuration or contact Microsoft support for further assistance.
