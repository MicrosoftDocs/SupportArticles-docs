---
title: Changing the posting type on an account
description: Describes how to correct the posting type on an account after you close the year in General Ledger.
ms.reviewer: theley, ryanklev, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Changing the posting type on an account after you close the year in General Ledger for Microsoft Dynamics GP

This article provides a solution to an issue where the posting type on an account is changed after you close the year in General Ledger for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864913

## Symptoms

The posting type determines how the account balance will be treated during the year-end closing process in General Ledger in Microsoft Dynamics GP. Balance sheet accounts will be rolled forward to the next year, and Profit and Loss accounts will be rolled into the Retained Earnings account.

## Cause

This problem occurs if you select the incorrect posting type for the account in the Account Maintenance window when you set up the General Ledger accounts in Microsoft Dynamics GP, There are two options for **Posting Type**: **Balance Sheet** or **Profit and Loss**.

## Resolution

Use the appropriate method below for the version of Microsoft Dynamics GP that you're using:

### Microsoft Dynamics GP 2013 R2 (12.00.1745) and higher versions

New functionality was added that will allow you to reopen a year yourself that was already closed successfully. With this new functionality, you can reopen the GL year, change the posting type on the GL Account setup, and reclose the GL Year again so the account closes properly. To do it, follow these steps:

1. Have all users exit all companies, and make a current **backup** of the company database.

    > [!NOTE]
    > If any other users are signed into any company in this Microsoft Dynamics GP installation, you will get a message:  
    > "*You cannot reverse the historical year because other users are logged in to the system."*  
    > All users need to be signed out of all companies.

2. Select **Microsoft Dynamics GP,** point to **Tools**, point to **Routines**, point to **Financial** and select **Year-End Closing.**  

3. In the Year-End Closing window, select the **Reverse Historical Year** button at the bottom.

4. Select **Process** to reopen the last closed historical year as shown in the Year to Open field.  

5. Select **Continue** to verify that you have made a backup of the company database. If not, select **Cancel** and make a backup of the company database before proceeding.

    > [!NOTE]
    > This process will physically move all the historical data from the GL history table to the GL Open Transaction table, and reverse all the Beginning Balance Entries that we brought forward. This process will reopen the GL year as if it was never closed in the first place.

6. Once the year is reopened, the next historical year will populate the window, so you can repeat for as many years as you need reopened. The historical years can only be reopened in consecutive order starting with the most previously closed year. Just exit out of these windows once you have the year(s) you want reopened.

7. Next select **Cards**, point to **Financial** and select **Account**. Select the GL account you need and change the **Posting Type** field to **Balance Sheet** or **Profit and Loss** as needed and select **Save**.

8. When you have finished editing the GL account type, select **Microsoft Dynamics GP**, point to **Tools**, point to **Routines**,  point to **Financial** and select **Year-End Closing** and reclose the GL year again. Print/review the Year End Closing report as wanted.

    > [!NOTE]
    > When you reopen and reclose a GL year, make sure that the Retained Earnings account being used hasn't changed, and that no historical data has been purged from that year.

9. Verify the GL account has or doesn't have a beginning balance as needed.

Q: Why are some Beginning balances different for GL accounts in which I didn't change the posting type?

A: The system allows you to post one historical year back and it creates separate BBF entries for those transactions. However, now if you reopen and reclose the year, those transactions will now be included in the new BBF entry as if it was keyed during the open year. It's now considered a current year transaction for that year rather than a historical year posting and will be included in the BBF entry that is recalculated.

### Microsoft Dynamics GP 2013 SP2, Microsoft Dynamics GP 2010, Microsoft Dynamics GP 10.0, and all prior versions

Use one of the following methods to correct the posting type for the next year.

