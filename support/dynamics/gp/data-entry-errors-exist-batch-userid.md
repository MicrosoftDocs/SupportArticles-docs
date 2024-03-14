---
title: Data entry errors exist in batch UserID
description: Provides a solution to an error that occurs when you select Process in the Create Refund Checks window in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# "Data entry errors exist in batch RMPMXFR UserID" Error message when you select "Process" in the Create Refund Checks window in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you select **Process** in the Create Refund Checks window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933027

> [!IMPORTANT]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Symptoms

When you select **Process** in the Create Refund Checks window, and then you select **Transfer**, you may experience the following problems.

### Scenario 1

You receive the following error message:

> Data entry errors exist in batch RMPMXFR UserID. Use the Batch Recovery window to process this batch.

> [!NOTE]
> UserID is a placeholder for the logon name of the user who is processing the refund checks. This logon name is part of the batch name.

If the **Auto-open Print Payables Checks** check box is selected in the Refund Checks Setup window, this error message is displayed before the Print Payables Check window is displayed.

You select **OK** after you receive the error message. If you continue to print the check batch, you receive the following error message:

> Errors have been found in this check batch. Please correct the errors before printing.

> [!NOTE]
> If you have Multi-Dimensional Analysis (MDA) enabled for any of the GL accounts used in the Refund check, and if it has an MDA Analysis group set to Required, but no default MDA codes ID's are defined, the same error happens and it also creates a blank record in the PM20000 table.  After this occurs, the damaged record needs to be manually removed from the PM20000 table. The issue can be avoided by either designating a default MDA analysis code ID for the MDA account/analysis group set to 100%, or by setting the assigned MDA analysis group ID for the account to **Optional** instead of **Required**.

### Scenario 2

- You view the vendor transactions in the "Payables Transaction Inquiry - Vendor" window.
- You select the row for the vendor.
- You press the TAB key to move from a field.

In this scenario, you receive the following error message:

> The stored procedure createSQLTmpTable returned the following results: DBMS 2627, Microsoft Dynamics GP:0.

The "Payables Transaction Inquiry - Vendor" window contains the following two work documents that resulted from the processing of the refund check:

- The check payment for the refund
- A miscellaneous charge

> [!NOTE]
> You do not see any duplicate documents in the "Payables Transaction Inquiry - Vendor" window.

If you select to clear the **Work** check box and the **History** check box, and then you select **Redisplay**, another miscellaneous charge document appears. This document has a status of Open, and the duplicate error message isn't displayed. If you drill down on that open document, the miscellaneous charge doesn't have any amounts, and it appears to be damaged. This document doesn't appear if you select the following check boxes at the same time:

- **Work**  
- **Open**  
- **History**

## Cause

### Cause of scenario 1

This problem occurs if the posting of the miscellaneous charge in Payables Management in Microsoft Dynamics GP is interrupted for one of the following reasons:

- The accounts payable account isn't assigned in the Vendor Account Maintenance window, and the accounts payable account isn't assigned in the Posting Accounts Setup window.
- The company is registered for Account Level Security. Additionally, the user who is processing the refund checks doesn't have permission to use the designated accounts payable accounts in the Vendor Account Maintenance window or in the Posting Accounts Setup window.
- The fiscal period in which the refund occurs in Accounts Payable in Microsoft Dynamics GP is closed.
- The processing of the refund checks met a posting interruption or a network interruption.

### Cause or scenario 2

This problem occurs if the posting of a miscellaneous charge that the check is paying has been interrupted. The miscellaneous charge was partially posted without an amount, and the transaction remains in the batch.

## Resolution

### Resolution for scenario 1

To resolve this problem, determine the cause from the list of possible causes in Scenario 1 in the [Cause](#cause) section, and then correct the problem. To correct the problem, follow these steps:

1. Make sure that a default accounts payable account is set up for Purchasing in Microsoft Dynamics GP, and that the account is listed in the **Display** list in the Posting Accounts Setup window.
2. Make sure that the user has access to the accounts payable account in the Organizational Structure Mass Assignment window. To open the Organizational Structure Mass Assignment window, point to **System** on the **Cards** menu, and then select **Organizational Assignments**.
3. Make sure that the user has access to the Accounts Payable window by using regular security or advanced security.
4. Make sure that the fiscal period in which the document is posted has a status of Open in the Fiscal Periods Setup window in Purchasing. To open the Fiscal Periods Setup window, point to **Setup** on the **Tools** menu, point to **Company**, and then select **Fiscal Periods**.
5. Make the check batch available, and then make the RMPMXFR batch available. To do it, follow the steps in [KB - A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/help/850289).
6. If you experience the problems in Scenario 2, go to the resolution for Scenario 2.

### Resolution for scenario 2

To resolve this problem, follow these steps:

1. If you haven't already made the check batch available, make the check batch available. To do it, follow the steps in [KB - A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/help/850289).
2. After the documents are verified, remove the duplicate document.

    > [!NOTE]
    > If the document that has a status of Open is posted correctly, and the document that has a status of Work is not corrected, delete the batch to remove the duplicate document. If the document that has a status of Open is damaged, remove the document that has a status of Open, and then enable the document that has a status of Work to be posted. (If there are no amounts, or if the document date is 00/00/0000, the document may be damaged.) You can remove this document by using the following delete script in SQL Query Analyzer or by using the Support Administrator Console.

    ```sql
    Delete PM20000 where Dex_Row_ID = XX
    ```

    > [!NOTE]
    > XX is a placeholder for the Dex Row ID of the miscellaneous charge.
3. If you've to post the miscellaneous charge document, post the document.
4. After you recover the check batch, print the check batch, and then post the check batch. For more information, see [KB - A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/help/850289).

## More information

To use refund checks, note the following requirements:

- The Refund Checks feature must be registered, and you must have purchased both Accounts Payable and Accounts Receivable in Microsoft Dynamics GP.
- The Refund Checks Setup window must be configured.
- The vendor record must be created for the customer.
- The relationship between the customer and the vendor must be established in the Customer/Vendor Relationships window.

When refund checks are processed, Microsoft Dynamics GP assumes that the customer over-paid the invoice and is requesting that the company refund the excess cash payment. When you process the refund, a debit memo is created. The debit memo is applied to the excess cash payment. Then, a miscellaneous charge is created. The miscellaneous charge is immediately posted to the vendor. This miscellaneous charge document is selected for payment by using a check.
