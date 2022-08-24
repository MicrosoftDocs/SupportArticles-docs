---
title: Command-line arguments for Screen Savers
description: This article description of command-line arguments for Win32 Screen Savers marked 4.0 or higher.
ms.date: 02/28/2020
ms.custom: sap:Desktop app UI development
ms.topic: article
ms.technology: windows-dev-apps-desktop-app-ui-dev
---
# Screen Saver command-line arguments

This article introduces command-line arguments for Win32 Screen Savers marked 4.0 or higher.

_Original product version:_ &nbsp; Win32 Screen Saver  
_Original KB number:_ &nbsp; 182383

Windows communicates with Screen Savers through command-line arguments. The ScrnSave.lib library handles this for Screen Savers that are written to use it, but other Win32 Screen Savers marked 4.0 or higher must handle the following command-line arguments:

```console
ScreenSaver           - Show the Settings dialog box.
ScreenSaver /c        - Show the Settings dialog box, modal to the foreground window.
ScreenSaver /p <HWND> - Preview Screen Saver as child of window <HWND>.
ScreenSaver /s        - Run the Screen Saver.
```

Windows 95 Screen Savers must handle:

```console
ScreenSaver /a <HWND> - change password, modal to window <HWND>
```

*HWND* is an HWND presented on the command line as an unsigned decimal number.

You need create the preview window as a child of this window. It should cover the parent's entire client area.

You need create the password dialog box as owned by HWND if it's supplied or as owned by the foreground window if HWND isn't supplied.
