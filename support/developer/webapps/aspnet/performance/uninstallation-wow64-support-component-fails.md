---
title: Uninstallation of WoW64 Support component fails
description: This article provides resolutions for the problem that On Windows 8 64 bit, if a customer installs ASP.NET on a 64-bit machine, and then attempts to uninstall the WOW64 subsystem, the WOW64 subsystem will fail to uninstall.
ms.date: 12/11/2020
ms.custom: sap:Performance
ms.reviewer: pranavra
---
# Uninstallation of WoW64 Support component fails when ASP.NET is installed on Windows 8 or Windows Server 2012

This article helps you resolve the problem where uninstallation of WoW64 Support component fails when ASP.NET is installed on Windows 8 or Windows Server 2012.

_Original product version:_ &nbsp; Windows 8, Windows Server 2012 Standard, Windows Server 2012 Standard  
_Original KB number:_ &nbsp; 2736294

## Symptoms

Consider the following scenario:

- You have a 64-bit computer running the Windows 8 or the Windows Server 2012 operating system, and with Internet Information Services (IIS) 8.0 and ASP.NET installed.
- You attempt to uninstall the WOW64 subsystem using the Remove Roles and Features Wizard, and then reboot the machine to complete the uninstallation.

In this scenario, after the machine has completed rebooting, you notice that the WOW64 subsystem is still present and failed to uninstall.

## Cause

This problem occurs because the 32-bit version of ASP.NET is failing to uninstall and causing the WOW64 uninstall to roll back. This is due to the fact that the ASP.NET custom actions are different executables for 32-bit and 64-bit; when the WOW 64 subsystem uninstalls, it causes the 32-bit ASP.NET to uninstall, which calls the 32-bit version of the custom actions.

## Workaround

To work around this problem, please take the following steps:

1. Uninstall ASP.NET.
2. Uninstall the WOW64 subsystem by disabling **WoW64 Support** from the Remove Features wizard in Server Manager.
3. Reinstall ASP.NET.

## Steps to reproduce

1. Install Win8 Server OS.
2. Start Server Manager.
3. Install IIS fully.
4. Start Server Manager again.
5. Select **Manage\Remove Roles and Features** to open the **Remove Roles and Features Wizard** dialog.
6. Continue the wizard and disable **WoW64 Support** from the **Remove features** wizard page.
7. Select **Remove Features** button and then finish the wizard.
8. OS should be restarted to complete uninstalling.

EXPECTED RESULT:

> Uninstall succeeded after rebooting

ACTUAL RESULT:

> Uninstall failed after rebooting

> [!NOTE]
> If you don't install IIS from the step3, you can't uninstall the WoW64 Support feature first with no problem.
