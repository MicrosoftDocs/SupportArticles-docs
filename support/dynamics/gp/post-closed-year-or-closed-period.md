---
title: Post to a closed year or to a closed period
description: This article describes how to post to a closed year or to a closed period in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# Steps to post to a closed year or to a closed period in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 851423

## Introduction

This article describes how to post transactions to a closed year or to a closed period in Microsoft Dynamics GP.

## More information

You can post transactions to the most recent closed year only (that is, one historical year back). This feature is useful if you have to enter audit adjustments after you've closed the year. When you post an adjustment to a closed year, the beginning balances of the affected accounts for the next year are adjusted automatically with Balance Brought Forward ('BBF') entries in Period '0' of the next year. You'll see both entries in the posting journal.

To post transactions to the most recent closed year or to a closed period, follow these steps:

1. Reopen the closed period. To do this, in Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.

1. In the Fiscal Periods Setup window, select the appropriate Year. Then unmark the Series that you'll be posting to for the appropriate period. This will allow posting to that period for that module. Select **OK**.

1. Enable the option for Posting to History in the General Ledger Setup window. To do this, in Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Financial**, point to **General Ledger**, and then select to select the **Posting to History**  check box in the **Allow** section.

1. In the **Maintain History**  area of the General Ledger Setup window, select to clear the **Accounts** check box and the **Transactions** check box.

    > [!IMPORTANT]
    > Only if you do not want to affect the closed year and are adjusting beginning balances only.

   Do this only if the following conditions are true:

   - You don't want the adjusting entries to affect the closed year.

   - You want the adjusting entries to roll forward to adjust the beginning balances.

1. select **OK**.

1. Enter the general ledger transactions. Microsoft Dynamics GP will roll forward the changes based on the General Ledger setup.

   - Balance sheet type accounts will have beginning balances rolled forward.
   - Profit & Loss type accounts will roll into the Retained Earnings account or Divisional retained earnings accounts based on your General Ledger setup.

1. When finished, go back to the Fiscal Periods window (see steps 1 and 2) and close the period again for that series so no other users will be allowed to post to that series/period going forward.

> [!NOTE]
> The system will allow you to post to one historical year back by design.  However, if you need to post to two or more closed years back, you must first use the 'Reverse Historical Year' button in Financial Year-End Closing window (in GP 2013 R2 and higher versions) to reopen the year.  You can reopen as many closed years back as you choose to be able to post the GL entries needed to that year.  When you reclose the year again, the balances will be recalculated based on the current settings.  If you reopen multiple years back, you should be aware of:
>
> - Has the Retained earnings account changed over time?
> - Has any Financial data been purged?
> - Have any adjustments to balances been done over time directly in the SQL tables?
>
> If you reopen and reclose multiple GL years back, make sure to have a current backup, and all users should be out of GP.
>
> If you reopen and reclose multiple GL years back, you will get prompted to run the Reconcile process for all years each time.   You can ignore this message during the process for each year, and just reconcile once at the very end for all years.
