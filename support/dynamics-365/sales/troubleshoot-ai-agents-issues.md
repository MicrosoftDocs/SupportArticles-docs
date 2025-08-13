---
title: Troubleshoot Issues With Dynamics 365 Sales AI Agents
description: Solves issues that are related to Sales Qualification Agent and Opportunity Research Agent in Microsoft Dynamics 365 Sales.
author: pachatte
ms.author: pachatte
ms.reviewer: aam, lavanyakr
ms.date: 08/13/2025
ms.custom: 
---
# Dynamics 365 Sales AI agent is stuck during activation

This article provides step-by-step guidance to troubleshoot and resolve issues with AI agents ([Sales Qualification Agent](/dynamics365/sales/sales-qualification-agent) and [Opportunity Research Agent](/dynamics365/sales/opportunity-research-agent)) in Microsoft Dynamics 365 Sales.

## Symptoms

- The agent remains stuck in the **Starting Agent**, **Starting Test**, or **Applying changes** state for more than 10 minutes when you try to test, start, or update its configuration.
- You receive error messages such as "Something went wrong. Please try again" or "Couldn't start the agent. Please try again."
- The agent's state reverts to its previous status, such as **Draft** or **On**.

## Cause

This issue occurs when the agent can't start the Power Automate flow required for activation. To check if the problem is related to the Power Automate flow, run the following query:

`<ORGURL>/api/data/v9.0/callbackregistrations?$filter=entityname eq 'msdyn_salesagentprofile'&$select=name,filteringattributes,softdeletestatus`

If the query returns no results or if `softdeletestatus` is set to **1**, the issue is related to the Power Automate flow.

## Resolution

Follow these steps to resolve the issue:

1. Go to the [Power Automate portal](https://make.powerautomate.com).
2. Select the environment where the agent is published.
3. Navigate to **My Flows**.
4. Open the **Activate Sales Agent Profile Flow**.
5. Turn the flow off, then turn it back on.
6. Run the query again:

   `<ORGURL>/api/data/v9.0/callbackregistrations?$filter=entityname eq 'msdyn_salesagentprofile'&$select=name,filteringattributes,softdeletestatus`

7. Confirm that `softdeletestatus` is **0**.
8. Open the Sales Hub app and start the agent.

If the issue persists after following these steps, contact your system administrator or Microsoft support for further assistance.
