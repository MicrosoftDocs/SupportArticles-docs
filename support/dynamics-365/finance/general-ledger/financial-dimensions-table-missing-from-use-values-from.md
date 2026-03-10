---
# required metadata

title: Can't find a table in the Use values from list on the Financial dimensions page
description: Learn about the reasons why a table doesn't appear in the Use values from list on the Financial dimensions page in Microsoft Dynamics 365 Finance, and how to resolve each scenario.
author: ethanrimes
ms.date: 03/03/2026

# optional metadata

ms.search.form: DimensionDetails
audience: Application User
ms.reviewer: twheeloc
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions
ms.search.region: Global
ms.author: ethanrimes
ms.search.validFrom: 2016-05-18
ms.dyn365.ops.version: AX 7.0.0
---

# Can't create entity-backed dimension - Source entity is not available in 'Use values from' dropdown

This article explains why a source entity might not appear in the **Use values from** dropdown on the **Financial dimension details** page in Microsoft Dynamics 365 Finance, and how to resolve each scenario.

## Symptoms

When you create a financial dimension at **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**, a source that you expect to see as a source of dimension values doesn't appear in the **Use values from** dropdown.

## Potential cause 1: The table isn't in the predefined set

Only tables that have a corresponding `DimAttribute[TableName]` view registered with the dimension framework appear in the **Use values from** list. The product ships with a predefined set of dimension-enabled views, including commonly used entities such as Customers, Vendors, Projects, Cost centers, and Departments. Tables outside this set don't appear in the list regardless of how they're set up.

### Resolution

If the source entity isn't in the predefined set and it needs to be included, a developer must create a `DimAttribute[TableName]` view and deploy it to the environment. For instructions, see [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After the view is deployed and the database is synchronized, clear the dimension caches by navigating to the **DimensionClearCacheScopes** menu item. To do this, take your current Dynamics 365 Finance URL, keep only the host (for example, `https://contoso.operations.dynamics.com`), and replace everything after the domain with `/?mi=DimensionClearCacheScopes` (for example, `https://contoso.operations.dynamics.com/?mi=DimensionClearCacheScopes`). Paste the resulting URL into your browser's address bar and press Enter. This forces the framework to detect the new view immediately without requiring a server restart.

## Potential cause 2: The source entity is only available in a demo model

Some dimension-enabled tables ship with demo models (such as the FleetManagement demo model) that are deployed only to development environments. These entries intentionally don't appear in UAT or production environments because the demo model isn't deployed there. This behavior is by design.

### Resolution

No action is required. If these values appear in a development environment but not in UAT or production, the environments are behaving as expected. Don't deploy demo models to non-development environments.

## Potential cause 3: A custom source entity was used, but its underlying developer-made representation (DimAttribute view) in the data doesn't conform to the required pattern.

This may be the the cause of the problem if neither of the former possible causes turned out to be the problem. The framework silently excludes views that don't meet all requirements.

For detail on common schema errors, see [common errors in financial dimension framework customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization#dimattribute-view-schema-errors).

### Resolution

Verify that the code package containing the view has been fully deployed and that the database has been synchronized. Then compare the view's structure against the step-by-step requirements in [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After correcting and redeploying, clear the dimension caches using the same **DimensionClearCacheScopes** menu item described in the resolution for Cause 1.
