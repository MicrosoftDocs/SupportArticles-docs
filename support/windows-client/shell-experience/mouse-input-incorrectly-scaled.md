---
title: Mouse input in some games is incorrectly scaled on high-DPI devices
description: Describes how to work around an issue in which mouse input in some games is incorrectly scaled on high-DPI devices.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dpi-and-display-issues, csstroubleshoot
---
# Mouse input in some games is incorrectly scaled on high-DPI devices

This article describes how to work around an issue in which mouse input in some games is incorrectly scaled on high-DPI devices.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2907016

## Introduction

Windows 8.1 supports bitmap scaling of desktop application content for applications that don't natively support high-DPI displays. It also scales mouse, pen, and touch input that is sent to those applications. Scaling both input and output guarantees a consistent experience for the application user.

However, there are two scenarios in which scaling can be mismatched:

- Games that run in full-screen mode and bypass the output scaling of Windows (only input is scaled)
- Games that use "raw mouse input" in windowed mode and bypass the input scaling of Windows (only output is scaled)

Most Windows desktop applications don't use full-screen mode or raw input. However, games frequently use one or both configurations. Windows detects many full-screen games and exempts them from both input and output high-DPI scaling on successive starts. But this detection fails in some games and upgrade scenarios. In these cases, you may experience mouse input that is either consistently larger or consistently smaller than what is reflected on the screen. The effect can be seen either in the position of the pointer or the location at which you can interact with on-screen content.

## Workaround

We recommend that you manually configure games to be exempt from output and input high-DPI scaling. This should be done only for specific applications. This is because a change in the global desktop DPI scaling settings affects other desktop applications and may cause content to be displayed too small to be usable.

To make these configurations, locate the game's executable binary, and then change the compatibility properties of that file. To do this, follow these steps:

1. Locate the game's executable binary. You can usually search for the file by using Windows 8.1 search, as follows:
      1. On the **Start** screen, type the name of the game application.
      2. Right-click or press and hold the application's icon, and then select **Open file location**.A folder that contains the start menu shortcut for the application will open.
2. Change the compatibility properties, as follows:
      1. Right-click or press and hold the file explorer icon for the application, and then select **Properties**.
      2. On the **Compatibility** tab, select the **Disable display scaling on high DPI settings** check box.
      3. Tap or click **Apply**, and then tap or click **OK**.

### Additional troubleshooting tips

- For some games, the shortcut starts a "launcher" application that then starts the game. You may have to locate the actual game application and then apply this compatibility change to it.
- Some applications provide compatibility options within the application instead of using the application's **Properties** window. If this window doesn't have a **Compatibility** tab, determine whether the options within the application include the ability to disable high-DPI scaling.
