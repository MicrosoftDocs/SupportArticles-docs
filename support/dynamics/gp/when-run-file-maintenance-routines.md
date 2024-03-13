---
title: When to run file maintenance routines
description: Provides information about when to run file maintenance routines in Project Accounting of Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.date: 03/13/2024
---
# Information about when to run file maintenance routines in Project Accounting

This article contains information that can help you determine when to run file maintenance routines and which ones to run in Microsoft Dynamics GP Project Accounting.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857058

## Introduction

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the company database that you can restore if a problem occurs.

The *PA Check Links* routine will validate data between tables within a table group. For example if you have a timesheet transaction that exists in the line detail table, but no record for it is in the header table, PA Check Links will likely remove that document from the tables where it exists.

## More information

PA Check Links shouldn't need to be run often, however if you've experienced an interruption in posting, it may be beneficial to run it to clear out any orphaned records.

1. To run the Project Accounting Check Links process, follow the appropriate step:

    - In Microsoft Dynamics GP 10.0 or later, point to **Maintenance** on the Microsoft Dynamics GP menu, and then select **PA Check Links**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Maintenance** on the **File** menu, and then select **PA Check Links**.  

2. In the Logical Tables area, select to highlight a selected table group. Select **Insert** to select the table, and then select **OK**.

3. Choose the destination for your File Maintenance Error Log Report.

    > [!NOTE]
    > It is recommended to print a hard copy (either to the printer or a file) for review since there is no opportunity to reprint this report.

The *PA Reconcile utility* will compare the values in the detail or transactional tables to the summary master records. The values in the detail tables are used to change the summary values if there's a discrepancy. So if you notice that summary values on a contract, on a project, or on a budget are incorrect, this process will correct those values.

You may want to run this process on a monthly basis to ensure your values are correct for reporting purposes. If no changes are made, then run the process quarterly or yearly. If many changes are made, you may need to increase the frequency in which you run it.

1. To run PA Reconcile, follow the appropriate step:

    - In Microsoft Dynamics GP 10.0 or later, point to **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Project**, and then select **PA Reconcile**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Utilities** on the **Tools** menu, point to **Project**, and then select **PA Reconcile**.

2. Select the following items in the Reconcile Totals area, and then select **Process** after you select each item.

    > [!NOTE]
    > The sequence in which these processes are run isn't important. However, for items that have the Posted check box or the Unposted check box available, make sure that both check boxes are selected for the item.

    - Budgets and fees
    - Cost Transactions
    - Committed Costs
    - Billing Transactions
    - RR Transactions
    - Cash Apply
    - Earnings and Cost of Earnings
    - Change Orders

3. Choose the destination for your PA Reconcile Log Report.

    > [!NOTE]
    > It's recommended to print a hard copy (either to the printer or a file) for review since there's no opportunity to reprint this report.

The *PA Recreate Periodic* utility has two functions. The **Options** drop-down allows you to choose **Recreate Periodics** or **Delete Periodic Records Outside Fiscal Years**. The Recreate Periodics process will create missing periodic records for your customer (PA00511), contract (PA01121), project (PA01121), and budgeted cost categories (PA01304). You should have a record for each period in your year, and a summary record. Your periodic records should exist for however many periods your budgeted cost category spans taking the earliest of your budget or actual start date and latest of your budget or actual end date.

You should run PA Recreate Periodic when you find there are missing or incorrect periodic records. You should run the option to Delete Periodic Records Outside Fiscal Years if a budget was first set up with an incorrect date and you want to remove invalid periodic records after the date has been corrected.

1. To run PA Recreate Periodic, follow the appropriate step:

    - In Microsoft Dynamics GP 10.0 or later, point to **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Project**, and then select **PA Recreate Periodic**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Utilities** on the **Tools** menu, point to **Project**, and then select **PA Recreate Periodic**.

2. Select the customer or range of customers to run the utility for.

    > [!NOTE]
    > The PA Recreate Periodic process can be time consuming so plan accordingly or choose to run it for only the customers necessary.

3. In the **Options** drop-down, select **Recreate Periodic** or **Delete Periodic Records Outside Fiscal Years**, and then select **Process**.

4. Choose the destination for your PA Recreate Periodic Log Report.

    > [!NOTE]
    > It's recommended to print a hard copy (either to the printer or a file) for review since there is no opportunity to reprint this report.

The *PA Reconcile Periodic* utility must be run after you complete the PA Recreate Periodic process to fully populate the new periodic records that have been created. The reconcile uses the transactional tables to compare, and change if necessary, the summary periodic records. It's also recommended to run PA Reconcile Periodic before creating revenue recognition transactions to ensure the values used for revenue recognition are accurate. Several reports, including the Performance reports, pull information from the periodic records so you may want to run Periodic Reconcile before printing these reports as well.

1. To run PA Reconcile Periodic, follow the appropriate step:

    - In Microsoft Dynamics GP 10.0 or later, point to **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Project**, and then select **PA Reconcile Periodic**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Utilities** on the Tools menu, point to **Project**, and then select **PA Reconcile Periodic**.

2. Select the customer or range of customers to run the utility for, and then select **Process**.

    > [!NOTE]
    > The PA Reconcile Periodic process can be time consuming so plan accordingly or choose to run it for only the customers necessary.

3. Choose the destination for your PA Reconcile Periodic Log Report.

    > [!NOTE]
    > It's recommended to print a hard copy (either to the printer or a file) for review since there is no opportunity to reprint this report. Review the Table and Record information on the report to see what changes have been made. If the information is on the report, a change has been made. The Before Reconcile and After Reconcile values will always show $0.00.

The *PA Reconcile Inventory Quantities*  utility must be run after the Inventory Reconcile completes. It's because the Inventory (IV) Reconcile doesn't look at the Project Accounting data files. For example an allocation that was created from a Project transaction would be removed after the IV Reconcile completes. Running PA Reconcile IV will add that allocation back.

1. To run PA Reconcile Inventory Quantities, follow the appropriate step:

    - In Microsoft Dynamics GP 10.0 or later, point to **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Project**, and then select **PA Reconcile IV**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Utilities** on the **Tools** menu, point to **Project**, and then select **PA Reconcile IV**.

2. Select the item or range of items to run the utility for, and then select **Process**.

3. Choose the destination for your Inventory Reconcile Report.

    > [!NOTE]
    > It's recommended to print a hard copy (either to the printer or a file) for review since there is no opportunity to reprint this report.

## References

For more information about the PA Reconcile IV process, see [Information about the order in which the reconcile procedures should be run in Microsoft Dynamics GP](https://support.microsoft.com/help/864622).
