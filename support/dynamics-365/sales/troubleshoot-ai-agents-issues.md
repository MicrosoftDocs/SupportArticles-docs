---
title: Troubleshoot issues with sales AI agents
description: Provides resolutions for the known issues that are related to AI agents in Dynamics 365 Sales.
author: 
ms.author: 
ms.reviewer: 
ms.date: 08/07/2025
ms.custom: 
---
# Troubleshoot issues with sales AI agents

This article helps you troubleshoot and resolve issues related to AI agents in Microsoft Dynamics 365 Sales.

## Sales AI agent is stuck during the activation process

### Symptoms 

- When you try to test or start the agent, or apply changes after editing the agent configuration, the agent is stuck in the **Starting Agent**, **Starting Test**, or **Applying changes** state for more than 10 minutes.
- You see an error message that says "Something went wrong. Please try again." or "Couldn't start the agent. Please try again."
- You see that the agent state is reset to its previous state, such as **Draft** or **On**.


### Cause

The agent is unable to start the Power Automate flow that activates the agent. To identify if the issue is related to the Power Automate flow, go to `<ORGURL>/api/data/v9.0/callbackregistrations?$filter=entityname eq 'msdyn_salesagentprofile'&$select=name,filteringattributes,softdeletestatus`

If there are no results OR if `softdeletestatus` is 1, then the issue is related to the Power Automate flow.

### Resolution

1. Go to the [Power Automate portal](https://make.powerautomate.com).
2. Select the environment in which the agent is being published.
3. Go to **My Flows**.
4. Open the **Activate Sales Agent Profile Flow** flow.
5. Turn it off and then turn it on again.
6. Go to `<ORGURL>/api/data/v9.0/callbackregistrations?$filter=entityname eq 'msdyn_salesagentprofile'&$select=name,filteringattributes,softdeletestatus`.
1. Check if the `softdeletestatus` is 0. 
1. Open the Sales Hub app and start the agent.
