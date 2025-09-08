---
title: Vacation or Sick time pay hours exceed employee vacation or sick time available warning
description: The Check File Report from the build checks process may show a warning message that the employee does not have enough vacation or sick time available in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Human Resources
---
# "Vacation/Sick Time pay hours exceed employee vacation/sick time available" warning when employee has sufficient time available in Human Resources

This article provides a resolution for the warning that states the vacation or sick time pay hours exceed employee vacation available when employee has sufficient time available in Human Resources in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2858161

## Symptoms

The Check File Report from the build checks process may show a warning message that the employee does not have enough vacation or sick time available, when they clearly have adequate hours available in Human Resources. The messages may include:

> The hours available amount is less than this amount. Do you want to continue?
>
> Vacation pay hours exceed employee vacation available.
>
> Sick time pay hours exceed employee sick time available.

## Cause

The warning checkboxes for **Warn When Available Time Falls Below Zero** are still marked on the Payroll side. These flags should be cleared from the payroll side, if you are now accruing in Human Resources, as HR has its own warning flags.

The warning flags for **Warn When Available Time Falls Below Zero** can be found for each module at this location:

- Human Resources: Select **Cards**, point to **Human Resources**, point to **Employee-Attendance**, and select **Maintenance**.
- Payroll: Select **Cards**, point to **Payroll** and select **Employee Card**. The warning flags are within the **Vac/Sick** button, which should now be grayed out if you are accruing in Human Resources, and not payroll.

## Resolution

If you were accruing attendance in Payroll, and now have setup attendance in Human Resources, the warning flags and balances should be cleared from the Payroll side, as they are no longer needed, and may cause misleading message on your Build Check report that the employee does not have adequate vacation or sick time available, when in fact they do on the HR side. There is a reconcile utility in Human Resources that will clear the warning flags and balances from the Payroll side, and should be run as a one-time process when HR is added. To clear the attendance warning flags from the payroll side, follow these steps:

1. Select **Tools** under Microsoft Dynamics GP, point to **Utilities**, point to **Human Resources** and select **Reconcile**.
2. Mark the option for Reset payroll Vacation and Sick Time Information.
3. Select **Process**.
