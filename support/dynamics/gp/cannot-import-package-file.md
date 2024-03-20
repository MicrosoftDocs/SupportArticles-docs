---
title: VBA Cannot be initialized. Cannot Import this package error when importing a package file in Microsoft Dynamics GP
description: Error - VBA Cannot be initialized. Cannot Import this package because it contains VBA components occurs when importing a package file.
ms.reviewer: theley, dlanglie
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "VBA Cannot be initialized. Cannot Import this package because it contains VBA components" error when importing a package file in Microsoft Dynamics GP

This article describes an issue where you can't import a package file into Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861062

## Symptoms

You receive the following error when you import a .package file into Microsoft Dynamics GP:
> VBA cannot be initialized. Cannot Import this package because it contains VBA components.

## Cause

The common shared files for Visual Basic for Applications (VBA) are damaged.

## Resolution

### Microsoft Dynamics GP 10.0 and Dynamics GP 9.0

1. Open Add or Remove Programs and repair Microsoft Office.
    > [!NOTE]
    > You may be prompted to insert your product CD.
2. This repairs VBA.
3. Restart the computer after the repair finishes.
4. Then try to import your package file again.

### Microsoft Business Solutions - Great Plains 8.0

1. Reinstall VBA on the computer.
2. You can find the installation on the Microsoft Business Solutions CD 1 under the *AdProd\VBA6* folder.
3. You must be logged in as administrator
4. Run the **Setup.exe** file that's found in the *Adprod\VBA6* folder.
5. Restart the computer after the installation is completed.
6. Then try to import your package file again.
