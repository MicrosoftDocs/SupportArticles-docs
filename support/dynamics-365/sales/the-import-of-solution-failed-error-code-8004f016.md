---
title: The import of solution failed with error code 8004f016
description: The import of solution failed with error code 8004f016 when importing a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# The import of solution failed with error code 8004f016 in Microsoft Dynamics 365

This article provides a resolution for the issue that you may receive **The import of solution failed** this error with error code **8004f016** when importing a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4346904

## Symptoms

When attempting to import a solution in Microsoft Dynamics 365, you encounter the following error:

> The import of solution: [solution name] failed.  
Error code 8004f016

Within the **Detail** column of the grid, you see the following message:

> A managed solution cannot overwrite a [component type] component on the target system that has an unmanaged base instance. The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged [component type] component on the target system, and now a managed solution from the same publisher is trying to install that same [component type] component as managed. This will cause an invalid layering of solutions on the target system and is not allowed.

## Cause

As mentioned within the error details, the most likely scenario for this error is that an unmanaged solution has installed a new unmanaged component on the target system, and now a managed solution from the same publisher is trying to install that same component as managed. This will cause an invalid layering of solutions on the target system and is not allowed.

Example: Your Microsoft Dynamics 365 instance already has a component such as a custom field (attribute) that was created using an unmanaged solution. If you later try to export a solution with that same field (component) as a managed solution, you will encounter this error if you try to import that solution into this instance where it already exists from an unmanaged solution.

## Resolution

If the component type is AttributeMap, see the following article:

- [Error importing AttributeMap in Dynamics 365](https://support.microsoft.com/help/4494576)

If the component type is SavedQuery, see the following article:

- [Error importing SavedQuery in Dynamics 365](https://support.microsoft.com/help/4496853)

Also verify you are importing the correct solution type. A solution can be exported as an unmanaged solution or a managed solution. Once a component is created/imported as part of an unmanaged solution, it cannot be reimported as a managed solution.

For more information on unmanaged and managed solutions, see [Managed and unmanaged solutions](/dynamics365/customerengagement/on-premises/customize/solutions-overview#managed-and-unmanaged-solutions).
