---
title: Vac Sick grayed out or missing on Employee Maintenance Card
description: The Vac Sick tab is grayed out or missing on the Employee Maintenance Card in Payroll in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The Vac/Sick tab is grayed out or missing on the Employee Maintenance Card in Microsoft Dynamics GP

This article provides a resolution for the issue that the **Vac/Sick** tab is missing on the Employee Maintenance Card in U.S. Payroll or grayed out in the Payroll Employee Setup - Canada window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3065204

## Symptoms

The **Vac/Sick** tab is missing on the Employee Maintenance Card in U.S. Payroll in Microsoft Dynamics GP or grayed out in the Payroll Employee Setup - Canada window in Canadian Payroll.

## Cause

If Attendance is set to accrue in the Human Resources module, it will automatically disable attendance on the Payroll side.

## Resolution

You must decide if you want to track attendance in HR or Payroll. Attendance is only tracked in one module and no longer updated in the other module. The HR setting that drives this can be found at the following location:

For U.S. Payroll:

1. In Microsoft Dynamics GP, select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Human Resources**, point to **Attendance** and select **Setup**.
2. In the *Accrual Information* section, set the **Accrue Type** to either Human Resources or Payroll as wished.
3. Select **OK**.

For Canadian Payroll:

1. In Microsoft Dynamics GP, select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **System** and select **Human Resources Preferences**.
2. Mark the checkbox for **Enable Attendance for Canada**.
3. Select **OK**.
4. If you had to mark the option above, then sign out of Microsoft Dynamics GP and log back in to have the option take effect.
5. Now select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Human Resources**, point to **Attendance** and select **Setup**.
6. In the *Accrual Information* section, set the **Accrue Type** to either Human Resources or Payroll as wished.
7. Select **OK**.

> [!NOTE]
> Once you mark the Accrue Type to either Human Resources or Payroll, attendance is only updated in this module and the other module is disabled, so it is not recommended to toggle this setting at all, or it will result in incorrect attendance balances.

## More information

For additional information on how to get the attendance balance from Human Resources pulled on to the check stub:

- For US Payroll, refer to [Check Stub or Earnings Statement displays Attendance balances from Payroll instead of Human Resources in Microsoft Dynamics GP](https://support.microsoft.com/topic/check-stub-or-earnings-statement-displays-attendance-balances-from-payroll-instead-of-human-resources-in-microsoft-dynamics-gp-f8ac3810-00de-892c-26c7-5486f2624da0).
- For Canadian Payroll, you can track attendance balances in HR, but attendance isn't integrated. So, there's no supported method to get the HR attendance balance pulled on to the cheque report, and the vacation liability accrued is not posted to GL.
