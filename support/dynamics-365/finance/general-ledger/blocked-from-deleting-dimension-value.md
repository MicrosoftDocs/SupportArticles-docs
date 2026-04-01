---
title: Can't delete a financial dimension value in Dynamics 365 Finance
description: Troubleshoot errors that prevent you from deleting financial dimension values in Microsoft Dynamics 365 Finance.
ms.date: 04/01/2026
ms.reviewer: ethankallett, anaborges, jowalker, setharvila, moaamer, nedavis, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
---

# Can't delete a financial dimension value

## Summary

This article provides troubleshooting steps for issues that prevent you from deleting financial dimension values in Microsoft Dynamics 365 Finance.

## Symptoms

You experience one or more of the following issues:

- The delete option is disabled on the **Financial dimension values** page.
- You receive an error when you try to delete a financial dimension value or a record from the entity that backs a financial dimension.

## Is the dimension entity-backed?

Entity-backed dimensions can't be deleted from the **Financial dimension values** page. To resolve this issue, delete the value from the corresponding entity page instead. For more information about entity-backed dimensions, see [Financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions).

For example, to delete a Department dimension value, go to the **Operating units** page and delete it there.

## Does the user have sufficient permissions?

If you don't have the necessary roles or privileges to manage dimension values, the delete option might be disabled. This situation can happen when [Extensible Data Security (XDS) policies](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies) restrict access to the backing entity.

To resolve this issue, verify that an administrator with full privileges can delete the dimension value. Contact your system administrator to request the necessary permissions. If the dimension value isn't visible at all, see [Financial dimension value is missing or unavailable](cannot-find-dimension-value.md) for additional troubleshooting steps related to security roles and XDS.

## Was the dimension value used in a transaction?

If the dimension value was saved to the dimension framework (for example, it was entered in a ledger account or used in a transaction), you can't delete it. Financial dimensions are insert-only and immutable for data integrity and auditing purposes. The system blocks deletion even if transactions were never posted or have been deleted.

To resolve this issue, rename or suspend the value instead. For detailed steps and best practices, see [Deleting financial dimension values](/dynamics365/finance/general-ledger/financial-dimensions#deleting-financial-dimension-values).

## Is an entity-backed record referenced as a dimension value?

If you're trying to delete a record from the underlying entity and the record is referenced as a financial dimension value, the system blocks the deletion. This behavior is by design. Financial dimensions are read-only once they're entered into the dimension framework, so the backing entity record can't be deleted as long as the dimension value exists in the system.

You might see an error formatted as:

> The *[Entity type]* '*[Entity identifier]*' is used in one or more transactions of the following types: *[Transaction usage category]* and can't be deleted.

For example:

- `The Customer 'CUST001' is used in one or more transactions of the following types: Ledger Budget Planning and can't be deleted.`
- `The Project 'ProjA-22' is used in one or more transactions of the following types: Budget, Budget Control and can't be deleted.`
- `The Item 'LCD_Television' is used in one or more transactions of the following types: Ledger and can't be deleted.`

You might also see the following popup when you try to delete the record:

:::image type="content" source="media/blocked-from-deleting-dimension-value/initial-popup.png" alt-text="Screenshot of the popup that appears when you try to delete a record used as a financial dimension value.":::

Or a scan warning popup that shows a delete check has been scheduled:

:::image type="content" source="media/blocked-from-deleting-dimension-value/scan-popup.png" alt-text="Screenshot of the scan warning popup that shows a delete check is scheduled.":::

If the scan completes and finds a reference, the following results appear and the delete is blocked:

:::image type="content" source="media/blocked-from-deleting-dimension-value/scan-ui-with-record.png" alt-text="Screenshot of the scan results showing a reference that blocks the deletion.":::

### Solution

For dimension types that support it (such as Bank, Project, Vendor, and Customer), let the delete scan run to completion:

- If no references are found, you can delete the backing record and its associated dimension value.
- If references are found, they're displayed so that you can take the necessary action before retrying.

If the scan finds that the record is referenced as a dimension value and deletion is blocked, consider renaming or suspending the value instead. For detailed steps and best practices, see [Deleting financial dimension values](/dynamics365/finance/general-ledger/financial-dimensions#deleting-financial-dimension-values).

## Related content

- [Financial dimension value is missing or unavailable](cannot-find-dimension-value.md)
- [Financial dimension is missing or shows as a custom dimension](financial-dimension-missing-details.md)
- [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures)
