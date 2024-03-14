---
title: Initialization errors when you remove or install Integration Manager
description: Troubleshoot the Initialization errors when you remove or install Integration Manager. Provides resolutions.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Troubleshooting Initialization errors when you remove or install Integration Manager

This article provides resolutions that correspond with the causes of the issue that you receive initialization errors when you remove or install Integration Manager in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861816

## Symptoms

When you remove or install Integration Manager, you may receive the following errors during setup initialization:

- Error extracting support files
- Error installing Ikernel.exe (0x any number)
- Access is denied
- Error loading Type Library/DLL

## Cause

Setup initialization errors can be caused by many factors. This is a non-exhaustive list of possible causes:

- You do not have sufficient permissions on the computer.
- If you just ran an InstallShield setup, the engine takes several seconds at the end of the installation to clean up.
- Ikernel.exe is in memory.
- There are extra files in the temp folder.
- The Program Files\Common Files\InstallShield\Engine folder exists.
- Core Windows files are corrupted or missing.
- The Stdole32.tlb file is missing.
- You do not have sufficient COM permissions.

## Resolution

To resolve this issue, use the method that corresponds with the cause of the issue.

- You do not have sufficient permissions on the computer.

  If you are using a Microsoft Windows 2000-based computer, a Windows XP-based computer, or a Windows 2003-based computer, you must have administrative permissions to run an InstallShield Professional 6.x setup. Make sure that you have the correct permissions.

- If you just ran an InstallShield setup, the engine takes several seconds at the end of the installation to clean up.

  During this time, Ikernel.exe (the engine file) is running in memory from a previous process; that is why you are not permitted to start another setup. Wait several seconds and then run the setup again.

- Ikernel.exe is in memory.

  Make sure Ikernel.exe is not in memory. If it is, and no setup is running at the time, end that task.

- There are extra files in the temp folder.

  Clean the temp folder.

- The Program Files\Common Files\InstallShield\Engine folder exists.

  Delete the Program Files\Common Files\InstallShield\Engine folder and then run the setup again.

- Core Windows files are corrupted or missing.

  Reinstalling Internet Explorer 6.x or a later version will repair many corrupted/missing core Windows files from your computer. Therefore, reinstalling Internet Explorer 6.x or a later version and the latest Windows Service Pack is suggested.

- The Stdole32.tlb file is missing.

  This is a core Windows file and must exist on your computer. Make sure that you have this file or get this file from another computer that is running the same operating system as the destination computer.

- You do not have sufficient COM permissions.

  If you receive the **Error installing Ikernel.exe, access is denied** error, follow these steps to give yourself the necessary permissions:

  1. In a Command Prompt window, type *dcomcnfg.exe*. This step opens the **Distributed COM Configuration Properties** dialog box.
  2. Select the **Default Security** tab.
  3. In the Default Access Permissions section, select the **Edit Default** button.
  4. Make sure that "Allow Access" appears next to the user name. If "Allow Access" does not appear next to the user name, modify an existing profile. Or, create a new profile that has the necessary permissions.
  5. Apply all the changes, and then run the setup again.
