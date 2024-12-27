---
title: System Configuration Error Using Online Installer
description: Helps resolve a system configuration error that occurs when you install Visual Studio using the online installer on a Windows 10, version 21H2 machine.
ms.date: 12/27/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Unable to install Visual Studio using online installer on a Windows 10, version 21H2 machine

## Symptoms

When you install Visual Studio using the online installer on a Windows 10, version 21H2 machine, it fails with the following error message in the setup logs:

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
1. Rename the new copy of the file to **machine.config**. This file replaces the existing **machine.config** file with the default version.
1. Restart your machine to ensure the changes take effect.

Renaming the **machine.config** file and replacing it with the default version resets the configuration to its original state, which can help resolve any corrupt or incorrect settings that might have caused the Visual Studio bootstrapper to fail during installation.

After restarting your machine, run the Visual Studio online installation again. The bootstrapper should now be able to launch successfully without encountering the `ConfigurationErrorsException` related to the **machine.config** file.
