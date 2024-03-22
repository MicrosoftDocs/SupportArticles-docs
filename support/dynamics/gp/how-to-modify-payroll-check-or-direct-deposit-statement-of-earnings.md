---
title: How to modify Payroll Check or Direct Deposit Statement of Earnings to pull Attendance Balances from Human Resources
description: How to modify the Payroll Check or Direct Deposit Statement of Earnings to pull Attendance Balances from Human Resources in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# How to modify the Payroll Check or Direct Deposit Statement of Earnings to pull Attendance Balances from Human Resources in Microsoft Dynamics GP

This article has steps on how to pull the HR attendance balance fields (arrays) on to the Payroll Check report or DD Earnings Statements report in Report Writer. For HR, you will drag out the arrays in which the attendance fields will print in alpha-numeric order within the arrays. An example is also included below, as well as some common troubleshooting questions. By default, the Vacation/Sick fields from the Payroll side are defaulted on to these canned reports and you must remove them and drag out the HR arrays for the balances.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4021536

> [!NOTE]
> To add **time** **code** balances from HR to an employee paycheck or DD Earnings Statement use the following steps: (The canned reports will default to the payroll side.)

Before editing any report, you should export the current modified report out to a folder for safe-keeping or reference. To do this:

1. In Microsoft Dynamics GP, go to Microsoft Dynamics GP > **Tools** > **Customize** > **Customization Maintenance**.
2. Highlight the report, and select **EXPORT** at the top.
3. Save the report to a file or location of your choice. The extension will be `.pkg`.

## Resolution

