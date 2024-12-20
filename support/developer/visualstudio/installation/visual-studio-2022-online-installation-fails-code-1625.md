---
title: Visual Studio 2022 Online Installation Fails with Error 1625
description: Helps resolve the error 1625 that occurs when you install Visual Studio 2022 using the online installer.
ms.date: 11/22/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Visual Studio 2022 online installation fails with the error code 1625

## Symptoms

When you install Visual Studio 2022 online, the process fails with the following error:

> Package 'Microsoft.VisualStudio.Devenv.MSI' fails to install, Return Code 1625.

## Cause

Error code 1625: This installation is prohibited by system policy.

The authorization level returned by the Software Restriction Policy is 0x0 (returned status 0x800b010c). `0x800b010c` usually means that a required certificate is revoked. 

Installation isn't allowed under the Software Restriction Policy. Windows Installer can only install unrestricted items. 

## Resolution

To resolve the error, follow these steps:

1. Open the **Control Panel** on your machine.
1. Select **Network and Internet** > **Internet Options**.
1. In the **Internet Options** window, select **Content**.
1. Under the **Certificates** section, select **Certificates**.
1. In the **Certificates** window, select **Untrusted Publishers**.
1. Look for any revoked certificates in the list. If you find a revoked certificate, select it and select the **Remove** button to remove it from the list.
1. After removing the revoked certificate, close the **Certificates** window and the **Internet Options** window.

Next, follow these steps to repair your Visual Studio installation using the Visual Studio Installer:

1. Launch the Visual Studio Installer on your machine.
1. In the **Visual Studio Installer** window, locate your installed version of Visual Studio 2022.
1. Select the three dots (**...**) button next to the Visual Studio 2022 installation and select **Repair**.
1. Follow the prompts to complete the repair process. The installer can repair your Visual Studio installation and resolve any issues related to the failed package installation.
