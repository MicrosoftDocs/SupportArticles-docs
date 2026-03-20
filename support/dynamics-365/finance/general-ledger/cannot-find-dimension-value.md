---
# required metadata
title: Can't find the dimension value I'm looking for
description: Troubleshooting steps for locating missing or unavailable financial dimension values
author: ethanrimes
ms.date: 02/10/2026
---

# I can't find the dimension value I'm looking for

This article provides troubleshooting steps for locating missing or unavailable financial dimension values.

## Potencial cause 1: You're working in the incorrect legal entity (company). 
If the dimension value is scoped to a specific legal entity (company) different from the one which you're working in, it may not be visible. This problem doesn't exist for shared values across entities. 

**Resolution** - Verify you're working in the correct legal entity where the dimension value was created.

## Potencial cause 2: The user lacks the necessary security role.
If your role doesn’t include access to the company or entity where the dimension value resides, it may appear blank or missing. This is especially common when [Extensible Data Security (XDS) policies](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies) are applied to the backing entity, and the user doesn’t have permission to view it.

**Resolution 1** - Assign the appropriate security role.
    1. Go to **System administration** > **Users** > **Users**.
    2. Select the affected user.
    3. Select **Roles** > **Assign organizations**.
    4. Review the access scope and grant access to the required organizations. To test, select **Grant access to all organizations** and check whether the dimension value appears.

**Resolution 2** - Check if the issue is XDS-related. Temporarily assign the **XDSDataAccessPolicyBypassRole** role to the user. If the dimension value appears, an XDS policy is blocking visibility. For more information about XDS and the bypass role, see [Extensible data security policies](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies#bypassing-xds-policy).

### Potencial cause 3: The dimension value is backed by a system entity and hasn't been used yet. 
Values for entity-backed dimensions aren't available in the dimension framework until used in places like posting profiles or journals.

**Resolution** - Ensure the dimension value has been used at least once.

### Potencial cause 4: The dimension value exists but isn't synced properly with the dimension framework.

**Resolution** - Use the [Data Maintenance](/dynamics365/fin-ops-core/dev-itpro/sysadmin/datamaintenanceportal) portal to check the sync status. Navigate to **System administration** > **Periodic tasks** > **Data maintenance** and check the status of the **Dimension value rename and modify chart of accounts delimiter process** job under the **Misc** tab. If no errors are present, and the problem persists, re-run this job by selecting the blue **Run now** button.

### Potencial cause 5: A customization or extension changed the structure of a dimension's underlying view.

Financial dimensions rely on underlying views with a specific, fixed structure. If a partner solution or customization added extra fields to one of these views, the system silently rejects the dimension at startup. This can cause a dimension to disappear from the Dimension Details form, show as **\<Custom dimension\>** instead of its expected backing entity, or become unavailable for selection in account structures.

**Resolution** - The extra fields need to be removed from the affected view so its structure matches what the system expects. After deploying the fix, the dimension reappears automatically when the server restarts.

For guidance on reviewing and correcting customizations, refer to [Best practices for financial dimension customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors).
