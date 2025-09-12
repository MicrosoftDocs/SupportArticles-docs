---
title: Year-end closing procedures for Receivables Management
description: Describes how to do the year-end closing routine in Receivables Management.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# Year-end closing procedures for Receivables Management in Microsoft Dynamics GP

This article contains checklists for the year-end closing process in Receivables Management in Microsoft Dynamics GP. This article also contains detailed information for each step in the year-end closing process and how to add the year-to-date finance charge information to customer statements for December and for January.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857444

## Summary

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

This article describes the recommended year-end closing procedures for Receivables Management in Microsoft Dynamics GP. Read this article before you do one or more of the procedures.

## Year-end closing checklist

You can use this checklist for the end of the fiscal year and for the end of the calendar year.

> [!NOTE]
> Although Receivables Management is date sensitive, the following items are updated based on the closing of Receivables Management:
>
> - The SmartList objects
> - The Receivables Management summary reports
> - The Amounts Since Last Close view in the Customer Summary window

So we recommend that you follow these steps so that the SmartList objects, the Receivables Management summary reports, and the Amounts Since Last Close view contain the correct information:

1. [Post all the sales and receivables transactions for the year.](#step-1-post-all-the-sales-and-receivables-transactions-for-the-year)
1. [Make a pre-year-end closing backup.](#step-2-make-a-pre-year-end-closing-backup)
1. [Close the year.](#step-3-close-the-year)
1. [Close the fiscal periods. (This step is optional.)](#step-4-close-the-fiscal-periods-this-step-is-optional)
1. [Close the tax year.](#step-5-close-the-tax-year)
1. [Make a post-year-end closing backup.](#step-6-make-a-post-year-end-closing-backup)

### Step 1: Post all the sales and receivables transactions for the year

Post all the sales and receivables transactions for the year before you close the year. If you want to enter any sales and receivables transactions for a future period before you close the year, create a batch that contains the transactions. Next, save the batch. Then, post the batch after you close the year.

You must close the year because some areas of Microsoft Dynamics GP aren't date-sensitive. If you don't close the year after you enter all the current year transactions and before you enter transactions for the next year, these areas will contain incorrect information. However, if you have to change the information, you can change the information in the Amounts Since Last Close view in the Customer Summary window and in the Customer Finance Charge Summary window. The following areas are the areas of Microsoft Dynamics GP that aren't date-sensitive.

- The Amounts Since Last Close view in the Customer Summary window

  To open the Amounts Since Last Close view in the Customer Summary window, follow these steps:

    1. On the **Cards** menu, point to **Sales**, and then select **Summary**.
    2. In the Customer Summary window, type a customer ID in the **Customer ID** box.
    3. In the **Summary View** list, select **Amounts Since Last Close**.

- The Customer Finance Charge Summary window

  To open the Customer Finance Charge Summary window, follow these steps:

    1. On the **Cards** menu, point to **Sales**, and then select **Summary**.
    2. In the Customer Summary window, type a customer ID in the **Customer ID** field.
    3. Select **Finance Charges**.

- The SmartList objects

  To view the SmartList columns that are affected, follow these steps:

    1. In Microsoft Dynamics GP, select **Columns** on the **Microsoft Dynamics GP** menu, select **SmartList**, expand **Sales**, expand **Customers**, and then select **Add**.
    2. Select the following items in the **Available Columns** list.

        > [!NOTE]
        > The items that are flagged with an asterisk are affected by the calendar year-end close. All the other items are affected by the fiscal year-end close.

         - **Average Days to Pay - Year**  
         - **Finance Charges CYTD**
         - **Finance Charges LYR Calendar**
         - **High Balance LYR**  
         - **High Balance YTD**  
         - **Number of ADTP Documents - LYR**  
         - **Number of ADTP Documents - Year**  
         - **Number of NSF Checks YTD**  
         - **Total # FC LYR**
         - **Total # FC YTD**
         - **Total # Invoices LYR**  
         - **Total # Invoices YTD**  
         - **Total Amount of NSF Check YTD**  
         - **Total Bad Debt LYR**  
         - **Total Bad Debt YTD**  
         - **Total Cash Received LYR**  
         - **Total Cash Received YTD**  
         - **Total Discounts Available YTD**  
         - **Total Discounts Taken LYR**  
         - **Total Discounts Taken YTD**  
         - **Total Finance Charges LYR**
         - **Total Finance Charges YTD**
         - **Total Returns LYR**  
         - **Total Returns YTD**  
         - **Total Sales LYR**  
         - **Total Sales YTD**  
         - **Total Waived FC LYR**
         - **Total Waived FC YTD**
         - **Total Writeoffs LYR**  
         - **Total Writeoffs YTD**  
         - **Unpaid Finance Charges YTD**
         - **Write Offs LYR**  
         - **Write Offs YTD**  
    3. Select **OK**.
    4. Select **OK**.

### Step 2: Make a pre-year-end closing backup

Create a backup before you close the year. Put the backup in safe, permanent storage. This backup makes sure that you've a permanent record of the company's financial position at the end of the year. You can restore information from this backup if you've to. For example, this backup would let you quickly recover if a power fluctuation or another problem occurred during the year-end close procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the Microsoft Dynamics GP menu, and then select **Backup**.
2. In the Back Up Company window, select the company name in the **Company Name** list.
3. Change the path of the backup file if it's required, and then select **OK**.

> [!NOTE]
> We recommend that you name this backup **PreYearEndClosingBackup20XX**. (Enter the year for the *XX* placeholder.)

### Step 3: Close the year

1. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Routines**, point to **Sales**, and then select **Year-End Close**.
2. If you're closing both the fiscal year and the calendar year at the same time, select **All**. If you're closing only the calendar year, select **Calendar**. If you're closing only the fiscal year, select **Fiscal**.
3. Select the **Print Report** check box, and then select **Close Year**.

    > [!NOTE]
    > We recommend that you keep a paper copy of the year-end report together with the permanent year-end audit records.

Calendar year details

The calendar year-end process in Microsoft Dynamics GP clears the following fields in the Customer Summary window:

- **Finance Charges CYTD**  
- **Total # FC YTD**  
- **Total Finance Charges YTD**  
- **Total Waived FC YTD**  
- **Unpaid Finance Charges YTD**

The calendar year-end process updates the amounts in the following fields:

- **Finance Charges LYR Calendar**  
- **Total # FC LYR**

Fiscal year details

The fiscal year-end process in Microsoft Dynamics GP clears the following fields in the Customer Summary window:

- **Average Days to Pay - Year**  
- **High Balance YTD**  
- **Number of ADTP Documents - Year**  
- **Number of NSF Checks YTD**  
- **Total # Invoices YTD**  
- **Total Amount of NSF Check YTD**  
- **Total Bad Debt YTD**  
- **Total Cash Received YTD**  
- **Total Discounts Available YTD**  
- **Total Discounts Taken YTD**  
- **Total Returns YTD**  
- **Total Sales YTD**  
- **Total Writeoffs YTD**  
- **Write Offs YTD**

The fiscal year-end process updates the amounts in the following fields:

- **High Balance LYR**  
- **Number of ADTP Documents - LYR**  
- **Total # Invoices LYR**  
- **Total Bad Debt LYR**  
- **Total Cash Received LYR**  
- **Total Discounts Taken LYR**  
- **Total Returns LYR**  
- **Total Sales LYR**  
- **Total Writeoffs LYR**  
- **Write Offs LYR**

### Step 4: Close the fiscal periods (This step is optional)

To prevent users from accidentally posting transactions to the wrong period or to the wrong year, use the Fiscal Periods Setup window to close all fiscal periods that are still open for the year. Before you close fiscal periods, verify that you've posted all the transactions for the period and for the year for all modules. If you must later post transactions to a fiscal period that you already closed, you can return to the Fiscal Periods Setup window to reopen the period so that you can post the transactions.

To close a fiscal period, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
2. Select the **Sales** check box for the period that you want to close.

### Step 5: Close the tax year

> [!NOTE]
> Follow these steps only after you complete the year-end closing procedures for all the sales and purchasing modules.

To close the tax year, follow these steps:

1. In Microsoft Dynamics GP, point to Tools on the Microsoft Dynamics GP menu, point to Routines, point to **Company**, and then select **Tax Year-End Close**.
2. Select the **Close Year** check box, and then select the **Print Report** check box.
3. Select **Process**.

    > [!NOTE]
    > We recommend that you keep a paper copy of the year-end report together with the permanent year-end audit records.

### Step 6: Make a post-year-end closing backup

Create a backup after you close the year. Put the backup in safe, permanent storage. This backup makes sure that you've a permanent record of the company's financial position at the end of the year. You can restore information from this backup if you've to. For example, this backup would let you quickly recover if a power fluctuation or another problem occurred during the year-end close procedure.

To create a backup in Microsoft Dynamics GP, follow these steps:

1. In Microsoft Dynamics GP, point to **Maintenance** on the Microsoft Dynamics GP menu, and then select **Backup**.
2. In the Back Up Company window, select the company name in the **Company Name** list.
3. Change the path of the backup file if it's required, and then select **OK**.

> [!NOTE]
> We recommend that you name this backup **PostYearEndClosingBackup20XX**. (Enter the year for the *XX* placeholder.)

## Year-to-date finance charges on customer statements for December and for January

Year-to-date finance charges aren't automatically printed on customer statements for December and for January.

### December statements

To add the year-to-date finance charges to the December statements, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Customize**, and then select **Report Writer**.
2. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.
3. Select **Reports**.
4. Use the appropriate method:
   - If you haven't previously modified the statement form, select the statement form that you print in the **Original Reports** list, select **Insert**, and then select the statement form in the **Modified Reports** list.
   - If you previously modified the statement form, select the statement form in the **Modified Reports** list.
5. Select **Open**.
6. In the Report Definition window, select **Tables**.
7. In the Report Table Relationships window, select **RM Customer MSTR**, and then select **New**.
8. In the Related Tables window, select **Customer Master Summary**, and then select **OK**.
9. Select **Close**.
10. Select **Layout**.
11. In the resource list in the **Toolbox** box, select **Customer Master Summary**.
12. In the field list, drag **Finance Charges CYTD** to the layout of the report. You can position this field in any section of the report.
13. On the **File** menu, select **Microsoft Dynamics GP**. When you’re prompted to save the changes, select **Save**.
14. If you haven't previously modified this report, you must grant security to the report. To do it, use the steps below:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Systems**, and then select **Alternate/Modified Forms and Reports**.
    2. In the **ID** box, enter the user ID.
    3. In the **Product** list, select
    **Microsoft Dynamics GP**.
    4. In the **Type** list, select **Reports**.
    5. Expand **Sales**, and then expand the node of the modified form.
    6. Select **Microsoft Dynamics GP (Modified)**.

### January statements

To add the year-to-date finance charges to the January statements, follow these steps:

1. Follow steps 1 through 11 in the [December statements](#december-statements) section.
2. In the field list, drag **Finance Charges LYR Calendar** to the layout of the report. You can position this field in any section of the report.
3. Follow steps 13 and 14 in the [December statements](#december-statements) section.
