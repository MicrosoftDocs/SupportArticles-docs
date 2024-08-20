---
title: GetObject and CreateObject functions in VBA
description: Discusses the different behaviors that occur when you use the GetObject and CreateObject functions with various versions of Microsoft Office applications.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Extensibility\Macros
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: rtaylor
appliesto: 
  - Microsoft Office
ms.date: 06/06/2024
---

# GetObject and CreateObject behavior of Office automation servers

## Summary

This article discusses the different behaviors that occur when you use the GetObject and CreateObject functions with various versions of Microsoft Office applications.
 
GetObject and CreateObject are functions that are provided by Microsoft Visual Basic and Microsoft Visual Basic for Applications (VBA). However, the information is also applicable to Microsoft Visual C++ if you treat references to GetObject as calls to the GetActiveObject API, and references to CreateObject as calls to the CoCreateInstanceAPI. 

## More Information

### GetObject

GetObject is used to attach to a running instance of an automation server. There are a few different ways to call GetObject, but the syntax that is recommended for the Microsoft Office applications is as follows: 

```vb
set xlApp = GetObject(, "Excel.Application")
```
 
If an instance of Microsoft Excel is running when this code is executed, you have access to the running instance's object model through the xlApp variable. If no instance is running, you receive the following trappable run-time error message:  

```adoc
Run-time error '429':
ActiveX component can't create object  
```

If multiple instances of Microsoft Excel are running, GetObject attaches to the instance that is launched first. If you then close the first instance, another call to GetObject attaches to the second instance that was launched, and so forth.

You can attach to a specific instance if you know the name of an open document in that instance. For example, if an instance of Excel is running with an open workbook named Book2, the following code attaches successfully to that instance even if it isn't the earliest instance that was launched: 

```vb
Set xlApp = GetObject("Book2").Application
```

### CreateObject

CreateObject is used to start a new instance of an Automation server. For example: 

```vb
set xlApp = CreateObject("Excel.Application")
```
 
Depending on whether the server is designed as SingleUse or MultiUse, another server process may or may not be launched. This might be an important distinction for deciding whether you should forcibly shut down an Automation instance. For example, with a MultiUse server, if an instance is already running before you attach to it, then you might want to avoid shutting down the server programmatically when you're done automating it.

The following table serves as a helpful reference when implementing a solution with Microsoft Office. It lists behaviors and attributes of the various versions and applications of Microsoft Office, such as whether the server defaults to being visible when launched, if it's SingleUse or MultiUse, if it has a UserControl property, if it has a Quit method, and the class name for its main window.

|Application(s)|Visible|Instancing|Has UserControl|Has QuitClassName|Class name|
|---|---|---|---|---|----|
|Excel 97, 2000, 2002, 2003, 2007|No|SingleUse|Yes|Yes|XlMain|
|Word 97, 2000, 2002, 2003, 2007|No|SingleUse|Yes|Yes|OpusApp|
|PowerPoint 97|No|MultiUse|No|Yes|PP97FrameClass|
|PowerPoint 2000|No|MultiUse|No|Yes|PP9FrameClass|
|PowerPoint 2002|No|MultiUse|No|Yes|PP10FrameClass|
|PowerPoint 2003|No|MultiUse|No|Yes|PP11FrameClass|
|PowerPoint 2007|No|MultiUse|No|Yes|PP12FrameClass|
|Access 97|Yes|SingleUse|Yes|Yes|OMain|
|Access 2000, 2002, 2003, 2007|No|SingleUse|Yes|Yes|OMain|
|Project 98, 2000|No|MultiUse|Yes|Yes|JWinproj-WhimperMainClass|

The main window class name is helpful for calling the FindWindow API when you want to find out conveniently if any instance is already running. The UserControl property is a boolean property that indicates whether the server application automatically shuts down when its last reference is released (set to nothing). The Quit method allows you to override the UserControl property in cases where it's necessary (such as when an instance doesn't shut down after the last reference is released).

In general, Microsoft recommends that you use a new instance of an Office application instead of attaching to an instance that the user may be using. It's best create an instance by using the Application ProgID, and then open or create new objects from there. Other ProgIDs, such as Excel.Sheet and Word.Document, and so forth, are intended for use in OLE (Object linking and Embedding) and may give inconsistent results when used with CreateObject. By using the Application ProgID, you avoid potential issues by explicitly starting the server for Automation (not Embedding).

When you're finished with the Automation server, release all your references to it and call its Quit method (if available) so that the server shuts down as expected. If you want to configure an instance through Automation and then leave it open for the user to use, you need to set the UserControl property to TRUE and then release all your references. The server then stays running (because the UserControl property is TRUE) and shuts down appropriately when the user closes the application (because there are no outstanding references). 

**Note** For Word, the UserControl property is read-only. It can't be set to True or False. Word always remains running when the last reference is released.