- If the account is supposed to be a **profit-and-loss** account, use [Method 1](#method-1-the-account-is-supposed-to-be-a-profit-and-loss-account) below.

- If the account is supposed to be a **balance sheet** account, use [Method 2](#method-2-the-account-is-supposed-to-be-a-balance-sheet-account) below.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

#### Method 1: The account is supposed to be a profit-and-loss account

As a balance-sheet account, this account will have a beginning balance after the year-end closing process is completed. To change the account to a profit-and-loss account and to reverse the beginning balance, follow these steps:

1. On the **Cards** menu, point to **Financial**, and then select **Account**. In the Account Maintenance window, type the account number in the **Account** field. Make sure that the **Posting Type** area is set to **Balance Sheet**, and then select **Save**. The type needs to be Balance Sheet type at this point so we offset the balance that was carried forward and it doesn't affect the RE account now.
2. Use one of the following methods, depending on whether you're registered for multicurrency or not registered:

   - If you're registered for Multicurrency Management in Microsoft Dynamics GP, follow these steps:
        1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **Multicurrency**.
        2. In the **Maintain History** area, select to clear the **General Ledger Account**  check box.
   - If you aren't registered for Multicurrency Management, open SQL Server Management Studio and run the following statement against the company database:

        ```sql
        UPDATE MC40000 SET MNSUMHST = 0
        ```

3. Change the **Maintain History**  settings in the General Ledger Setup window so we don't keep the actual journal entry in the prior year, as we only want to offset the BBF that was created. To change the setting, follow these steps:

    1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **General Ledger**  
    2. In the **Maintain History** area, select to clear the **Accounts** check box and the **Transactions** check box.

4. In the **Allow** area, select the **Posting to History** check box. We want to be able to post an offsetting journal entry using a prior year date. Select **OK**.
5. Reopen the period for the prior Fiscal Year. To do it, follow these steps.
    1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
    2. In the Fiscal Periods Setup window, make sure that the Financial period for the recently closed year is open.

6. Enter a journal entry to offset the incorrect beginning balance. To do it, follow these steps:
    1. On the **Transactions** menu, point to **Financial**, and then select **General**.
    2. In the Transaction Entry window, enter a transaction that reverses the incorrect beginning balance of the profit-and-loss account.
    3. In the **Transaction Date**  field, enter a date that is in the closed fiscal year such as 12/31/201x.

        For example, if the profit-and-loss account has an incorrect debit beginning balance of $100.00, create a transaction that credits the profit-and-loss account for $100.00, and then debit the kept earnings account for $100.00.
    4. Select **Post**. (The General Posting Journal should show the entry listed twice. The first is for the original entry, but because of our settings, we won't be keeping that, and the second set is for the BBF entry that will offset the balance.)

        > [!NOTE]
        > The transaction updates only the current year because the **Maintain History** settings are not enabled.
7. Change the **Maintain History** settings in the General Ledger Setup window back to how they originally were. To do it, follow these steps:
    1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **General Ledger**.
    2. In the **Maintain History** area, select to select the **Accounts** check box and the **Transactions** check box.
    3. To post the transactions to the transaction history, select the **Posting to History** check box under **Allow**. If you don't want to post the transactions to the transaction history, select to clear this check box. Then, select **OK**.

8. Use one of the following methods to change the Multicurrency setting back to how it originally was, depending on whether you're using multicurrency or not:

   - If you're registered for Multicurrency Management, follow these steps:
        1. In Microsoft Dynamics GP, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Financial**, and then select **Multicurrency**.
        2. In the **Maintain History** area, select to select the **General Ledger Account** check box.
   - If you aren't registered for Multicurrency Management, open SQL Server Management Studio and run the following statement against the company database:

      ```sql
      UPDATE MC40000 SET MNSUMHST = 1
      ```

9. Go back to the Fiscal Period setup and mark to close the Fiscal Period for the prior year again.
10. Now you can verify the balance on the GL account is $0.00 and then you can change the type on the account to Profit and Loss. To do it, on the **Cards** menu, point to **Financial**, and then select **Account**. In the Account Maintenance window, type the account number in the **Account** field. In the **Posting Type** area, select **Profit and Loss**, and then select **Save**.

#### Method 2: The account is supposed to be a balance-sheet account

As a profit-and-loss account, this account won't have a beginning balance after the year-end closing process is completed. To change the account to a balance-sheet account and to create the beginning balance, follow these steps:

1. On the **Cards** menu, point to **Financial**, and then select **Account**. In the Account Maintenance window, type the account number in the **Account** field. In the **Posting Type** area, select **Balance Sheet**, and then select **Save**. Select **Balance Sheet** so that the correcting entry that you make in step 6 later in this section will correctly update the beginning balance for the current year.
2. Use one of the following methods, depending on whether you're using multicurrency or not:
   - If you're registered for Multicurrency Management in Microsoft Dynamics GP, follow these steps:
        1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **Multicurrency**.
        2. In the **Maintain History** area, select to clear the **General Ledger Account** check box.
   - If you aren't registered for Multicurrency Management, open SQL Server Management Studio and run the following statement against the company database:

        ```sql
        UPDATE MC40000 SET MNSUMHST = 0
        ```

3. Change the **Maintain History** settings in the General Ledger Setup window using these steps:
    1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **General Ledger**.
    2. In the **Maintain History** area, select to clear the **Accounts** check box and the **Transactions** check box.
4. In the **Allow** area, select the **Posting to History** check box, and then select **OK**.
5. Verify fiscal period is open so you can post to the prior year. To do it, follow these steps.
    1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
    2. In the Fiscal Periods Setup window, make sure that the Financial period for the recently closed year is open.
6. Enter a journal entry to create a beginning balance for the account. To do it, follow these steps:
    1. On the **Transactions** menu, point to **Financial**, and then select **General**.
    2. In the Transaction Entry window, enter a transaction that creates the correct beginning balance of the balance sheet account.
    3. In the **Transaction Date** field, enter a date that is in the closed fiscal year.

        For example, if the balance sheet account should have a debit beginning balance of $100.00, create a transaction that credits the kept earnings account for $100.00 and that debits the balance sheet account for $100.00.
    4. Select **Post**.

        > [!NOTE]
        > The transaction updates only the current year because the **Maintain History** settings aren't enabled.

7. Change the Maintain History settings in the General Ledger Setup window back to how they originally were. To do it, follow these steps:
    1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **General Ledger**.
    2. In the **Maintain History** area, select the **Accounts** check box and the **Transactions** check box.
    3. To post the transactions to the transaction history, select the **Posting to History** check box under **Allow**. If you don't want to post the transactions to the transaction history, select to clear this check box. Then, select **OK**.
8. Go back to the Fiscal Period setup and mark to close the Fiscal Period for the prior year again
9. Use one of the following methods to change the Multicurrency setting back to how it originally was, depending on whether you're using multicurrency or you aren't:
   - If you're registered for Multicurrency Management, follow these steps:
        1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then select **Multicurrency**.
        2. In the **Maintain History** area, select the **General Ledger Account** check box.
   - If you aren't registered for Multicurrency Management, open SQL Server Management Studio and run the following statement against the company database:

        ```sql
        UPDATE MC40000 SET MNSUMHST = 1
        ```
