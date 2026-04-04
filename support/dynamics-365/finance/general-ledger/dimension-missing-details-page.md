---
title: Financial dimension missing from details page
description: Fix an issue in which a financial dimension disappears or appears as a custom dimension on the Financial Dimensions details page in Dynamics 365 Finance.
ms.date: 04/02/2026
ms.reviewer: ethankallett, anaborges, jowalker, setharvila, moaamer, nedavis, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
---

# Financial dimension is missing or incorrectly appears as a custom dimension on the Financial Dimensions details page

## Summary

This article provides troubleshooting steps for an issue in which a financial dimension is missing from the **Financial Dimensions** details page, appears incorrectly as a custom dimension, or can't be added to account structures or integration formats. This issue affects the dimension itself, not individual dimension values. If a specific dimension value is missing or unavailable, see [Financial dimension value is missing or unavailable](cant-find-dimension-value.md) instead.

## Symptoms

You experience one or more of the following symptoms:

- A dimension no longer appears on the **Financial Dimensions** details page.
- A dimension that was previously available is missing.
- A dimension that should be backed by a system entity (such as Department or Project) shows as a **\<Custom dimension>** instead.
- A dimension can't be added to an account structure even though other ones already use it.
- A dimension is missing from certain reports.  

## Review the DimAttribute view structure of customizations

Financial dimensions rely on underlying database views that must have an exact number of fields. If a partner solution, independent software vendor (ISV), or customization adds extra fields to one of these views, the system silently rejects the dimension when the server starts.

To fix the view structure, remove the extra fields from the affected view through a code deployment so that the view structure matches what the system expects. After you deploy the corrected code and the environment restarts, the dimension reappears automatically.

For guidance to review and correct customizations, see [Best practices for financial dimension customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors).

## Remove dimensions created from an demo model

If you set up dimensions by using the [FleetManagement demo project](/dynamics365/fin-ops-core/dev-itpro/dev-tools/introduction-fleet-management-sample) (for example, Branch, Region, or RentalLocation) in a development environment, those dimensions don't work in production. The FleetManagement demo model is available only in development environments. Therefore, it leaves behind dimension data that the system can't resolve.

To resolve this problem, remove the orphaned dimension data that the demo model left behind. The Fleet Management sample application is available only in development environments and shouldn't be used as a basis for production dimension configuration. Contact your system administrator or partner to clean up the FleetManagement-related dimension configuration.

## Related content

- [Can't delete a financial dimension value](blocked-deleting-dimension-value.md)
- [Financial dimensions overview](/dynamics365/finance/general-ledger/financial-dimensions)
- [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures)
