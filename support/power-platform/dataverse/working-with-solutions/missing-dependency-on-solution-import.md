---
title: Missing dependencies during solution import in Power Apps
description: Works around an issue about missing dependencies that occurs when you import a solution in the target environment in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 03/07/2025
author: swatimadhukargit
ms.author: swatim
ms.custom: sap:Working with Solutions\Dependencies prevent a solution import
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

    The **Missing dependencies** page lists all the components that are missing from the target environment. It also shows three categories of dependencies from which the component dependencies are obtained. The component missing issue might occur due to missing an application, a managed solution or an unmanaged component.

2. Expand each section of dependencies that is encountered and resolve this issue based on the different types of dependencies described in the following sections, once the missing dependencies are fixed, retry the import:

### Missing dependencies coming from a Dynamics 365 application

You can find these dependencies in the **Applications** section of the **Missing dependencies** page. To resolve this issue:

- If the application isn't installed in the target environment:

  - System administrators can use the **Install** button, which redirects to the [application install](/power-platform/admin/manage-apps#install-an-app) page in the Power Platform admin center. Choose and install the application.
  - Non-system administrators can use the **Copy Install Link** button to copy the application install link and request their system administrator to install the application. Alternatively, a system administrator can directly go to the [application install](/power-platform/admin/manage-apps#install-an-app) page to install the application in the Power Platform admin center.

- If the application is installed but outdated in the target environment:

  - System administrators can use the **Update** button to open the application update page in the Power Platform admin center.
  - Non-system administrators can use the **Copy Update Link** button to copy the application update link and request their system administrator to update the application.
  
### Missing dependencies coming from another managed solution

You can find these dependencies in the **Managed Solution** section of the **Missing dependencies** page. To resolve this issue, import the same version of the solution that's installed in the source environment into the target environment.

### Missing dependencies on the "Active" solutions

You can find these dependencies in the **Unmanaged components** section of the **Missing dependencies** page. This indicates that the dependency is from unmanaged customization in the source environment. To resolve this issue, return to the source environment, include the missing components, export the solution again, and then import it into the target environment.

### Example

The following example illustrates a scenario when a system administrator performs a solution import and encounters a missing dependencies which has applications, managed solutions and unmanaged components missing.

:::image type="content" source="media/missing-dependency-on-solution-import/missing-dependencies-update-experience.png" alt-text="Example of the application upgrade link for a component with missing dependencies." lightbox="media/missing-dependency-on-solution-import/missing-dependencies-update-experience.png":::

Here the solution has taken dependencies on the components of two applications which are missing in the target environment. One application is not installed, and the other application is installed but outdated in target environment. 
The information for each application missing is provided in the format <solution_name> (<solution_version>) from <application_name>. When expanded further, component information is provided. Next to application name is Install or Update button to redirect the user to Power platform admin center for Install or Update.

The solution has also taken dependencies on the components of three managed solutions and two unmanaged components. Expanding each section will help to determine more details. These can be resolved based on the instruction provided above.


> [!TIP]
> Another method to find dependencies of components is to open the solution file, unzip it, and then open the *solution.xml* file. In the *solution.xml* file, look for a `<MissingDependencies>` element. All the dependencies are listed within this node.
