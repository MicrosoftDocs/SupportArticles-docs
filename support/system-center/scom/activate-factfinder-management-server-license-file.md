---
title: Activate a FactFinder management server license file
description: Describes how to activate a license file for a FactFinder management server.
ms.date: 08/13/2020
ms.custom: linux-related-content
---
# How to activate a license file for a FactFinder management server

This article describes how to activate a license file for a FactFinder management server.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134875

## New installation for Windows

For a new installation, there are two ways to activate the license file for a Windows base FactFinder management server.

### GUI (graphical user interface)

When installing the FactFinder management server with the GUI, the installer will prompt the user for the license file. The full path to the file can be typed into the dialog box, or the user can select the **Browse** button to search for the file. Once located, the user selects the file to continue with the installation.

### Command Line (silent install)

When installing the FactFinder management server from the command line, use the following command:

```console
InstallBlueStripeFactFinderMS.exe /S /LicenseFile=<path to license file>
```

## Replace existing or expired license file for Windows

1. Stop the management server service.
2. Copy the new license file to the root directory of where the management server is installed (default path is `c:\program files\bluestripe\factfinder\server`).
3. Delete the old license file in this directory.
4. Restart the management server service.

## New installation for Linux

For a new linux management server installation, there are two ways to activate the license file. For either method, it's best to copy the *.license* file to the same directory location from which the management server install script will run.

- Interactive Linux installation

    Run the `sh ./InstallBlueStripeFactFinderMS-Linux.bin` command and follow the prompts. The installer will find the *.license* file in the same directory, and apply that to the installation.

- Silent Linux installation

    Run the following command to do a silent installation that includes the *.license* file:

    ```console
    sh ./InstallBlueStripeFactFinderMS-Linux.bin -s --LicenseFile=<path to license file>
    ```

## Replace existing or expired license file for Linux

1. Stop the management server service.
2. Copy the new license file to the root directory of where the management server is installed (default path is `/usr/lib/bluestripe-management-server`).
3. Delete the old license file in this directory.
4. Restart the management server service.
