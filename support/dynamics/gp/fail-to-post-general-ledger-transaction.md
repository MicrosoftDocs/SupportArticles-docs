---
title: Error when you post a general ledger transaction 
description: Provides a solution to an error that occurs when you try to post a general ledger transaction.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# Error when you try to post a general ledger transaction: "The Rate Type ID is not associated with the currency ID for this transaction"

This article provides a solution to an error that occurs when you post a general ledger transaction.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935381

## Symptoms

When you try to post a general ledger transaction in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> The Rate Type ID is not associated with the currency ID for this transaction

> [!NOTE]
> This error message may also occur if the batch was created in a submodule.

## Cause

This problem may occur if one of the following scenarios is true.

### Scenario 1

The transaction that you try to post uses an account that is specified in the Interfund Management setup window. To determine whether this scenario applies to you, follow these steps:

1. Print the edit list of the batch after you recover the batch.
2. Verify that the accounts that were used in that transaction were actually used in the Interfund Management setup window.

    To open the Interfund Management setup window, click **Tools**, point to **Setup**, point to **Financial**, and then click **Interfund Management**.

### Scenario 2

At least one account that was used in the transaction has a segment that is not set up correctly in the Interfund Management setup window. To determine whether this scenario applies to you, verify that an account is set up for each fund account in the Interfund Management setup window.

To open the Interfund Management setup window, click **Tools**, point to **Setup**, point to **Financial**, and then click **Interfund Management**.

You cannot post a transaction until an account is defined for each transaction segment in the **Due To / Due From Account** column and in the **Clearing Fund Account** column.

Typically, the accounts are defined for a new account that has a new value in the fund segment of the account number. For example, accounts are defined if the following conditions are true:

- The fund segment is the first segment of the account number.
- The values for the first segment are as follows:
  - 100
  - 200
  - 300

> [!NOTE]
> This list excludes the main fund of 000.

If an account that uses a value of "111" for the first segment is created, a line is allocated for segment "111" in the Interfund Management setup window. Accounts must be assigned to this line. Otherwise, whenever an account uses a value of "111" for the first segment, the error message that is mentioned in the [Symptoms](#symptoms) section appears.  

If you use the "Single Due To / Due From" method, all segments must have an assigned account in the **Due To / Due From Account** column.  

If you use the "Clearing Fund / Central Treasury" method, all segments except the Clearing Fund Number segment must have an assigned account in the **Clearing Fund Account** column and in the **Due To / Due From Account** column.

## Resolution

To resolve this problem, change the status for the batch that is to be posted. To do this, follow these steps:

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Make the batch available. For more information about how a batch can be unavailable because of its status, see [A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/help/850289).

2. Use Microsoft SQL Query Analyzer or Microsoft Support Administrator Console to run the following delete statement under the correct company database.

    `delete IF000005`

    > [!NOTE]
    > The table IF000005 is the IF_Error_Log table or the table that holds the Errors Activity records. If this table is not cleared, the edit list continues to contain the following error message:  
    > "The Rate Type ID is not associated with the currency ID for this transaction.The batch cannot be posted even if it has a status of **Available**."

    - If you are using Microsoft SQL Server 7.0 or Microsoft SQL Server 2000, run the statement in Query Analyzer. To start Query Analyzer, click **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

    - If you are using Microsoft SQL Server Desktop Engine (also known as MSDE 2000), run the statement in Support Administrator Console. To start Support Administrator Console, click **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then click **Support Administrator Console**.

3. Log on to the company database as the sa user or as a user who has equivalent permissions.
4. Use one of the following methods, depending on the scenario:

    - Method 1
        > [!NOTE]
        > In this scenario, we assume that you must post transactions directly to the accounts that are specified in the Interfund Management setup window.

        1. Click **Tools**, click **Customize**, click **Customization Status**, click **Interfund Management**, and then click **Disable**.
        2. Click **Transactions**, click **Financial**, and then click **Batches**.
        3. Click the lookup button next to the **Batch ID** field, and then click the batch.
        4. Display the edit list on screen to make sure that there are no more errors in the batch.
        5. If the edit list does not show errors, post the batch and print the posting journal as required.
        6. Click **Tools**, click **Customize**, click **Customization Status**, click **Interfund Management**, and then click **Enable**.

    - Method 2

        1. After the accounts are entered correctly in the Interfund Management window, print the edit list to the screen to make sure that there are no other problems that can cause the batch not to post. To print the edit list, follow these steps:
            1. Click **Transactions**, click **Financial**, and then click **Batches**.
            2. Click the lookup button next to the **Batch ID** field, double-click the batch, and then click the printer button.
        2. If you do not find errors in the batch edit list, click **Post**.
        3. Print the posting journal if it is required.
