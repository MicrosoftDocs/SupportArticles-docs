---
title: Missing dependencies on solution import in Power Apps
description: Works around an issue where importing a solution in target environment result in missing dependencies error page in Power Apps.
ms.reviewer: jdaly
ms.topic: troubleshooting
ms.date: 09/19/2023
author: swatimadhukargit
ms.author: swatim
---
# Missing dependencies error on solution import

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for a missing dependencies issue that occurs when you [import a solution](/powerapps/maker/data-platform/import-update-export-solutions). You can't proceed with the solution import until the missing dependencies are resolved

## Symptoms

When you try to import a solution in [Power Apps](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc) you get an error saying: **Import failed due to missing dependencies**.

<!-- I think it would be valuable to also include the 'raw' error message that people might get from other processes that import solutions. Not all solutions get manually imported from Power Apps. -->

This issue occurs when the solution has taken dependencies on components in the source environment, but those dependencies aren't present in the target environment.

## Cause

The solution has taken dependency on a component, which is present in the source environment where the solution was developed. The component doesn't exist in the target environment where the solution is imported.

This could happen when applications are upgraded to latest version through regular maintenance from Microsoft in the source environment, but the target environment has yet to be upgraded.

## Workaround

When you see this error in in [Power Apps](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc), select the **Show dependencies** button to view the the **Missing dependencies** page.

The **Missing dependencies** error page lists of all the components that are missing in the target environment. It also shows the solution/application from which the component dependency was taken.

Consider the following types of dependencies to understand how to resolve this error:

### Dependencies on solution coming from an application

You can find these dependencies in the **Managed Solution** tab of the **Missing dependencies** error page. If the application isn't yet installed in the target environment, install it from [Power Platform admin center](https://admin.powerplatform.microsoft.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc). If the application is installed but of lower version, a link is provided next to the solution that takes you to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc) where you can update the application to resolve the issue.

### Dependencies on solution coming from another managed solution

You can find these dependencies in the **Managed Solution** tab of the **Missing dependencies** error page. Resolve the issue by importing the same solution with exactly same version into the target environment that was installed in the source environment.

### Dependencies on active solution that indicates unmanaged customization in your source environment

You can find these dependencies in the **Objects** tab. Resolve the issue by going back to the source environment, including the missing components, export the solution again and then import to the target environment.

> [!TIP]
> Another way to find dependencies of components is by opening the solution file, unzip it, and then open the solution.xml file. In the solution.xml file look for a `<missingdependencies>` element. All the missing dependencies are listed within this node.