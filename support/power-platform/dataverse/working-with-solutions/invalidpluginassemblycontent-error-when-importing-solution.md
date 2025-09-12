---
title: InvalidPluginAssemblyContent error when importing solution
description: InvalidPluginAssemblyContent error when importing a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Working with Solutions
---
# InvalidPluginAssemblyContent error when importing a solution in Microsoft Dynamics 365

This article provides a resolution for the issue that you may receive the **InvalidPluginAssemblyContent** error when importing a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4500635

## Symptoms

When attempting to import a solution in Microsoft Dynamics 365, the solution import fails with the following error:

> Plug-in assembly does not contain the required types or assembly content cannot be updated.
>
> Error code: 8004418b

## Cause

This error occurs if you have modified an assembly included in this solution but the version of the solution was not incremented.

Examples:

Changing the name, version, isolation level, public key token, or culture of the assembly without increasing the version of the solution will cause this error. Changes like these require a solution upgrade (version change) instead of a solution update.

## Resolution

Increase the version of the solution and try the import again.

## More information

For more information, see the following articles:

- [Update a custom workflow activity using assembly versioning](/powerapps/developer/common-data-service/workflow/workflow-extensions#manage-changes-to-custom-workflow-activities)
- [Release a new version of your managed solution](/dynamics365/customerengagement/on-premises/developer/maintain-managed-solutions#release-a-new-version-of-your-managed-solution)
