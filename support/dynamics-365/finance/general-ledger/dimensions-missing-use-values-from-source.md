---
title: Financial dimension source not in use values from
description: If the financial dimensions source is missing from the "Use values from" list in Dynamics 365 Finance, learn how to resolve registration gaps, demo model conflicts, and customization errors.
ms.date: 04/02/2026
ms.reviewer: ethankallett, nedavis, anaborges, jowalker, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
audience: Application User
ms.search.form: DimensionDetails
ms.search.region: Global
ms.search.validFrom: 2016-05-18
ms.dyn365.ops.version: AX 7.0.0
---

# Source entity isn't available in the "Use values from" list

## Summary

When you set up [financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions) on the **Financial dimensions** page in Microsoft Dynamics 365 Finance, an expected source entity doesn't appear in the **Use values from** list. This article covers the most common reasons an expected source is missing, and provides solutions for each scenario.

## Symptoms

When you create a financial dimension, a source that you expect to see in the **Use values from** list doesn't appear on the list.

## The source isn't in the predefined set

Only sources that the financial dimension framework registers appear in the **Use values from** list. The product ships by having a predefined set of dimension-enabled sources. This set includes commonly used entities such as Customers, Vendors, Projects, Cost centers, and Departments. Sources outside this predefined set don't initially appear in the list.

### Solution

If the source isn't in the predefined set but has to be included, an administrator must create the required customization, and then deploy it to the environment. For admin instructions, see [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After you deploy the customization and synchronize the database, the new source should appear in the **Use values from** list.

## The source is available only in a demo model

Some dimension-enabled sources ship together with demo models, such as the [Fleet Management sample application](/dynamics365/fin-ops-core/dev-itpro/dev-tools/fleet-management-sample), that you deploy to only development environments. By design, these entries don't appear in User Acceptance Testing (UAT) or production environments because the demo model isn't deployed there.

### Solution

No user action is needed. If these values appear in a development environment but not in UAT or production, the environments are behaving as expected. We recommend that you don't deploy demo models to nondevelopment environments.

## A customization doesn't follow the required pattern

If the previous sections don't apply to your situation, the problem might occur because the framework silently excludes customizations that don't meet all its requirements.

For guidance to build customizations correctly, see [Best practices for financial dimension customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors#dimattribute-views).

### Solution

Check whether the code package that contains the customization is fully deployed, and that the database is synchronized. Then, have an admin compare the customization to the requirements that are discussed in [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After you correct and redeploy the customization, the source should appear in the **Use values from** list.

## Related content

- [Financial dimension errors after restoring a database to another environment](dimensions-errors-after-database-restore.md)
- [Common dimension-related errors](common-dimension-related-errors.md)
