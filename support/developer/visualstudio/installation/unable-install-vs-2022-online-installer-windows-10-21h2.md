---
title: Can't Install Visual Studio 2022 Using Online Installer
description: Helps resolve an error that occurs when you install Visual Studio 2022 using the online installer on a Windows 10, version 21H2 machine.
ms.date: 12/06/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Unable to install Visual Studio 2022 using online installer on a Windows 10, version 21H2 machine

## Symptoms

When you install Visual Studio 2022 using the online installer on a Windows 10, version 21H2 machine, it fails with the following error message in the setup logs:

```output
HttpWebRequest& webRequest, String& remoteAddress, CancellationToken cancellationToken)
Download failed using WebClient engine. System.Configuration.ConfigurationErrorsException: Configuration system failed to initialize --->
System.Configuration.ConfigurationErrorsException: Unrecognized element. (C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config line 141)
```

## Cause

The error message indicates that there's a corrupt or incorrect setting in the **machine.config** file located at **C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\\**.

## Resolution

To solve the issue, follow these steps:

1. Open File Explorer and navigate to the path: **C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\\**.
1. In the **Config** directory, locate the **machine.config** file.
1. Rename the **machine.config** file to create a backup. You can rename it to **machine_bkp.config** or any other name of your choice.
1. Still in the same directory, locate the **machine.config.default** file.
1. Make a copy of the **machine.config.default** file.
1. Rename the new copy of the file to **machine.config**. This behavior replaces the existing **machine.config** file.
1. Restart your machine. It's important to reboot to ensure the changes take effect.

Renaming the **machine.config** file and replacing it with the default version can reset the configuration to its original state. This behavior can help resolve any corrupt or incorrect settings that caused the Visual Studio bootstrapper to fail during installation.

After rebooting your machine, try running the Visual Studio 2022 online installation again. The bootstrapper should now be able to launch successfully without encountering the `ConfigurationErrorsException` related to the **machine.config** file.
