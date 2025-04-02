---
title: Error code 80048539 when importing solution patch
description: Solves the error code 80048539 that occurs when you try to import a solution patch in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# Error code 80048539 occurs when trying to import solution patch in Dynamics 365

This article provides a resolution for error code 80048539 that may occur when you try to import a solution patch in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471087

## Symptoms

When you try to [import a solution patch in Microsoft Dynamics 365](/power-platform/alm/create-patches-simplify-solution-updates#export-and-import-a-patch), you receive the following error message:

> The import of solution: [solution patch name] failed.  
> Error code 80048539.

If you download the log file and open it in Excel, additional details similar to the following are displayed:

> Failure 0x80048539  
> Solution manifest import: FAILURE: Patch version 1.0.1.0 is invalid for parent version 1.1.0.0

## Cause

Error code **80048539** indicates an invalid patch is being imported.

This issue occurs because the version of the solution patch being imported is lower than the version of the solution already installed. For example, a solution named "SolutionA" is already installed with version 1.1.0.0, but you attempt to import a patch with version 1.0.1.0.

> [!NOTE]
> If you're using [Power Apps to import your unmanaged solution update](/power-apps/maker/data-platform/update-solutions#apply-the-upgrade-or-update-in-the-target-environment) and receive the error, as a workaround, expand the **Advanced settings** and select the **Update (not recommended)** option.  
> Microsoft is aware of the issue and is working on a fix.

## Resolution

To resolve this issue, verify that the solution patch version you're attempting to import is a higher version than the version of the solution already installed.

Follow these steps:

- Check the version of the solution currently installed in Dynamics 365.
- Confirm that the version of the solution patch you are trying to import is higher than the version of the installed solution.
- If necessary, update the version number of the solution patch and attempt the import again.