1. Open Report Writer:  To do this, select **Microsoft Dynamics GP** > **Tools** > **Customize** > **Report Writer**.
2. Select Product: **Microsoft Dynamics GP**, select **OK**.
3. Select **Reports** in the menubar.
4. If you have a modified report already, it will be listed on the right-hand side already. If your report is not modified, then find it on the left side in the Original Reports column and select **highlight the report** (ex. Employee Checks or Direct Deposit Statement of Earnings) you wish to modify, and select **Insert** to move it to the Modified Reports list. Select **highlight the report** in the Modified Reports list and select **Open**. (Select the report you need.)
5. Then select **Layout** button. (this opens the Toolbox, Report Definition and Report Layout windows).
6. On the **Toolbox** window (shown below), select the **Payroll Work Check** table and scroll down to select the Time **Available Array** and drag this field to the Report Layout window where you want these fields to be. (On the report Layout, you can find the payroll vacation and sick fields and highlight them and press Delete to remove them from the report. Then drag out the new Time Available Array field above in its place.)

    6b. When you drop the new field on to the report, the **Report Field Options** window will open. Put **1** for the **Array Index**.

    6c. Also in the Report Field Options window, select the **Ellipsis** button next to the FORMAT field. In the Format Lookup, select any of the options (such as **DLR11_U2**) that does not have a dollar sign in it. Select **OK**, and select **OK** to close the windows. (If you don't do this, your hours will have a dollar sign next to it.)

    6d. Repeat 5a and 5b and drag out the Time Available Array for as many codes that you would like to be listed on the document. Increase the array index by 1 for each, so the next one will have an **Array Index** of **2**, etc. The rule is to drag out as many arrays as the employee who has the most codes to print would need. (most users drag out one for vacation and one for sick time, so drag the field out to the layout twice.)

    > [!NOTE]
    > The codes will print in an alphanumeric order. (See example below in next section.) Therefore, it will be easier if you have fewer codes to print out and all employees are enrolled in the same codes.

    For example, Array #1 might print out sick time for one employee, but be vacation time for another. Therefore, you can drag out the corresponding titles to go with each code in the next step:

7. Add Field labels: To the left of the Time Available Array field, you can simply hard-code the VAC and SICK labels right on to the report if you want to. However, since codes print in alphanumeric order, they may print in different orders for different employees, and therefore, you will also want to drag out the *Time Code Array* fields as well, so the field labels can default in for each employee. Follow the steps below.  

    1. On the **Toolbox**, change the drop-down to **Payroll Check descriptions**.
    2. Scroll down to **Time** **Code** **Array** and drag this field to the report.

    3. A report **Field Options Window** will pop up and in the **Array Index** field put **1**.  (This field label for 1 will correspond with the Time Available array of 1 on the report.)

    4. Repeat 6b and 6c for as many numbers as you need to track. Increase the **Array Index** by 1 for each. (NOTE: Make sure that you drag and drop Time **Code** Array **1** next to the Time **Available** Array **1** since they correspond. Drag Time **Code** Array **2** next to Time **Available** Array **2**, etc.)

8. Save the changes to the report. (Close all windows and select **Save** when prompted.)
9. Go to **File** > **Microsoft Dynamics GP** to get back to GP and exit Report Writer.

10. Back in GP, be sure to **grant access** for the user to the modified report. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **System/Alternate Modified Forms and Reports**.

11. **Test** printing the modified report for several employees and verify the correct balance now shows.

12. Repeat steps for any other report you wish to modify, such as the Earnings statements, or reprint Pay Statement, etc.

## More information

EXAMPLE:

Below is an example of how the codes may print in different arrays for different employees:

Employee #A is assigned to two codes: SICK and HVAC. (hourly vac)

Employee #B is assigned to three codes: HOL, SICK, and SVAC. (salary vac)

- So we drag out three Time Available and Time Code Arrays on to the check.

**This is how the codes will print:**

- For employee #A: Array 1 - HVAC, Array 2 -SICK.
- For Employee #B: Array 1 - HOL, Array 2 -SICK, Array 3 - SVAC.
- So you can see that they will print in a different order if the employees have different codes. Array #1 is VAC for the first employee, but vacations in Array #3 for the other. By chance, SICK is array #2 for both. The codes print in alphanumeric order.
- If you mark HOL not to print for Employee B, then Array 1 would be SICK and Array 2-SVAC for employee B. So Employee A would have vacation and sick print in that order, and employee B would have sick and vacation print in that order.

**What if I want SICK and VAC to print for everyone on the DD statement?  How do I do this?**

In the above example, you can drag array field #2 out to the SICK area of the earnings statement. However, the VAC code is different arrays for the employees, so you can't drag out any array for VAC time.

We would recommend removing the hard-coded titles on the earnings statement and drag out the corresponding Time Code Array for the title next to each Time Available Array instead.

Here are some options:

1. Drag out the Titles or Time Code Arrays to correspond to each Time Available Array and do not hard code the title. (They are hard-coded on the current earnings statement, which you don't want since the codes will print in a different order for each employee. Hard-coding the field labels on to the report only  works only if all employees are enrolled in all the same codes.)

2. You could enroll Employee A in the HOL code (or a dummy code), so they print the same number of arrays for the employees. (Although the order will still be different in the example above.) In this example, you would have to drag out three arrays to the earnings statement (fit 1 in 1 box, and 2 in the other box by making the font smaller. VAC is array 1 for one employee and array 3 for the other, so unless you are willing to rename the codes, you would have to drag all three codes out on to the statement, and their corresponding titles or Time Code Arrays.)

3. Rename some codes to force them to print in a certain order. For example, HVAC and SVAC print in opposite arrays in the above example due to the alphanumeric order. You could rename these codes or set up new ones such as VACH and VACS instead, so they print last for both employees. Then enroll Employee A in HOL or a dummy code. Then your array 1, 2 and 3 would be the same for all employees in the example above. If they are all the same order for all employees, then you could hard-code the title.

- We do not recommend hard-coding the titles. Use the corresponding Time Code Array instead, which will alleviate problems in case new codes are added in the future. This will prevent mismatches in the future.
- But how you modify the check or earnings statement is really up to you, since it is a modified report.

## Troubleshooting tips

Below are notes to review if you use the arrays for the headers or descriptions, and also for if you hard-code the headers or descriptions for each array:

### How do I get codes to appear in a certain order so I can hard-code the Titles

If you **hard-code the headers** or descriptions instead of using the Time Code Arrays, then you can use the below tips to force them to appear in a certain order:

1. You can set up codes such as 1sick or 1vac if you want to be sure that they always print first. Use a numbering sequence to have them print in a certain order. (or you could just make **Comp** be **Xcomp** so it prints last.)

2. Or you could assign all employees to all codes, provided a 0 balance would print for those that don't use the **code**.

3. Or create a dummy **code** to fill in for those employees that are short one **code**. For example, if you have COMP that is throwing off your codes because it doesn't apply to everyone, you could create a dummy **code** and name it *Filler* or *CompNone* (or whatever you want so it falls in the same alphanumeric order with the other codes) and assign it to the other employees. Mark this to print on the check. This will print 0 balances since it is not used for those employees.

### How do I get a code to print

1. Go to **Cards** > **HR** > **Attendance** > **Maintenance** and bring up an employee and a *benefit* type code, you will see a box called: **Print available time on payroll checks**. If this box is marked, this time will be viewable on checks.

   (This box corresponds to the **PRNAVAILTMEPYRL** field in the TATM1030 table. A value of 1 indicates the field can be shown on the employee paycheck.)

1. It is also a good idea to use a SQL query tool and check the TATM1030 table. Sometimes it may show marked on the front end, but the table may not show the value of 1. In this case, the table will need to be updated.

Any way you choose to do this, is up to you. Be sure to load your data into a test environment first and test it out to confirm that you're getting the results you desire.

### If your codes aren't printing out

1. Only the **benefit** type will print.
2. Make sure the **Print Available Time on Payroll Checks** option is marked in the Employee Attendance Maintenance window. (**Cards** > **HR** > **Employee Attendance** > **Maintenance**)
3. **The time code must be linked to a pay code**. Drill back on the time code in the Employee Attendance Maintenance window to verify. (Or go to **Tools** > **Setup** > **HR** > **Attendance** > **Time Code**.)

### If six arrays are listed, but not all employees have six codes assigned to them, how to I get the zeroes NOT to print out in the remaining arrays

Double-click on the array in Report Writer and instead of Visible, you can choose Hide When Empty.

### I modified the report, but the user is still seeing the old report

You will need to grant access to the report for the user to be able to use it.

## References

- [Reprinted Paystub pulls Attendance Balance from Payroll instead of Human Resources in Microsoft Dynamics GP 2010](https://support.microsoft.com/topic/reprinted-paystub-pulls-attendance-balance-from-payroll-instead-of-human-resources-in-microsoft-dynamics-gp-2010-2efd5dcd-15e5-81c0-28b1-b224af744617)
- [Check Stub or Earnings Statement displays Attendance balances from Payroll instead of Human Resources in Microsoft Dynamics GP](https://support.microsoft.com/topic/check-stub-or-earnings-statement-displays-attendance-balances-from-payroll-instead-of-human-resources-in-microsoft-dynamics-gp-f8ac3810-00de-892c-26c7-5486f2624da0)
