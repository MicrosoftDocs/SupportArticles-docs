---
title: A benefit setup based on deductions calculates differently if the Percent of Deduction percentage is equal to or less than the Employer Maximum percentage on the Benefit
description: Describes a problem where benefits that are set up to be based on a deduction calculate incorrectly when the Percent of Deduction percentage amount is less than the Employer Maximum percentage on the Benefit card.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# A benefit setup based on deductions will calculate differently if the Percent of Deduction percentage is equal to or less than the Employer Maximum percentage on the Benefit after installing the 2010 Round 5 Payroll Tax Update in Microsoft Dynamics GP 9.0

This article provides help to solve an issue where a benefit setup based on deductions will calculate differently if the Percent of Deduction percentage is equal to or less than the Employer Maximum percentage on the Benefit after installing the 2010 Round 5 Payroll Tax Update in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2403301

## Symptoms

In Microsoft Dynamics GP 9.0, benefits that are set up based on a deduction calculate incorrectly when the **Percent of Deduction** percentage amount is less than or equal to the Employer Maximum percentage on the Benefit card.

## Cause

System code changes in previous updates created a necessary change in how the setup should be done in Microsoft Dynamics GP 9.0 for benefits that are set up to be based on deductions. This only affects Microsoft Dynamics GP 9.0, as this version of the product is coded a bit differently than more recent versions.

## Resolution

To solve this issue, use one of the following methods:

- Method 1: Change the calculation method on the benefit to be based on Percent of Gross Wages.

- Method 2: Change the calculation method on the benefit to be a Fixed Amount.

- Method 3: Adjust the amounts in the benefits that are Based on the Deduction so that the percent of deduction percentage is higher than the Employer Maximum on the benefit itself.

## More information

Example of changing the Benefit so the Employer Maximum is less than the Deduction percentage:

- Deduction percentage-6%
- Benefit Tier-50%
- Benefit Employer Maximum- 6%

This would need to be changed to the following:

- Deduction percentage-6%
- Benefit Tier-100%
- Benefit Employer Maximum- 3%
