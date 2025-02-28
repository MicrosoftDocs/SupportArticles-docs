---
title: Run programs automatically
description: Describes how to use group policies in Windows 2000 to configure a program to run automatically when a user signs in.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:system management components\task scheduler
- pcy:WinComm User Experience
---
# How to run programs automatically when a user logs on

This article describes how to use group policies in Windows 2000 to configure a program to run automatically when a user signs in.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 240791

## Summary

You can apply a policy to an individual user or to a computer, and you can use any valid program (custom, third-party, or Windows 2000 programs such as Microsoft Internet Explorer). For example, use the appropriate method to configure Notepad.exe to run when a user signs in:

- To configure Notepad to run when any user signs in to a specific computer:
  1. Edit the following group policy:  
      Computer Configuration\\Administrative Templates\\System\\Logon\\Run These Programs at User Logon

  2. Type the full path name of the program. In this example, type the following path name:  
      `c:\%windir%\system32\notepad.exe`

- To configure Notepad to run when a specific user logs on (regardless of the computer he or she uses):
  1. Edit the following group policy:  
      User Configuration\\Administrative Templates\\System\\Run These Programs at User Logon

  2. Type the full path name of the program.

> [!NOTE]
> If the program doesn't run, make sure the path is correct. The program doesn't run (and no error message is displayed) if the path isn't found.
