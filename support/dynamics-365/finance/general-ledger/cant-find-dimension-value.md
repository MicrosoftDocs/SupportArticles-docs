---
title: Resolve Missing Dimension Values in Dynamics 365 Finance
description: Resolve missing financial dimension values in Dynamics 365 Finance caused by legal entity scope, security roles, XDS policies, or sync problems.
ms.date: 04/01/2026
ms.reviewer: ethankallett, anaborges, jowalker, setharvila, moaamer, nedavis, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
---

# Financial dimension value is missing or unavailable

## Summary

This article provides troubleshooting steps for issues where a financial dimension value is missing or unavailable in Microsoft Dynamics 365 Finance. A dimension value might not appear due to legal entity scope, insufficient security roles, [Extensible Data Security (XDS) policies](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies), sync problems with the dimension framework, or customizations that changed the dimension's underlying view structure.

If the dimension itself is missing from the **Financial Dimensions** details page or shows as **\<Custom dimension\>**, see [Financial dimension is missing or shows as a custom dimension](dimension-missing-details-page.md) for more detailed troubleshooting.

## Verify the legal entity context

If the dimension value is scoped to a specific legal entity, it's only visible when you work in that legal entity. This issue doesn't apply to values that are shared across entities.

To resolve this issue, verify that you're working in the legal entity where the dimension value was created.

## Check security role and XDS policy assignments

If your role doesn't include access to the company or entity where the dimension value resides, it might appear blank or missing. This issue is especially common when [Extensible Data Security (XDS) policies](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies) are applied to the backing entity.

To resolve this issue, assign the appropriate security role to the user:

1. Go to **System administration** > **Users** > **Users**.
1. Select the affected user.
1. Select **Roles** > **Assign organizations**.
1. Review the access scope, and grant access to the required organizations:
   1. To test, select **Grant access to all organizations**, and then check whether the dimension value appears.
   1. If the dimension value appears, remove **Grant access to all organizations** and assign only the specific organizations that the user needs.

If the dimension value is still missing, an XDS policy on the backing entity (such as Customers or Operating units) might be filtering out records. To check:

1. Temporarily assign the **XDSDataAccessPolicyBypassRole** role to the user.
1. If the dimension value appears, an XDS policy is blocking visibility. 

For more information about XDS and the bypass role, see [Extensible data security policies](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies#bypassing-xds-policy). If the dimension value is visible but you can't delete it, see [Can't delete a financial dimension value](blocked-deleting-dimension-value.md).

## Confirm the dimension value has been used

Values for entity-backed dimensions aren't available in the dimension framework until they're used in places like posting profiles or journals.

To resolve this issue, make sure the dimension value has been used at least once.

## Check the dimension framework sync status

The dimension value might exist but not be synced properly with the dimension framework.

To resolve this issue, use the [Data Maintenance](/dynamics365/fin-ops-core/dev-itpro/sysadmin/datamaintenanceportal) portal to check the sync status:

1. Go to **System administration** > **Periodic tasks** > **Data maintenance**.
1. Select the **Misc** tab.
1. Check the status of the **Dimension value rename and modify chart of accounts delimiter process** job.
1. If no errors are present and the problem persists, rerun this job by selecting the **Run now** button.

## Review customizations to the dimension's underlying view

Financial dimensions rely on underlying views with a specific, fixed structure. If a partner solution or customization added extra fields to one of these views, the system silently rejects the dimension at startup. This issue can cause a dimension to:

- Disappear from the **Dimension details** page.
- Show as **\<Custom dimension\>** instead of its expected backing entity.
- Become unavailable for selection in account structures.

To resolve this issue, remove the extra fields from the affected view so its structure matches what the system expects. After you deploy the fix, the dimension reappears automatically when the server restarts.

For more information about reviewing and correcting customizations, see [Best practices for financial dimension customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors).

## Related content

- [Financial dimensions overview](/dynamics365/finance/general-ledger/financial-dimensions)
- [Plan your chart of accounts](/dynamics365/finance/general-ledger/plan-chart-of-accounts)