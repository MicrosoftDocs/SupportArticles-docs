---
title: Undefined Symbol FOO764DO5774DD or FOO764DO1098 or Report not found error when you print a check
description: Describes a problem that occurs when you have security set up on the report that is associated with a print format that was removed. Security must be removed from the report. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Payroll
---
# "Undefined Symbol FOO764DO5774DD Mask Doll" or "Undefined symbol FOO764DO1098 Employee_ID" or "Report not found" error when you print a check in Payroll - US

This article provides a resolution for the error messages that may occur when you try to print a check in Payroll - US in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 916672

## Symptoms

When you print a check in Payroll - US in Microsoft Dynamics GP, you receive one of the following error messages.

Error message 1

> Undefined Symbol FOO764DO5774DD Mask Doll.

Error message 2

> Undefined symbol FOO764DO1098 Employee_ID.

Error message 3

> Report not found.

## Cause

This problem occurs when the following conditions are true:

- Any one of the following check formats is removed in Microsoft Dynamics GP 9.0:
  - Direct Deposit Employee Checks Other-D
  - Direct Deposit Employee Checks Other-L
  - Direct Deposit Employee Checks Stub on Bottom-D
  - Direct Deposit Employee Checks Stub on Top-D
  - Direct Deposit Employee Checks Stub on Top and Bottom-L
- You have security set up on the report that is associated with a check format that was removed.
- You use this check format to print a check.
- You use one of the Employee Checks formats. However, the format is missing in the direct deposit tables.

In this situation, you receive one of the error messages that is described in the Symptoms section.

## Resolution 1

To resolve this problem, remove security from the report in the Advanced Security window. To do this, follow these steps.

> [!NOTE]
> By default, when you open the Advanced Security window, the current user and the current company are selected. Therefore, any changes that you make are made only for the current user and the current company. To select additional users and companies, select their names in the User and the Company sections in the Advanced Security window.

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
2. If you are prompted, type the system password. Then, select **OK**.
3. Select **View**, and then select **by Alternate, Modified and Custom**.
4. Expand **Microsoft Dynamics GP**, expand **Reports**, and then expand **Payroll**.
5. Clear any one of the following check formats that is selected:

   - Direct Deposit Employee Checks Other-D
   - Direct Deposit Employee Checks Other-L
   - Direct Deposit Employee Checks Stub on Bottom-D
   - Direct Deposit Employee Checks Stub on Top-D
   - Direct Deposit Employee Checks Stub on Top and Bottom-L

6. Select **OK**.

> [!NOTE]
> If you upgraded to Microsoft Dynamics GP 10.0 from Microsoft Business Solutions - Great Plains 8.0 or an earlier version, you may experience this problem in Microsoft Dynamics GP 10.0. To resolve this problem, follow these steps:

1. Open the Alternate/Modified Forms and Reports window. To do this, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **System**, and then select **Alternate/Modified Forms and Reports**.

2. Enter an ID, and then select **Microsoft Dynamics GP** in the **Product** list.
3. In the **Type** list, select **Reports**.

    > [!NOTE]
    > In the **Alternate/Modified Forms and Report** list, a tree view is displayed if there are any alternate/modified forms and reports for the product and the type that you clicked. The tree view is organized by series.

4. Expand the **Payroll** series to display a list of the forms or the reports that are available as alternate/modified forms or reports.

    > [!NOTE]
    > By default, the original forms or reports are selected.

5. Remove access to the alternate version of the forms or the reports. To do this, clear any of the following check formats that are selected:
   - Direct Deposit Employee Checks Other-D
   - Direct Deposit Employee Checks Other-L
   - Direct Deposit Employee Checks Stub on Bottom-D
   - Direct Deposit Employee Checks Stub on Top-D
   - Direct Deposit Employee Checks Stub on Top and Bottom-L

6. Select **Save**.

## Resolution 2

To resolve this problem, add the following tables to the Employee Checks reports:

- Direct Deposit Employee Deposit Work
- Direct Deposit Check Messages Setup

To do this, follow these steps:

1. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
2. In the product list, select **Microsoft Dynamics GP**, and then select **OK**.
3. Select **Reports**.
4. If any of the following reports appear in the **Modified Reports** section, select the report, and then select **Open**.
   - Employee Checks Other-D
   - Employee Checks Other-L
   - Employee Checks Stub on Bottom-D
   - Employee Checks Stub on Top-D
   - Employee Checks Stub on Top and Bottom-L

5. In the Report Definition window, select **Tables**.
6. Verify that the following tables are linked to the report:
   - Payroll Work Check
   - Payroll Master
   - Payroll Address Master
   - Payroll Check Descriptions
   - Payroll Work Check YTD Amounts

7. Select **Payroll Work Check**, and then select **New**.
8. Select **Direct Deposit Employee Deposit Work**, and then select **OK**.
9. Select **Direct Deposit Employee Deposit Work**, and then select **New**.
10. Select **Direct Deposit Check Messages Setup**, and then select **OK**.
11. In the Report Table Relationships window, select **Close**.
12. Select **OK** to close the Report Definition window.
13. Repeat steps 4 through 12 in this section for each Employee Checks report.

## More information

If you want to modify the payroll report, Microsoft Dynamics GP 9.0 uses the following check formats:

- Employee Checks Other-D
- Employee Checks Other-L
- Employee Checks Stub on Bottom-D
- Employee Checks Stub on Top-D
- Employee Checks Stub on Top and Bottom-L
