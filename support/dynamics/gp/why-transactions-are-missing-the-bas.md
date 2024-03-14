---
title: Why transactions are missing from the BAS
description: Explains why transactions aren't displayed on the Business Activity Statement (BAS) for Australian Goods and Services Tax (GST) in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/13/2024
---
# Information about why transactions are missing from the Business Activity Statement (BAS) for Australian GST in Microsoft Dynamics GP

This article contains reasons why transactions aren't displayed on the Business Activity Statement (BAS) for Australian Goods and Services Tax (GST) in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 945198

## Introduction

The Business Activity Statement (BAS) is the tax return form that is used in Australia to report the Goods and Services Tax (GST) amounts to the Australian Taxation Office (ATO). The processing routine for the BAS report obtains data from the originating transaction's tax detail tables. The following reasons explain why a transaction isn't displayed on the BAS report.

## More information

1. The transaction doesn't fall into the selected date range for the date field being used. The BAS Report can use **Tax Date** (default), **Document Date** or **Posting Date** for the selection of transactions. The date is selected from the **Base Date Ranges on** field in the BAS Report Option Maintenance window. To open the BAS Report Option Maintenance window, on the **Reports** menu, point to **Company**, select **BAS Report**, and then select **Add** or **Modify**. The dates that will be used when the BAS report is next processed is displayed on the right side of the BAS Report Option Maintenance window.
2. The transaction has been voided. A voided transaction won't appear on the BAS report. A voided transaction is treated as if the transaction has never occurred. For audit trail purposes, you could enter a reversing transaction instead of voiding the transaction. Void only those transactions that haven't already been reported to the ATO on a previous BAS report.

    For more information about voiding transactions for Australian companies, see[How to void a transaction for an Australian company in Microsoft Dynamics GP](https://support.microsoft.com/help/933936).

3. The transaction has incorrect tax details in the Tax Expansion window. Because the BAS report uses the tax details that appear in the Tax Expansion window, you must make sure that the tax schedules and tax details are set correctly up for Australian GST. You can use the Australian GST Tax Information Setup Wizard to create the tax schedules and tax details needed. Then, assign them to the appropriate setup and master tables.

    For more information about the GST Tax Information Setup Wizard, see [944226](https://support.microsoft.com/help/944226) How to set up tax-free import creditors for Australian GST in Microsoft Dynamics GP  

4. Tax schedules aren't used correctly. For example, if you change an incorrect tax schedule ID when you change a Payables Management transaction or a Receivables Management transaction from a taxable transaction to a tax free transaction.

    For more information about how tax schedules work for the Australian GST in Microsoft Dynamics GP, see [How tax schedules work for the Australian GST in Microsoft Dynamics GP](https://support.microsoft.com/help/944222).

5. The tax details ID has the wrong BAS Assignment setting. If the correct tax detail ID appears in the Tax Expansion window for the transaction, but the transaction isn't displayed in the correct location on the BAS report, the tax detail may not have the correct BAS Assignment associated with it. Verify that the correct BAS Assignment appears for the tax detail ID in the Tax Detail Maintenance window. In the BAS Assignment field, use the CTRL key to select more than one item in the list. If you make changes to the BAS Assignment field, you can process the BAS Report Option again without changing any transactions to see the results of the change. To open the Tax Detail Maintenance window, follow one of these steps:

    - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Company**, and then select **Tax Details**.

    - In versions earlier than Microsoft Dynamics GP, on the **Tools** menu, point to **Setup**, point to **Company**, and then select **Tax Details**.

6. Tax details are excluded from the BAS Report Option. To provide support for multiple tax entities using a single company in Microsoft Dynamics GP, the BAS Report Option Maintenance window lets you select the tax detail IDs that should be included in a report. Select the tax details to verify that the tax details are excluded. To open the BAS Report Option Maintenance window, on the **Reports** menu, point to **Company**, select **BAS Report**, and then select **Add** or **Modify**.

7. The BAS Report Option is set to exclude processing. Verify that the **Do not perform Goods and Services Tax Processing** check box and the **Exclude History Transactions** check box aren't marked in the BAS Report Option Maintenance window. In addition, the transaction series for processing can be controlled. To do it, select **Transactions** to confirm that all modules are selected. To open the BAS Report Option Maintenance window, on the **Reports** menu, point to **Company**, select **BAS Report**, and then select **Add** or **Modify**.

8. A Purchasing series transaction is marked as **Tax Invoice Required**, but not marked as **Tax Invoice Received**. To claim a Purchasing series transaction as a tax credit from the ATO, you must have a valid tax invoice. Contact your accountant or the ATO for the requirements for a tax invoice. The tax detail ID used for purchases for which a tax credit can be claimed should be marked **Tax Invoice Required**. When the tax for a transaction is calculated, if any tax details associated with the transaction are marked as **Tax Invoice Required**. Then the transaction will be marked as T **ax Invoice Required**. If a transaction is marked as **Tax Invoice Required**, it can be marked as **Tax Invoice Received** during initial data entry or later by using the Track Tax Invoices Received window. The **Tax Date** will be changed when the **Tax Invoice** is marked as received, it could shift the transaction into a different reporting period. To open the Track Tax Invoices Received window, follow one of these steps:

    - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Purchasing**, and then select **Tax Invoice Received**.

    - In versions earlier than Microsoft Dynamics GP 10.0, on the **Tools** menu, point to **Routines**, point to **Purchasing**, and then select **Tax Invoice Received**.
    If you have creditors that always provide valid tax invoices, select the **Tax Invoice Received** check box in the Creditor Maintenance Options window. To open this window, on the **Cards** menu, point to **Purchasing**, select **Creditor**, and then select **Options**.

9. Transaction history wasn't kept. The BAS report obtains data from the tax details of the originating transactions, and these transactions may be present in both the Open tables and in the History tables. Microsoft Dynamics GP should be set up to maintain history.

    For more information about Maintain History options for BAS, see [How to specify Maintain History options for Business Activity Statement (BAS) and Pay As You Go (PAYG) reporting in the Australian version of Microsoft Dynamics GP 9.0](https://support.microsoft.com/help/929214).

10. Inconsistencies exist between the transaction and the tax detail data. Examples follow:

    - A Sales Order Processing transaction has an associated transaction in Receivables Management that is missing or voided.

    - A Purchase Order Processing transaction has an associated transaction in Payables Management that is missing or voided.
    - Transactions may not have been created correctly by add-in products or by an import of data. As an example, a Sales Order Processing transaction may contain summary tax detail records, but may be missing tax details for the individual line item for the transaction.

    - The tax detail information was manually edited incorrectly. For example, the **Tax Detail Taxable Amount** is more than the **Tax Detail Total Amount**, or the **Tax Detail Taxable Amount** is zero and the **Tax Detail Tax Amount** isn't zero.

Most data issues will be reported in the BAS Report Processing Error Log.

For more information about error codes and their descriptions, see [Description of Pay As You Go error messages and Business Activity Statement error messages in Microsoft Dynamics GP](https://support.microsoft.com/help/910984).

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
