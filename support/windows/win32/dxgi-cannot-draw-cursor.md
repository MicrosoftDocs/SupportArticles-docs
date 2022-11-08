---
title: DXGI can't draw cursor to desktop image
description: This article discusses that a Desktop Duplication application running on Windows Serve 2012 that uses the DXGI 1.2 desktop duplication APIs doesn't draw the cursor to the desktop image. Provides a workaround.
ms.date: 03/10/2020
ms.custom: sap:Graphics and multimedia development
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# DXGI 1.2 desktop duplication APIs can't draw the cursor to the desktop image

This article helps you resolve the problem where Microsoft DirectX Graphics Infrastructure (DXGI) 1.2 Desktop Duplication application can't draw the mouse pointer to the desktop image.

_Original product version:_ &nbsp; Windows 8.1, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 2920206

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows Server 2012, Windows 8, or a later version of Windows.
- The system uses DXGI 1.2 desktop duplication APIs.
- You're running the Desktop Duplication application.

In this scenario, the Desktop Duplication application doesn't draw the mouse pointer to the desktop image.

## Cause

This issue occurs because the system is using a third-party Windows Display Driver Model (WDDM) graphics adapters or driver that doesn't support a hardware cursor. This issue doesn't occur if the graphics adapter uses the Microsoft Basic graphics driver.

## Workaround

To work around this issue, update the graphics driver to support a hardware cursor. If the graphics adapter itself can't support a hardware cursor, set the cursor scheme to **None**. This setting can reduce the effect of the issue. However, mouse pointer images will still be missing if the pointer has transparency or alpha blending set.

## More information

The graphics driver developer can emulate a hardware cursor by saving the background of the pointer image and performing a bit-block transfer of the pointer shape into the frame buffer. This method is used in the Microsoft Basic Display Adapter driver but was removed from the Display Only sample driver in the Windows Driver Kit (WDK).

For more information about DXGI, see [DXGI Overview](/windows/win32/direct3ddxgi/d3d10-graphics-programming-guide-dxgi).
