---
title: PTE transactions don't flow to PA Tables
description: Provides a solution to an issue where PTE transactions aren't flowing to the Project Accounting Tables when approved in the workflow email.
ms.reviewer: ansather, cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# PTE transactions aren't flowing to the Project Accounting tables when approved in the workflow email in Microsoft Dynamics GP

This article provides a solution to an issue where PTE transactions aren't flowing to the Project Accounting tables when approved in the workflow email in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3096998

## Symptoms

When approving PTE Timesheets or Employee Expenses through Workflow email, the Completed Workflow transactions aren't flowing to the Project Accounting (PA) tables in Microsoft Dynamics GP 2013 and 2015.

## Cause

It's a known quality issue and is targeted to be fixed in a future release. (TFS #86918/CR 86871)

## Resolution

This issue is targeted to be fixed in a future release.

The current workaround is to approve the Timesheets and Employee Expenses through the Rich or Web client, and not the workflow email. For existing transactions, the Employee can recall and resubmit the completed PTE Document. The Approver can reapprove it through the Rich or Web client.
