---
title: Environment schema type mismatch during solution import in Power Apps
description: Works around a warning about environment schema type mismatch that occurs when you import a solution in the target environment in Microsoft Power Apps.
ms.reviewer: matp
ms.date: 02/27/2025
author: swatimadhukargit
ms.author: swatim
ms.custom: sap:Working with Solutions\Environment schema type mistamch during solution import
---
# Environment schema type mismatch warning during solution import

This article provides a workaround for an issue about source environment's [schema type](/power-apps/developer/data-platform/webapi/reference/organizationdetail?view=dataverse-latest#remarks) higher than target environment's schema type that occurs when you [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) in Microsoft Power Platform. You can still proceed with the solution import if there is no other error but this warning helps guide you to avoid missing components due to schema type mismatch for future imports.

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to import a solution in [Power Apps](https://make.powerapps.com/?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc), you receive a warning like this:

> This solution was exported from a [source environment schema type] environment, which has more components tham the current [target environment schema type] environment. When you import, some components might be missing.

## Cause

The source environment where the solution is developed has a higher schema type, which has more components than the target environment which has a lower schema type with lesser components. The solution might (or might not) take a dependency on a component which is present in source environment but is missing in the target environment and could result in missing dependencies.
Full `schemaType` has more components than **Standard**. Standard has more components than **Core**.

This warning ensures that you understand the drawbacks of having source and development environments with different schema types. 

## Workaround

To work around this issue, choose the same or lower schema type for the source environment as compared to the target environment. If schema type of the source environment is higher than the target environment's, consider changing changing the source environment schema type. 
The warning doesn't confirm missing dependencies during solution import due to dependencies on components present in the source environmen. Instead, this warning guides you to do a best practice to setup source and target environments correctly to avoid future risks of missing dependencies.
