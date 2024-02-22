---
title: Manage and distribute Outlook Visual Basic for Applications (VBA) projects
description: Describes how Outlook stores VBA code and supports one VBA project at a time. This article explains how to manage multiple projects.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: danba, brijs, catagh, gbratton, dvespa
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# Managing and distributing Outlook Visual Basic for Applications (VBA) projects

_Original KB number:_ &nbsp;290779

## Summary

This article provides an overview of how Microsoft Outlook stores Microsoft Visual Basic for Applications (VBA) code, and how you can manage multiple projects.

## More information

Unlike other Microsoft Office programs, Outlook supports only one VBA project at a time. VBA macros are stored in a file that's named VbaProject.OTM. This file is a product storage file and isn't meant for distribution. Outlook doesn't provide a direct means to manage OTM files. Outlook VBA code wasn't designed to be deployed or distributed. It was designed solely to be a personal macro development environment.
The project, Project1, is available and associated with the program at all times. It's not possible to add another project in the Visual Basic Editor.

Project1 is stored on your hard disk as VbaProject.otm in the following folder:

\<Drive>:\Users\\\<LogonName>\AppData\Roaming\Microsoft\Outlook

If you want to begin a new VBA project, you could theoretically export all your existing modules and forms. But this is typically not a realistic approach. Instead, follow these steps:

1. Exit Outlook.
2. Locate your VbaProject.otm file in the indicated path.
3. Rename the file to something meaningful to you, such as VbaProject-testing.otm.
4. Restart Outlook.

Because Outlook can't find an existing project file, Visual Basic Editor starts with a new project. When you save changes to your project, Outlook creates a new VbaProject.otm file in the folder.
If you want to switch between projects, add one more step to the previous procedure (as step 4):

1. Exit Outlook.
2. Locate your VbaProject.otm file.
3. Rename the file to something meaningful to you, such as VbaProject-testing.otm.
4. Restore the name the file that you now want to use as VbaProject.otm.
5. Restart Outlook.

If you want to move a VBA project from one computer to another, first determine where Outlook is storing the VbaProject.otm files on each computer. Then, copy the OTM file from one computer to the other, and make sure to put it into the correct folder. When you restart Outlook, the program will find the VbaProject.otm file and use it.
> [!IMPORTANT]
> Although you can do this, Microsoft Product Support Services can't support deploying solutions in this way. There are known issues that occur by using this procedure, and Outlook wasn't designed to support this functionality. As one example, there can be issues that affect compatibility with OTM files from different versions of Outlook. Therefore, if you update Outlook, copies of the VbaProject.otm file may no longer be compatible.

If you're developing a solution that you intend to distribute to more than a few people, you should convert your VBA code into an Outlook COM or VSTO add-in or an Office add-in for Outlook. However, developing an add-in typically requires considerably more programming knowledge than creating a short macro. If your VBA project is relatively simple, and there aren't too many people that have to use it, you may want to distribute the code together with instructions to set it up.
