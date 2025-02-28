---
title: Change the fiscal period setup in General Ledger
description: This article describes how to change the fiscal periods so that the fiscal periods differ from the current calendar year in Microsoft Dynamics GP.
ms.reviewer: Theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# Change the fiscal period setup in General Ledger in Microsoft Dynamics GP

This article describes how to change the fiscal periods so that the fiscal periods differ from the current calendar year in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871647

## Summary

This article describes how to change the fiscal periods so that the fiscal periods differ from the current calendar year in Microsoft Dynamics GP.

## More information

In Microsoft Dynamics GP, you can change only open fiscal periods in the Fiscal Periods Setup window. Historical year changes are not supported because the year-end close process has already been completed for those years, and the beginning balances for the next fiscal period can no longer be adjusted. The beginning balance for the next fiscal period reflects the ending balance that existed on the day that the year-end close occurred. This balance omits any transactions that have been posted between the year-end close and the new end of the fiscal period. Also, the date of the year-end close transactions is the date on which the year-end close already occurred. This dating process leaves an inaccurate audit trail.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To change the fiscal period setup in General Ledger in Microsoft Dynamics GP, follow these steps:

1. Open the **Fiscal Periods Setup** window.

   In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup** > **Company**, and then select **Fiscal Periods**.

2. Set up the current fiscal year.

   1. In the **Fiscal Periods Setup** window, select the current year in the **Year** list.
   1. In the **Number of Periods** field, type the number of periods for the fiscal year.
   1. In the **First Day** field, type the first day of the fiscal year.
   1. In the **Last Day** field, type the last day of the fiscal year.
   1. Select **Calculate**. If it is necessary, adjust the beginning dates of specific periods. Or, change the period names.

3. Set up the new fiscal year.

   1. In the **Year** field, type the year.
   2. In the **Number of Periods** field, type the number of periods for the fiscal year.
   3. In the **First Day** field, type the first day of the fiscal year.
   4. In the **Last Day** field, type the last day of the fiscal year. If it is necessary, adjust the beginning dates of specific periods. Or, change the period names.
   5. Select **OK**.
   6. Select **OK** when you receive the following message:

      > These changes will cause period balances to be incorrect. You must reconcile General Ledger files.

4. Reconcile the General Ledger files.

   1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Financial**, and then select **Reconcile**.
   2. Select the **Year** checkbox, and then select the earliest year in the list.
   3. Select **Reconcile**.

     > [!NOTE]
     >
     > - When you select **Reconcile** when the **Year** checkbox is selected, no report is printed. Additionally, no message appears that states that the reconciliation process is complete. The reconciliation process recalculates the summary information based on the detailed transactions in the General Ledger files. The reconciliation process usually takes several seconds.
     >
     > - Make sure that consecutive fiscal periods are set up so that no days are excluded from the open fiscal periods. If days are missing from the fiscal periods, you receive the following error message when you try to reconcile the fiscal periods:  
     >
     > A transaction does not fall within an existing fiscal year. Use the Fiscal Period Setup window to enter consecutive years. Then reconcile again.
     >
     > - If you need more than one open year, make sure that you change the most recent fiscal period first. If you change a different fiscal period first, you receive the following error message:
     >
     > The date cannot be part of a different fiscal year.
