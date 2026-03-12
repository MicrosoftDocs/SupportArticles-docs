---
# required metadata

title: Expected source is missing from the Use values from list on the Financial dimensions page
description: Learn about the reasons why an expected source doesn't appear in the Use values from list on the Financial dimensions page in Microsoft Dynamics 365 Finance, and how to resolve each scenario.
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

This article explains why an expected source might not appear in the **Use values from** dropdown on the **Financial dimensions** page in Microsoft Dynamics 365 Finance, and how to resolve each scenario.

## Symptoms

When you create a financial dimension, a source that you expect to see doesn't appear in the **Use values from** dropdown.

## Potential cause 1: The source isn't in the predefined set

Only sources that have been registered with the financial dimension framework appear in the **Use values from** list. The product ships with a predefined set of dimension-enabled sources, including commonly used entities such as Customers, Vendors, Projects, Cost centers, and Departments. Sources outside this predefined set don't appear in the list.

### Resolution

If the source isn't in the predefined set and it needs to be included, a developer must create the required customization and deploy it to the environment. For developer instructions, see [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After the customization is deployed and the database is synchronized, the new source should appear in the **Use values from** list.

## Potential cause 2: The source is only available in a demo model

Some dimension-enabled sources ship with demo models (such as the Fleet Management demo model) that are deployed only to development environments. These entries intentionally don't appear in UAT or production environments because the demo model isn't deployed there. This behavior is by design.

### Resolution

No action is required. If these values appear in a development environment but not in UAT or production, the environments are behaving as expected. Don't deploy demo models to non-development environments.

## Potential cause 3: A customization was made to add a new source, but it doesn't conform to the required pattern

This may be the cause if neither of the previous possible causes turned out to be the problem. The framework silently excludes customizations that don't meet all of its requirements.

For detail on common errors, see [Common errors in financial dimension framework customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization#dimattribute-view-schema-errors).

### Resolution

Verify that the code package containing the customization has been fully deployed and that the database has been synchronized. Then have a developer compare the customization against the step-by-step requirements in [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities).

After correcting and redeploying the customization, the source should appear in the **Use values from** list.
