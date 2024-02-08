---
title: Error code 8004F042 occurs when import solution patch.
description: Provides a solution to an error that occurs when attempting to import a solution patch in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Error code 8004F042 occurs when attempting to import solution patch in Microsoft Dynamics 365

This article provides a solution to an error that occurs when attempting to import a solution patch in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471082

## Symptoms

When attempting to import a solution patch in Dynamics 365, you receive the following error:

> "The import of solution: [solution name] failed.  
Error code 8004F042."

If you download the log file and open it in Excel, you see more details such as the following message:

> "Failure 0x8004F042  
Solution manifest import: FAILURE: Solution patch with version [version number] already exists. Updating patch is not supported."

## Cause

Error code 8004F042 indicates you're trying to import a patch that is already installed with the same version.

## Resolution

Verify the patch you're attempting to import isn't already installed and the same version number. If the patch is already installed, the updated patch needs to be a higher version number.
