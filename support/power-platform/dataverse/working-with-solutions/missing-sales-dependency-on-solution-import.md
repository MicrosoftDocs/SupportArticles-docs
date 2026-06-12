---
title: Resolve missing Sales dependencies on import in Power Apps
description: Resolve missing Sales dependency errors in Power Apps solution imports. Discover steps to activate features, install packages, and reimport successfully.
ms.date: 06/02/2026
ms.reviewer: swatim, rkothaari, v-shaywood
ms.custom: sap:Working with Solutions\Dependencies prevent a solution import
ai-usage: ai-assisted
---
# Missing Sales dependencies during solution import in Power Apps

## Summary

When you [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) into a target environment in Microsoft Power Apps, you might receive a missing dependency error that references Sales packages or components. This article helps you identify the missing Sales dependencies, install or update the related apps, align versions across environments, and reimport the solution.

## Symptoms

When you import a solution, you receive an error message about missing dependencies that are related to Sales packages or components. This message resembles one of the following messages:

> Import failed due to missing dependencies.

> Failed to resolve app information for `msdyn_SalesOpportunityResearch`.

> Missing dependencies due to version mismatch of `msdyn_SalesAgents`.

The error might report components such as:

- `msdyn_SalesAgents`
- `msdyn_DataQualityAgent`
- `msdyn_SalesOpportunityResearch`

## Cause

These dependency problems occur if a solution references apps or components that exist in the source environment but aren't provisioned in the target environment, or when versions don't match between environments.

Common causes include:

- You upgrade apps in the source environment but not in the target environment.
- First-party or managed solutions, such as Data Quality Agent or Sales Agents, are missing or outdated in the target environment.
- Unmanaged customizations from the source environment are missing in the target environment.

## Solution

To resolve the missing Sales dependencies, follow these steps:

1. **Install or update missing components during solution import.**

    If missing dependencies are detected during solution import, the **Missing dependencies** page opens and allows you to resolve dependencies without leaving the import flow.

    - If an **Install** or **Update** button appears next to the application, use it to install or update the application.
    - If the system offers the **Deploy Dependencies** option, select it to install or update all supported components.

    For more information, see [Missing dependencies during solution import](missing-dependency-on-solution-import.md#missing-dependencies-coming-from-a-first-party-dynamics-365-application).

1. **Manually check versions and dependencies.**

    In the target environment, verify the installed versions of the dependent apps:

    1. Go to the [Power Platform admin center](/power-platform/admin/admin-documentation) and select your environment.
    1. Select **Resources** > **Dynamics 365 Apps**.
    1. Check the installed versions of dependent apps.
    1. Install or update any missing apps to ensure the version is aligned with the source environment.

    Some features cannot be manually installed from the Power Platform admin center, such as:

    - Sales Insights
    - Sales Accelerator
    - AI Agents such as Sales Opportunity Analysis (Research) Agent and Sales Qualification Agent

    These features require proper entitlement-based licensing and are enabled through Microsoft-controlled provisioning, often via **Feature Management** in Dynamics 365 or auto-provisioning by backend services. If the missing dependency is from one of these features, you can:

    - Wait for the next scheduled deployment. Packages are updated on a bi-weekly deployment cycle.
    - [Contact Microsoft Support](/power-platform/admin/get-help-support) for assistance if the issue is urgent.

1. **Reimport the solution.**

    After the missing dependency is available or updated, reimport the solution.

## Related content

- [Environment version mismatch warning during solution import](version-mismatch-on-solution-import.md)

