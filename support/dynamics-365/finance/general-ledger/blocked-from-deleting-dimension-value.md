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

  **Resolution:** Delete the dimension value from the corresponding entity page. For example, to delete a Department dimension, go to the **Operating units** page.

**Potential Cause 2:** The user lacks sufficient roles or privileges to manage dimension values.

  **Resolution:** Verify that an administrator with full privileges can delete the dimension value. Contact your system administrator to request the necessary permissions.

## An error is preventing me

**Potential Cause:** The dimension value was saved to the dimension framework, indicating it was entered in a ledger account or used in a transaction. Financial dimensions are insert-only and immutable for data integrity and auditing purposes. The system blocks deletion even if transactions were never posted or have been deleted.

  **Resolution:** Choose one of the following options:

  - (Recommended) Rename the dimension value to indicate it shouldn't be used, such as **___DONOTUSE_DIMNAME** or **_DONOTUSE_** prefix.
  - Suspend the dimension value: Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**. Select the dimension, select **Dimension values**, select the value to suspend, select **Edit**, and mark it as suspended. This hides the value from view.
