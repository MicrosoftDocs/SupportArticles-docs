---
title: Can't upgrade the MARS Agent
description: Describes an issue that occurs when you try to upgrade from an older version to a newer version of the Microsoft Azure Recovery Services (MARS) Agent. Provides a resolution.
ms.date: 08/14/2020
author: genlin
ms.author: genli
ms.service: azure-site-recovery
ms.reviewer: saurse
ms.custom: sap:I need help with Azure Backup
---
# Error when you try to upgrade the MARS Agent: The Microsoft Azure Recovery Services Agent update failed

This article describes the symptoms and resolution for an issue that occurs when you try to upgrade from an older version to a newer version or release of the Microsoft Azure Recovery Services (MARS) Agent.

_Original product version:_ &nbsp; Azure Site Recovery  
_Original KB number:_ &nbsp; 4020490

## Symptoms

When you try to upgrade the MARS Agent by using the Microsoft Azure Recovery Services Agent Upgrade Wizard, the upgrade fails and you receive the following error message:

> The Microsoft Azure Recovery Service Agent update failed.  
Error: Unable to start RecoveryServicesManagementAgent Service. Uninstall the patch  
Problem: Update install failed with error 1612

## Cause

This issue occurs because the upgrade can't find the source installer for the MARS Agent in the Windows Installer cache. The source installer is required for the upgrade to complete successfully.

## Resolution

To fix this issue, make sure that the source installer exists in the Windows Installer cache. To do this, follow these steps:

1. Exit the Microsoft Azure Recovery Services Agent Upgrade Wizard.
2. Open the OBPatch.log file that's located in the `C:\Windows\Temp` folder.
3. Locate the error-description line within the OBPatch.log file be searching for "Warning: Local cached package."
4. Locate a line that resembles the following: Warning:
    > Local cached package 'C:\Windows\Installer\Unique_ID.msi is missing.

5. Note theUnique_IDvalue for future reference.
6. Double-click the MARS Agent update installer (.exe) file. This copies all Setup-related binaries and installer files to a temporary location on your computer and opens the Microsoft Azure Recovery Services Agent Upgrade Wizard.

    **Note** Leave the wizard open until step 12.
7. Open the OBInstaller0Curr.errlog file that's located in the "C:\Windows\Temp" folder.
8. Search in the text for "Directory Path for SetupLaunchScreen," and then locate the line with the latest time stamp that resembles the following: Directory Path for SetupLaunchScreen: `C:\Temp_ID`.
9. Go to the `C:\Temp_ID\Installers` folder.
10. In this folder, locate and copy the OBSAGENT.msi file to the C:\Windows\Installer folder. Rename the destination file as **Unique_ID.msi**.
11. Close the MARS Agent Upgrade Wizard.
12. Run the upgrade installer to install the upgrade. If the issue persists, contact Microsoft Support.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
