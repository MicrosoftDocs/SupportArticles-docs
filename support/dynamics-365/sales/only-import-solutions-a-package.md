---
title: Only import solutions with a package
description: Provides a solution to the 80048068 error that occurs when you try to import a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# You can only import solutions with a package version of 9.0 or earlier into this organization error occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4462712

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "You can only import solutions with a package version of 9.0 or earlier into this organization. Also, you can't import any solutions into this organization that were exported from Microsoft Dynamics 365 2011 or earlier.  
Error code 80048068"

## Cause

### Cause 1

This message can occur if you're trying to import a solution from a newer version of Dynamics 365. For example: If you had a solution created in Dynamics 365 9.0, and are trying to import it into a Dynamics 365 organization that is version 8.2. This error also occurs if the solution was exported from a version 9.1 organization and you're trying to import it into an organization that is version 9.0.

### Cause 2

This message will also occur if you try to import a solution that is from Dynamics 365 2011 (5.0) or earlier. If you open the solution.xml file within the solution zip file and see the version information at the top is from 5.0, it's the cause of the error.

## Resolution

There isn't a supported way to import a solution from a higher version of Dynamics 365 into an organization that is a lower version. There's also not a supported way to import a solution from version 2011 (5.x) into a Dynamics 365 organization that is version 9.x or later.
