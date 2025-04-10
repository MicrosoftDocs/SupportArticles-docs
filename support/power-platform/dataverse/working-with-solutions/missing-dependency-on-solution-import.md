---
title: Missing dependencies during solution import in Power Apps
description: Works around an issue about missing dependencies that occurs when you import a solution in the target environment in Microsoft Power Apps.
ms.reviewer: matp
ms.date: 04/10/2025
author: swatimadhukargit
ms.author: swatim
ms.custom: sap:Working with Solutions\Dependencies prevent a solution import
---
# Missing dependencies error during solution import

This article provides a workaround for an issue about missing dependencies that occurs when you [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) in Microsoft Power Apps.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to import a solution in Power Apps, you receive an error message like the following one:

> Import failed due to missing dependencies.

You can't proceed with the solution import until the missing dependencies are resolved.

## Cause

The solution has dependencies on a component that exists in the source environment where the solution is deployed. However, the component doesn't exist in the target environment where the solution is imported.

This issue might occur when applications are upgraded to the latest version through Microsoft scheduled maintenance in the source environment, but they aren't upgraded in the target environment.

## Workaround

> [!IMPORTANT]
> The experience described here might not be available to the environments of all the regions yet.

To work around this issue, follow these steps:

1. Select the **Show dependencies** button to navigate to the **Missing dependencies** page.

    This page lists all missing components and categorizes them into **Applications**, **Managed Solutions**, and **Unmanaged Components**.

    > [!TIP]
    > Another method to find dependencies of components is to open the solution file, unzip it, and then open the *solution.xml* file. In the file, look for the `<MissingDependencies>` element that lists all missing dependencies.

2. Expand each section of dependencies and resolve the issue based on the type of dependencies described in the following sections. Once the missing dependencies are fixed, retry the import.

### Missing dependencies coming from a Dynamics 365 application

This issue occurs when the solution relies on components from Dynamics 365 applications that are missing or outdated in the target environment. You can find these dependencies in the **Applications** section of the **Missing dependencies** page. Each entry provides details about the missing application in the following format:

_<solution_name> (<solution_version>) from <application_name>_

Next to the application name, you'll find an **Install** or **Update** button that redirects you to the Power Platform admin center.

:::image type="content" source="media/missing-dependency-on-solution-import/missing-dependencies-applications-section.png" alt-text="Screenshot that shows the Applications section of the Missing dependencies page." lightbox="media/missing-dependency-on-solution-import/missing-dependencies-applications-section.png":::

 To resolve this issue:

- If the application isn't installed in the target environment:

  - System administrators can use the **Install** button, which redirects to the [application installation](/power-platform/admin/manage-apps#install-an-app) page in the Power Platform admin center. Choose and install the application.
  - Non-system administrators can use the **Copy Install Link** button to copy the application installation link and request their system administrator to install the application. Alternatively, a system administrator can directly go to the [application installation](/power-platform/admin/manage-apps#install-an-app) page to install the application in the Power Platform admin center.

- If the application is installed but outdated in the target environment:

  - System administrators can use the **Update** button to open the application update page in the Power Platform admin center.
  - Non-system administrators can use the **Copy Update Link** button to copy the application update link and request their system administrator to update the application.
  
### Missing dependencies coming from another managed solution

This issue occurs when the solution relies on components from another managed solution that's missing in the target environment. You can find these dependencies in the **Managed Solutions** section of the **Missing dependencies** page. Expanding the section provides additional details.

:::image type="content" source="media/missing-dependency-on-solution-import/missing-dependencies-managed-solutions-section.png" alt-text="Screenshot that shows the Managed Solutions section of the Missing dependencies page." lightbox="media/missing-dependency-on-solution-import/missing-dependencies-managed-solutions-section.png":::

To resolve this issue, import the same version of the solution that's installed in the source environment into the target environment.

### Missing dependencies on the "Active" solutions

This issue occurs when the solution relies on unmanaged customizations from the source environment that are missing in the target environment. You can find these dependencies in the **Unmanaged Components** section of the **Missing dependencies** page. Expanding the section provides additional details.

:::image type="content" source="media/missing-dependency-on-solution-import/missing-dependencies-unmanaged-components.png" alt-text="Screenshot that shows the Unmanaged Components section of the Missing dependencies page." lightbox="media/missing-dependency-on-solution-import/missing-dependencies-unmanaged-components.png":::

To resolve this issue, return to the source environment, include the missing components, export the solution again, and then import it into the target environment.
