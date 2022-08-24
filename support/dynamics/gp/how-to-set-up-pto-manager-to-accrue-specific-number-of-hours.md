---
title: How to set up PTO Manager to accrue specific number of hours
description: Describes how to set up PTO Manager to accrue a specific number of hours based on the number of years employed in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: how-to
ms.date: 03/31/2021
---
# How to set up PTO Manager to accrue a specific number of hours based on the number of years employed

This article describes how to set up accrual schedules in PTO Manager for Microsoft Dynamics GP to accrue a specific number of paid time off (PTO) hours per pay period. The accruals are based on the number of years of employment, regardless of how many hours the employee works during the period.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 949763

## More information

Consider the following example:

New employees do not accrue PTO time for the first three months of employment. Employees employed from three months to 2.99 years accrue 3.69 hours of PTO time. Employees employed from three years to 8.99 year accrue 4.46 hours of PTO time. Employees employed nine years and longer accrue 5.24 hours of PTO Time. Employees cannot use PTO time that is accrued until after the first six months of employment. The following steps describe how to set up the accrual schedule in PTO Manager based on this example:

### Set up the accrual schedule

1. Use one of the following options

   - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Payroll**, point to **PTO Manager**, and then select **Accrual Schedules**.
   - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to **Setup**, point to **Payroll**, point to **PTO Manager**, and then select **Accrual Schedules**.

2. In the **Schedule Code** field, type a new schedule name.
3. In the **Range Based On** list, select **Years Worked**.
4. In the **Maximum Hours Based On** list, select **Per Pay Period Variable**.
5. To create the first range, use the following information:
   - **From**: 0
   - **To**: .25
   - **Calculation Factor**: 0
   - **Maximum Hour**: 0

   The first range shows that no PTO time is accrued for the first three months of employment.

6. To create the second range, use the following information:

    - **From**: .26
    - **To**: 2.99
    - **Calculation Factor**: 9.99999
    - **Maximum Hours**: 3.69.

    The second range shows that anyone employed from three months to 2.99 years accrues 3.69 hours of PTO time per period regardless of the number of hours they worked during the period. For example, when an employee works 1 hour, the calculation factor of 9.99999 is used to calculate 9.99999 hours of PTO time. However, the maximum of 3.69 would override this calculation.

7. To create the third range, use the following information:

    - **From**: 3.00
    - **To**: 8.99
    - **Calculation Factor**: 9.99999
    - **Maximum Hours**: 4.46

    The third range shows that anyone employed from three years to 8.99 years of employment accrues 4.46 hours of PTO time per pay period.

8. To create the fourth range, use the following information:
   - **From**: 9.00
   - **To**: 999,999.99
   - **Calculation Factor**: 9.99999
   - **Maximum Hours**: 5.24.

   The third range shows that anyone employed nine years or longer earns 5.24 hours of PTO time per pay period.

9. Select **Save**, and then close the Accrual Schedule Setup window.

### Assign the accrual schedule to the employee

1. On the **Cards** menu, point to **Payroll**, and then select **PTO**.
2. In the **Employee** list, select an employee.
3. Select the **Use Custom Accrual Method** check box
4. In the **Vacation Accrual Schedule 1** list, select the accrual section you created in the "Set up the accrual schedule" section, and then select **Select**.
5. In the **Vacation Waiting Period** area, in the **Waiting Period Expires** field, type a date that is six months after the employee hire date.
6. Select **Save**, and then close the Employee PTO Setup window.
