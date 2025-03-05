---
title: Missing dependencies during solution import in Power Apps
description: Works around an issue about missing dependencies that occurs when you import a solution in the target environment in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 09/25/2023
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

    The **Missing dependencies** page lists all the components that are missing from the target environment. It also shows three categories of dependencies from which the component dependencies are obtained. The component missing can be due to missing application, missing managed solution or missing unmanaged component.

2. Resolve this issue based on the different types of dependencies described in the following sections:

### Missing dependencies coming from a Dynamics 365 application

You can find these dependencies in the **Applications** section of the **Missing dependencies** page. To resolve this issue:

- If the application isn't installed in the target environment
    - System administrator will see an **Install** button, clicking the button will redirect to application install [install the application](/power-platform/admin/manage-apps#install-an-app) page in the Power Platform admin center. Choose the application and install it.
    - Non system administrator will see a **Copy Install Link**. Copy the application install link and request your system administrator to install the application. Alternatively, system administrator can directly go to the [install application](/power-platform/admin/manage-apps#install-an-app) page in Power platform admin center.
    
- If the application is installed but has an outdated version in the target environment
    - System administrator will see an **Update** button, click the button to open the application update page in Power platform admin center.
    - Non system administrator will see a **Copy Update Link**. Copy the application update link and request your system administrator to update the application.
  
### Missing dependencies coming from another managed solution

You can find these dependencies in the **Managed Solution** section of the **Missing dependencies** page. To resolve this issue, import the same version of the solution that's installed in the source environment into the target environment.

### Missing dependencies on the "Active" solutions

You can find these dependencies in the **Unmanaged components** section of the **Missing dependencies** page. This indicates that the dependency is from unmanaged customization in the source environment. To resolve this issue, return to the source environment, include the missing components, export the solution again, and then import it into the target environment.

> [!TIP]
> Another method to find dependencies of components is to open the solution file, unzip it, and then open the *solution.xml* file. In the *solution.xml* file, look for a `<MissingDependencies>` element. All the dependencies are listed within this node.
