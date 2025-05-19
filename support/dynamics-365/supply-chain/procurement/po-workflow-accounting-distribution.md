---
title: Accounting Distribution Validation Failed Error
description: Solves an issue where you can't submit a purchase order for approval after it's updated.
ms.reviewer: shubhamshr
ms.date: 05/19/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---
# Workflow approval fails with the "Accounting distribution validation failed" error

This article addresses an issue where the workflow approval process for a purchase order fails due to unvalidated accounting distributions. The error occurs when the purchase order is modified and resubmitted without the validating accounting distributions, causing the workflow process to stop.

## Symptoms

After [setting a purchase order back to "Draft"](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation#changing-purchase-orders) and modifying the line items (for example, changing the unit price or the confirmed receipt date), when you submit the purchase order for approval, the workflow approval process fails with the following error:

> Stopped (error): Accounting distribution validation failed. Please recall purchase order workflow and rectify accounting distributions. This action can only be completed after the line number 1 is fully distributed.

### Steps to reproduce

1. Create and approve a purchase order for a vendor with change management enabled.
2. Confirm the purchase order.
3. Request a change to revert the purchase order to "Draft" status.
4. Modify the line items, for example, changing the unit price or the confirmed receipt date.
5. Resubmit the purchase order for workflow approval without first saving the line items.
6. Observe that the workflow approval fails with the error.

## Cause

When the **Auto calculate totals and accounting distributions** feature is enabled, the system automatically recalculates the purchase order totals and accounting distributions when a purchase order is submitted to the workflow. This recalculation is part of the workflow validation process, and any validation errors are displayed in the workflow history. For more information about the feature, see [Procurement and sourcing feature updates](/dynamics365/release-plan/2023wave2/finance-supply-chain/dynamics365-supply-chain-management/procurement-sourcing-feature-state-updates-10036#features-becoming-generally-available-with-the-10036-release).

If accounting distribution errors occur, such as missing financial dimensions or invalid combinations, the system generates a warning or error and prevents the workflow submission until the issue is resolved.

## Workaround

To avoid workflow failures due to unvalidated accounting distributions, you can disable the auto calculation feature. This action ensures that errors in accounting distributions are identified and resolved before the workflow submission.

1. Navigate to **Accounts Payable** > **Setup** > **Parameters**.
2. Select the **General** tab.
3. Locate the **Purchase Order Workflow** section.
4. Disable the **Auto calculate totals and accounting distributions** parameter.
5. Save your changes.

By disabling this parameter, the system prevents you from submitting a purchase order to the workflow if there are accounting distribution errors. Instead, it displays a warning, requiring you to fix the distribution errors first. Once the errors are resolved, you can submit the purchase order to the workflow, and it will proceed without issues.

## Additional considerations

If disabling the **Auto calculate totals and accounting distributions** parameter is unacceptable to your organization, ensure that all accounting distribution errors are resolved before submitting the purchase order to the workflow.

- Ensure that all required financial dimensions are correctly assigned to the accounting distributions.
- After modifying the purchase order line items, make sure to manually save the changes.

## More information

[Approve and confirm purchase orders](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation)
