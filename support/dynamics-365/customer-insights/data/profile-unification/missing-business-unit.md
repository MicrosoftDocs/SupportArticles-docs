---
title: Missing Business Unit in Unification
description: Learn how to fix a missing business unit in Dynamics 365 Customer Insights - Data by adding units to Dataverse.
ms.date: 11/16/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Unification\Business Unit Data Separation
---
# Missing business unit in unification in Dynamics 365 Customer Insights - Data

## Summary

This article provides a resolution for an issue where the **Business unit** dropdown list is empty in the **Business unit separator** step in the data unification process.

## Symptoms

During the unification process, the **Business unit** field in the **Business unit separator** step doesn't show any value.

## Solution

Verify that the [business units are added to the Dataverse](/power-platform/admin/create-edit-business-units) environment that's linked to the Customer Insights - Data instance.

> [!NOTE]
> The test and production environments have different environment IDs and names.

For more information about business units, see [Business unit data separation overview](/dynamics365/customer-insights/data/business-units-data-separation).
