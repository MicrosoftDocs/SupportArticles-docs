---
title: Missing dependencies during solution import in Power Apps
description: Works around an issue about missing dependencies that occurs when you import a solution in the target environment in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 09/25/2023
author: swatimadhukargit
ms.author: swatim
---
# Missing dependencies error during solution import

This article provides a workaround for an issue about missing dependencies that occurs when you [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) in Microsoft Power Apps. You can't proceed with the solution import until the missing dependencies are resolved.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to import a solution in [Power Apps](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc), you receive an error message like the following one:

> Import failed due to missing dependencies.

## Cause

The solution has dependencies on a component that exists in the source environment where the solution is deployed. However, the component doesn't exist in the target environment where the solution is imported.

This issue might occur when applications are upgraded to the latest version through Microsoft scheduled maintenance in the source environment, but they aren't upgraded in the target environment.

## Workaround

To work around this issue, follow these steps:

1. Select the **Show dependencies** button to navigate to the **Missing dependencies** page.

    The **Missing dependencies** page lists all the components that are missing from the target environment. It also shows the solution or application from which the component dependencies are obtained.

2. Resolve this issue based on the different types of dependencies described in the following sections:

### Missing dependencies coming from a Dynamics 365 application

You can find these dependencies in the **Managed Solution** tab of the **Missing dependencies** page. To resolve this issue:

- If the application isn't installed in the target environment, [install the application](/power-platform/admin/manage-apps#install-an-app) from the Power Platform admin center.
- If the application is installed but has an outdated version, a link is provided next to the solution. This link will redirect you to the Power Platform admin center update page for the environment where you can update the application to resolve the issue.

  The following screenshot shows the link provided on the **Missing dependencies** page.  

  :::image type="content" source="media/missing-dependency-on-solution-import/missing-dependency.png" alt-text="Example of the application upgrade link for a component with missing dependencies." lightbox="media/missing-dependency-on-solution-import/missing-dependency.png":::

  Select the link to open the upgrade application page in the Power Platform admin center.

  :::image type="content" source="media/missing-dependency-on-solution-import/application-update.png" alt-text="Example of the upgrade application page in the Power Platform admin center." lightbox="media/missing-dependency-on-solution-import/application-update.png":::

### Missing dependencies coming from another managed solution

You can find these dependencies in the **Managed Solution** tab of the **Missing dependencies** page. To resolve this issue, import the same version of the solution that's installed in the source environment into the target environment.

### Missing dependencies on the "Active" solutions

You can find these dependencies in the **Objects** tab. This indicates that the dependency is from unmanaged customization in the source environment. To resolve this issue, return to the source environment, include the missing components, export the solution again, and then import it into the target environment.

> [!TIP]
> Another method to find dependencies of components is to open the solution file, unzip it, and then open the *solution.xml* file. In the *solution.xml* file, look for a `<MissingDependencies>` element. All the missing dependencies are listed within this node.
