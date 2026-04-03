---
title: Troubleshoot dimension value deletion errors
description: If you can't remove a financial dimension value in Dynamics 365 Finance, learn how to handle entity-backed dimensions, verify permissions, and manage referenced records to fix the issue.
ms.date: 04/02/2026
ms.reviewer: ethankallett, anaborges, jowalker, setharvila, moaamer, nedavis, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
---

# Can't delete a financial dimension value

## Summary

This article provides troubleshooting steps for issues that prevent you from deleting financial dimension values in Microsoft Dynamics 365 Finance. You might find that the delete option is disabled, or you receive an error message when you try to delete a dimension value or its backing entity record. Common causes include entity-backed dimensions that require deletion from a different page, insufficient permissions, dimension values that are used in transactions, and records that the dimension framework still references.

## Symptoms

You experience one or more of the following issues:

- The delete option is disabled on the **Financial dimension values** page.
- You receive an error mesage when you try to delete a financial dimension value or a record from the entity that backs a financial dimension.

## Delete entity-backed dimensions from the source entity page

You can't delete entity-backed dimensions from the **Financial dimension values** page. To resolve this issue, delete the value from the corresponding entity page instead.

For example, to delete a Department dimension value, go to the **Operating units** page, and delete it there.

For more information about entity-backed dimensions, see [Financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions#entity-backed-dimensions).

## Verify user permissions for dimension management

If you don't have the necessary roles or privileges to manage dimension values, the delete option might be disabled. This situation can occur if [Extensible Data Security (XDS) policies](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies) restrict access to the backing entity.

To resolve this issue, verify that an administrator who has full privileges can delete the dimension value. Contact your system administrator to request the necessary permissions.

## Rename or suspend dimension values used in transactions

If you save a dimension value to the dimension framework (for example, if you enter it in a ledger account or use it in a transaction), you can't delete it. For data integrity and auditing, financial dimensions are insert-only and immutable. The system blocks deletion even if you never posted or deleted the transactions.

To resolve this issue, rename or suspend the value instead. For detailed steps and best practices, see [Deleting financial dimension values](/dynamics365/finance/general-ledger/financial-dimensions#deleting-financial-dimension-values).

## Run the delete scan for referenced entity records

If you try to delete a record from the underlying entity, and the record is referenced as a financial dimension value, the system blocks the deletion. This behavior is by design. Financial dimensions are read-only after they're entered into the dimension framework. Therefore, you can't delete the backing entity record as long as the dimension value exists in the system.

You might receive an error message that resembles the following example:

> The \<EntityType> '\<EntityIdentifier>' is used in one or more transactions of the following types: \<TransactionType> and can't be deleted.

You might also see the following popup window when you try to delete the record.

:::image type="content" source="media/blocked-deleting-dimension-value/initial-popup.png" alt-text="Screenshot of the popup window that appears when you try to delete a record that's used as a financial dimension value.":::

You might also see a scan warning pop-up window that shows that a delete check is in progress.

:::image type="content" source="media/blocked-deleting-dimension-value/scan-popup.png" alt-text="Screenshot of the scan warning popup that shows a delete check is scheduled.":::

If the scan finds a reference, results that resemble the following example appear, and the deletion is blocked.

:::image type="content" source="media/blocked-deleting-dimension-value/scan-ui-with-record.png" alt-text="Screenshot of the scan results showing a reference that blocks the deletion.":::

To resolve this problem, let the delete scan run to completion for dimension types that support it (such as Bank, Project, Vendor, and Customer). Follow these guidelines:

- If the scan doesn't find any references, you can delete the backing record and its associated dimension value.
- If the scan finds references, it displays them so that you can take the necessary action before you retry.
- If the scan finds that the record is referenced as a dimension value and deletion is blocked, consider renaming or suspending the value, instead. For detailed steps and best practices, see [Deleting financial dimension values](/dynamics365/finance/general-ledger/financial-dimensions#deleting-financial-dimension-values).

## Related content

- [Financial dimension value is missing or unavailable](cant-find-dimension-value.md)
- [Financial dimension is missing or shows as a custom dimension](dimension-missing-details-page.md)
- [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures)
