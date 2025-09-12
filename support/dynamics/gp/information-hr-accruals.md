---
title: Information about HR Accruals in Microsoft Dynamics GP
description: Information about HR Accruals in Microsoft Dynamics GP.
ms.reviewer: theley, Cwaswick
ms.date: 04/17/2025
ms.custom: sap:Human Resources
---
# Information about HR Accrual Types in Microsoft Dynamics GP

This article describes information about HR Accrual Types in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4057511

## Question

What types of accruals can you set up in Human Resources in Microsoft Dynamics GP?

## Answer

There are four types of Accruals you can set up on HR: (Go to **Microsoft Dynamics GP | Tools | Setup | Human Resources | Attendance | Accruals** and refer to the ACCRUE BY field.)

1. **POST ONCE** - The Number of Hours to Accrue amount will be awarded ONE TIME only and stop.
2. **INTERVAL** - The Number of Hours to Accrue amount will be awarded repeatedly for each interval set, defined by the fixed Number Of Days per Interval set.  For monthly, set to 30, for yearly, set to 365, and so on.
3. **HOUR/YR** - It's the Hours Worked accrual and will be awarded based on transactions keyed (so is typically used for Hourly employees). With this type, the Based on Time Codes section will become available and you can mark which Time Codes should be accrued on. The transactions must exist in the HR transaction table (TATX1030) BEFORE the Accrual process is run.  Once the transactions are accrued on, they're marked off in the table so they aren't accrued on again. This type is most common for hourly employees. For the Hours/Yr accrual type, the amount accrued per hour/unit will equal the YEAR MAX / Hour per Year base (fields in the Accrual Setup window):  

    **Hours Accrued =  'Maximum Accrual Hours Per Year' / 'Work Hours Per Year'**
    Example: If you wanted the employee to earn '4' Accrual hours for every 40 hours worked, and they can only earn a maximum of '80' accrual hours per calendar year, then you would use the equation above to figure out what to enter for the 'Work Hours Per Year' field on the Accrual setup.   In the Accrual Setup, the 'Maximum Accrual Hours per year' would be 80 according to our example, and the '**Work Hours Per Year**' would be calculated out to be **'800**'.  Enter 800 in this field in the Accrual setup window. So 80/800 = 0.1 hours per unit, and 0.1 x 40 total hrs = 4 hours earned.
    > [!NOTE]
    > Keep in mind that salaried employees typically do not have transactions created in the TATX1030 table so the Hrs/Yr type is typically not used for salaried employees.
4. **PAY PERIOD** - The type will award a 'fixed amount' per pay period. This type is most commonly used for salaried employees.
