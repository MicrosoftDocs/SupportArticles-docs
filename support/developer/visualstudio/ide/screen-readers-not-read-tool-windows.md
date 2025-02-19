---
title: Screen readers can't read tool windows
description: Visual Studio 2012 tool windows no longer accessible via screen reader software, due to scrollbar theming.
ms.date: 04/27/2020
ms.custom: sap:Integrated Development Environment (IDE)\Other
ms.reviewer: eddo, cbrochu
---
# Screen readers fail to read content of Visual Studio tool windows

This article helps you resolve the problem where screen readers fail to read content of Visual Studio 2012 tool windows.

_Original product version:_ &nbsp; Visual Studio 2012  
_Original KB number:_ &nbsp; 2854367

## Symptoms

Screen reading software like JAWS for Windows, System Access, fails to provide Text to Speech feedback for tool windows in the Visual Studio integrated development environment (IDE). Windows and tabs with themed scrollbars may not be read by some accessibility software.

## Cause

This is a known issue with the Visual Studio 2012 IDE. The Visual Studio 2012 scrollbars are themed by default, to ensure scrollbar styles don't inherit from the system but match the new Visual Studio UI themes. The underlying technology used for theming scrollbars may cause problems from some accessibility tools.

## Resolution

Users affected by this issue can work around it by running the following command from a Windows Command Prompt:

```console
reg ADD HKCU\Software\Microsoft\VisualStudio\11.0\General /v SuppressThemedScrollbars /t REG_DWORD /d 1 /f  
```

This command will add a registry key value that will turn off themed scrollbars in Visual Studio.

To remove the above workaround and re-enable Themed Scrollbars, run the following command:

```console
reg delete HKCU\Software\Microsoft\VisualStudio\11.0\General /v SuppressThemedScrollbars /f  
```

> [!NOTE]
> Visual Studio will need to be restarted after running either of the above commands.

## Applies to

- Visual Studio Express 2012 for Windows 8
- Visual Studio Express 2012 for Windows Desktop
- Visual Studio Express 2012 for Windows Phone
- Visual Studio Premium 2012
- Visual Studio Ultimate 2012
