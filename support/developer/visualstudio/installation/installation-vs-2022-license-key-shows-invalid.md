---
title: License Key Is Invalid when Install Visual Studio 2022
description: Helps resolve an error where the license key shows as invalid even though the license key is mentioned on the package When install Visual Studio 2022.
ms.date: 11/22/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# The license key is invalid when install Visual Studio 2022

## Symptoms

When install Visual Studio 2022, the license key shows as invalid even though the license key is mentioned on the package. After the installation, it kept asking for a license key.

## Resolution

According to [Use command-line parameters to install, update, and manage Visual Studio](/visualstudio/install/use-command-line-parameters-to-install-visual-studio), the `--productkey` parameter only supports 25 alphanumeric characters in the format of `XXXXXXXXXXXXXXXXXXXXXXXXX`.

| Parameters      | Description                                                 |
|-----------------|-------------------------------------------------------------|
| `--productKey`  | **Optional**: During an install command, this parameter defines the product key to use for an installed product. It's composed of 25 alphanumeric characters in the format `XXXXXXXXXXXXXXXXXXXXXXXXX`.|

## Solution

To solve the issue, remove the dashes from the Product Key in the following command line:

```powershell
$RetVal = Execute-Process -Path "$dirFiles\vs_Professional.exe" -Parameters "--add Microsoft.VisualStudio.Workload.Data --add Microsoft.VisualStudio.Workload.DataScience --add Microsoft.VisualStudio.Workload.ManagedDesktop --locale en-US --quiet --wait --norestart --norestart --productKey XXXXX-XXXXX-XXXXX-XXXXX-XXXXX" -PassThru
```

The command line should be as the following one:

```powershell
$RetVal = Execute-Process -Path "$dirFiles\vs_Professional.exe" -Parameters "--add Microsoft.VisualStudio.Workload.Data --add Microsoft.VisualStudio.Workload.DataScience --add Microsoft.VisualStudio.Workload.ManagedDesktop --locale en-US --quiet --wait --norestart --productKey XXXXXXXXXXXXXXXXXXXXXXXXX" -PassThru
```
