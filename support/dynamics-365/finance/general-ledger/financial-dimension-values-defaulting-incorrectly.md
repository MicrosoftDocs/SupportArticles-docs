---
# required metadata

title: Financial dimension values are defaulting incorrectly in documents and transactions
description: Troubleshooting steps for when financial dimension values appear incorrect after being merged, saved, or posted in Dynamics 365 Finance
author: ethanrimes
ms.date: 03/01/2026

# optional metadata

audience: Application User
ms.reviewer: kfend
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions
ms.search.region: Global
ms.author: ethanrimes
ms.dyn365.ops.version: 10.0.0
---

# Financial dimension values are defaulting incorrectly in documents and transactions

This article helps you troubleshoot situations where financial dimension values appear incorrect after being merged, saved, or posted in Microsoft Dynamics 365 Finance. You may notice the problem only after posting, when you drill back into the original document or transaction.

## Symptoms

After completing a process such as posting a journal or source document, you notice that the financial dimension values on the resulting transaction don't match what you expected. The values may have appeared correct earlier in the process but changed by the time the transaction was finalized.

## Potential causes and resolutions

### Potential cause 1: Fixed dimensions are configured on the main account

Fixed dimensions are a setting on a main account that forces specific dimension values to be used on any transaction that posts to that account—regardless of what was entered on the document or journal line. This override happens at the moment of posting and can be surprising if you aren't aware the setting is enabled.

**Resolution:** Check whether fixed dimensions are set up on the main account involved in the transaction.

1. Go to **General ledger** > **Chart of accounts** > **Accounts** > **Main accounts**.
2. Open the main account used in the transaction.
3. Expand the **Legal entity overrides** FastTab.
4. Select the legal entity (company).
5. Select **Default dimension**.
6. In the **Default dimension** dialog, each financial dimension has a **Fixed** / **Not fixed** column. If a dimension is set to **Fixed**, its value is enforced at posting time and overrides values entered on documents, journals, and master data.


![](media/default-dimension-fixed-toggle.png)

7. Select **Save** and close the dialog.

If the fixed dimension is intentional but causing confusion, consider updating user guidance or training so team members are aware. If it was set unintentionally, an administrator can remove or update the value.

---

### Potential cause 2: A customization is changing dimension values during processing

If your Dynamics 365 Finance environment has custom code or extensions, those customizations may intentionally or unintentionally alter dimension values during document processing. The change can happen at any step in the workflow—entry, approval, or posting—making it difficult to trace.

**Resolution:** If you have ruled out fixed dimensions and the behavior doesn't occur in a standard demo environment, a customization is likely involved.

1. Test the same scenario in a standard demo data environment (such as **USMF**) without customizations. If the issue doesn't appear there, a customization in your environment is most likely the cause.
2. Contact your system administrator or the partner responsible for your Dynamics 365 customizations and ask them to review any custom code that touches financial dimensions during the affected process.
3. Ask whether any recent updates, deployments, or code changes were made before the issue started.

Your system administrator or partner will need to review the customization to determine whether the behavior is intentional or a defect.

---

### Potential cause 3: The document type is a correction, reversal, or relieving transaction

Certain document types—such as **Correction**, **Reversal**, and **Relieving** transactions—are designed to exactly undo a previously posted entry. To ensure the reversal precisely mirrors the original, the system intentionally reuses the dimension values from the original posted transaction rather than re-merging dimension defaults from the current setup.

This is expected behavior. If the system re-applied current dimension defaults on a reversal, the reversed entry might not balance correctly against the original, which could cause accounting problems.

**Resolution:** Verify that the document being created is a reversal or correction of a prior transaction.

1. Open the transaction and confirm whether it is a reversal, correction, or relieving document (this is often visible in the document header or transaction type field).
2. If it is, the dimension values shown are pulled from the original posted transaction—this is by design and ensures proper accounting integrity.
3. If you need different dimension values on the reversal, consider whether the correct approach is to post a new, separate adjusting entry rather than using the automatic reversal function.

If you believe the reversal is pulling incorrect original values, contact Microsoft Support, as this may indicate a data issue with the original transaction.
