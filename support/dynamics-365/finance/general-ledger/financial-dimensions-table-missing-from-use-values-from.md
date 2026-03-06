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

# Can't find a source entity in the 'Use values from' dropdown on the 'Financial dimensions' page

This article explains why a table might not appear in the **Use values from** dropdown on the **Financial dimension details** page in Microsoft Dynamics 365 Finance, and how to resolve each scenario.

## Symptoms

When you create a financial dimension at **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**, a table that you expect to see as a source of dimension values doesn't appear in the **Use values from** dropdown.

## Potential cause 1: The table isn't in the predefined set

The product ships with approximately 50 predefined dimension-enabled views. Only tables that have a corresponding `DimAttribute[TableName]` view registered with the dimension framework appear in the **Use values from** list. Tables without such a view don't appear in the list regardless of how they're set up.

### Resolution

A developer must create a `DimAttribute[TableName]` view and deploy it to the environment. For instructions, see [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After the view is deployed and the database is synchronized, clear the dimension caches by navigating to the **DimensionClearCacheScopes** menu item. To do this, take your current Dynamics 365 Finance URL, keep only the host (for example, `https://contoso.operations.dynamics.com`), and replace everything after the domain with `/?mi=DimensionClearCacheScopes` (for example, `https://contoso.operations.dynamics.com/?mi=DimensionClearCacheScopes`). Paste the resulting URL into your browser's address bar and press Enter. This forces the framework to detect the new view immediately without requiring a server restart.

## Potential cause 2: The table is part of the FleetManagement demo model

Three dimension-enabled tables — Branch, Region, and Rental Location — ship with the **FleetManagement** demo model, which is deployed only to development environments. These entries intentionally don't appear in UAT or production environments because the FleetManagement model isn't deployed there. This behavior is by design.

### Resolution

No action is required. If these values appear in a development environment but not in UAT or production, the environments are behaving as expected. Don't deploy the FleetManagement model to non-development environments.

## Potential cause 3: A custom DimAttribute view doesn't conform to the required pattern

If a custom `DimAttribute[TableName]` view was created by a developer or partner and still doesn't appear in the list, the view may not conform exactly to the pattern required by the dimension framework. The framework silently excludes views that don't meet all requirements.

Common reasons include:

- The view hasn't been deployed or synchronized to the current environment.
- The data source node on the view isn't named **BackingEntity**.
- The field names on the view aren't exactly **Key**, **Value**, and **Name**.
- The required indexes are missing, have duplicate names, or have incorrect **Allow Duplicates** settings.
- The **Configuration key** on the view doesn't match the configuration key of the backing table.
- The event subscriber method that registers the view with the dimension framework is absent, has an incorrect delegate name, or references the wrong view.
- Security privileges for the view haven't been added to the **SysServerAXBasicMaintain** security duty.

### Resolution

Verify that the code package containing the view has been fully deployed and that the database has been synchronized. Then compare the view's structure against the step-by-step requirements in [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After correcting and redeploying, clear the dimension caches using the same **DimensionClearCacheScopes** menu item described in the resolution for Cause 1.
