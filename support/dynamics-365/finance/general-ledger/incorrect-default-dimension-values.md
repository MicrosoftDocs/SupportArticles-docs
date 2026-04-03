---
title: Incorrect dimension values after document posting in Dynamics 365 Finance
description: If your financial dimension values aren't matching expected results after you post in Dynamics 365 Finance, discover how to troubleshoot and resolve this issue step by step.
ms.date: 04/02/2026
ms.reviewer: ethankallett, kfend, anaborges, jowalker, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
audience: Application User
ms.search.region: Global
ms.dyn365.ops.version: 10.0.0
---

# Unexpected financial dimension values on transactions

## Summary

This article helps you troubleshoot financial dimension values that are incorrect after you merge, save, or post documents in Microsoft Dynamics 365 Finance. During transaction processing, the system assembles dimension values from multiple sources, including the journal header, master data records, ledger-level settings, and derived dimension rules. The system applies these sources in a specific priority order. Therefore, a higher-priority source can overwrite values from a lower-priority source. Additionally, any of the following changes might occur:

- Fixed dimensions on a main account override entered values at posting time.
- Reversal or correction logic reuses dimension values from a previous transaction.
- Custom code alters values at any stage.

You might not notice the issue until you review the original document or transaction after you post.

## Symptoms

After you complete a process such as posting a journal or source document, the financial dimension values on the resulting transaction don't match what you expected. The values might appear correct earlier in the process but then change by the time the transaction is finalized.

## Check for fixed dimensions on the main account

Fixed dimensions are a setting on a main account that forces specific dimension values on any transaction that posts to that account, regardless of what you enter on the document or journal line. This override occurs at the moment of posting.

To resolve this issue, check whether fixed dimensions are set up on the main account that's involved in the transaction. For information about how fixed dimensions work and the order in which default dimension values are applied during posting, see [Financial dimensions and posting](/dynamics365/finance/general-ledger/default-dimensions).

## Check the source of default dimension values

The system merges financial dimension values from multiple sources during document and journal processing. If a higher-priority source provides a value for a dimension, it overwrites what you enter or expect from a lower-priority source. The following sources can contribute default dimension values:

- **Journal header**: Default dimensions set on the journal header apply to all lines in that journal unless a line-level value overrides them.
- **Master data**: Dimension values that are associated with records such as customer accounts, vendor accounts, or workers are applied when you select those records on a transaction line.
- **Ledger or legal entity**: Default dimensions that are configured at the ledger level apply as a baseline across all transactions in that company.
- **Derived dimensions**: Rules that automatically populate one dimension value are based on the value of another dimension. For example, selecting a specific department might automatically fill in a cost center. For more information, see [Financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions).

Check each source to identify which one supplies the unexpected value, and then correct the value. For a comprehensive explanation of how default dimensions are applied and the order of priority, see [Financial dimensions and posting](/dynamics365/finance/general-ledger/default-dimensions).

## Check whether the document is a correction, reversal, or relieving transaction

Certain document types, such as **Correction**, **Reversal**, and **Relieving** transactions, undo a previously posted entry. To make sure that the reversal precisely mirrors the original, the system intentionally reuses the dimension values from the original posted transaction instead of remerging default dimension values from the current setup.

This behavior is by design to avoid accounting problems. If the system reapplied current dimension default values on a reversal, the reversed entry might not balance correctly against the original.

To check:

1. Open the transaction, and verify whether it's a reversal, correction, or relieving document. You can often see this information in the document header or transaction type field.
1. If the transaction is one of these types, the system pulls the dimension values from the original posted transaction to maintain accounting integrity.
1. If you need different dimension values on the reversal, consider posting a separate adjusting entry instead of using the automatic reversal function. For more information about reversal capabilities, see [Reverse journal posting](/dynamics365/finance/general-ledger/reverse-journal-posting).

For guidance regarding common issues that involve reversing transactions, including the reasons that a reversal might be blocked, see [Can't reverse a transaction](/troubleshoot/dynamics-365/finance/general-ledger/cant-reverse-transactions).

## Test in a standard environment to rule out customizations

If your Dynamics 365 Finance environment has custom code or extensions, those customizations might intentionally or unintentionally change dimension values during document processing. The change can occur at any step in the workflow (entry, approval, or posting). Therefore, it can be difficult to trace the change.

If you rule out fixed dimensions, and the behavior doesn't occur in a standard demo environment, a customization is likely involved.

1. Test the same scenario in a standard demo data environment (such as **USMF**) without customizations. If the issue doesn't appear there, a customization in your environment is likely the cause. For information about how to set up a demo environment, see [Fleet Management sample application](/dynamics365/fin-ops-core/dev-itpro/dev-tools/fleet-management-sample).
1. Contact your system administrator or the partner responsible for your Dynamics 365 customizations. Ask them to review any custom code that touches financial dimensions during the affected process.
1. Check whether any recent updates, deployments, or code changes were made before the issue began.

## Related content

- [General journal processing](/dynamics365/finance/general-ledger/general-journal-processing)
- [Ledger account combinations](/dynamics365/fin-ops-core/dev-itpro/financial/LedgerAccountCombinations)
- [Financial dimension customization best practices](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors)
