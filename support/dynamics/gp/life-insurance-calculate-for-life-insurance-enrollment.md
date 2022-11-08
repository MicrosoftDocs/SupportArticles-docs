---
title: Why doesn't Life Insurance calculate for Life Insurance Enrollment using Human Resources
description: Why doesn't Life Insurance calculate for Life Insurance Enrollment using Human Resources in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Why doesn't Life Insurance calculate for Life Insurance Enrollment using Human Resources in Microsoft Dynamics GP

This article provides a solution to an issue where Life Insurance doesn't calculate for Life Insurance Enrollment by using Human Resources.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4049013

## Issue

Why doesn't Life Insurance calculate for Life Insurance Enrollment using Human Resources in Microsoft Dynamics GP?

## Resolution

Under **Cards | Human Resources | Employee - Benefits | Life Insurance,** enter the Employee ID and Benefit Name. Review these possible reasons:

- Make sure the **Benefit Status** = Active
- Make sure the **Benefit Begins** date is a prior date.
- Make sure the **Benefit Ends** date is blank or a date in the future.  
- Make sure the **AMOUNT** field is filled in. The **AMOUNT** field must be manually entered by the user. Dynamics GP does not assume that the employee, spouse or child automatically gets the maximum amount.  Therefore, the user must key in the AMOUNT field and then the premium will automatically calculate.

> [!NOTE]
> The **Estimated Annual Salary** field will display the pay code amount for the pay code marked as the 'Primary Pay Code'.
