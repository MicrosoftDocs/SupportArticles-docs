---
title: The solution file is invalid
description: Provides a solution to the 80048060 error that occurs when you try to import a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# The solution file is invalid error occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4456506

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "The solution file is invalid. The compressed file must contain the following files at its root: solution.xml, customizations.xml, and [Content_Types].xml. Customization files exported from previous versions of Microsoft Dynamics 365 are not supported.  
Error code 80048060."

## Cause

This error can occur if you attempt to import a solution file that isn't valid. Dynamics 365 solution files are stored as .zip files that contain files with the following names:

- solution.xml
- customizations.xml
- [Content_Types].xml

If you attempt to import a solution file that doesn't contain these files, this error will occur.

## Resolution

Verify the .zip file you're trying to import contains the files mentioned in the [cause](#cause) section and then attempt to import the solution again.

Example: If you had extracted the solution .zip file and made manual changes to customizations.xml but rezipped just that file, you would receive this error. You need to select all of the files that were in the .zip file and choose to compress them to a zipped folder before trying to reimport them.
