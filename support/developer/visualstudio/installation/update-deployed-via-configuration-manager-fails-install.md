---
title: Update deployed via Configuration Manager fails to install
description: Provides a resolution for an issue where the Visual Studio update deployed using Microsoft Configuration Manager fails to install.
ms.date: 09/26/2023
ms.reviewer: khgupta, raviuppa, aartigoyle, v-sidong
ms.custom: sap:installation
---
# The Visual Studio update deployed via Configuration Manager fails to install

_Applies to:_ &nbsp; Visual Studio 2022

## Symptoms

The Visual Studio update deployed using Microsoft Configuration Manager fails to install. You may also see the following message in the installation log:

```output
[5600:0007][2022-11-03T03:10:10] Warning: Pre-check verification: Save your work before continuing.
```

## Cause

The update process requires all the following Visual Studio-related processes to be closed before installation.

- node
- devenv
- WebViewHost
- VSIISExeLauncher
- vstest.console
- Visual Studio Standard Collector Service 150 (VSStandardCollectorService150)

If one or more of these processes are running on your machine, the update won't be installed.

## Resolution

To resolve the issue, follow these steps:

1. Close all Visual Studio-related processes running on your machine.
1. Reboot the machine to ensure a clean state.
1. Install the Visual Studio update again.

## More information

- [Applying administrator updates that use Microsoft Endpoint Manager (SCCM or Intune)](/visualstudio/install/applying-administrator-updates)
- [Enabling administrator updates to Visual Studio with Microsoft Endpoint Configuration Manager](/visualstudio/install/enabling-administrator-updates)
