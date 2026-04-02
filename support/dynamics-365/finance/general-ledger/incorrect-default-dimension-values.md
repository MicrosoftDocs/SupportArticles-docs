---
title: Incorrect Dimension Values After Document Posting in Dynamics 365 Finance
description: Financial dimension values not matching expected results after posting in Dynamics 365 Finance? Discover how to troubleshoot and resolve this issue step by step.
ms.date: 04/02/2026
ms.reviewer: ethankallett, kfend, anaborges, jowalker, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
audience: Application User
ms.search.region: Global
ms.dyn365.ops.version: 10.0.0
---

# Unexpected financial dimension values on transactions

## Summary

This article helps you troubleshoot financial dimension values that are incorrect after you merge, save, or post documents in Microsoft Dynamics 365 Finance. During transaction processing, the system assembles dimension values from multiple sources, including the journal header, master data records, ledger-level settings, and derived dimension rules. The system applies these sources in a specific priority order, so a higher-priority source can overwrite values from a lower-priority source. Additionally, fixed dimensions on a main account can override entered values at posting time, reversal or correction logic can reuse dimension values from a prior transaction, and custom code can alter values at any stage. You might not notice the problem until after posting, when you review the original document or transaction.

## Symptoms

After you complete a process like posting a journal or source document, the financial dimension values on the resulting transaction don't match what you expected. The values might have appeared correct earlier in the process but changed by the time the transaction was finalized.

## Check for fixed dimensions on the main account

Fixed dimensions are a setting on a main account that forces specific dimension values on any transaction that posts to that account, regardless of what you entered on the document or journal line. This override happens at the moment of posting.

To resolve this issue, check whether fixed dimensions are set up on the main account involved in the transaction. For detailed information about how fixed dimensions work and the order in which default dimension values are applied during posting, see [Financial dimensions and posting](/dynamics365/finance/general-ledger/default-dimensions).

## Check the source of default dimension values

The system merges financial dimension values from multiple sources during document and journal processing. If a higher-priority source provides a value for a dimension, it overwrites what you entered or expected from a lower-priority source. The following sources can contribute default dimension values:

- **Journal header**: Default dimensions set on the journal header apply to all lines in that journal unless a line-level value overrides them.
- **Master data**: Dimension values associated with records like customer accounts, vendor accounts, or workers are applied when you select those records on a transaction line.
- **Ledger or legal entity**: Default dimensions configured at the ledger level apply as a baseline across all transactions in that company.
- **Derived dimensions**: Rules that automatically populate one dimension value based on the value of another dimension. For example, selecting a specific department might automatically fill in a cost center. For more information, see [Financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions).

Check each source to identify which one supplies the unexpected value, and then correct it. For a comprehensive explanation of how default dimensions are applied and the order of priority, see [Financial dimensions and posting](/dynamics365/finance/general-ledger/default-dimensions).

## Check whether the document is a correction, reversal, or relieving transaction

Certain document types, like **Correction**, **Reversal**, and **Relieving** transactions, undo a previously posted entry. To make sure the reversal precisely mirrors the original, the system intentionally reuses the dimension values from the original posted transaction rather than remerging default dimension values from the current setup.

This behavior is by design. If the system reapplied current dimension default values on a reversal, the reversed entry might not balance correctly against the original, which could cause accounting problems.

To check:

1. Open the transaction and confirm whether it's a reversal, correction, or relieving document. You can often see this information in the document header or transaction type field.
1. If it is, the system pulls the dimension values from the original posted transaction to maintain accounting integrity.
1. If you need different dimension values on the reversal, consider posting a separate adjusting entry instead of using the automatic reversal function. For more information about reversal capabilities, see [Reverse journal posting](/dynamics365/finance/general-ledger/reverse-journal-posting).

For guidance on common issues with reversing transactions, including reasons a reversal might be blocked, see [Can't reverse a transaction](/troubleshoot/dynamics-365/finance/general-ledger/cant-reverse-transactions).

## Test in a standard environment to rule out customizations

If your Dynamics 365 Finance environment has custom code or extensions, those customizations might intentionally or unintentionally change dimension values during document processing. The change can happen at any step in the workflow (entry, approval, or posting), making it difficult to trace.

If you rule out fixed dimensions and the behavior doesn't occur in a standard demo environment, a customization is likely involved.

1. Test the same scenario in a standard demo data environment (like **USMF**) without customizations. If the issue doesn't appear there, a customization in your environment is likely the cause. For details on setting up a demo environment, see [Fleet Management sample application](/dynamics365/fin-ops-core/dev-itpro/dev-tools/fleet-management-sample).
1. Contact your system administrator or the partner responsible for your Dynamics 365 customizations. Ask them to review any custom code that touches financial dimensions during the affected process.
1. Check whether any recent updates, deployments, or code changes were made before the issue started.

## Related content

- [General journal processing](/dynamics365/finance/general-ledger/general-journal-processing)
- [Ledger account combinations](/dynamics365/fin-ops-core/dev-itpro/financial/LedgerAccountCombinations)
- [Financial dimension customization best practices](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors)
