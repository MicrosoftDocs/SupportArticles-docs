---
# required metadata
title: I cannot find the dimension value I'm looking for
description: Troubleshooting steps for locating missing or unavailable financial dimension values
author: ethanrimes
ms.date: 02/10/2026
---

# I cannot find the dimension value I'm looking for

This guide provides troubleshooting steps for locating missing or unavailable financial dimension values.

**Potential Cause 1:** The dimension is scoped to a specific legal entity. Custom dimensions are shared across companies, but many entity-backed dimensions are company-specific.

  **Resolution:** Verify you're working in the correct legal entity where the dimension value was created.

**Potential Cause 2:** The user lacks the necessary security role. Extensible Data Security (XDS) policies may restrict access to the dimension value.

  **Resolution:** Assign the **XDSDataAccessPolicyBypassRole** role to the user temporarily. If the dimension value appears, the issue is XDS-related. Work with your administrator to adjust role permissions.

**Potential Cause 3:** The dimension is backed by a system entity. Values for entity-backed dimensions aren't available in the dimension framework until used in an account or journal.

  **Resolution:** Ensure the dimension value has been used in at least one account or journal entry.

**Potential Cause 4:** The dimension value you entered doesn't exist in the system.

  **Resolution:** Verify the dimension value exists by going to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions** and selecting **Dimension values**.

**Potential Cause 5:** The dimension value exists but isn't synced properly with the dimension framework.

  **Resolution:** Rename the entity to a temporary name, then rename it back to the original name. This triggers a sync with the dimension framework.

  The rename process is handled by a background process in the Data Maintenance portal. Monitor progress by going to **System administration** > **Periodic tasks** > **Data maintenance** and checking the status of the "Dimension value rename and modify chart of accounts delimiter process" job.
