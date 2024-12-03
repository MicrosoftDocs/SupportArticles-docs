---
title: Visual Studio 2022 Installation Stops on Windows 10 21H2
description: Helps resolve an error that occurs when you install Visual Studio Professional 2022 using the online installer on a Windows 10, version 21H2 machine.
ms.date: 11/22/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# The installation of Visual Studio Professional 2022 stops during the installation of package 10 on a Windows 10, version 21H2 machine

## Symptoms

When you install Visual Studio Professional 2022 on a Windows 10, version 21H2 machine, it stops during the installation of package 10. In addition, you see the following message in the event viewer for **setup.exe**:

```output
Log Name: Application
Source: Application Hang
Event ID: 1002
Task Category: Hanging Events
Level: Error
Keywords: Classic
User: N/A
Description: The program setup.exe version 3.4.2246.31370 stopped interacting with Windows and was closed. To see if more information about the problem is available, check the problem history in the Security and Maintenance control panel.
Event Xml: <Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event"> <System> <Provider Name="Application Hang" /> <EventID Qualifiers="0">1002</EventID>
```

This issue can occur if the Visual Studio Installer is corrupt or fails to launch.

## Resolution

To resolve the issue, follow these steps:

1. Uninstall the Visual Studio Installer application.
1. Delete the folder and its contents located at **C:\Program Files (x86)\Microsoft Visual Studio\Installer**.
1. Download the latest **vs_Professional.exe** file.
1. Run the **vs_Professional.exe** file as an administrator.
1. Install [Visual Studio 2022](https://visualstudio.microsoft.com/vs/).
