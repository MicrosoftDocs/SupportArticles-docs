---
title: History removal options
description: Describes the history removal options in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# History removal options in Microsoft Dynamics GP

This article describes how the history removal options differ.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 849494

## Introduction

The following history removal options are available:

- Transaction history
- Distribution history
- Calendar year history or fiscal year history
- Journal history

## Transaction history

If you keep transaction history, detailed information is kept about all transactions that were posted and that were paid during the year.

If you remove transaction history, complete information isn't available to print the Historical Aged Trial Balance report or the posting journals. You can select ranges by voucher number, by document number, by document date, by document type, by vendor ID, or by vendor status.

To remove transaction history, use the Remove Payables Transaction History window. To do it, follow these steps:

1. Use the appropriate step:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Purchasing**, and then select **Remove Transaction History**.
   - In Microsoft Dynamics GP 9.0 or in earlier versions, point to **Utilities** on the **Tools** menu, point to **Purchasing**, and then select **Remove Transaction History**.
2. In the **Ranges** list, select the type of range that you want to select.

3. In the **From** box, type the starting date of the date range.

4. In the **To** box, type the ending date of the date range.

5. Select the **Transactions** check box.

6. If you also want to remove distribution history, select the **Distributions** check box. This option makes distribution removal more convenient. This option can be used to make sure that you aren't maintaining distribution history for transactions that no longer exist in the system.

7. Select **Process**.

## Distribution history

If you keep distribution history, a detailed record is kept of how Payables Management transactions affect the balances of the posting accounts. If you remove distribution history, you may not have all the information that is needed to reprint the posting journals in the future.

To remove distribution history only, use the Remove Payables Distribution History window. To do it, follow these steps:

1. Use the appropriate step:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, select **Purchasing**, and then select **Remove Distributions**.
   - In Microsoft Dynamics GP 9.0 or in earlier versions, point to **Utilities** on the **Tools** menu, point to **Purchasing**, and then select **Remove Distributions**.

2. In the **Ranges** list, select the type of range that you want to select.

3. In the **From** box, type the starting date of the date range.

4. In the **To** box, type the ending date of the date range.

5. Select the **Remove** check box, and then select **Process**.

When you remove distribution history, you won't remove the related transactions. When you remove distribution history in Payables Management in Microsoft Dynamics GP, the historical distribution records in General Ledger in Microsoft Dynamics GP aren't affected. Payables Management transaction history is maintained separately from General Ledger transaction history. This feature enables you to maintain distribution history for Payables Management whatever of whether you use General Ledger.

## Calendar year history or fiscal year history

If you keep calendar year history, vendor information is recorded in a month-by-month format. If you keep fiscal year history, the same information is recorded according to the fiscal period format that you specified in the Fiscal Periods Setup window.

To remove the calendar year history or the fiscal year history, use the Remove Payables Calendar/Fiscal History window. To do it, follow these steps:

1. Use the appropriate step:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, select **Purchasing**, and then select **Remove Period History**.
   - In Microsoft Dynamics GP 9.0, or in an earlier version, point to **Utilities** on the **Tools** menu, point to **Purchasing**, and then select **Remove Period History**.
2. In the **Ranges** list, select the type of range that you want to select.

3. In the **From** box, type the starting date that of the date range.

4. In the **To** box, type the date that you want the range to end.

5. Select the **Remove History** check box, and then select **Process**.

After history has been removed, you can't print the Calendar report or the Fiscal Year History report for the ranges of information that are removed.

## Journal History

If you keep distribution history, you can reprint posting journals for Payables Management transactions. Posting journals are valuable audit trail tools. Posting journals include audit trail codes that are assigned to transactions during the posting process. You can use posting journals to trace any transaction back to when it was entered.

After history has been removed, you can't reprint the journal history for the removed range of information. If you keep the transaction history and the distribution history for vendor records, or if you select the **Print Historical Aged Trial Balance** check box in the Payables Management Setup window, the transaction history and the distribution history aren't removed when you remove journal history. The batch itself is removed. So you can't reprint the posting journal. The transaction history and the distribution history will remain until the records are removed in the Remove Payables Transaction History window or in the Remove Payables Distribution History window.

To remove journal history, use the Remove Payables Journal History window. To do it, follow these steps:

1. Use the appropriate step:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, select **Purchasing**, and then select **Remove Journal History**.
   - In Microsoft Dynamics GP 9.0 or in earlier versions, point to **Utilities** on the **Tools** menu, point to **Purchasing**, and then select **Remove Journal History**.
2. In the **Ranges** list, select the type of range that you want to select.

3. In the **From** box, type the starting date of the date range.

4. In the **To** box, type the ending date of the date range.

5. Select the **Remove History** check box, and then select **Process**.
