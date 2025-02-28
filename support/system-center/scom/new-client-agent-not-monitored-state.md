---
title: The Windows Operating System column has a Not monitored state
description: Describes an issue that occurs after you delete an agent and then create a new agent that has the same NetBIOS name in System Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: adoyle, jchornbe
---
# The Windows Operating System column has a Not monitored state for a new Operations Manager agent

This article helps you work around an issue in which the **Windows Operating System** column has a **Not monitored** state after you delete an agent and then create a new agent that has the same NetBIOS name in Operations Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 979387

## Symptoms

In the Operations Manager console of System Center Operations Manager, the **Windows Operating System** column may have a **Not monitored** state for a new client agent. Additionally, the state never changes to **Healthy**.

## Cause

This issue can occur because the new agent has the same NetBIOS name as a previously installed agent. When the agent is deleted from Operations Manager, the grooming of the deleted agent is hard coded to occur after two days. Therefore, the agent is not immediately groomed out of the database completely.

## Workaround

To work around this issue after the old agent is deleted from the console, wait three days, and then add the new agent to Operations Manager. Alternatively, make sure that two full days have passed and then add the new agent to Operations Manager.

## More information

If the data from the old NetBIOS name is not groomed out of the database (such as from the monitoring data or the state change history), Operations Manager uses the NetBIOS name to search the database for some of this information.

A side effect is that the discovery data for the new agent and the state of the discovered objects are linked to the instance of the old NetBIOS name. Therefore, the state of the new agent is incorrect, and the **Windows Operating System** column of the Operations Manager console may have a **Not monitored** state for a new agent.
