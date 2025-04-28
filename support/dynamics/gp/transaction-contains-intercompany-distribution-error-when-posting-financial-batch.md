---
title: Transaction contains intercompany distributions error when posting financial batch
description: When posting a batch in General Ledger, this error message (Transaction contains intercompany distributions; mark as an IC transaction) is returned, but the customer does not have any intercompany relationships set up.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# "Transaction contains intercompany distributions; mark as an IC transaction" error when posting a financial batch in GL

This article provides a resolution for the issue that you can't post a batch in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2414963

## Symptoms

When posting a batch in General Ledger, the error message below is listed on the General Posting Journal or Batch Edit List, but the customer does not have any intercompany relationships set up.

> Transaction contains intercompany distributions; mark as an IC transaction.

## Cause

The transaction or distribution is marked as intercompany, but there are no intercompany relationships set up.

## Resolution

Follow these steps to resolve the issue:

1. Use the scripts below to help identify which transactions in the GL10000 Transaction Work table are incorrectly marked as intercompany. Open SQL Server Management Studio and copy these scripts into a query window. Execute against the company database.

    ```sql
    Select ICDISTS, ICTRX, * from GL10000 where BACHNUMB = 'XXX'
    ```

    > [!NOTE]
    > insert the batch number for the XXX placeholder

    ```sql
    select * from GL10000 where ICDISTS <> 0 or ICTRX <> 0
    ```

    ```sql
    select * from GL10001 where INTERID <> DB_NAME()
    ```

2. , you found using the scripts from the last step, update the fields as appropriate and test again:

    - If you find any transactions (ICTRX) or distributions (ICDISTS) marked with a value, you can update them to be `'0'` so they are not marked to be intercompany.
    - If you find any intercompany ID's (INTERID) incorrect, you can update them to be the correct database name. (To be valid, the database names listed need to match the INTERID column in the SY01500 Company Master table in the Dynamics database.)
