---
title: Missing dependencies on solution import in Power Apps
description: Works around an issue where importing a solution in target environment result in missing dependencies error page in Power Apps.
ms.reviewer: jdaly
ms.topic: troubleshooting
ms.date: 09/15/2023
author: swatimadhukargit
ms.author: swatim
---
# Missing dependencies error on solution import

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for the Missing dependencies issue that occurs when you perform [solution import](/powerapps/maker/data-platform/import-update-export-solutions) in the target environment. You can proceed with the solution import until the missing dependencies are resolved

## Symptoms

When you try to import a solution in the target environment, it results in import failure with a message on the top, showing message "Import failed due to missing dependencies" and a **Show dependencies** button which navigates to the Missing dependencies error page.

This issue occurs when the solution has taken dependencies on some components in the source environment, but those dependencies aren't present in the target environment.

## Cause

The solution has taken dependency on a component, which is present in the source environment where the solution was developed. The component doesn't exist in the target environment where the solution is imported. The missing dependencies error page shows the component on which the solution is dependent and doesn't exist in the target environment. This could happen for applications which were upgraded to latest version through regular maintenance from Microsoft in the source environment, but yet to get upgraded in the target environment.

### Workaround

Use one of the following method to find dependencies:

- The Missing dependencies error page shows list of all the components that are missing in the target environment. It also shows the solution/application from which the component dependency was taken.
- Another way to find dependencies of components the solution has taken is by opening the solution file, unzip it, and then open the solution.xml file. In the solution.xml file check for **missingdependencies** tag. All the missing dependencies are listed within this tag.

The different types of dependencies to consider and how to resolve those are mentioned below:

- Dependencies on solution coming from an application

    - If the application is not yet installed in the target environment, install it from Power Platform admin center. If it is installed but of lower version, a link is provided next to the solution which takes you to the Power Platform Admin Center where you can update the application to resolve the issue.

- Dependencies on solution coming from another managed solution
    - This kind of dependencies can be resolved by importing the same solution with exactly same version into the target environment that was installed in the source environment

- Dependencies on active solution that indicates unmanaged customization in your source environment.
    - This kind of dependencies can be resolved by going back to the source environment, including the missing components, export then import to the target environment.
