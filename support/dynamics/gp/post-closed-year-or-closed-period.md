---
title: Post to a closed year or to a closed period
description: This article describes how to post to a closed year or to a closed period in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: how-to
ms.date: 03/31/2021
---
# Steps to post to a closed year or to a closed period in Microsoft Dynamics GP

This article describes how to post transactions to a closed year or to a closed period in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 851423

## Introduction

This article describes how to post transactions to a closed year or to a closed period in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

## More information

You can post transactions to the most recent closed year. This feature is useful if you have to enter audit adjustments after you have closed the year. When you post an adjustment to a closed year, the beginning balances of the affected accounts for the next year are adjusted automatically with Balance Brought Forward entries. You will see both entries in the posting journal.

To post transactions to the most recent closed year or to a closed period, follow these steps:

1. Reopen the closed period. To do this, use the appropriate method:

1.
   - In Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Company**, and then click **Fiscal Periods**.

   - In Microsoft Dynamics GP 9.0 and earlier versions, click **Tools**, point to **Setup**, point to **Company**, and then click **Fiscal Periods**.

   In the Fiscal Periods Setup window, select the appropriate Year. Then unmark the Series that you will be posting to for the appropriate period. This will allow posting to that period for that module. Click **OK**.

1. Enable the option for Posting to History in the General Ledger Setup window. To do this, use the appropriate method:

   - In Microsoft Dynamics GP 10.0, or Microsoft Dynamics GP 2010, click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Financial**, point to **General Ledger**, and then click to select the **Posting to History**  check box in the Allow section.

   - In Microsoft Dynamics GP 9.0 and earlier versions, click **Tools**, click **Setup**, click **Financial**, click **General Ledger**, and then click to select the **Posting to History** check box.

1. In the **Maintain History**  area of the General Ledger Setup window, click to clear the **Accounts** check box and the **Transactions** check box.

   Do this only if the following conditions are true:

   - You do not want the adjusting entries to affect the closed year.

   - You want the adjusting entries to roll forward to adjust the beginning balances.

1. Click **OK**.

1. Enter the general ledger transactions. Microsoft Dynamics GP will roll forward the changes based on the General Ledger setup.

1. When finished, go back to the Fiscal Periods window (see steps 1 and 2) and close the period again for that series so no other users will be allowed to post to that series/period going forward.

> [!NOTE]
> The system will allow you to post to one closed year back by design. However, if you need to post to two or more closed years back, you must open a support case and ask for a consulting service to be set up to have Microsoft re-open the closed years for you. This would be a billable consulting expense to you. Please open a support case or call 1-800-477-7877 for assistance.
