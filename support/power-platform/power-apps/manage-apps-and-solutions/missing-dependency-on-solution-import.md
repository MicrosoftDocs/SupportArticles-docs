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

When you try to import a solution in the target environment, it results in Missing dependenies error page.

This issue occurs because the solution has taken dependencies on some components in the source environment, but those dependencies are not present in the target environment where the solution is imported.

## Cause

The solution has taken dependency on a component which is present in the source environment where the solution was developed. The component does not exist in the target environment where the solution is imported. The missing dependencies error page shows the component on which the solution is dependent and does not exist in the target environment

### Workaround

Use one of the following workarounds to find dependencies:

- The Missing dependencies error page shows list of all the components that are missing in the target environment, it also show the solution/application from which the component dependency was taken.
- Another way to find dependencies of components the solution has taken is by opening the solution file, unzip it, and then open the solution.xml file. In the solution.xml file check for **missingdependencies** tag. All the missing dependencies are listed within this tag.

These are the different types of dependencies to consider:

- Dependencies on solution coming from a Microsoft owned application

    - It can happen due to source environment having latest version of the application but target environment has older version, this could be because regular maintenance of this application happened in source environment, but is behind in target environment. In the missing dependencies error page, a link is provided which takes you to the Power Platform Admin Center where you can update the application to resolve the issue.

- Dependencies on solution coming from 3rd party application available from AppSource
    - This can be resolved by installing/upgrading the application from Power Platform Admin Center.

- Dependencies on solution coming from another managed solution
    - This can be resolved by importing the same solution with exactly same version into the target environment which was installed in the source environment

- Dependencies on active solution that is unmanaged customization in your source environment.
    - This can be resolved by going back to the source environment, including the missing components, export then import to the target environmnet.
