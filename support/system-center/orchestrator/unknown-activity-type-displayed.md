---
title: Activities are displayed as unknown in Runbook Designer
description: Fixes an issue in which one or more activities are displayed as unknown in the System Center Orchestrator Runbook Designer.
ms.date: 08/04/2020
---
# Unknown activity type displayed in the System Center Orchestrator Runbook Designer

This article helps you fix an issue where one or more activities are displayed as **unknown** in the System Center Orchestrator Runbook Designer.

_Original product version:_ &nbsp; System Center 2016 Orchestrator, Microsoft System Center 2012 R2 Orchestrator, Microsoft System Center 2012 Orchestrator, System Center Orchestrator version 1807, System Center Orchestrator version 1801  
_Original KB number:_ &nbsp; 2702398

## Symptoms

When viewing a runbook in the System Center Orchestrator Runbook Designer, one or more activities are displayed as **unknown**, represented by an activity icon that's a question mark, and no properties can be displayed.

## Cause

Cause # 1

The Orchestrator Runbook Designer doesn't have the integration pack containing the associated activity deployed.

Cause # 2

The runbook was imported from an export file prior to the integration pack containing the associated activity being registered into the Orchestrator environment via the Orchestrator Deployment Manager.

## Resolution

Resolution # 1

Deploy the integration pack that includes the associated activity to the Orchestrator Runbook Designer using the Orchestrator Deployment Manager.

Resolution # 2

Register the integration pack that includes the associated activity, and then deploy the integration pack to the Orchestrator Runbook Designer using the Orchestrator Deployment Manager. Using the Orchestrator Runbook Designer where the integration pack was deployed, perform the import operation again to have the data from the export file successfully imported into the Orchestrator database.

## More information

Details on how to register and deploy an integration pack can be found on [How to Install an Integration Pack](/previous-versions/system-center/system-center-2012-R2/hh420346(v=sc.12)?redirectedfrom=MSDN).
