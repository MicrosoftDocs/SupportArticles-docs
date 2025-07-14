---
title: Can't create DSN for Office System Driver
description: Describes an issue in which the drivers aren't visible when you attempt to create ODBC connections that utilize the Microsoft Office System Driver, such as connections to Access or Excel, on a 64-bit Operating system like Windows 7.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Data\
  - CSSTroubleshoot
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access 2010
  - Office Access 2007
  - Excel 2010
  - Office Excel 2007
  - Office Excel 2007 (Home and Student version)
  - Office Access 2003
  - Office Excel 2003
ms.date: 06/06/2024
---

# Unable to create DSN for Microsoft Office System Driver on 64-bit versions of Windows

## Symptoms

When attempting to create ODBC connections that utilize the Microsoft Office System Driver, such as connections to Access or Excel, on a 64-bit Operating system like Windows 7, the drivers aren't visible. They aren't visible in the standard ODBC Administrator dialog that is launched from the Administrative Tools dialog in the Control Panel.

## Cause

This occurs when the 32-bit version of Office or the 32-bit Office System Drivers is installed on a 64-bit version of Windows. In 64-bit versions of Windows, there's a separate ODBC Administrator used to manage 32-bit drivers and DSNs.

## Resolution

To locate the 32-bit Office System drivers, use the appropriate version of the ODBC Administrator tool. If you build and then run an application as a 32-bit application on a 64-bit operating system, you must create the ODBC data source by using the ODBC Administrator tool in %windir%\SysWOW64\odbcad32.exe. For example, the default location on a Windows 7 64-bit machine is "C:\Windows\SysWOW64\odbcad32.exe."

## More Information

On a 64-Bit Windows operating system, there are two versions of the ODBC Administrator tool. The 64-bit ODBC Administrator tool is the default dialog that is launched from the control panel and is used to manage the 64-bit drivers and DSNs on the machine. The second ODBC Administrator tool to manage the 32-bit drivers and DSNs on the machine can be launched from the SysWow64 folder.

To determine whether Office 2010 64-bit or 32-bit is installed, take the following steps:

1) Open an Office application like Excel.
2) Click on the File tab in the upper left corner.
3) Select Help on the left-hand side
4) Underneath "About Microsoft Excel," you'll see a version number and in parentheses 32-bit or 64-bit will be listed.

**Note**: All Office versions prior to Office 2010 can only be installed as 32-bit applications.

Here's a table that shows which ODBC Administrator Tool to use:

|Windows OS|Office Version|Data Source Administrator tool|
|---|---|---|
|Windows 64-bit|Office 2010 64-bit|64-bit ODBC Administrator tool %systemdrive%\Windows\System32\odbcad32.exe, or Control Panel\System and Security\Administrative Tools\Data Sources (ODBC)|
|Windows 64-bit|Office 2010, 2007, or 2003 32-bit|32-bit ODBC Administrator tool %windir%\SysWOW64\odbcad32.exe|
|Windows 32-bit|Office 2010, 2007, or 2003 32-bit|32-bit ODBC Administrator tool %systemdrive%\Windows\System32\odbcad32.exe, or Control Panel\System and Security\Administrative Tools\Data Sources (ODBC)|

For more information about known issues with using the 32-bit and 64-bit ODBC Administrator tool view the following article:

[942976](https://support.microsoft.com/help/942976) The 32-bit version of the ODBC Administrator tool and the 64-bit version of the ODBC Administrator tool display both the 32-bit user DSNs and the 64-bit user DSNs in a 64-bit version of the Windows operating system

For more information on the 2010 Office System Drivers view the following article:

[Microsoft Access Database Engine 2010 Redistributable](https://www.microsoft.com/download/details.aspx?id=13255)
