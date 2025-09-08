---
title: Vacation pay hours exceed employee vacation available warning on the Build Check File Report
description: Describes a problem where the warning - Vacation pay hours exceed employee vacation available is displayed on the Build Check File Report in Payroll even though there are sufficient vacation hours in Human Resources in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Payroll
---
# Warning "Vacation pay hours exceed employee vacation available" on the Build Check File Report when employee has sufficient vacation hours in Human Resources

This article provides resolutions to solve the **Vacation pay hours exceed employee vacation available** warning that occurs on the Build Check File Report in Payroll even though there are sufficient vacation hours in Human Resources in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 961460

## Symptoms

When you build checks in Payroll in Microsoft Dynamics GP, the following warning is displayed on the Build Check File Report even though the employee has sufficient vacation hours in the Employee Attendance Maintenance window:

> Vacation pay hours exceed vacation available

This problem occurs if the following conditions are true:

- The checkbox is marked in Payroll for **Warn When Vacation Available Falls Below Zero** or **Warn When Sick Time Available Falls Below Zero**.
- The Accrue type is set to Human Resources.

## Resolution

To resolve the error, the warning checkboxes on the Payroll side need to be cleared. Even though accruals are done in Human Resources, the warning flags on the Payroll side are still being read and cause the error. To resolve this issue, follow one of the options below:

### Option 1 - Perform the reconcile procedure for Reset Payroll Vacation and Sick Time Information

1. Follow the appropriate step:

   - In Microsoft Dynamics GP 10.0 and later versions, on the **Microsoft Dynamics GP** menu, point to **Tools**, and then point to **Utilities**.
   - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to Utilities.
2. Point to **Human Resources**, and then select **Reconcile**.
3. Select the **Reset Payroll Vacation and Sick Time Information** check box.
4. Select **Process**.
5. When you are prompted, print the HR_Reconcile_Report.
6. Select **OK**. This reconcile process will set the vacation and sick balances on the Payroll side to 0.00 and also clear out the flags in Payroll for the system to warn when the balance goes below the available balance.

### Option 2 - Manually clear the Warn When Vacation Available Falls Below Zero check box in Payroll for each employee

1. Follow the appropriate step:

   - In Microsoft Dynamics GP 10.0 and later versions, on the **Microsoft Dynamics GP** menu, point to **Tools**, and then point to **Setup**.
   - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to **Setup**.

2. Point to **Human Resources**, point to **Attendance**, and then select **Setup**.
3. In the Attendance Setup window, in the **Accrual Information** area, select **Payroll**, and then select **OK**.
4. On the **Cards** menu, point to **Payroll**, and then select **Employee**.
5. In the Employee Maintenance window, type the employee ID in the **Employee ID** field, and then select **Vac/Sick**.
6. In the Employee Vacation-Sick Time Maintenance window, clear the **Warn When Vacation Available Falls Below Zero** check box.
7. Select **OK**, and then select **Save**.
