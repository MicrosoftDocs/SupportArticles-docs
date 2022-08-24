---
title: SystemParametersInfo works incorrectly
description: This article describes a problem in which Windows Explorer overrides changes to work area made by applications calling SystemParametersInfo (SPI_SETWORKAREA) on Windows 10.
ms.date: 03/16/2020
ms.custom: sap:Desktop app UI development
ms.reviewer: christys, delhan
ms.technology: windows-dev-apps-desktop-app-ui-dev
---
# Applications calling SystemParametersInfo function with SPI_SETWORKAREA flag might not work correctly in Windows 10

This article describes a problem that when you use an application to call the `SystemParametersInfo` function with the `SPI_SETWORKAREA` flag, the application may not work correctly in Windows 10.

_Original product version:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 4014104

## Symptoms

When you use an application that adjusts a monitor's work area by calling the `SystemParametersInfo` function with the `SPI_SETWORKAREA` flag, the application may not perform correctly in Windows 10.

## Cause

In Windows 10, Windows Explorer will handle `WM_SETTINGCHANGE` notifications that are generated as a result of changes to a monitor's work area by recalculating the work area for all monitors attached to the system. This recalculation takes into account the size and position of the taskbar window on the monitor and any app bars on the monitor that are registered by applications calling the `SHAppBarMessage` function. It does not take into account changes to the work area that is made by applications calling the `SystemParametersInfo` function. This behavior is by design.

Windows Explorer's recalculation of the work area may override changes that an application makes to a monitor's work area while Windows Explorer is running. Applications that rely upon modifying the work area may not perform correctly in Windows 10.

> [!NOTE]
> This issue does not occur prior to Windows 10.

## Reference

- [SHAppBarMessage function](/windows/win32/api/shellapi/nf-shellapi-shappbarmessage)

- [SystemParametersInfo function](/windows/win32/api/winuser/nf-winuser-systemparametersinfoa)
