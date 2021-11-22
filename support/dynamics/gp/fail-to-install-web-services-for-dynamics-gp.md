---
title: Error when you install Web Services for Microsoft Dynamics GP
description: Error (The eConnect installation cannot be found) when you try to install Web Services for Microsoft Dynamics GP. This article provides help to solve this error.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Error when you try to install Web Services for Microsoft Dynamics GP: The eConnect installation cannot be found

This article provides a solution to an error that occurs when you install Web Services for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 925664

## Symptoms

When you try to install Web Services for Microsoft Dynamics GP, you receive the following error message:

> The eConnect installation cannot be found.

## Cause

This problem occurs because the Microsoft_Business_Solutions_eConnect_Runtime.msi file does not reside in the same directory in which the DynamicsGPWebServices.msi file resides.

## Resolution

To resolve this problem, move the Microsoft_Business_Solutions_eConnect_Runtime.msi file into the directory in which the DynamicsGPWebServices.msi file resides. Then try the installation again.
