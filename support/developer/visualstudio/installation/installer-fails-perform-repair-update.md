---
title: Visual Studio Installer fails to perform repair or update
description: Provides a resolution for an issue that occurs when you try to repair or update Visual Studio.
ms.date: 09/26/2023
ms.reviewer: khgupta, raviuppa, aartigoyle, v-sidong
ms.custom: sap:installation
---
# Visual Studio Installer fails to perform repair or update

_Applies to:_ &nbsp; Visual Studio 2022

## Symptoms

You may see the following error when you try to repair or update Visual Studio:

```output
A product matching the following parameters cannot be found:channelId: VisualStudio.17.Release

productId: Microsoft.VisualStudio.Product.Enterprise
```

## Cause

This issue can occur if the Visual Studio instance on the machine is corrupt.

## Resolution

If your previous attempts to repair or update Visual Studio failed, you can run the [InstallCleanup.exe](/visualstudio/install/uninstall-visual-studio#remove-all-with-installcleanupexe) tool to remove installation files and product information, and then reinstall Visual Studio 2022. This process ensures a fresh installation of Visual Studio, which should allow for successful repairs or updates.

To solve this issue, follow these steps:

1. Open a command prompt with administrator privileges.
1. Run the following command to execute the [InstallCleanup](/visualstudio/install/uninstall-visual-studio#remove-all-with-installcleanupexe) tool:

   `"C:\Program Files (x86)\Microsoft Visual Studio\Installer\InstallCleanup.exe" -i 17`

   This command will perform a cleanup of the Visual Studio installation, removing any corrupted or incomplete components. The version value, in this case `17`, specifies the version of product to be removed. 

1. Once the cleanup process is completed, reinstall [Visual Studio 2022](https://visualstudio.microsoft.com/downloads/).
1. Launch the Visual Studio 2022 installer and follow the prompts to reinstall Visual Studio. Make sure to select the desired workloads and components during the installation.

## More information

- [Update Visual Studio](/visualstudio/install/update-visual-studio)
- [Repair Visual Studio](/visualstudio/install/repair-visual-studio)
- [Troubleshoot installation and upgrade issues](troubleshoot-installation-issues.md)
