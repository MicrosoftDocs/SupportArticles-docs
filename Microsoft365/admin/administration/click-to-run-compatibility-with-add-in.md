---
title: Office 2010 Click-to-Run compatibility with add-ins
description: Discusses Office 2010 Click-to-Run compatibility with add-ins.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: gquintin
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# Office 2010 Click-to-Run compatibility with add-ins

## Summary

Because Microsoft Office 2010 Click-to-Run is in its own virtualized application space, some applications, such as add-ins, cannot access and or work correctly with Office 2010 applications.

### More Information About Click-to-Run

What is Click-to-Run? 

Click-to-Run is a new way to deliver and update Microsoft Office 2010 to broadband customers. Click-to-Run uses Microsoft virtualization and streaming technologies.

How does Click-to-Run work? 

Click-to-Run products use streaming. Think of this just as you think about how to stream video. You can watch the first part of the video before the whole file is downloaded. Similarly, with Click-to-Run, you can start using Office 2010 before the whole suite or product is downloaded. When you are using your application, the rest of the Office 2010 suite or product is being downloaded quietly in the background. 

Another aspect of Office Click-to-Run is the unique way that Office 2010 is stored after it is downloaded onto your computer. Click-to-Run uses Microsoft virtualization technology to contain Office 2010 inside a virtualized application space. This virtual "bubble" separates Office 2010 from the regular file system and applications on your computer. This lets Office 2010 Click-to-Run coexist side-by-side with any existing version of Office that is already installed on your computer. There are also other benefits to Office 2010 Click-to-Run.

What products use Click-to-Run?

Click-to-Run delivery is available for Microsoft Office Home and Student 2010 and for Microsoft Office Home and Business 2010 when you download directly from Microsoft. Click-to-Run is also used for Microsoft Office Starter 2010.

##  More Information

In-process, out-of-process, and hybrid add-ins

A key differentiator from a technical standpoint is whether the add-in is loaded in-process by an Office application or whether an out-of-process application is making a call into Office. 

Out-of-process add-ins/applications are stand-alone programs, scripts, or applications that use Office object model APIs to start functionality in the application and integrate with Office. In this case, the out-of-process application drives Office. Out-of-process applications are not supported in Click-to-Run.

In-process add-ins are loaded in-process by an Office application, and detected and opened by the application. Because of this, the Office application can use existing mechanisms, such as looking at specific registry keys or locations in the file system to discover all in-process add-ins. There is no such mechanism for out-of-process add-ins. Generally, in-process add-ins work with Click-to-Run.

##  Workaround

If Office 2010 Click-to-Run does not meet your needs, you can uninstall it. Then, install Office 2010 by using a method other than Click-to-Run. To do this, follow these steps:


1. Uninstall the Click-to-Run version of Office 2010 from Control Panel.   
2. Visit the site where you purchased Office 2010, and sign in with the same Live ID that you used when you first purchased Office 2010.   
3. Click the **My Account** link at the top of the home page to access your Office downloads.   
4. Click the **Download** button for the suite that you purchased, and then click the **Advanced Options** link under the **Download Now** button.   
5. There is a version of Office 2010 listed that is not Click-to-Run and that does not require an available Q: drive.   