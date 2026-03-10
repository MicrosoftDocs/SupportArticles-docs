---
# required metadata
title: I want to delete a dimension value but I am blocked
description: Troubleshooting steps for errors that prevent you from deleting financial dimension values
author: ethanrimes
ms.date: 02/10/2026
---

# I want to delete a dimension value but I am blocked

This guide provides troubleshooting steps for errors that prevent you from deleting financial dimension values.

## Deletion is disabled

**Potential Cause 1:** Entity-backed dimensions can't be deleted from the **Financial dimension values** page.

- **Resolution:** Delete the dimension value from the corresponding entity page. For example, to delete a Department dimension, go to the **Operating units** page.

**Potential Cause 2:** The user lacks sufficient roles or privileges to manage dimension values.

- **Resolution:** Verify that an administrator with full privileges can delete the dimension value. Contact your system administrator to request the necessary permissions.

## An error is preventing me

**Potential Cause:** The dimension value was saved to the dimension framework, indicating it was entered in a ledger account or used in a transaction. Financial dimensions are insert-only and immutable for data integrity and auditing purposes. The system blocks deletion even if transactions were never posted or have been deleted.

- **Resolution 1:** (Recommended) Rename the dimension value to indicate it shouldn't be used, such as **___DONOTUSE_DIMNAME** or **_DONOTUSE_** prefix.

- **Resolution 2:** Suspend the dimension value. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**. Select the dimension, select **Dimension values**, select the value to suspend, select **Edit**, and mark it as suspended. This hides the value from view.

Later, when a new dimension value is needed, you can rename and reuse the old dimension to the new desired value. Rather than deleting old values and creating new ones, this practice of reusing existing dimensions values is a best practice and should improve application performance.

## I can't delete a record from the underlying entity

**Potential Cause:** The record you're trying to delete is referenced as a financial dimension value. This is by design. Financial dimensions are read-only once they've been entered into the dimension framework, meaning the backing entity record can't be deleted as long as the dimension value exists in the system.

You may see an error formatted as:

> The *[Entity type]* '*[Entity identifier]*' is used in one or more transactions of the following types: *[Transaction usage category]* and cannot be deleted.

For example:

- `"The Customer 'CUST001' is used in one or more transactions of the following types: Ledger Budget Planning and cannot be deleted."`
- `"The Project 'ProjA-22' is used in one or more transactions of the following types: Budget, Budget Control and cannot be deleted."`
- `"The Item 'LCD_Television' is used in one or more transactions of the following types: Ledger and cannot be deleted."`

You might also see the following popup when attempting the deletion:

![Screenshot of the initial popup that appears when attempting to delete a record used as a financial dimension value.](media/cant-delete-record-used-as-financial-dimension-value/initialpopup.png)

Or a scan warning popup indicating that a delete check has been scheduled:

![Screenshot of the scan warning popup indicating a delete check is scheduled.](media/cant-delete-record-used-as-financial-dimension-value/ScanPopup.png)

If the scan completes and finds a reference, the following UI is shown, and the delete is blocked:

![Screenshot of the scan results UI showing a reference that blocks the deletion.](media/cant-delete-record-used-as-financial-dimension-value/ScanUIWithRecord.png)

- **Resolution 1:** (Recommended) For dimension types that support it (Bank, Project, Vendor, Customer, and similar), allow the delete scan to run to completion. If no references are found, the backing record and its associated dimension value are allowed to be deleted. If references are found, they're displayed so that you can take any necessary action before retrying.

- **Resolution 2:** If the scan finds that the record is referenced as a dimension value and deletion is blocked, rename the backing entity record to indicate it shouldn't be used. For example, you may add a **___DONOTUSE_** prefix. As is mentioned above, this value may be reused.

Later, when a new dimension value is needed, you can rename and reuse the old record and its dimension value. Rather than deleting old values and creating new ones, this practice of reusing existing dimension values is a best practice and should improve application performance.
