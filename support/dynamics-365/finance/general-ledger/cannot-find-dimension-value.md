---
# required metadata
title: I cannot find the dimension value I'm looking for
description: Troubleshooting steps for locating missing or unavailable financial dimension values
author: ethanrimes
ms.date: 02/10/2026
---

# I cannot find the dimension value I'm looking for

This guide provides troubleshooting steps for locating missing or unavailable financial dimension values.

**Potential Cause 1:** You're working in the incorrect legal entity (company). If the dimension value is scoped to a specific legal entity (company) different from the one which you're working in, it may not be visible. This problem does not exist for "shared" values across entities. 

  - **Resolution:** Verify you're working in the correct legal entity where the dimension value was created.

**Potential Cause 2:** The user lacks the necessary security role. If your role doesn’t include access to the company or entity where the dimension value resides, it may appear blank or missing. This is especially common when XDS filters are applied to the backing entity, and the user doesn’t have permission to view it.

  - **Resolution:** To verify the cause is not an XDS issue, assign the **XDSDataAccessPolicyBypassRole** role to the user temporarily. If the dimension value appears, the issue is XDS-related. 
  - To verify the cause is not a security role issue, see if the admin user is able to see the missing value.

**Potential Cause 3:** The dimension value has not been used yet and is backed by a system entity. Values for entity-backed dimensions aren't available in the dimension framework until used in an account or journal.

  - **Resolution:** Ensure the dimension value has been used in at least one account or journal entry.

**Potential Cause 4:** The dimension value exists but isn't synced properly with the dimension framework.

  - **Resolution:** Rename the dimension value to a temporary name, then rename it back to the original name. This triggers a sync with the dimension framework.

  - The rename process is handled by a background process in the Data Maintenance portal. Monitor progress by going to **System administration** > **Periodic tasks** > **Data maintenance** and checking the status of the "Dimension value rename and modify chart of accounts delimiter process" job.
