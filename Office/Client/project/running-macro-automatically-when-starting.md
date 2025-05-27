---
title: Running a macro automatically when you start Project
description: Describes how to create a macro and run it automatically when you start Project.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Online Desktop Client
  - Project Professional 2019
  - Project Standard 2019
  - Project Professional 2016
  - Project Standard 2016
  - Project Professional 2013
  - Project Standard 2013
ms.reviewer: 
ms.date: 05/26/2025
---
# Running a macro automatically when you start Project

_Original KB number:_ &nbsp; 128622

## Summary

To make a macro run automatically whenever the Microsoft Project icon is used to start Microsoft Project, edit the command line for the icon's properties so that a project containing an Auto_Open macro is opened automatically at startup.

## More information

The following steps will cause an Auto_Open macro to be executed when you start Microsoft Project by double-clicking the Microsoft Project shortcut icon or by double-clicking the Microsoft Project file, which contains the Auto_Open macro.

In Project 2013 and 2010 use the following steps:

1. Create a new project.

    > [!NOTE]
    > For this example, the project is named as STARTUP.MPP, but you can use any valid filename.

1. From the **View** menu, choose **Macros**, and click **View Macros**.
1. Begin to type a new name for the macro called "Auto_Open" and click **Create**. Microsoft Visual Basic For Applications window will launch.
1. In the VBA editor, enter the code that you want to be run each time Microsoft Project is started.
1. From the editor's **File** menu, choose Save STARTUP.MPP, from the **File** menu, click **Close** and Return to Microsoft Project.
1. Save the plan and Close Microsoft Project. The next time you open this plan the Auto_Open macro will run if you answer Yes to enable macros.

    > [!NOTE]
    > The Auto_Open macro can also run other macros. For example, if there is only one macro in GLOBAL.MPT called "MyStartup," and if it takes no arguments, then Auto_Open can run it using: Macro "MyStartup".

1. Create a shortcut on your desktop for Microsoft Project. The executable is called WINPROJ.EXE.
1. Right-click the shortcut and click **Properties**. In Target, append the path to your saved plan STARTUP.MPP. For example: c:\winproj\winproj.exe c:\data\Startup.mpp, click **OK**.

> [!NOTE]
> The Auto_Open macro can also run other macros. For example, if there is only one macro in GLOBAL.MPT called "MyStartup," and if it takes no arguments, then Auto_Open can run it using: Macro "MyStartup".

Follow these steps for earlier versions of Microsoft Project:

1. Create a new project.

    > [!NOTE]
    > For this example, the project is named as STARTUP.MPP, but you can use any valid filename.

1. From the **Tools** menu, choose **Macros**, and choose the **New** button. Choose **Options**, and under Store Macro In, select **Current Project File**.
1. In the **Macro Name** box, type Auto_Open and choose **OK**.
1. Follow steps 4 through 8 above.

If you do not want the Auto_Open macro in STARTUP.MPP to be run, press and hold the SHIFT key when you start Microsoft Project.

Microsoft Project does not automatically create a blank Project1 when the icon is set up to automatically open a project. To create a new project, you can use the FileNew method in the Auto_Open macro in STARTUP.MPP.

If want to close STARTUP.MPP after you start Microsoft Project, add code to the Auto_Open macro to close it. For example, the following lines activate STARTUP.MPP and then close it without saving changes:

```vb
Projects("Startup.mpp").Activate
FileClose save:=pjDoNotSave
```
