---
title: Clear beginning balances for unit accounts in General Ledger in Microsoft Dynamics GP
description: Discusses that the balances for all unit accounts roll forward after the General Ledger fiscal year has been closed in Microsoft Dynamics GP. Describes how to delete the beginning balances for the unit accounts.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# How to clear beginning balances for unit accounts in General Ledger in Microsoft Dynamics GP

This article provides a solution to an issue where the balances for all unit accounts roll forward after the General Ledger fiscal year has been closed in Microsoft Dynamics GP.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857582

## Symptoms

When you close the year in General Ledger in Microsoft Dynamics GP, the balances for all unit accounts roll forward to the current year. This issue occurs because Microsoft Dynamics GP treats unit accounts as if they were balance sheet accounts.

## Resolution

Refer to the steps for the appropriate version below:

### Prevent unit account from having a bbf going forward (for Microsoft Dynamics GP 2013 and higher versions)

There is new functionality in Microsoft Dynamics GP 2013 that included a checkbox on the unit account setup that you can mark to automatically prevent a BBF from being created in the new year as part of the GL year-end close process for that particular unit account. Follow these steps to mark each unit account you do not want a beginning balance for:

1. Prior to closing the GL year, click on **Cards**, point to **Financial** and click **Unit Account**.
2. Select the unit account and mark the checkbox for **Clear Balance During Year-End Close**.
3. Click **Save**. Do this for each unit account that you wish not to have a beginning balance for in the new year, as part of the GL year end close process.

> [!NOTE]
>
> - This checkbox will prevent a BBF from being created in the new year the next time you close a GL year. It does not touch past closed years or existing BBF's. To clear out an existing BBF, you must follow the steps below.
> - To clear BBF's in prior years, you can reopen your GL years, mark the checkbox(s) on your unit account(s) and then reclose your GL years again.

### Clear out bbf in open/historical years

- Microsoft Dynamics GP 2013 and higher versions

    1. Reopen the GL year(s).
    2. Mark the checkbox(s) on the unit account(s).
    3. Reclose the GL year(s).

- Microsoft Dynamics GP 2010 and prior versions

    To delete the beginning balance amounts for unit accounts in the current year and in historical years, use the appropriate method(s):

  - Method 1: Delete balances for unit accounts in the current year

    1. Open Microsoft SQL Server Management studio.  
    2. Run the following `select` statement against the company database to get a list of all the unit accounts you will be clearing out the BBF for in the current open year:

        ```sql
        select * from GL00100, GL20000 where GL00100.ACTINDX = GL20000.ACTINDX and GL00100.ACCTTYPE = 2 and GL20000.SOURCDOC = 'BBF'
        ```

    3. If you agree, then run the following `delete` statement against the company database to remove the BBF records for these unit accounts in the open current year.

        ```sql
        delete GL20000 from GL00100, GL20000 where GL00100.ACTINDX = GL20000.ACTINDX and GL00100.ACCTTYPE = 2 and GL20000.SOURCDOC = 'BBF'
        ```

    4. On the **Tools** menu, point to **Utilities**, point to **Financials**, and then click **Reconcile**.

        1. In the Reconcile Financial Information window, click to select the **Year** check box.
        2. Reconcile each year.  Start the process by using the oldest historical year. End the process by using the current open year.

  - Method 2: Delete balances for unit accounts in historical years

    1. Open SQL Server Management Studio.
    2. Run this script to get a list of all the unit accounts with a BBF. Be sure to update the *XXXX* placeholder for the historical year you want to check.  

        ```sql
        select * from GL00100, GL30000 where HSTYEAR = 'XXXX' and GL00100.ACTINDX = GL30000.ACTINDX and GL00100.ACCTTYPE = 2 and GL30000.SOURCDOC = 'BBF'
        ```

    3. Run the following statement against the company database to remove the BBF for the year you want. (Typically if you remove one year, you remove all years AFTER that year. So if you want to remove the BBF for 2015, you would also remove the BBF for 2017, then 2016 and then 2015 last for unit accounts, since balances were rolled forward year to year.)  

        ```sql
        delete GL30000 from GL00100, GL30000 where HSTYEAR = 'XXXX' and GL00100.ACTINDX = GL30000.ACTINDX and GL00100.ACCTTYPE = 2 and GL30000.SOURCDOC = 'BBF'
        ```

    4. On the **Tools** menu, point to **Utilities**, point to **Financials**, and then click **Reconcile**.
        1. In the **Reconcile Financial Information** window, click to select the **Year** check box.
        2. Reconcile each year. Start the process by using the oldest historical year. End the process by using the current open year.
