---
title: Unknown Dictionary Error
description: Provides a solution to an error that occurs when starting Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains.
ms.reviewer: theley, kyouells
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Unknown Dictionary Error" Error message displays when you start Microsoft Dynamics GP

This article provides a solution to an error that occurs when starting Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 875794

## Symptoms

When you start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains, you receive the following error message:
> Unknown Dictionary Error

Additionally, when you select **OK**, Microsoft Dynamics GP closes.

## Resolution

To resolve this problem, follow these steps:

1. Make sure that the paths to the dictionary files in the Dynamics.set file on the local computer are correct.

2. If the paths are correct, re-create the Dynamics.set file. To do it, follow these steps:
    1. Rename the current Dynamics.set file.
    2. Copy over the Dynamics.set file from another workstation that contains the same modules and doesn't receive the error.

    > [!NOTE]
    > If the location of the code folder of Microsoft Dynamics GP differs between workstations, additional modifications may be needed to change the paths to the dictionary files in the new Dynamics.set file.
3. Make sure that all users have permissions to the location that is specified for the application, the forms, the reports, or the third-party dictionaries.

4. If another computer is working correctly, copy the Dynamics.dic file from the working computer to the computer that is experiencing the error message.

5. If the error message still occurs, disable the reference to third-party dictionaries. For more information about how to do it, see [KB - Steps to disable third-party products or temporarily disable additional products in the Dynamics.set file in Microsoft Dynamics GP](https://support.microsoft.com/help/872087)
