---
title: Some shortcut names still indicate preview
description: Provides a resolution for an issue where some shortcut names still indicate preview version after a newer version is installed.
ms.date: 04/17/2025
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---
# Some shortcut names still indicate Preview after a newer version is installed

This article helps you resolve an issue that occurs when you install Microsoft Visual Studio 2013.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 2899270

## Symptoms

If you installed Visual Studio 2013 Preview, and then installed a newer version of Visual Studio 2013 without first uninstalling Preview, some Visual Studio shortcut names aren't correctly updated to indicate that a new version is installed.

> [!NOTE]
> These shortcut names are incorrect but correctly point to the newer Visual Studio installation, so it isn't necessary to take any action.

## Resolution

To fix these shortcut names, follow these steps:

1. To uninstall Visual Studio 2013, open **Programs and Features** (appwiz.cpl), right-click **Visual Studio 2013**, and then select **Change** > **Uninstall**.

2. Manually delete any shortcuts that have been left behind:

    1. Open an elevated **Command Prompt** window.

    2. In the **Command Prompt** window, type the following command, and then press **Enter**:

        ```console
        rmdir /S "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft Visual Studio 2013"
        ```

3. Enter _Y_ to confirm that you want to delete the folder and its contents.

4. Reinstall the latest version of Visual Studio.
