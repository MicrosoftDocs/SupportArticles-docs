---
title: A transaction cannot fall in a fiscal year
description: Provides a solution to an error that occurs when you select Year and Reconcile in the Reconcile Financial Information window.
ms.reviewer: LMuelle, cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "A transaction does not fall within an existing fiscal year" Error message when you select Year and Reconcile in the Reconcile Financial Information window

This article provides a solution to an error that occurs when you select **Year** and then you select **Reconcile** in the **Reconcile Financial Information** window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943030

## Symptoms

In Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you select **Year** and then you select **Reconcile** in the **Reconcile Financial Information** window. When you do it, you receive the following error message:

> A transaction does not fall within an existing fiscal year. Use the Fiscal Period Setup window to enter consecutive years. Then reconcile again.

## Cause

This problem occurs when the date of a General Ledger journal entry falls outside dates that are set up in the **Fiscal Period Setup** window.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1

To resolve this problem, follow these steps to verify all the correct fiscal years exist and no dates are skipped:

1. Open the **Fiscal Periods Setup** window. To do it, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
2. In the **Fiscal Periods Setup** window, verify that consecutive fiscal periods are configured to have no days that are excluded from open fiscal periods or from historical fiscal periods. Verify no dates are skipped between periods for all years.

### Method 2

To resolve this problem, follow these steps to identify any transaction dates in which the fiscal year doesn't exist.

1. Determine whether a transaction date falls outside the configured fiscal years. In SQL Server Management Studio, select **New Query**, and then run the following script against the company database to find any transaction dates on journal entries that fall outside the existing fiscal year date ranges:

    ```sql
    select * from GL30000 a left join SY40101 b on a.HSTYEAR = b.YEAR1 where a.TRXDATE not between b.FSTFSCDY and b.LSTFSCDY and a.SOURCDOC not in ('BBF','P/L') select * from GL20000 a left join SY40101 b on a.OPENYEAR = b.YEAR1 where a.TRXDATE not between b.FSTFSCDY and b.LSTFSCDY and a.SOURCDOC not in ('BBF','P/L')
    ```

    > [!NOTE]
    > If you don't get any results from the scripts above, then you may review the dates on the BBF and P/L entries.  By default, these entries should be dated the last day of the prior fiscal year. (For example, on a calendar year setup, the '2017' BBF entries would have a '2017' year stamp and a docdate of '12-31-2016'.) If a BBF or P/L entry has a blank docdate (1900-01-01", this may also be an issue and isn't typical behavior in Microsoft Dynamics GP.

1. Next, if GL history has been removed, the first historical year may contain a BBF or P/L entry dated the last day of the prior year, and that year no longer exists. This scenario will cause the above message to happen when Reconcile is done on the historical year. Execute the scripts below to identify the lowest and highest transaction dates in the GL tables, and verify that fiscal years exist that contain the dates returned.

    ```sql
    select MIN(Trxdate) from GL30000 select MAX(Trxdate) from GL30000 select MIN(Trxdate) from GL20000 select MAX(Trxdate) from GL20000
    ```

1. Reconfigure the fiscal year dates

    If the transaction falls outside the configured fiscal years, do one of the following actions:

    - Option 1- Create fiscal years for the dates of the transactions.

    - Option 2 - Delete the transactions that fall outside the fiscal years. Then, reenter the transactions together with current fiscal year dates.

For more information about how to create fiscal years or deleting transactions that fall outside the fiscal years, contact Technical Support for Microsoft Dynamics and for related products. You can sign in to the Microsoft Dynamics site and create a new support request.

You can also contact Technical Support for Microsoft Dynamics and related products by telephone at (888) 477-7877.
