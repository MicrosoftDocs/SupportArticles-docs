---
title: Missing Dependencies During Solution Import in Power Apps
description: Works around an issue about missing dependencies that occurs when you import a solution in the target environment in Microsoft Power Apps.
ms.reviewer: 
  - swatim
  - matp
  - v-shaywood
  - rkothaari
  - cdietric
ms.date: 08/28/2025
ms.custom: sap:Working with Solutions\Dependencies prevent a solution import
---
# Missing dependencies error during solution import

This article provides workarounds for a missing dependencies issue that occurs when you [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) in Microsoft Power Apps.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to import a solution in Power Apps, you receive an error message that resembles the following message:

> Import failed due to missing dependencies.

In this situation, you can't continue the solution import until the missing dependencies issue is resolved.

## Cause

The solution is dependent on a component that exists in the source environment where the solution is deployed. However, the component doesn't exist in the target environment that the solution is imported into.

This issue might occur if applications are upgraded to their latest version (through Microsoft scheduled maintenance) in the source environment but not in the target environment.

## Workaround 1: Resolve missing dependency errors

To work around this issue, follow these steps:

1. Navigate to the **Missing dependencies** page by selecting the **Show dependencies** button. This page lists all missing components, and sorts them into the following categories:

    - **Applications**
    - **Managed Solutions**
    - **Unmanaged Components**
       >
   > [!TIP]
   > Another method to find dependencies of components is to open the solution file, expand it, and then open the *solution.xml* file. In this file, look for the `<MissingDependencies>` element that lists all missing dependencies.

2. Expand each section of dependencies, and mitigate the issue based on the type of dependencies that are described in the following sections. After the missing dependencies are restored or updated, retry the import.

### Missing dependencies coming from a Dynamics 365 application

This issue occurs if the solution relies on components from Dynamics 365 applications that are missing or outdated in the target environment. You can find these dependencies in the **Applications** section of the **Missing dependencies** page. Each entry provides details about the missing application in the following format:

_<solution_name> (<solution_version>) from <application_name>_

Next to the application name is an **Install** or **Update** button that redirects you to the Power Platform admin center.

:::image type="content" source="media/missing-dependency-on-solution-import/missing-dependencies-applications-section.png" alt-text="The Applications section of the Missing dependencies page lists applications that are missing or outdated." lightbox="media/missing-dependency-on-solution-import/missing-dependencies-applications-section.png":::

To work around this issue, use one of the following methods:

- If the application isn't installed in the target environment:

  - System administrators can use the **Install** button to be redirected to the [application installation](/power-platform/admin/manage-apps#install-an-app) page in the Power Platform admin center. Alternatively, a system administrator can directly go to the [application installation](/power-platform/admin/manage-apps#install-an-app) page to install the application in the Power Platform admin center.
  - Non-system administrators can use the **Copy Install Link** button to copy the application installation link and ask their system administrator to install the application. 

- If the application is installed but outdated in the target environment:

  - System administrators can use the **Update** button to open the application update page in the Power Platform admin center.
  - Non-system administrators can use the **Copy Update Link** button to copy the application update link and ask their system administrator to update the application.

### Missing dependencies coming from a first-party Dynamics 365 application

> [!IMPORTANT]
> This experience might not be available yet in the environments of all regions.

A solution might depend on only components from first-party Dynamics 365 applications that are missing or outdated in the target environment. In this situation, the system might be able to automatically update or install these components, and no manual action is required from the user. The **Missing dependencies** page displays the **Deploy Dependencies** option. If you select this option, and then you select the **Import** button, the system first installs or updates the required dependencies, and then imports the solution. If the update or installation of a dependent application fails, the solution import also fails. You can track the status of these updates or installations on the solution history page.

:::image type="content" source="media/missing-dependency-on-solution-import/missing-dependencies-first-party-application.png" alt-text="The Applications section of the Missing dependencies page showing a first-party application that can be auto installed or updated from the system." lightbox="media/missing-dependency-on-solution-import/missing-dependencies-first-party-application.png":::

### Missing dependencies coming from another managed solution

This issue occurs when the solution relies on components from another managed solution that's missing in the target environment. You can find these dependencies in the **Managed Solutions** section of the **Missing dependencies** page. Expand the section to see additional details.

:::image type="content" source="media/missing-dependency-on-solution-import/missing-dependencies-managed-solutions-section.png" alt-text="The Managed Solutions section of the Missing dependencies page shows solution dependencies." lightbox="media/missing-dependency-on-solution-import/missing-dependencies-managed-solutions-section.png":::

To work around this issue, import the same version of the solution that's installed in the source environment into the target environment.

### Missing dependencies on the "Active" solutions

This issue occurs when the solution relies on unmanaged customizations from the source environment that are missing in the target environment. You can find these dependencies in the **Unmanaged Components** section of the **Missing dependencies** page. Expanding the section provides additional details.

:::image type="content" source="media/missing-dependency-on-solution-import/missing-dependencies-unmanaged-components.png" alt-text="The Unmanaged Components section of the Missing dependencies page shows solutions that rely on unmanaged components." lightbox="media/missing-dependency-on-solution-import/missing-dependencies-unmanaged-components.png":::

To work around this issue, return to the source environment, include the missing components, export the solution again, and then import it into the target environment.

## Workaround 2: Best practices to prevent missing dependency errors

When you create a solution in Power Platform, you often reuse existing components for improved consistency and development speed. There are some key considerations for reusing existing objects across environments.

### Component availability in target environments

If your solution has dependencies on components (such as tables, flows, or apps) in the source environment, those components must also exist in the target environment when you deploy the solution. This requirement applies to both pipeline deployments and manual importing. If components are missing in the source environment, a missing dependency error occurs during import.

### Select only necessary components

To work around dependency issues, don't include entire tables or components if you need only a subset of their elements (for example, specific columns, views, or forms). Adding unnecessary elements can cause:

- Increased solution complexity
- Multiple managed layers that are applied to components
- Potential conflicts during updates

Instead, include only the parts of the component that your solution actively uses.

### Avoid modifying components in managed solutions

Don't make changes directly to components that are part of a managed solution. Such changes create an unmanaged layer on top of the managed component. This unmanaged layer can:

- Override updates from the source managed solution
- Cause inconsistencies across environments
- Prevent changes (such as updates to Power Automate flows or table configurations) from being reflected correctly after deployment

Always apply changes within an unmanaged solution or extend functionality by using solution layering. For more information about solution layering, see [Solution layers](/power-platform/alm/solution-layers-alm).

### Avoid dependencies on deprecated applications

Avoid taking dependencies on deprecated applications. Deprecated applications are no longer available for installation or update. You can find these dependencies in the **Deprecated Applications** section of the **Missing dependencies** page. Expanding the section provides additional details.

:::image type="content" source="media/missing-dependency-on-solution-import/deprecated-applications.png" alt-text="Screenshot that shows the Deprecated Applications section of the Missing dependencies page.":::

Remove any dependencies between solution components and deprecated applications before importing your solution.

## Related content

- [Organize your solutions](/power-platform/alm/organize-solutions)
