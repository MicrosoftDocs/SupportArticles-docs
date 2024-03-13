---
title: Guidelines to delete an account from GL
description: Guidelines to use when you delete an account from the general ledger in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.date: 03/13/2024
---
# Guidelines to use when you delete an account from the general ledger in Microsoft Dynamics GP

This article contains guidelines to use when you delete an account from the general ledger in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933642

## Introduction

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## More information

To delete an account from the general ledger, the following conditions must be true: (in bullet points)

- The account can't have a balance

    If the account has a balance, you must transfer the balance by using a clearing transaction. To do it, follow these steps:

    1. In the Balance area, select **Transactions**, point to **Financial**, select **Clearing**, and then select **Year-to-Date**.  
    2. Use the clearing transaction to transfer the balance from the account that you want to delete to another account in the general ledger.  
    3. Post the clearing transaction.
        > [!NOTE]
        > Post the clearing transaction to the current year only. You can't post the clearing transaction to the year that was most recently closed.  
    4. Select **Cards**, select **Financial**, and then select **Account** to select the account that you want to delete.  
    5. Select the Inactive check box to make sure that no other transaction will be posted to this account.

- The account can't have any current activity or any year-to-date transactions.

    > [!NOTE]
    > If the account has a balance, the account typically also has one or more year-to-date transactions. To remove the year-to-date transactions, you must wait until the current fiscal year is closed.

- The account can't have any historical data, such as a transaction history or any transactions that occur in years that are closed

    If the account has any historical data, follow these steps:

    1. Make sure that all users are signed out from Microsoft Dynamics GP.  
    1. Select **Tools**, select **Utilities**, select **Financial**, and then select **Remove History**.  
    1. In the Transaction History area, select the **Print** check box to print the data that will be removed.  
    1. In the Account History area, select the **Print** check box to print the data that will be removed.  
    1. In the Year list, select the year that contains the historical data, and then select **Ranges**.  
    1. In the Account Segment Ranges window, select the segment values of the account that you want to delete. Select only one segment value at a time so that you delete the history of only that one account. For example, to delete the history of account 000-1100-00, follow these steps:
        1. Select the **lookup** button that is next to **Segment ID**  
        1. In the ID area, select **Segment 1**, and then select **Select**.  
        1. In the **From** box, Type **000**.  
        1. In the **To** box, type **000**.  
        1. Select **Insert**.  
        1. Select the **lookup** button that is next to **Segment ID**.  
        1. In the ID area, select **Segment 2**, and then select **Select**.  
        1. In the **From** box, Type **1100**.  
        1. In the **To** box, type **1100**.  
        1. Select **Insert**.  
        1. Select the **lookup** button that is next to **Segment ID**.  
        1. In the ID area, select **Segment 3**, and then select **Select**.  
        1. In the **From** box, type **00**.  
        1. In the **To** box, type **00**.  
        1. Select **Insert**.  

    1. When the restrictions are correct, select **OK**.  
    1. In the Remove History window, select **Process** to print the report.  
    1. Verify that the report is accurate. Don't continue with the rest of the steps unless the report is accurate.  
    1. In the Transaction History area, select the **Remove** check box, and then select to clear the **Print** check box.  
    1. In the Account History area, select the **Remove** check box, and then select to clear the **Print** check box.  

    > [!NOTE]
    > The trial balance will be out of balance for the year for which the history was removed.

- The account can't have any multicurrency data in the MC00201 table or in the MC30001 table.

    The MC00201 table is cleared automatically if you complete the year-end close process. The MC30001 table is cleared automatically when you use the Remove Transaction utility.

    To make sure that these two tables have no transactions for the account that is being deleted, follow these steps.

    Microsoft provides programming examples for illustration only, without warranty either expressed or implied. It includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they won't modify these examples to provide extra functionality or construct procedures to meet your specific requirements.

    1. Run the following statements against the company database in Microsoft SQL Query Analyzer or in Microsoft Support Administrator Console.
        - If you use Microsoft SQL Server, use SQL Query Analyzer. To start SQL Query Analyzer, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
        - If you use SQL Server Desktop Engine (also known as MSDE 2000), use Support Administrator Console. To start Support Administrator Console, select **Start**, point to **Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

            ```sql
             Select * from GL00105 where ACTNUMST = 'yyy'
            ```

            > [!NOTE]
            > In this statement, yyy represents the actual account number.

    2. Use the value that is returned in the ACTINDX field to run the next statement.  

        ```sql
        Select * from MC00201 where ACTINDX = 'xxx' Select * from MC30001 where ACTINDX = 'xxx'
        ```

        > [!NOTE]
        > In this statement, xxx represents the account index value that was returned in the ACTINDX field.  

    3. If the statement returns any records in the MC00201 table or in the MC30001 table, run the following statements against the company database to delete these records.

        ```sql
        Delete MC00201 where ACTINDX = 'xxx' Delete MC30001 where ACTINDX = 'xxx'
        ```

- The account cannot be contained in a quick journal or in a saved batch

    To determine whether the account is contained in a quick journal or in a saved batch, follow these steps:

    1. Select **Tools**, point to **Setup**, point to **Financial**, and then select **Quick Journal** to determine whether the account is contained in a quick journal.  
    1. Select **Tools**, point to **Routines**, and then select **Master Posting** to determine whether the account is contained in a saved batch.  
    1. If you see any batches in the **Master Posting** window, determine the module to which the batch belongs.  
    1. In that module, view the batch or the batches by using a window that displays only one batch at a time. To do it, follow these steps:
        1. Select **Transactions**.  
        1. Select the series name, such as **Financial**, **Sales**, or **Purchasing**.  
        1. Select **Batches**.  
        1. > [!NOTE]
           > The menu name may be different for each module. For example, the menu name may be Receivables Batches.

    1. Select the batches one at a time, and then print the edit list.

    > [!NOTE]
    >
    > - You can print the edit list in the Series window or in the Master Posting window. The edit list prints the accounts that are affected if the batch is posted.
    > - The name of the edit list may be different for each module. For example, the name of the edit list may be Clearing Entry Edit List.

- The account must not be contained in an allocation account. The account may not be included in an allocation account either as a breakdown account or as a distribution account.

    > [!NOTE]
    > You can delete variable allocation accounts and fixed allocation accounts at any time because these accounts do not hold a balance. However, if any transactions contain a balance, those transactions will have a blank distribution account. If you add the allocation accounts again, the accounts do not reestablish the link between the transactions that contain a balance. The link is not reestablished because the accounts are given a new account index value.

    To determine whether the account is contained in an allocation account, follow these steps:

    1. Select **Cards**, point to **Financial**, select **Variable Allocation**, and then select the variable allocation accounts one at a time to view both the distribution and breakdown accounts.
        > [!NOTE]
        > You can view only the breakdown accounts if you select the distribution accounts.  
    2. If the account is listed as part of a variable allocation account, select **Edit**, and then select **Delete Row** to remove the row in which the account is listed.  
    3. Select **Cards**, point to **Financial**, select **Fixed Allocation**, and then select the fixed allocation accounts one at a time to view the distribution accounts.
    4. If the account is listed as part of a fixed allocation account, select **Edit**, and then select **Delete Row** to remove the row in which the account is listed. Then, adjust the percentages that are assigned to distribution accounts.

    > [!NOTE]
    > You can save a fixed allocation account even though its distribution accounts are not 100 percent distributed. However, you can't post any transactions by using that fixed allocation account.  

    > [!NOTE]
    > To delete unit accounts, use the same guidelines that you use to delete posting accounts.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
