---
title: Accrual checkboxes not automatically mark off in Accrual Period Setup
description: When the accrual process is run, it should automatically mark off the Accrual checkboxes in the Accrual Period Setup window to show the accrual has been completed. However, after manually marking or unmarking in this window, the checkboxes do not get automatically updated any longer when the accrual is run for Human Resources in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Human Resources
---
# The Accrual Checkboxes in the Accrual Period Setup window do not automatically mark off when the accrual is completed using Human Resources

This article provides a resolution for the issue that the Accrued checkboxes in the Accrual Period Setup are no longer getting automatically marked off when the accrual is completed using Human Resources in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2547236

## Symptoms

When the Accrual process is run for Human Resources in Microsoft Dynamics GP, the Accrued checkboxes in the Accrual Period Setup (Weekly, Biweekly, Semimonthly, Monthly, Quarterly, Semiannual, and so on) window are no longer getting automatically checked off to show that the accrual has been completed for that period. In the past, the checkboxes were automatically marked off. However, the checkboxes are no longer marked off automatically. This behavior has stopped.

## Cause

If the user manually marks or unmarks the Accrued checkboxes in any of the Accrual Period Setup windows, it may disrupt the automatic process that marks off these checkboxes.

## Resolution

The Accrued checkboxes are *informational only*, and do not affect anything if they do not get marked off as completed. Having the Accrued checkbox unmarked will not result in the employee getting an extra accrual amount when the next accrual process is run.

The marking off process should read the Last Day Accrued date in the Human Resources Setup window, but once the automatic process is disrupted, there is no simple way to turn it back on. Therefore, after the automatic process is disrupted, the user has these options:

Option 1 - The user can manually mark the Accrued checkbox as completed going forward for their own reference.

Option 2 - The user may decide to just ignore the checkboxes in this window since they are informational only.

> [!NOTE]
> As an alternative, the user can view the date listed in the **Last Day Accrued** field in the Human Resources setup window. (This window can be found by selecting Microsoft Dynamics GP , point to **Tools**, point to **Setup**, point to **Human Resources**, point to **Attendance**, and select **Setup**.)
