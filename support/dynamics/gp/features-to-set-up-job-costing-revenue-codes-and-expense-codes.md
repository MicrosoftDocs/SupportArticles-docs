---
title: Features for job costing and revenue codes and expense codes
description: Discusses the features and options that you can use to set up job costing to help categorize transactions by job, by revenue code, or by expense code in Microsoft Dynamics GP. Provides an example job costing setup.
ms.reviewer: theley, aeckman
ms.date: 03/13/2024
---
# Features that you can use to set up job costing, revenue codes, and expense codes for Manufacturing

This article discusses different features and options that you can use to set up job costing in Microsoft Dynamics GP. This article also discusses how to set up revenue codes and expense codes for reports.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 937817

## Summary

You can use the Revenue/Expense Code Setup window to create revenue codes and expense codes. You can use these codes to summarize the transactions that are applied to jobs.

For example, you can create an expense code that is named LABOR to summarize all expenses that are incurred by a job. This expense code can include actual labor and labor overhead. Also, you can create a revenue code that tracks purchase receipts for incoming inventory.

You must assign the revenue code or the expense code to the appropriate transaction list, depending on what you want to track.

You can clear the **Auto Apply** check box so that changes have to be manually applied. Then, you must assign the transaction list to a job.

After you enter the transactions, and after you apply the transactions to jobs, you can print reports by job. In the report, you can list the transactions by job, by revenue code, or by expense code. You can use these reports to help categorize transactions.

## More information

The following procedure is an example of how to set up job costing in Microsoft Dynamics GP.

> [!NOTE]
> The following steps refer to the Fabrikam company. Fabrikam is a fictitious company name that is used for demonstration in Microsoft Dynamics GP.

1. Select **Cards**, point to **Manufacturing**, point to **Job Costing**, and then select **Job Maintenance**.
2. Select the lookup button that is next to the **Job Number** field, and then double-click **J001**.

3. The **Transaction List** field displays the **All Trx Applied** value.
4. Close the Job Maintenance window.
5. Open the **All Trx Applied** transaction list. To do this, select **Cards**, point to **Manufacturing**, point to **Job Costing**, and then select **Transaction List**.

6. Select the lookup button that is next to the **Job Transaction List** field, and then double-click **All Trx Applied**.
7. In the **Transactions** list, select **Purch. Inv. Material**.

    > [!NOTE]
    > Material is listed in the **Default Revenue/Expense** column.

8. You can select the Material code in the Revenue/Expense Code window. To open the Revenue/Expense Code window, select **Cards**, point to **Manufacturing**, point to **Job Costing**, and then select **Rev/Exp Codes**. The items that are in the **Revenue/Expense Code** list are the codes for which you can create reports.

9. Enter a purchase order. To do this, select **Transactions**, point to **Purchasing**, and then select **Purchase Order Entry**.
10. In the **Item** field, right-click the line item, select **Link to**, and then double-click **J001**.
11. Receive and then post the purchase order. To do this, select **Transactions**, point to **Purchasing**, and then select **Receivings Transaction Entry**.
12. Print the Job Transaction List. To do this, follow these steps:
    1. Select **Reports**, point to **Manufacturing**, point to **Job Costing**, and then select **Report Options**.
    2. In the **Report** list, select **Job Transactions**, select the print button, select the **Screen** check box, and then select **OK**.

    > [!NOTE]
    >
    > - The report shows the receiving transaction. Additionally, the report shows that the transaction uses **Material** as the **Revenue/Expense Code** value.
    > - Revenue codes and expense codes let you group transactions by type. By using this grouping, you can print the job to see all the revenue transactions and expense transactions for the job.

13. Continue to enter transactions, such as Sales Order Processing invoices, Payables Management invoices, and so on.
14. Link the J001 job number to these transactions before you post. Then, reprint the report.

    > [!NOTE]
    > Each code is assigned in the transaction list.
