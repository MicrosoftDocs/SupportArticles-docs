---
title: Missing dependencies during solution import in Power Apps
description: Works around an issue about missing dependencies that occurs when you import a solution in the target environment in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 09/20/2023
author: swatimadhukargit
ms.author: swatim
---
# Missing dependencies error during solution import

This article provides a workaround for an issue about missing dependencies that occurs when you [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) in Microsoft Power Apps. You can't proceed with the solution import until the missing dependencies are resolved.

_Applies to:_ &nbsp; Power Platform, Solutions


## Symptoms

When you try to import a solution in the [Power Apps admin center](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc), you receive an error message like the following one:

> Import failed due to missing dependencies.

<!-- I think it would be valuable to also include the 'raw' error message that people might get from other processes that import solutions. Not all solutions get manually imported from Power Apps. -->

## Cause

The solution has dependencies on a component that exists in the source environment where the solution is deployed. However, the component doesn't exist in the target environment where the solution is imported. 

This issue might occur when applications are upgraded to the latest version through Microsoft scheduled maintenance in the source environment, but they aren't upgraded in the target environment.

## Workaround

To work around this issue, follow these steps:

1. Select the **Show dependencies** button to navigate to the **Missing dependencies** page.

    The **Missing dependencies** page lists all the components that are missing from the target environment. It also shows the solution or application from which the component dependencies are obtained.

2. Resolve this issue based on the different types of dependencies.

#### Dependencies on solutions coming from an application

You can find these dependencies in the **Managed Solution** tab of the **Missing dependencies** page. If the application isn't installed in the target environment, install it from the [Power Platform admin center](https://admin.powerplatform.microsoft.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc). If the application is installed but has an outdated version, a link is provided next to the solution. This link will redirect you to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc) where you can update the application to resolve the issue.

#### Dependencies on solutions coming from another managed solution

You can find these dependencies in the **Managed Solution** tab of the **Missing dependencies** page. To resolve this issue, import the same version of the solution that's installed in the source environment into the target environment.

#### Dependencies on "Active" solutions indicating unmanaged customizations in the source environment

You can find these dependencies in the **Objects** tab. To resolve this issue, return to the source environment, include the missing components, export the solution again, and then import it into the target environment.

> [!TIP]
> Another method to find dependencies of components is to open the solution file, unzip it, and then open the *solution.xml* file. In the *solution.xml* file, look for a `<MissingDependencies>` element. All the missing dependencies are listed within this node.
