---
# required metadata
title: Can't delete a financial dimension
description: A consolidation of various troubleshooting topics related to problems deleting financial dimensions
author: ethanrimes
ms.date: 02/09/2026
---

# Can't delete a financial dimension

This guide provides troubleshooting steps for errors that prevent you from deleting financial dimension values, along with the proper mitigation steps to resolve each problem.

## 1. Deleting dimension value is disabled

**Potential Cause:** Entity-backed dimensions can't be deleted from the **Financial dimension values** page.

**Resolution:** Delete the dimension value from the corresponding entity page. For example, to delete a Department dimension, go to the **Operating units** page.

**Potential Cause:** The user lacks sufficient roles or privileges to manage dimension values.

**Resolution:** Verify that an administrator with full privileges can delete the dimension value. Contact your system administrator to request the necessary permissions.

## 2. Delete scan for main account fails with error

**Potential Cause:** The delete scanner fails because the DAT company doesn't have a chart of accounts configured. This error appears only in the Data Maintenance portal.

**Resolution:** Create a minimal chart of accounts for the DAT company.

1. Go to **General ledger** > **Chart of accounts** > **Charts of accounts** and create a new chart. Don't add any main accounts.
2. Go to **General ledger** > **Ledger setup** > **Ledger**.
3. In the **Chart of accounts** field, select the newly created chart and save.

## 3. Unable to remove account structure from ledger

**Potential Cause:** The account structure is used in multiple locations throughout the system.

**Resolution:** Instead of deleting the account structure, modify it by replacing its content with dummy values, then activate the structure. This approach avoids breaking references across the system.

## 4. Dimension value is missing

**Potential Cause:** The dimension is scoped to a specific legal entity. Custom dimensions are shared across companies, but many entity-backed dimensions are company-specific.

**Resolution:** Verify you're working in the correct legal entity where the dimension value was created.

**Potential Cause:** The user lacks the necessary security role. Extensible Data Security (XDS) policies may restrict access to the dimension value.

**Resolution:** Assign the **XDSDataAccessPolicyBypassRole** role to the user temporarily. If the dimension value appears, the issue is XDS-related. Work with your administrator to adjust role permissions.

**Potential Cause:** The dimension is backed by a system entity. Values for entity-backed dimensions aren't available in the dimension framework until used in an account or journal.

**Resolution:** Ensure the dimension value has been used in at least one account or journal entry.

## 5. Cannot delete a financial dimension

**Potential Cause:** The dimension or its values have been used in any transaction, posted or unposted. Financial dimensions are insert-only and immutable for data integrity and auditing purposes.

**Resolution:** Rename the dimension with a **_DONOTUSE_** prefix to indicate it shouldn't be used.

**Potential Cause:** The user lacks sufficient roles or privileges to manage dimensions.

**Resolution:** Verify that an administrator with full privileges can delete the dimension. Contact your system administrator to request the necessary permissions.

## 6. Record has been used as a dimension value and cannot be deleted

**Potential Cause:** The dimension value was saved to the dimension framework, indicating it was entered in a ledger account. The system blocks deletion even if transactions were never posted or have been deleted.

**Resolution:** Choose one of the following options:

- (Recommended) Rename the dimension value to indicate it shouldn't be used, such as **___DONOTUSE_DIMNAME**.
- Suspend the dimension value: Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**. Select the dimension, select **Dimension values**, select the value to suspend, select **Edit**, and mark it as suspended. This hides the value from view.

## 7. Dimension value does not exist

**Potential Cause:** The dimension value you entered doesn't exist in the system.

**Resolution:** Verify the dimension value exists by going to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions** and selecting **Dimension values**.

**Potential Cause:** The dimension value exists but isn't synced properly with the dimension framework.

**Resolution:** Rename the entity to a temporary name, then rename it back to the original name. This triggers a sync with the dimension framework.

The rename process is handled by a background process in the Data Maintenance portal. Monitor progress by going to **System administration** > **Periodic tasks** > **Data maintenance** and checking the status of the "Dimension value rename and modify chart of accounts delimiter process" job.