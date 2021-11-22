---
title: Incompatible Dynamics.dic 
description: Provides a solution to the Incompatible Dynamics.dic error when you start Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "You are attempting to Install a version of Great Plains for SQL Server that is older than the one currently installed on your computer." Error message when you start Microsoft Dynamics GP

This article provides a solution to an error that occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866197

## Symptoms

You may receive the following error message when you start Microsoft Dynamics GP:

> Incompatible Dynamics.dic  
"You are attempting to Install a version of Great Plains for SQL Server that is older than the one currently installed on your computer."

## Cause 1

This problem can occur because the version of the Dynamics GP installation that you're starting is an earlier version than the one that is stated in the database. To resolve this problem, see [Resolution 1](#resolution-1).

## Cause 2

This problem can occur when you have multiple installations of Microsoft Dynamics GP and the incorrect one is being started. To resolve this problem, see [Resolution 2](#resolution-2).

## Cause 3

This problem can occur because the installation on the computer is corrupted. To resolve this problem, see [Resolution 3](#resolution-3).

## Resolution 1

To resolve the problem with the version information, make sure that the Microsoft Dynamics GP installation on this computer is the same version as on another computer. To do it, follow these steps:

1. Locate the Microsoft Dynamics GP installation folder, depending on the version that you're using:

    - If you're using Microsoft Dynamics GP 9.0 or Microsoft Dynamics GP 9.0 10.0, by default the installation folder is located at `C:\Program Files\Microsoft Dynamics\GP`.
    - If you're using Microsoft Business Solutions-Great Plains 8.0, by default the installation folder is located at `C:\Program Files\Microsoft Business Solutions\Great Plains`.
2. On the **Dictionary** tab, note the dictionary version.
3. Repeat steps 1 through 3 on a workstation that doesn't receive the error message.
    > [!NOTE]
    > These values should match. If the version information does not match, update the installation on the computer that is receiving the error message so that the version information does match.

## Resolution 2

Manually start Microsoft Dynamics GP. To do it, follow these steps:

1. Locate the Microsoft Dynamics GP installation folder, depending on the version that you're using:

    - If you're using Microsoft Dynamics GP 9.0 or Microsoft Dynamics GP 10.0, by default the installation folder is located at `C:\Program Files\Microsoft Dynamics\GP`.
    - If you're using Microsoft Business Solutions-Great Plains 8.0, by default the installation folder is located at `C:\Program Files\Microsoft Business Solutions\Great Plains`.
2. Locate the Dynamics.set file.
3. Drag-and-drop the Dynamics.set file onto the Dynamics.exe file.

## Resolution 3

To resolve a corrupted installation, uninstall Microsoft Dynamics GP from the computer that is receiving the error message. Then, install a new instance of Microsoft Dynamics GP to a new location.

## Reference

For more information about how to update a computer that has more than one Microsoft Dynamics GP installation, see [Frequently asked questions about the Windows Installer .msp files for Microsoft Dynamics GP](https://support.microsoft.com/help/912997).

For specific steps that you can use to install a service pack to multiple instances, refer to A13 in the article.
