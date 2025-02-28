---
title: Temporary profile error during machine registration
description: Provides a resolution for an issue where you can't register a machine due to an error when using the Power Automate machine runtime application.
ms.reviewer: fanedjad
ms.date: 10/24/2023
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Temporary profile error during machine registration

This article provides a resolution for an error that occurs when you try to [register a machine](/power-automate/desktop-flows/manage-machines#register-a-new-machine) using the Power Automate machine runtime application.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5007391

## Symptoms

When you try to register a machine using the Power Automate machine runtime application, you receive the following error message:

> An error occurred while registering your machine. Power Automate may have not been installed properly. Follow the steps in the learn more sections.

## Cause

This issue occurs because the Power Automate for desktop application isn't properly installed due to a previous installation or uninstallation that puts the "NT Service\UIFlowService" user profile in a broken state.

## Resolution

To solve this issue,

1. Uninstall Power Automate for desktop from the machine and make sure the related files, located in *C:\Program Files (x86)\Power Automate Desktop*, are deleted.

2. Reset the user profile manually.

   1. Verify the settings of the "UIFlowService" profile:

       Open the Registry Editor and go to the key folder:

       *Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-80-3017052307-2994996872-1615411526-3164924635-3391446484*

       If a second key exists with the `.bak` extension, you can delete it.

   2. Go to the location of `ProfileImagePath`.

   3. Verify that the *UIFlowService* folder is present in that directory. By default, it's located in *%SystemRoot%\ServiceProfiles*.

   4. Modify the `ProfileImagePath` value to point to the existing *UIFlowService* folder. By default, it should be *%SystemRoot%\ServiceProfiles\UIFlowService*.

3. Restart your machine.
4. Install Power Automate for desktop again.
