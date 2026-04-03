---
title: Source entity isn't available in the "Use values from" dropdown
description: Fix issues where an expected source doesn't appear in the Use values from list on the Financial dimensions page in Microsoft Dynamics 365 Finance.
ms.date: 04/02/2026
ms.reviewer: ethankallett, nedavis, anaborges, jowalker, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
audience: Application User
ms.search.form: DimensionDetails
ms.search.region: Global
ms.search.validFrom: 2016-05-18
ms.dyn365.ops.version: AX 7.0.0
---

# Source entity isn't available in the "Use values from" dropdown

## Summary

When you set up [financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions) on the **Financial dimensions** page in Microsoft Dynamics 365 Finance, a source entity might not appear in the **Use values from** list. This article covers the most common reasons an expected source is missing and provides solutions for each scenario.

## Symptoms

When you create a financial dimension, a source that you expect to see doesn't appear in the **Use values from** dropdown.

## The source isn't in the predefined set

Only sources that are registered with the financial dimension framework appear in the **Use values from** list. The product ships with a predefined set of dimension-enabled sources that includes commonly used entities such as Customers, Vendors, Projects, Cost centers, and Departments. Sources outside this predefined set don't initially appear in the list.

### Solution

If the source isn't in the predefined set and needs to be included, an administrator must create the required customization and deploy it to the environment. For admin instructions, see [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After the customization is deployed and the database is synchronized, the new source should appear in the **Use values from** list.

## The source is only available in a demo model

Some dimension-enabled sources ship with demo models (such as the [Fleet Management sample application](/dynamics365/fin-ops-core/dev-itpro/dev-tools/fleet-management-sample)) that are deployed only to development environments. These entries intentionally don't appear in User Acceptance Testing (UAT) or production environments because the demo model isn't deployed there.

### Solution

No action is needed. If these values appear in a development environment but not in UAT or production, the environments are behaving as expected. Don't deploy demo models to non-development environments.

## A customization doesn't follow the required pattern

This might be the cause if the previous sections don't apply. The framework silently excludes customizations that don't meet all its requirements.

For guidance on building customizations correctly, see [Best practices for financial dimension customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors#dimattribute-views).

### Solution

Check that the code package containing the customization is fully deployed and the database is synchronized. Then have an administrator compare the customization to the requirements in [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After the customization is corrected and redeployed, the source should appear in the **Use values from** list.

## Related content

- [Financial dimension errors after restoring a database to another environment](dimensions-errors-after-database-restore.md)
- [Common dimension-related errors](common-dimension-related-errors.md)
