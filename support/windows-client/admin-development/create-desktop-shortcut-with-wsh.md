---
title: Create a desktop shortcut with Windows Script Host
description: Describes how to create desktop shortcuts by using the Windows Scripting Host from within Visual FoxPro.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Application Technologies and Compatibility\Windows Script Host (CScript or WScript), csstroubleshoot
---
# How to create a desktop shortcut with the Windows Script Host

This article describes how to create desktop shortcuts by using the Microsoft Windows Script Host (WSH) from within Visual FoxPro.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 244677

## Summary

The WSH is a tool that allows you to run Microsoft Visual Basic Scripting Edition and JScript natively within the base Operating System, either on Windows 95 or Windows NT 4.0. It also includes several COM automation methods that allow you to do several tasks easily through the Windows Script Host Object Model. The Microsoft Windows Script Host is integrated into Windows 98, Windows 2000, and later versions of the Windows operating system. It is available for Windows NT 4.0 by installing the Windows NT 4.0 Option Pack. To download this tool, visit [Scripting](/previous-versions/ms950396(v=msdn.10)).

## Examples to create a desktop shortcut with WSH

This program demonstrates how to use the Windows Script Host to create a shortcut on the Windows Desktop. In order to run this example, you must have the Windows Script Host installed on your computer. To run one of these examples, copy the code below into a new program file and run it.

### Example 1

```vbs
WshShell = CreateObject("Wscript.shell")
strDesktop = WshShell.SpecialFolders("Desktop")
oMyShortcut = WshShell.CreateShortcut(strDesktop + "\Sample.lnk")
oMyShortcut.WindowStyle = 3 &&Maximized 7=Minimized 4=Normal
oMyShortcut.IconLocation = "C:\myicon.ico"
OMyShortcut.TargetPath = "%windir%\notepad.exe"
oMyShortCut.Hotkey = "ALT+CTRL+F"
oMyShortCut.Save
```

### Example 2: Add a command-line argument

```vbs
WshShell = CreateObject("WScript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop")
oMyShortCut= WshShell.CreateShortcut(strDesktop+"\Foxtest.lnk")
oMyShortCut.WindowStyle = 7 &&Minimized 0=Maximized 4=Normal
oMyShortcut.IconLocation = home()+"wizards\graphics\builder.ico"
oMyShortCut.TargetPath = "c:\Program Files\Microsoft Visual Studio\VFP98\vfp6.exe"
oMyShortCut.Arguments = '-c'+'"'+Home()+'config.fpw'+'"'
oMyShortCut.WorkingDirectory = "c:\"
oMyShortCut.Save
```

> [!NOTE]
> Depending on the version of Visual FoxPro that you are using, you may need to change the name and the path of the Visual FoxPro executable in Example 2.

### Example 3: Add a URL shortcut to the desktop

```vbs
WshShell = CreateObject("WScript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop")
oUrlLink = WshShell.CreateShortcut(strDesktop+"\Microsoft Web Site.URL")
oUrlLink.TargetPath = "http://www.microsoft.com"
oUrlLink.Save
```

> [!NOTE]
> For the shortcut to be created, valid parameters must be passed for all methods. No error appears if one of the parameters is incorrect.

## References

- White paper: Windows Script Host: A universal Scripting Host for scripting languages
- Technical paper: Windows Script Host programmer's reference
