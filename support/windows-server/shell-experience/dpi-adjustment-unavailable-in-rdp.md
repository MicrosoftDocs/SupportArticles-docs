---
title: DPI adjustment is unavailable in Remote Session
description: This article describes a technique to make user-interface and font-size adjustments available to users that connect remotely to a Remote Desktop server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, sashalon
ms.custom: sap:dpi-and-display-issues, csstroubleshoot
ms.technology: windows-server-shell-experience
---
# The DPI adjustment isn't available in a Remote Session (RDP)

This article describes a technique to make user-interface and font-size adjustments available to users that connect remotely to a Remote Desktop server.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2544872

## Summary

When regular users connect to a remote session, they are unable to change the resolution of the display or the DPI settings. The DPI settings would normally be used to make a global change to the size of the fonts and other user-interface elements; for example, to increase the UI legibility. Changes to the global DPI settings can only be done by an administrator logged on to the console of the Windows Server or PC, and a reboot will be required. The DPI setting affects the entire user interface, including the logon interface (LogonUI).

Regular users (and users in a remote session) can adjust many UI elements individually, however, using the "Window Color and Appearance" in the Personalization Control Panel applet.  

In order to provide a solution to users, it is recommended that an Administrator create several Themes with different-sized fonts and UI elements, named in a discoverable way (for example, "120 dpi Theme", "150 dpi Theme"). This will enable remote desktop users to easily select a Theme with scaled-up user interface elements, from a familiar place in Windows (for example, Personalization applet; also accessible via a right-click on the desktop).

## More information

Scaled-up Themes can be created as follows:

- Log on as an administrator.
- Open the Personalization applet in Control Panel.
- Choose a Theme as a base.
- Use the Windows Color and Appearance to adjust fonts and other UI elements to a slightly larger size.
- Save the Theme with an appropriate name.
- For Windows Vista and Windows Server 2008, the resulting.theme file will be stored in the My Documents folder in the current user's profile. Move the file to the %systemroot%\Resources\Themes folder, which allows it to be shown along with the regular system Themes.  
- For Windows 7 and Windows Server 2008 R2, the resulting.theme file will be stored in AppData\Local\Microsoft\Windows\Themes folder in the current user's profile. Move the file to the %systemroot%\Resources\Ease of Access Themes folder, which will allow it to be shown with the other Ease of Access themes.
- Let users know that the new Themes are available in lieu of a system-wide DPI change.

The resulting Theme files can be copied to the appropriate %systemroot%\Resources folder on other Windows computers if needed.
