---
title: Applications don't print to XPS Document Writer
description: This article describes a problem in which the Save As dialog box is hidden behind the app that's printing to an XPS Document Writer printer. This makes the application appear to hang. A workaround is provided.
ms.date: 12/19/2023
ms.reviewer: robcap, philipd
ms.custom: sap:other
ms.subservice: graphics-multimedia-dev
---

# The Save As dialog box is displayed behind the application that's printing to the XPS Document Writer

This article helps you resolve a problem where the **Save As** dialog box is hidden behind the app that's printing to an XPS Document Writer printer and the application stops responding.

_Original product version:_ &nbsp; XPS Document Writer  
_Original KB number:_ &nbsp; 2567869

## Symptoms

Consider the following scenario:

- You run a 32-bit application on a 64-bit version of Windows 7.
- You print from the application to a Microsoft XPS Document Writer (MXDW) printer. In this scenario, the **Save As** dialog box is displayed behind the application.

Additionally, you may experience the following symptoms:

- The application seems to stop responding (hang) until you enter a file name or cancel the printing task.
- The application that's printing doesn't become the foreground (active) application when the **Save As** dialog box is closed.

> [!NOTE]
> This problem may also occur when you print to a different printer whose driver displays the **Save As** dialog box or another modal dialog box. The printer driver for the Adobe PDF printer is this type of driver.

## Cause

Printer drivers are implemented as dynamic-link libraries (DLLs) that are loaded into a process that's printing. Printer drivers are implemented as 64-bit DLLs on 64-bit versions of Windows and as 32-bit DLLs on 32-bit versions of Windows.

A 32-bit process can't load 64-bit DLLs. Therefore, 64-bit versions of Windows support printing from 32-bit processes through the Splwow64.exe process. Splwow64.exe is a 64-bit process that can load 64-bit printer drivers and that handles printing for 32-bit processes.

When an application calls the `StartDoc` function to print to the XPS Document Writer printer, the XPS Document Writer printer driver displays a **Save As** dialog box so that users can specify the name and location of the XPS file. The owner window of the dialog box is typically the active window of the thread that is calling the `StartDoc` function, and the dialog box will appear over the active window.

When a 32-bit application calls the `StartDoc` function on a 64-bit version of Windows, the Splwow64.exe process calls in to the XPS Document Writer printer driver for the 32-bit application. In this scenario, the **Save As** dialog box is unowned because the thread in the Splwow64.exe process doesn't have an active window. The dialog box may appear behind the application that is printing because the Splwow64.exe process doesn't have permission to set the foreground window. Also, since the dialog is unowned, the application that called the `StartDoc` function may not become the foreground application when the dialog is closed.

The `StartDoc` call doesn't return until the dialog box is dismissed, so the application may seem to stop responding.

The **Save As** dialog box has its own button in the Windows Explorer taskbar if it's created by the Splwow64.exe process. This is because the dialog box is unowned. The taskbar button also flashes when the Splwow64.exe process can't set the foreground window.

## Workaround

To work around this issue, you can access the **Save As** dialog box through its taskbar button. Or, you can press Alt+Tab to switch the focus to the dialog box.

## More information

Software developers can avoid this problem in their 32-bit applications by having these applications detect when the user is printing to the XPS Document Writer printer or to the Adobe PDF printer. The application then specifies the full path to a file in the `DOCINFO.lpszOutput` structure member when calling the `StartDoc` function. The printer driver will use the specified file instead of prompting the user for a file.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
