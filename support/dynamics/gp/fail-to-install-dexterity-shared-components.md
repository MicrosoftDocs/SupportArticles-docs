---
title: Error when you install Microsoft Dexterity Shared Components
description: Describes a problem that may occur if the new version of the Microsoft Dexterity Shared Components is not installed successfully in the registry. Provides a resolution.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you try to install the Microsoft Dexterity Shared Components: "Another version of this product is already installed"

This article provides a solution to an error that occurs when you install the Microsoft Dexterity Shared Components.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 923963

## Symptoms

When you try to install the Microsoft Dexterity Shared Components, you receive the following error message:

> Another version of this product is already installed. Installation of this version cannot continue. To configure or remove the existing version of this product, use Add/Remove Programs on the Control Panel.

However, the Microsoft Dexterity Shared Components do not appear in Add or Remove Programs.

## Cause

This problem may occur if the new version of the Microsoft Dexterity Shared Components is not installed successfully in the registry.

## Resolution

To resolve this problem, clean up the registry entries to enable the new version of the Microsoft Dexterity Shared Components to be installed correctly. To do this, follow these steps:

1. Click **Start**, click **Run**, type the `msiexec /uninstall {E5C511B5-B2E2-4ACE-AC14-AEE720CC4C6E}` line in the **Open** box, and then click **OK**.

2. Double-click the **DexCmn.msi** file in the installation media, and then reinstall the Microsoft Dexterity Shared Components.

## More information

DexCmn.msi is the file name for the Microsoft Dexterity Shared Components installation. The Microsoft Dexterity Shared Components are automatically installed by Microsoft Dynamics GP 9.0. An updated version of the Microsoft Dexterity Shared Components is available in Microsoft Dynamics GP 9.0 Service Pack 1. The Microsoft Dexterity Shared Components are common components that are shared by various components of Microsoft Dynamics GP 9.0.

The most common .dll files that are used in the Microsoft Dexterity Shared Components are the GPConn.dll file and the GPConnNet.dll file. These .dll files are APIs. You can use these files to establish a database connection to the Microsoft Dynamics GP 9.0 database by using external programs.
