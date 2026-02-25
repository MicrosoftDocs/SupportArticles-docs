---
# required metadata
title: Can't find the dimension value I'm looking for
description: Troubleshooting steps for locating missing or unavailable financial dimension values
author: ethanrimes
ms.date: 02/10/2026
---

# I can't find the dimension value I'm looking for

This article provides troubleshooting steps for locating missing or unavailable financial dimension values.

## You're working in the incorrect legal entity (company). 
If the dimension value is scoped to a specific legal entity (company) different from the one which you're working in, it may not be visible. This problem doesn't exist for shared values across entities. 

Resolution - Verify you're working in the correct legal entity where the dimension value was created.

## The user lacks the necessary security role. 
If your role doesn’t include access to the company or entity where the dimension value resides, it may appear blank or missing. This is especially common when XDS filters are applied to the backing entity, and the user doesn’t have permission to view it.

Resolution - Assign the appropriate security role.
    1. Go to **System administration** > **Users** > **Users**.
    2. Select the affected user.
    3. Select **Roles** > **Assign organizations**.
    4. Review the access scope and grant access to the required organizations. To test, select **Grant access to all organizations** and check whether the dimension value appears.

Resolution - Check if the issue is XDS-related, temporarily assign the **XDSDataAccessPolicyBypassRole** role to the user. If the dimension value appears, an XDS policy is blocking visibility.

### The dimension value is backed by a system entity and hasn't been used yet. 
Values for entity-backed dimensions aren't available in the dimension framework until used in an account or journal.

Resolution - Ensure the dimension value has been used in at least one account or journal entry.

### The dimension value exists but isn't synced properly with the dimension framework.

Resolution - Rename the dimension value to a temporary name, then rename it back to the original name. This triggers a sync with the dimension framework.

The rename process is handled by a background process in the Data Maintenance portal. To monitor progress, go to **System administration** > **Periodic tasks** > **Data maintenance**.
Check the status of the "Dimension value rename and modify chart of accounts delimiter process" job.
