---
title: Visual Studio Installation Stops on Windows 10 21H2
description: Helps resolve an error that occurs when you install Visual Studio using the online installer on a Windows 10, version 21H2 machine.
ms.date: 12/27/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Visual Studio installation stops during package 10 on Windows 10, version 21H2

## Symptoms

When you install Visual Studio on a Windows 10, version 21H2 machine, it stops during the installation of package 10, and you see the following message in the event viewer for **setup.exe**:

```output
Log Name: Application
Source: Application Hang
Event ID: 1002
Task Category: Hanging Events
Level: Error
Keywords: Classic
User: N/A
Description: The program setup.exe version 3.4.2246.31370 stopped interacting with Windows and was closed. To see if more information about the problem is available, check the problem history in the Security and Maintenance control panel.
Event Xml: <Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event"> <System> <Provider Name="Application Hang"/> <EventID Qualifiers="0">1002</EventID>
```

This issue can also occur if the Visual Studio Installer is corrupt or fails to launch.

## Resolution

To resolve the issue, follow these steps:

1. Uninstall the Visual Studio Installer application.
1. Delete the folder and its contents located at **C:\Program Files (x86)\Microsoft Visual Studio\Installer**.
1. Go to the [Visual Studio page](https://visualstudio.microsoft.com/vs/) and download the edition that you're using.
1. Run the Visual Studio setup as an administrator.
