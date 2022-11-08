---
title: Box 84 not available on T4 in Canadian Payroll for Dynamics GP
description: When you try to select the T4 Primary Box Number on the Deduction Code Setup, it will not accept Box 84. This article provides a solution to this issue.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# Box 84 not available on T4 in Canadian Payroll for Microsoft Dynamics GP

This article provides a solution to an issue where Box 84 isn't accepted when you select the T4 Primary Box Number on the Deduction Code Setup.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2545803

## Symptoms

When you try to select the T4 Primary Box Number on the Deduction Code Setup, it will not accept Box 84. Box 84 is used to track Public Transit Passes.

## Cause

Unfortunately Box 84 is not currently available on the T4. There is currently no way to store this information in the CPY table structure.

## Resolution

Update the T4 manually for Box 84.

## More information

Access [MS Connect](https://connect.microsoft.com/dynamicssuggestions/feedback/details/657707/gp-need-ability-to-update-and-track-box-84-on-t4-for-public-transit-passes-in-canadian-payroll) and vote on the product suggestion if you would like to see this functionality considered for a future enhancement.
