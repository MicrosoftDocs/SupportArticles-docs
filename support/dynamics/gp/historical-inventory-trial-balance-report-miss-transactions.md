---
title: Historical Inventory Trial Balance report is missing transactions in Microsoft Dynamics GP
description: Provides a solution to an issue where posted transactions are missing from the Historical Inventory Trial Balance report.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# The Historical Inventory Trial Balance report is missing transactions in Microsoft Dynamics GP

This article provides a solution to an issue where posted transactions are missing from the Historical Inventory Trial Balance report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2714780

## Symptoms

You print the Historical Inventory Trial Balance (HITB) report in Microsoft Dynamics GP and find that a posted transaction is missing from the report.

## Cause

The HITB report pulls from the SEE30303 table so if the transaction isn't in that table, it won't print on the report. There are various reasons why the  posted transaction wouldn't be in that table.

Here are some examples:

- The "HITB record" isn't in the SY01401 table.

    When the IV Reset is performed and finalized, a record is written to the SY01401 table that essentially activates HITB. Since this table is read when Microsoft Dynamics GP is started, you must verify that after the IV Reset is performed that all users have gotten out and then back into the application.

    Verify that this record exists by checking to make sure you have a record with a coDefaultType = 5597 in the SY01401 table. If the record doesn't exist, then the HITB IV Reset process will need to be run. See the More Information section of this article.

- The HITB Report isn't in the workstation's Dynamics.set file.

    Verify in the Dynamics.set file on each workstation that posts transactions related to inventory items that "HITB Report" - product ID of 5597 exists. If it does not, then add it. By default the Dynamics.set file is located in the installation folder. The path of the installation folder is C:\\Program Files\\Microsoft Dynamics\\GP.

- Enhanced Intrastat is installed and you're batch level posting Sales Order Processing (SOP) transactions.

    If Enhanced Intrastat is installed, you could be experiencing a bug that prevented the SEE30303 table from being updated by SOP transactions if they were posted in a batch and Enhanced Intrastat was enabled. This issue was fixed in Microsoft Dynamics GP 10.0 Service Pack 5 and Microsoft Dynamics GP 2010 Service Pack 1.

- The receipt in the Inventory Purchase Receipts (IV10200) table that is being consumed doesn't have the VCTNMTHD (valuation method) field populated.

    The SEE30303 table is populated based off activity that is occurring in the IV10201 (outflow) table. The IV10201 table will be written to whenever a quantity from a receipt in the IV10200 table is sold as long as the VCTNMTHD field in the IV10200 for the receipt that is being sold is something other than 0. Beginning with Microsoft Dynamics GP 9.0, this field should be populated with all new transactions (it was a new field on that version) so the only time it may be something other than the actual valuation method value is if IV Reconcile created the record, or if a third party was being used that populated it incorrectly. To find any purchase receipt layers that don't have the valuation method field populated, you can run the `SELECT * FROM IV10200 WHERE VCTNMTHD =0` statement in a SQL query tool:

    If results are returned those records will need to be evaluated to see why that field is not populated. We do not recommend using SQL to update that field.

- A third-party product is being used which does not utilize the posting logic of GP.

    If the third-party product uses its own posting routine and it affects item quantities or costs, then you will want to verify that they know about HITB and have taken updating the SEE30303 table into consideration in their code. You may need to get a new version of their product installed.

- The GP posting process experienced a deadlock that prevented the SEE30303 table from being written to.

    If this has occurred it is usually a sporadic thing where all tables except SEE30303 were updated and it was just 1 transaction from the batch. Code changes were made beginning with Microsoft Dynamics GP 10.0 Service Pack 5 and Microsoft Dynamics GP 2010 Service Pack 1 to limit these occurrences.

- Process server was being used to post transactions.

    There is a bug related to using Process Server as the SEE30303 table was not being populated when Process Server was used for posting. This was  corrected in Microsoft Dynamics GP 2010 Service Pack 2.

If the transaction is in the SEE30303 table, then verify that the IVIVINDX field is something other than 0. The IVIVINDX field is the General Ledger account index of the inventory account. A zero in this field would indicate no account was used and would prevent the transaction from appearing on the report.

## Resolution

There's no utility (for example, Reconcile, Check Links) that will add records to the HITB (SEE30303) table for you. A SQL insert statement would have to be written to put the correct record into the SEE30303 table.

If there are a large amount of records missing, you may want to consider removing the current contents of the SEE30303 table and running the HITB IV Reset process. Doing this will cause you to lose the ability to go back to a previous date and review your inventory information using HITB, as the table (and therefore report) would be starting over with beginning balances from the date the IV Reset is run.  However, if the current data is not correct, then this may be the best approach once the cause of the issue has been identified so that it can be avoided going forward.

If the IVIVINDX field in the SEE30303 for the record is 0, an update statement could be written and ran in SQL to update the field to the proper GL account index. Further reconciliation would need to be done to determine if a direct adjustment to GL would also need to be made.
