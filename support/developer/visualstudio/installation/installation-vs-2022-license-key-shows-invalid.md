---
title: License Key Is Invalid When Installing Visual Studio 2022
description: Helps resolve an issue where the license key shows as invalid even though the license key is mentioned in the package when installing Visual Studio 2022.
ms.date: 12/09/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# The license key is invalid when installing Visual Studio 2022

## Symptoms

When you install Visual Studio 2022 with the parameter `--productKey` like `XXXXX-XXXXX-XXXXX-XXXXX-XXXXX`, the license key shows as invalid, and the installer repeatedly asks for the license key, even though you use the license key mentioned in the package.

## Cause

According to [Use command-line parameters to install, update, and manage Visual Studio](/visualstudio/install/use-command-line-parameters-to-install-visual-studio), the `--productkey` parameter only supports 25 alphanumeric characters in the format of `XXXXXXXXXXXXXXXXXXXXXXXXX`.

| Parameter      | Description                                                 |
|-----------------|-------------------------------------------------------------|
| `--productKey`  | **Optional**: During an install command, this parameter defines the product key to use for an installed product. It's composed of 25 alphanumeric characters in the format of `XXXXXXXXXXXXXXXXXXXXXXXXX`.|

## Resolution

To solve the issue, remove the dashes in `XXXXX-XXXXX-XXXXX-XXXXX-XXXXX` from the parameter `--productKey`. Here's an example:

```powershell
$RetVal = Execute-Process -Path "$dirFiles\vs_Professional.exe" -Parameters "--add Microsoft.VisualStudio.Workload.Data --add Microsoft.VisualStudio.Workload.DataScience --add Microsoft.VisualStudio.Workload.ManagedDesktop --locale en-US --quiet --wait --norestart --productKey XXXXXXXXXXXXXXXXXXXXXXXXX" -PassThru
```
