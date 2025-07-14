---
title: View error signatures if Office programs experience a serious error and quits
description: Explains how to view the error signatures when an Office program experiences a serious error and quits.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Reliability
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office
ms.date: 06/06/2024
---

# How to view error signatures if an Office program experiences a serious error and quits

## Introduction

If a Microsoft Office program experiences a serious error and quits, your computer records an error signature that describes the error that occurred. This article explains how to view these error signatures.

## More information

The error signature contains information, such as the program name, error name, and module name, that Microsoft uses to further develop and improve Microsoft products.

If you have an Internet connection, you can send this information directly to Microsoft by using the Office Application Error Reporting tool. If you choose to report this information, the tool checks to see if a solution to the problem is available, and if so, sends that information to you.

If you choose not to use the Office Application Error Reporting tool, you can use the information in the error signature to search the Microsoft Knowledge Base directly.

To find the error signature on your computer after a program stops responding, use the appropriate method for your operating system. 

### In Microsoft Windows 2000, Microsoft Windows XP, and Microsoft Windows Server 2003

The Event Viewer contains the error signature. To use the Event Viewer, follow these steps: 

1. Click Start, point to Settings, and then click Control Panel.    
2. Double-click Administrative Tools, and then double-click Event Viewer.    
3. In the Event Viewer, click the Application Log icon on the Tree tab.   
4. To view the log, double-click any entry in the right pane where the Source column contains Microsoft Office 10 for Microsoft Office XP or Microsoft Office 11 for Microsoft Office 2003.   
5. For additional information about how to use Event Viewer, click Help on the Action menu.   

### In Microsoft Windows NT 4.0 (SP6)

1. Click Start, point to Programs, point to Administrative Tools (Common), and then click Event Viewer.   
2. In Event Viewer, click Application on the Log menu to view events for applications.   
3. For additional information about how to use Event Viewer, click Help on the Action menu.   

### In Microsoft Windows 98 or Microsoft Windows Millennium Edition (Me)

The error signature is listed on the affected program's Help menu.

1. On the Help menu, click About Microsoft **Program name**.  
2. Click System Info, and then double-click Office 10 Applications in the folder tree.
3. Click the Office Event/Application Fault folder.

    The error log appears in the right pane.

You can also read this information in the DW.log file.
