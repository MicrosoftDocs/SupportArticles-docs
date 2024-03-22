---
title: Year-end closing for Payables Management
description: Describes how to do the year-end closing routine in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Year-end closing procedures for the Payables Management module in Microsoft Dynamics GP

This article describes the recommended year-end closing procedures for the Payables Management module in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 875169

## Summary

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

The [More Information](#more-information) section contains the following information:

- _A checklist of the steps that you must follow to complete the calendar year-end closing procedures._  

- _A checklist of the steps that you must follow to complete the fiscal year-end closing procedures._  

- _Detailed information about each step in the checklists._  
- _A list of frequently asked questions._  

## More Information

Read this whole article before you do the steps. If you've questions, contact Microsoft Dynamics Technical Support.

### Payables Management master year-end closing checklist

> [!NOTE]
> Use this checklist if you're closing your fiscal year and your calendar year at the same time.

1. [Post all transactions for the year.](#step-1-post-all-transactions-for-the-year)
1. [Print the Aged Trial Balance with Options report.](#step-2-print-the-aged-trial-balance-with-options-report)
1. [Print the Vendor Period Analysis Report.](#step-3-print-the-vendor-period-analysis-report)
1. [Install the Payroll year-end update (optional)](#step-4-install-the-payroll-year-end-update-optional)
1. [Make a backup that is named "Pre-1099 Edits."](#step-5-make-a-backup-that-is-named-pre-1099-edits)
1. [Verify the 1099 information and edit it if it's required.](#step-6-verify-the-1099-information-and-edit-it-if-its-required)
1. [Print the 1099 statements.](#step-7-print-the-1099-statements)
1. [Make a backup that is named "Pre Year-End."](#step-8-make-a-backup-that-is-named-pre-year-end)
1. [Close the year.](#step-9-close-the-year)
1. [Close the fiscal periods.](#step-10-close-the-fiscal-periods)
1. [Close the tax year.](#step-11-close-the-tax-year)
1. [Make a backup that is named "Post Year-End."](#step-12-make-a-backup-that-is-named-post-year-end)

### Payables Management calendar year-end closing checklist

> [!NOTE]
> Although the Payables Management module is date-sensitive, the SmartList objects, the Payables Management summary reports, and the **Amounts Since Last Close** view of the Vendor Yearly Summary window are updated based on the closing of the Payables Management module. So we recommend that you follow these steps so that the SmartList objects, the Payables Management summary reports, and the **Amounts Since Last Close** view of the Vendor Yearly Summary window are correct.

1. [Post all transactions for the calendar year.](#step-1-post-all-transactions-for-the-year)
1. [Print the Aged Trial Balance with Options report.](#step-2-print-the-aged-trial-balance-with-options-report)
1. [Make a backup that is named "Pre-1099 Edits."](#step-5-make-a-backup-that-is-named-pre-1099-edits)
1. [Verify the 1099 information and edit it if it's required.](#step-6-verify-the-1099-information-and-edit-it-if-its-required)
1. [Print the 1099 statements.](#step-7-print-the-1099-statements)
1. [Make a backup that is named "Pre Year-End."](#step-8-make-a-backup-that-is-named-pre-year-end)
1. Close the calendar year.
1. [Close the fiscal periods.](#step-10-close-the-fiscal-periods)
1. [Close the tax year.](#step-11-close-the-tax-year)
1. [Make a backup that is named "Post Year-End."](#step-12-make-a-backup-that-is-named-post-year-end)

### Payables Management fiscal year-end closing checklist

1. [Post all transactions for the fiscal year.](#step-1-post-all-transactions-for-the-year)
2. [Print the Vendor Period Analysis Report.](#step-3-print-the-vendor-period-analysis-report)
3. [Make a backup that is named "Pre Year-End."](#step-8-make-a-backup-that-is-named-pre-year-end)
4. [Close the fiscal year.](#step-9-close-the-year)
5. [Close the fiscal periods.](#step-10-close-the-fiscal-periods)
6. [Make a backup that is named "Post Year-End."](#step-12-make-a-backup-that-is-named-post-year-end)

## Detailed information for each step in the year-end checklist

The following steps are detailed information for the year-end checklist.

### Step 1: Post all transactions for the year

Post all transactions for the year before you close the year. If you want to enter future period transactions before you close the year, create a new batch for the future period transactions. Save the future period transactions in the new batch, but don't post the new batch until after the year has been closed.

The following areas of Microsoft Dynamics GP aren't date-sensitive:

- The **Amounts Since Last Close** view of the Vendor Yearly Summary window
- SmartList objects
- Vendor Summary reports

These areas of Microsoft Dynamics GP will be incorrect if you don't close the payables year after you enter all current year transactions and before you enter any transactions for the new year. However, the **Amounts Since Last Close** view of the Vendor Yearly Summary window is editable. So you can update the information in the **Amounts Since Last Close** view of the Vendor Yearly Summary window if it's required.

To access the **Amounts Since Last Close** view of the Vendor Yearly Summary window, follow these steps:

1. On the **Cards** menu, point to **Purchasing**, and then select **Summary**.
2. In the Vendor Credit Summary window, type a vendor ID in the **Vendor ID** field, and then select **Yearly**.
3. In the **Summary View** list, select **Amounts Since Last Close**.

To view the SmartList columns that are affected, follow these steps:

1. Open SmartList. To do it in Microsoft Dynamics GP, select **SmartList** on the Microsoft Dynamics GP menu.
2. Expand the **Purchasing** node, and then select **Vendors**.
3. Select **Columns**.
4. Select **Add**.
5. Select the following fields in the **Available Columns** list.

    > [!NOTE]
    > The items flagged with an asterisk are affected by the calendar year-end close. All other items are affected by the fiscal year-end close.

      - **1099 Amount YTD**  
      - **1099 Amount LYR**  
      - **Amount Billed YTD**  
      - **Amount Billed LYR**  
      - **Amount Paid YTD**  
      - **Amount Paid LYR**  
      - **Average Days To Pay - Year**  
      - **Discount Available LYR**  
      - **Discount Available YTD**  
      - **Discount Lost LYR**  
      - **Discount Lost YTD**  
      - **Discount Taken LYR**  
      - **Discount Taken YTD**  
      - **Finance Charge LYR**  
      - **Finance Charge YTD**  
      - **Number of Finance Charges LYR**  
      - **Number of Finance Charges YTD**  
      - **Number of Invoice LYR**  
      - **Number of Invoice YTD**  
      - **Number of Paid Invoice YTD**  
      - **Returns LYR**  
      - **Returns YTD**  
      - **Trade Discounts Taken LYR**  
      - **Trade Discounts Taken YTD**  
      - **Withholding LYR**  
      - **Withholding YTD**  
      - **Write Offs LYR**  
      - **Write Offs YTD**

6. Select **OK**.
7. Select **OK**.

To view the Vendor Summary reports, follow these steps:

1. On the **Reports** menu, point to **Purchasing**, and then select **Analysis**.
2. In the **Reports** list, select **Calendar Year**.
3. In the **Options** list, select an option, and then select **Print**.

### Step 2: Print the Aged Trial Balance with Options report  

We recommend that you print a paper copy of the Aged Trial Balance with Options report to keep with your year-end permanent financial records. To do it, follow these steps:

1. On the **Reports** menu, point to **Purchasing**, and then select **Trial Balance**.
2. In the **Reports** list, select **Aged Trial Balance with Options**.

### Step 3: Print the Vendor Period Analysis report

We recommend that you print a paper copy of the Vendor Period Analysis report to keep with your year-end permanent financial records. To do it, follow these steps:

1. On the **Reports** menu, point to **Purchasing**, and then select **Analysis**.
2. In the **Reports** list, select **Period**.

### Step 4: Install the Payroll year-end update (optional)  

If there are compliance changes for Payables Management, such as 1099 form changes, install the Payroll year-end update. If there are no changes or compliance issues for the tax year for Payables Management, you may skip this step.

Review the changes that are included in the Payroll year-end update.

### Step 5: Make a backup that is named Pre-1099 Edits

Create a backup, and then put the backup in safe, permanent storage. A backup gives you a permanent record of the company's financial position at the end of the year, and this backup can be restored later if it's required. A backup lets you recover data quickly if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Backup**.
2. In the **Company Name** list, select your company name.
3. Change the path of the backup file if it's required, and then select **OK**.

    > [!NOTE]
    > We recommend that you name this backup **Pre-1099 Edits** to differentiate it from your other backups.

### Step 6: Verify the 1099 information and edit it if it's required

To print the 1099 edit list, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Purchasing**, and then select **Print 1099**.

2. Enter the Company Information and Address ID.

3. Select the printer icon in the upper right corner to print the 1099 Edit List. Review for accuracy.

4. If you need to edit any 1099 information, use one of the following methods (Method 1 and 2 is recommended for Microsoft Dynamics GP 2013 and higher versions and also illustrated in [Editing made EASY for 1099s in Microsoft Dynamics GP](https://community.dynamics.com/blogs/post/?postid=487c4288-7473-47de-a4e7-221c26a2adc6)

**Method 1:** (RECOMMENDED) Edit 1099 Transaction details (Applies to Microsoft Dynamics GP 2013 and higher versions)

1. Select **Transactions**, point to **Purchasing**, and select **Edit 1099 Transaction Information**.

2. Select the appropriate Vendor ID. (Only vendors set to be 1099able will be displayed in the window.)

3. You may restrict by Voucher Number, by Document Number, or by Date, if wanted.

4. Select if you want 1099 Debit Transactions, **All Debit Transactions**, or **All Credit Transactions**.

5. The vendor's transaction detail will populate in the bottom of the window. For each transaction, you can edit the Tax Type, Box Number, and Amount on open and historical transactions.

    > [!NOTE]
    > You may not enter a higher 1099 amount than the total amount of the document.

6. Select **Process** to have the changes made and the 1099 will be updated.

**Method 2:** VENDOR NOT MARKED CORRECTLY: (Applies to Microsoft Dynamics GP 2013 and higher versions)

If you marked a vendor as 1099able and shouldn't have, or you forgot to mark a vendor as 1099able at all, you can use the Update 1099 Information utility to change the 1099 status on the vendor and also to update the 1099 information. You can change a 1099 vendor to be non-1099 or visa versa.

1. Select **Tools** under **Microsoft Dynamics GP**, point to **Utilities**, point to **Purchasing**, and select **Update 1099 Information**.

2. Mark the bullet for Vendor and 1099 Transactions.

3. In the FROM and TO sections, enter the following content:

    - _To change a vendor to be 1099able:_ select **Not a 1099 Vendor** in the FROM section, and select the appropriate 1099 type of Dividend, Interest or Miscellaneous, and the appropriate 1099 Box number in the TO section. (Miscellaneous and Box 7 Nonemployee Compensation is the most common.)

    - _To change a vendor to not be 1099able_ : Select the current Tax Type and 1099 Box Number that is selected on the Vendor Maintenance Options window for the vendor in the FROM section, and select **Not a 1099 Vendor** in the TO section.

    *If **Not a 1099 Vendor** isn't an option in the drop-down lists, then either you aren't on a GP version higher than Microsoft Dynamics GP 2013, or you didn't select Vendor and 1099 Transactions as instructed in step 2.

4. Use the Range restriction to restrict to the Vendor ID that you wish to change and select **INSERT**.

5. Select **Process**. The vendor status will be updated on the Vendor Maintenance Options window, and the 1099 information will be updated appropriately. You can use the _1099 details_ window (see Method 1) to verify.

**Method 3:** Edit the 1099 directly (Use for Microsoft Dynamics GP 2010 and prior versions, but can work for all versions)

> [!NOTE]
> The Reconcile utility for 1099 amounts would undo any edits you make using this method.

1. On the **Cards** menu, point to **Purchasing**, and then select **1099 Details**.

2. In the Vendor ID list, select a vendor ID.

3. In the Tax Type list, select one of the following:

    - Dividend  

    - Interest  

    - Miscellaneous

4. In the Display area, select **Month** or **Year**, and then type *_20XX_* in the Year field. (Enter the wished year for the *20XX* placeholder.)

5. In the Amount column, type the correct 1099 amount. Select **Save**.

**Method 4:** Edit the 1099 directly (Use for Microsoft Dynamics GP 2010 and prior versions, but can work for all versions)
> [!NOTE]
> The Reconcile utility for 1099 Amounts would undo any edits you make using this method.

1. On the **Cards** menu, point to **Purchasing**, and then select **Summary**.

2. In the Vendor ID list, select a vendor ID, and then select **Period**.

3. In the Year field, type *_20XX_*. (Enter the wished year for the *20XX* placeholder.)

4. In the Month/Period field, select the appropriate month or period.

5. Select the **1099 Details** blue expansion button that appears next to the 1099 Amount field. This 1099 Details window will open.

6. In the Amount column, type the correct 1099 amount for the respective box.

7. Press **Save**. Exist out of the remaining windows.

### Step 7: Print the 1099 statements

> [!NOTE]
> You can do it at any time.

To print the 1099 statements, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Purchasing**, and then select **Print 1099**.
2. In the **1099 Year** field, type *_20XX_*. (Enter the year for the *20XX* placeholder.)
3. Each of your 1099 report types must be printed separately. In the Print 1099 window, select the options that you want in the **1099 Type** field and in the **1099 Box Number** field, and then select **Print**.

The following table provides additional information about the fields on the 1099 form and where this information can be located in Microsoft Dynamics GP.

|Field|window where data is located|
|---|---|
|Payers name, street address, city, state, and ZIP Code/Postal Code|Print 1099 window|
|Payers Federal Identification number|Print 1099 window|
|Recipients name, address, and Zip Code/Postal Code| **Primary Address** of the Vendor Maintenance window|
|Recipients identification number| **Tax ID** field of the Vendor Maintenance Options window|
|Amounts for boxes 1-9 on the Dividend Form or 1-16 on the Miscellaneous Form| **1099 Amount** field in the Vendor Yearly Summary window|
  
Currently, Microsoft Dynamics GP doesn't handle magnetic media filing of state 1099s. The following Microsoft Dynamics Partner does offer compatible State W-2 and 1099 magnetic media products. For more information, contact:  

Greenshades Accounting Software, Inc.  
7800 Belfort Parkway Suite 220  
Jacksonville, FL 32207  
General: 1-800-209-9793 (Toll-Free)  
Sales: 1-800-209-9793x2 (Toll-Free)  
`sales@greenshades.com`  
[Greenshades](https://www.greenshades.com)

### Step 8: Make a backup that is named Pre Year-End

Create a backup, and then put the backup in safe, permanent storage. A backup gives you a permanent record of the company's financial position at the end of the year, and this backup can be restored later if it's required. A backup lets you recover data quickly if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the Microsoft Dynamics GP menu, and then select **Backup**.
2. In the **Company Name** list, select your company name.
3. Change the path of the backup file if it's required, and then select **OK**.
    > [!NOTE]
    > We recommend that you name this backup "Pre Year-End" to differentiate it from your other backups.

### Step 9: Close the year  

To close the year, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Routines**, point to **Purchasing**, and then select **Year-End Close**.
2. If you're closing both your fiscal and calendar year at the same time, select **All**. If you're just closing your calendar year, select **Calendar**. If you're just closing your fiscal year, select **Fiscal**.
3. Select the **Print Report** check box, and then select **Close Year**.

    > [!NOTE]
    > We recommend that you keep a paper copy of the year-end report together with your permanent year-end audit records.

To view the Vendor Yearly Summary window, follow these steps:

1. On the **Cards** menu, point to **Purchasing**, and then select **Summary**.
2. In the **Vendor ID** field, type a vendor ID to view, and then select **Yearly**.

**The calendar year details**  
The calendar year-end process in Microsoft Dynamics GP will clear the **1099 Amount Year to Date** field and then transfer the amount to the **1099 Amount Last Year** field for the **Amounts Since Last Close** view of the Vendor Yearly Summary window.

**The fiscal year details**  
The fiscal year-end process in Microsoft Dynamics GP will clear the following fields:

- **Amount Billed YTD**  
- **Amount Paid YTD**  
- **Average Days To Pay - Year**  
- **Discount Available YTD**  
- **Discount Lost YTD**  
- **Discount Taken YTD**  
- **Finance Charge YTD**  
- **Number of Finance Charges YTD**  
- **Number of Invoice YTD**  
- **Number of Paid Invoice YTD**  
- **Returns YTD**  
- **Trade Discounts Taken YTD**  
- **Withholding YTD**  
- **Write Offs YTD**

The amounts in these fields will also be updated in the **Amounts Since Last Close** view of the Vendor Yearly Summary window:

- **Amount Billed LYR**  
- **Amount Paid LYR**  
- **Discount Available LYR**  
- **Discount Lost LYR**  
- **Discount Taken LYR**  
- **Finance Charge LYR**  
- **Number of Finance Charges LYR**  
- **Number of Invoice LYR**  
- **Returns LYR**  
- **Trade Discounts Taken LYR**  
- **Withholding LYR**  
- **Write Offs LYR**

### Step 10: Close the fiscal periods

You can use the Fiscal Periods Setup window to close any fiscal periods that are still open for the year. It prevents users from accidentally posting transactions to the wrong period or year. Verify that you've posted all transactions for the period and the year for all modules before closing fiscal periods. If you must later post transactions to a fiscal period that you've already closed, you can return to the Fiscal Periods Setup window to reopen the period before you can post a transaction.

To close a fiscal period, follow these steps:

1. Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
2. Select the **Purchasing** check box for the **Period** that you must close.

### Step 11: Close the tax year

> [!NOTE]
> This procedure should only be completed after you have completed the year-end closing procedures for all sales and purchasing modules.

To close the tax year, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Routines**, point to **Company**, and then select **Tax Year-End Close**.
2. Select the **Close Year** check box and the **Print Report** check box.
3. Select **Process**. When you're prompted to continue with the year-end close. Select **Yes**.
    > [!NOTE]
    > We recommend that you keep a paper copy of the year-end report together with your permanent year-end audit records.

### Step 12: Make a backup that is named Post Year-End  

Create a backup, and then put the backup in safe, permanent storage. A backup gives you a permanent record of the company's financial position at the end of the year, and this backup can be restored later if it's required. A backup lets you recover data quickly if a power fluctuation or other problem occurs during the year-end closing procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the Microsoft Dynamics GP menu, and then select **Backup**.
2. In the **Company Name** list, select your company name.
3. Change the path of the backup file if it's required, and then select **OK**.
    > [!NOTE]
    > We recommend that you name this backup "Post Year-End" to differentiate it from your other backups.

### Frequently asked questions

Q1: Are inactive vendor records cleared during year-end closing? If not, how can inactive vendor records be removed?

A1: No, inactive vendor records aren't automatically removed. To remove an inactive vendor record, the following conditions must be true:

- No current year 1099 amounts exist for the vendor
- The vendor has no documents in work or history.

To delete all inactive vendor records that fit these criteria, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Purchasing**, and then select **Mass Vendor Delete**.
2. In the **Range** list, select **by Vendor Status**.
3. In the **From** list, select **Inactive**.
4. In the **To** list, select **Inactive**.
5. Select **Process**.

Q2: What should I do if I must issue a check on January 1 for the next year, but I'm not ready to close the current year yet?

A2: Print the checks, but don't _post_ them until after you process your year-end closing. If you must post the checks immediately, change the **Amount Paid** fields in the **Amounts Since Last Close** view of the Vendor Yearly Summary window.
