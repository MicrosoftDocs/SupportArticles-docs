---
title: CPP and EI taxes not stopping at Yearly Maximum
description: CPP and EI not stopping at Yearly Maximum in Canadian Payroll for Microsoft Dynamics GP. Provides resolutions.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# CPP and EI taxes not stopping at Yearly Maximum in Canadian Payroll for Microsoft Dynamics GP

This article provides resolutions for the issue that CPP (Canada Pension Plan) and EI (Employment Insurance) taxes are not stopping at the Yearly Maximum in Canadian Payroll for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2537997

## Symptoms

CPP (Canada Pension Plan) and EI (Employment Insurance) taxes are not stopping at the Yearly Maximum and continue to deduct in full in Canadian Payroll for Microsoft Dynamics GP.

## Cause

The typical causes for this issue are that the Employee's T4 is not maxed out in Boxes 16 or 18, or the employee has more than one T4 or R1 associated with them.

## Resolution 1

Check the employee's T4 to see if boxes 16 and 18 are maxed out. The T4 is updated when you run Update Masters. The system checks the Employee's T4 in box 16 - CPP Deducted, box 18 - EI Deducted, box 24 - EI Insurable Earnings and box 26 - CPP Pensionable Earnings to decide if the maximum has been met or not. To do this, select **Cards**, point to **Payroll-Canada**, select **Employee**, enter the Employee ID and select the **T4** button. If you update box 16 and box 18 to the maximum yearly contributions allowed for the employee and test again, you should find that EI and CPP taxes stop at the maximum.

> [!NOTE]
> The maximums allowed can be found in the Canadian Payroll Tax Update documentation that included the Federal Tax Compliance changes for the year. The maximums are defined in the GP code.

## Resolution 2

To see if there is more than one T4 or R1 associated with the employee, select **Cards**, point to **Payroll-Canada**, point to **Employee**, enter an Employee ID and select the **T4** button. Use the arrows on the bottom left-side of the screen to scroll to see if the employee has more than one T4. If they do have more than one T4 the system will treat each one separately and a full amount can be deducted for each.
