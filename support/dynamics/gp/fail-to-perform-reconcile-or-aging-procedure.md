---
title: Error when you perform Reconcile procedure or Aging procedure in Receivables Management in Microsoft Dynamics GP
description: Error message when you perform the Reconcile procedure or the Aging procedure in Receivables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# Error message when you perform the Reconcile procedure or the Aging procedure in Receivables Management in Microsoft Dynamics GP: "Unhandled script exception, value of range, exception class script out of range"

This article provides a solution to an error that occurs when you perform the Reconcile procedure or the Aging procedure in Receivables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 851191

## Symptoms

Consider the following scenario. You perform the Reconcile procedure or the Aging procedure in Receivables Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains. When you do this, you receive the following error message:

> Unhandled script exception, value of range, exception class script out of range

## Cause

This issue occurs for one of the following reasons:

- The Statement Cycle is missing on the **Customer Maintenance Options** window.
  - There is a record in an RM table with a blank Customer ID.
  - In the Reconcile Receivables Amounts window, you clicked **Current Customer Information**, and then you clicked **Process**.
- In the **Receivables Aging Process** window, you clicked **Process**.

## Resolution

To resolve this problem, use one of the following methods.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

### Method 1

1. When you receive the error message, note the customer record on which the process stopped.
2. On the **Cards** menu, point to **Sales**, and then click **Customer**.
3. In the **Customer ID** field, type the customer identifier (ID) of the customer record that you noted in step 1. Click **Options**.
4. In the **Customer Maintenance Options** window, click a statement cycle in the **Statement Cycle** list, and then click **OK**.

### Method 2

Use this method if one of the following conditions is true:

- You followed the steps in [Method 1](#method-1), and then you performed the Reconcile procedure or the Aging procedure again. When you did this, you received the same error message. But, the process stopped on a different customer record.
- You followed the steps in [Method 1](#method-1), and then you performed the Reconcile procedure or the Aging procedure again. When you did this, you received the same error message, and the process stopped on the same customer record.

To use this method, follow these steps:

1. In the **Customer Maintenance Options** window, determine the customer records that contain a blank statement cycle. To do this, follow these steps:

    1. Open SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 20XX** (your version), and then click **SQL Server Management Studio**.
    2. Run the `select * from RM00101 where STMTCYCL = ''` statement against the company database.
    3. Note the customer IDs from the result of the statement that you ran in step 1b.

2. Assign the statement cycle for the customer records that you noted in step 1c. To do this, follow these steps:

    1. On the **Cards** menu, point to **Sales**, and then double-click **Customer**.
    2. In the **Customer Maintenance** window, enter the first customer ID that you noted in step 1c in the **Customer ID** box, and then click **Options**.
    3. In the **Customer Maintenance Options** window, make sure that a statement cycle is specified in the **Statement Cycle** field, and then click **OK**.
    4. Click **Save**.
    5. Repeat steps 2b through 2d for each customer ID that you noted in step 1c.

3. Run the Check Links process. To do this, follow these steps:

    1. Use the appropriate method:

        - In Microsoft Dynamics GP 10.0 and higher versions, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then click **Check Links**.
        - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Maintenance** on the **File** menu, and then click **Check Links**.
    2. In the **Check Links** window, click **Sales** in the **Series** list, click **Receivables Customer Master Files**, and then click **Insert**.
    3. Click **OK**.

### Method 3

Use this method if you still receive the error message after you use method 1 and method 2. To use this method, follow these steps:

1. Determine whether the following tables contain blank records:

    - The RM Customer Master table (RM00101)
    - The Customer Master Address File table (RM00102)
    - The Customer Master Summary table (RM00103)
    - The Customer Period Summary table (RM00104)
    - The RM Statements E-mail Addresses table (RM00106)

    To do this, follow these steps:

    1. Open SQL Server Management Studio.  To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 20XX** (your version), and then click **SQL Server Management Studio**.

    2. Run the following statements against the company database.

        ```sql
        select DEX_ROW_ID,* from RM00101 where CUSTNMBR = ''
        select DEX_ROW_ID,* from RM00102 where CUSTNMBR = ''
        select DEX_ROW_ID,* from RM00103 where CUSTNMBR = ''
        select DEX_ROW_ID,* from RM00104 where CUSTNMBR = ''
        select DEX_ROW_ID,* from RM00106 where CUSTNMBR = ''
        ```

    3. Note the DEX_ROW_ID values from the result of the statements that you ran in step 1b.

    > [!NOTE]
    > You will use these DEX_ROW_ID values to delete the blank records in step 2.

2. Use an SQL query tool to delete the blank records. For more information about how to delete records, contact your Microsoft Dynamics partner. Or, contact technical support for Microsoft Dynamics GP.
3. Run the Check Links process. To do this, follow these steps:

    1. Use the appropriate method:

        - In Microsoft Dynamics GP 10.0 and higher versions, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then click **Check Links**.
        - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Maintenance** on the **File** menu, and then click **Check Links**.

    2. In the Check Links window, click **Sales** in the **Series** list, click **Receivables Customer Master Files**, and then click **Insert**.
    3. Click **OK**.
4. Perform the Reconcile procedure or the Aging procedure again.
