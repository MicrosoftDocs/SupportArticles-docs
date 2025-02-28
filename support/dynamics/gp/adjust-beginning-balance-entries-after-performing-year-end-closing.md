---
title: Adjust the beginning balance entries after you perform a year-end closing in Microsoft Dynamics GP
description: Describes how to adjust the beginning balance entries after you perform a year-end closing in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# How to adjust the beginning balance entries after you perform a year-end closing in Microsoft Dynamics GP

This article describes how to adjust the beginning balance entries after you perform a year-end closing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857310

## Adjust the beginning balance entries after you perform a year-end closing

To adjust the beginning balance entries after you perform a year-end closing, you can follow the steps below to key a GL transaction and not keep history on the transaction, but a BBF entry will be created for that amount and carried forward to affect the beginning balance for the open year. To do this, follow these steps:

1. If you have a backup of the database, restore the database from the backup, and then run the year-end closing process again. For more information, see [Year-end closing procedures for General Ledger in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-year-end-closing-procedures-for-general-ledger-in-microsoft-dynamics-gp-4447f7bb-7143-60e2-882a-c7ae86f5792e).

    If you do not have a backup of the database, go to step 2.

2. Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

    In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then click **Multicurrency**. In the **Maintain History** area, click to clear the **General Ledger Account** check box.

    > [!NOTE]
    >
    > - If Multicurrency in Microsoft Dynamics GP is not registered, rename the MC40000.* files that are located in the company Finance directory.
    > - If you use Microsoft SQL Server, run the `update MC40000 set MNSUMHST=0` statement against the company database.

3. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then click **General Ledger**. In the **Maintain History** area, click to clear the **Accounts** check box, and then click to clear the **Transactions** check box.

4. In the **Allow** area, make sure that the **Posting to History** check box is selected. Click **OK** to save the changes.

5. Use the appropriate step:

    In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then click **Fiscal Periods**. Make sure that the fiscal period is open.

6. Click **Transactions**, point to **Financial**, and then click **General**. Enter the appropriate journal entry. Make sure that the transaction date is in the closed year so that the entry will update the beginning balances. If the balance sheet account should have a debit beginning balance, make an entry that resembles the following entry:

    The balance sheet account is debited, and the retained earnings account is credited. Enter one transaction for each account that had an incorrect posting type.

7. Post the transactions. The posting procedure affects only the current year because the Maintain History options are disabled. A beginning balance transaction is posted in the new year. Therefore, the accounts will have the correct balances.

8. Use the appropriate step:

    In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then click **General Ledger**. In the **Maintain History** area, click to select the **Accounts** check box, and then click to select the **Transactions** check box.

9. In the **Allow** area, make sure that the **Posting to History** check box is selected. Click **OK** to save the changes.

10. Use the appropriate step:

    In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then click **Multicurrency**. In the **Maintain History** area, click to select the **General Ledger Account** check box.

    > [!NOTE]
    >
    > - If Multicurrency is not registered, rename the MC40000.* files back to the original names from which you renamed them in step 2.
    > - If you use Microsoft SQL Server, run the `update MC40000 set MNSUMHST=1` statement against the company database.

> [!IMPORTANT]
> If you reopen the GL year using SQL Scripts (for any GL version) or the *Reverse Historical Year* option in the GL Year-End Closing window in Microsoft Dynamics GP 2013 or later versions, please note that **these BBF entries will be removed.** When you reclose the GL year(s), the recalculated BBF's will now be missing this amount because no detailed transaction exists to support it and therefore it won't be recalculated back in. So be sure to keep good notes of entries you make like this, so you can rekey them in the event you need to reopen/reclose a GL year.

## References

For more information, see [Changing the posting type on an account after you close the year in General Ledger for Microsoft Dynamics GP](https://support.microsoft.com/topic/changing-the-posting-type-on-an-account-after-you-close-the-year-in-general-ledger-for-microsoft-dynamics-gp-98b71d37-573e-5c24-383e-1d570fb5daf0).
