---
title: A fully applied document is in open status
description: Provides a solution to an issue where a fully applied document is still in open status in Payables Management.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 08/05/2024
ms.custom: sap:Financial - Payables Management
---
# A fully applied document is still in open status in Payables Management

This article provides a solution to an issue where a fully applied document is still in open status in Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3208146

## Symptoms

When reviewing the Aged Trial Balance report or Historical Aged Trial Balance (HATB) report in Payables Management, a document shows up as fully applied and is still in the open table. The document should be moved to history automatically.

## Cause

Fully applied document where the Amount Remaining is $0.00 should automatically move to history during the posting process. If it didn't, there's data corruption.

## Resolution

To solve the issue, follow these steps:

1. In Microsoft Dynamics GP, go to **Inquiry**, and select **Purchasing** > **Transaction By Vendor**. Clear the **WORK** and **HISTORY** checkboxes and select **Redisplay** to view only documents in an **OPEN** status.

    > [!NOTE]
    > Use the **View | Currency | Functional** to view the document in Functional Currency.

2. Select to expand the line, and review all open documents. Locate the problem document. If the **Unapplied Amount** is $0.00, it's fully applied (which is the **CURTRXAM** field in the `PM20000` table.)

3. Next, select/highlight the problem document and select the **Unapplied Amount** link to drill back to view the records applied against it. Verify that the total of the **Applied Amount** field for all the applied records adds up to the total amount of the document to verify that it's fully applied.

    If not, and there should be dollars left on it to apply to, then update the **CURTRXAM** field in the `PM20000` table for the amount that should still be unapplied on the document.

4. If the applied records match the total document amount and the document should be in history, you can go to Microsoft Dynamics GP, point to **Maintenance** and select **Check Links**. Select the **Purchasing series**. Insert over the Payables Transaction Logical File and select **OK**. Check links should move all document in the open table with an amount remaining of 0.00 to history.

    > [!IMPORTANT]
    > You can't undo a "check links" process, so ensure you have a current backup first. Or, perform the process in a test environment to review the changes and confirm your approval before applying it to your live database to avoid any surprises.

5. Review in Purchasing Inquiry to see if the document has now moved to history.

6. If not, then use the scripts below to locate the remittance records for it in the `PM20100` table, and delete these records. The `PM20100` remittance table is just a table that stores applied records solely for the purpose of printing them on the next check stub sent to the vendor (if you're printing previously applied documents). Once the records are printed, they're removed from this remittance table, or just built into this table if they aren't printed. This record might hold it up from moving to history, and it doesn't hurt anything to remove this record. Delete it from the `PM20100` remittance table once you've located it. Below are helpful scripts to use to locate it in this table.

    ```sql
    select * from PM20100 where VENDORID = 'xxx' and DOCDATE = '2017-04-12'
    --update the vendor ID and the document date for the problem document to help locate it.

    Delete PM20100 where DEX_ROW_ID = X
    --update the script for the dex row ID you with to remove.
    ```

7. After deleting the remittance document from the `PM20100` table, run "check links" again and it should move to history now. (See step 4.)

8. Review in Purchasing Inquiry again to verify the document has now moved to history.
