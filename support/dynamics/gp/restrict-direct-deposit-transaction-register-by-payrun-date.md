---
title: Restrict Direct Deposit Transaction Register by Payrun Date in Microsoft Dynamics GP
description: This article describes how to modify the Direct Deposit Transaction Register to show only those payroll transactions that were processed on a specific date.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# Restrict Direct Deposit Transaction Register by Payrun Date in Microsoft Dynamics GP

This article provides a solution to an issue where the Direct Deposit Transaction Register Report shows all direct deposit transactions in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2647454

## Symptoms

The Direct Deposit Transaction Register Report shows all direct deposit transactions in Microsoft Dynamics GP. This article describes how to modify the Direct Deposit Transaction Register to show only those payroll transactions that were processed on a specific date.

## Cause

You will add a new report restriction in Report Writer using the steps below to restrict the Build Check Date to a certain date.

> [!NOTE]
> You will need to modify this report restriction in Report Writer each time you wish to generate the report for a different payrun date.

## Resolution

To solve this issue, follow these steps:

### Step 1: Modify the Transaction Summary Direct Deposit for Payroll Report to restrict by check build date

1. Click **Transactions**, point to **Payroll**, and then click **Generate ACH File** to open the **Generate ACH File** window.

2. Click the **Trx Summary** button. Print the Report to the Screen.

3. Click **Modify** to open the Direct Deposit Trx Register report in Report Writer.

4. Exit out of the **Report Layout** window.

5. On the **Report Definition** window, click **Restriction**.

6. Click **New**. In a Restriction Name field, type a name such as "Date Restriction".

7. In the **Fields** section and **Report Table** field, use the drop-down list to choose **Direct Deposit ACH Header**.

8. In the **Table Fields** field, click **Build Check Date**.

9. Click **Add Field** to populate the field in the Restriction Expression at the bottom of the window.

10. In the **Operators** section, click the "=" button. (The equals sign will populate in the Restriction Expression.)

11. In the **Constants** section, for the **Type**, click **Date**.

12. In the **Constant** field, enter the user date for the date the pay run was built (May 5th of 2011 would be entered as 05012011). This is the date that will need to be modified regularly in Report Writer according to how you want your report to print.

13. Click **Add Constant**. (This will populate the Restriction Expression field at the bottom.)

    The **Restriction Expression** section at the bottom of the window should display the following:

    `ddACHHdr.Build Check Date = MM/DD/YYYY`

14. Click **OK** to close the **Report Restriction Definition** window.

15. Exit out of the **Report Restrictions** window.

16. Click **OK** to close the **Report Definition** window.

17. Save the changes, if prompted.

18. To return back to Microsoft Dynamics GP, click File,  and then click Microsoft Dynamics GP.

### Step 2: Grant Security to the modified report

1. Click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**. This will open the Alternate/Modified forms and reports window.

2. Next to **ID**, choose the appropriate ID from the drop-down list that you wish to grant access to. (Example: DEFAULTUSER)

3. Next to **Products**, click **Microsoft Dynamics GP**.

4. Next to **Type**, click **Reports** and then tab off this field.

5. In the **Alternate/Modified Forms and Reports** list, click to expand the Payroll folder. (Click the "+" symbol.)

6. Click to expand the Direct Deposit Trx Register.

7. Click to mark the radio button next to the Microsoft Dynamics GP (Modified) version of this report.

8. Click **Save**.

9. Close the window.

### Step 3: Modify the Direct Deposit Trx Register before each pay run is processed

1. In Microsoft Dynamics GP, open Report Writer to modify the report using one of the following options:

    - Option 1: Click Tools in the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.
    - Option 2: In Microsoft Dynamics GP, press ALT and F9.
    - Option 3: Print the report to screen and click the **Modify** button as documented in [Step 1: Modify the Transaction Summary Direct Deposit for Payroll Report to restrict by check build date](#step-1-modify-the-transaction-summary-direct-deposit-for-payroll-report-to-restrict-by-check-build-date) above.

2. Click **OK** for the Product of Microsoft Dynamics GP.

3. Click on **Reports** in the top menubar.

4. Under the **Modified Reports**, click to highlight Direct Deposit Trxs Register, and then click **Open**. This will open the **Report Definition** Window.

5. On the **Report Definition** Window, click **Restrictions**.

6. Highlight the Date Restriction you created above, and then click **Open**.

7. Under the **Restriction Expression** at the bottom of the window, click on the old date in the expression to highlight it, and then click **Remove**.

8. Under **Constants** section for the **Type** field, use the drop-down list to choose **Date**.

9. Next to the **Constant** field, enter the new date for the new pay run date that you wish to restrict to. (For example: May 5th of 2011 would be entered as 05012011). This is the date that will need to be modified each time you would like the report to print according to a different date.

10. Click **Add Constant**.

11. Click **OK** to close the **Report Restriction Definition** window.

12. Close the **Report Restrictions** window.

13. Click **OK** on the **Report Definition** window.

14. Save the changes, if prompted.

15. To return back to Microsoft Dynamics GP, click **File** in the Microsoft Dynamics GP menu.

16. Now when you print the report, it will restrict the transactions to the new payrun date.
