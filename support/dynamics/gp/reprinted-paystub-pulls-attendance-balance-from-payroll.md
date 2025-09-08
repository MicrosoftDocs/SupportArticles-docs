---
title: Reprinted Paystub pulls Attendance Balance from Payroll instead of Human Resources
description: The new feature in Microsoft Dynamics GP 2010 to reprint payroll checks will print the attendance balance from Payroll instead of Human Resources, even if Human Resources is marked in the HR Attendance setup window. This article provides a solution to this issue.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 04/17/2025
ms.custom: sap:Human Resources
---
# Reprinted Paystub pulls Attendance Balance from Payroll instead of Human Resources in Microsoft Dynamics GP 2010

This article provides a solution to an issue where the new feature to reprint the payroll paystub will print the attendance balance from Payroll instead of Human Resources.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2520503

## Symptoms

The new feature to reprint the payroll paystub will print the attendance balance from Payroll instead of Human Resources, even if Human Resources is marked in the HR Attendance setup window. The reprint paystub feature was new to Microsoft Dynamics GP 2010.

To reprint paystubs, click on **Inquiry**, point to **Payroll**, and click on **Check History**. Enter the **Employee ID**, mark the appropriate paycheck and then click **Recreate Paystub** to print the **Duplicate Pay stub**.

## Cause

The reprinted pay stub uses a different report called Reprint Pay Statement in Report Writer than the original check printed on. The out of the box check stubs (original and reprinted) pull from Payroll by default and must be modified in Report Writer to pull Attendance balances from Human Resources.

## Resolution

Use the steps below to modify the Reprint Pay Statement Report Writer:

1. Open Report Writer as follows:

    1. Click on **Microsoft Dynamics GP**, point to **Tools**, point to **Customize**, and then select **Report Writer**.
    2. Select **Dynamics GP** as the **Product**, and then click **OK**.
    3. Click the **Reports** button.
    4. In the **Original Reports** list, click to select **Reprint Pay Statement**, and then click **Insert**.

2. Modify the report:

    1. In the Modified Reports list, click to select **Reprint Pay Statement**, and then click **Open**.
    2. In the **Report Definition** window, click **Layout**.
    3. On the report layout, the **Time Off Balances** are in the F1 footer section. Click to select the **Vac Balance** and **Sick Bal** fields and click **Delete**.
    4. Also delete the V**acation Balance** and **Sick Balance** title next to each field. You will be dragging in arrays to print both the titles and hours inplace of these fields.

3. Drag out the Time Available Arrays that will print the Attendance balances from HR:

    1. In the **Toolbox**, using the same UPR_Reprint_Checks table, scroll down to find the Time Available Array. Drag this out onto the Footer of the Layout and when you drop it, the **Report Options** window will open. You will want to enter an Array Index of 1, and then click **OK**.

    2. Drag out the Time Available Array again, and this time set the Array Index to 2 and click **OK**. Drag out as many arrays as you need and increment the Array Index accordingly.

    3. Then drag out either the Time Code Array or Time Code Description to the left of each Time Available Array. When you drag this field onto the layout of the report, the **Report Field Options** window will open. You will want to enter a matching Array Index of 1,2,3, etc to match the Array Index of the Time Available array that you put it next to and then click **OK**. (For example, Time Code Array 1 should be next to Time Available Array 1, Time Code Array 2 should be next to Time Available Array 2, etc.) You can drag out as many arrays as you need and are not confined to two.

        > [!NOTE]
        > The time codes that print will be the same timecodes that printed on the original check stub that was modified in the same manner. To check which codes these are, click on **Cards**, point to **Human Resources**, point to **Employee-Attendance** and click on **Maintenance**. Enter the **Employee ID**. As you scroll through the time codes assigned to this employee, the codes with the option for Print Available Time on Payroll Checks are the codes that will print in alpha-numeric order in the arrays that you dragged onto the report layout.

    4. Exit Report Writer and save the changes to the report.

    5. On the **File** menu, select **Microsoft Dynamics GP** to exit Report Writer.

4. Grant Security to the modified format in Microsoft Dynamics GP:

    1. Click **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System** and then click **Alternate Modified Forms/Reports**.
    2. Select the ID associated with the users you would like to access the modified form.
    3. Select **Microsoft Dynamics GP** as the **Product** and **Reports** as the **Type**.
    4. Expand **Payroll** and then expand **Reprint Pay Statement**.
    5. Mark the **Microsoft Dynamics GP (Modified)** button.
    6. Click **Save**.

## More information

Similar steps to modify the Check stub or Earnings Statement are listed in KB 2023150. For more information and troubleshooting tips, see [The Check Stub or Earnings Statement displays Attendance balances from Payroll instead of Human Resources in Microsoft Dynamics GP](https://support.microsoft.com/topic/check-stub-or-earnings-statement-displays-attendance-balances-from-payroll-instead-of-human-resources-in-microsoft-dynamics-gp-f8ac3810-00de-892c-26c7-5486f2624da0).
