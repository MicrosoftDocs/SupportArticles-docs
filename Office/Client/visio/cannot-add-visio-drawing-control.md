---
title: Cannot add Visio drawing control to Windows Form application
description: Provides a workaround for problems that occur when you work with the Microsoft Visio 2013 and 2010 drawing control in a Windows Form application in Visual Studio on a computer that has the 64-bit version of Visio 2010 installed.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: sthorn, HeidiMu, Arykhus, kevinmil, barbway
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Visio Standard 2013
  - Visio Professional 2013
  - Visio Premium 2010
  - Visio Professional 2010
  - Visio Standard 2010
ms.date: 03/31/2022
---

# You cannot add the Microsoft Visio 2010 or 2013 drawing control to a Windows Form application in Visual Studio if you have the 64-bit version of Visio installed

## Symptoms

You experience one of the following problems on a computer that has the 64-bit version of Microsoft Visio 2010 or 2013 installed:

- **Microsoft Office Visio Drawing Control** does not appear in the **COM Components** tab in the **Choose Toolbox Items** dialog box as expected. Therefore, you cannot add the drawing control to a Windows Form application in Microsoft Visual Studio.   
- When you rebuild a Windows Form application in Visual Studio that already has the drawing control, you may receive the following error message: 

  "Failed to create the wrapper assembly for type library "AxVisOcx". Did not find a registered ActiveX control in 'VisOcx'."

**Note** AxVisOcx is the ActiveX control wrapper assembly that enables the drawing control to be embedded in a Windows Form application. When you receive this error message, you receive other error messages that are caused by this problem. These error messages discuss the AxMicrosoft namespace.    

## Cause

These problems occur because the Visual Studio designer does not support 64-bit ActiveX controls and because the 64-bit version of Visio only works with the 64-bit version of the Microsoft Office Visio drawing control. Therefore, the drawing control cannot be instantiated. 

## Workaround

To work around this problem, follow these steps:

1. Install the 32-bit version of Visio on a computer.   
2. Add the 32-bit version of the Microsoft Office Visio drawing control to the Windows Form application in Visual Studio. Make all the necessary design changes to the drawing control.   
3. Move the Visual Studio project to a computer that has the 64-bit version of Visio 2010 installed. The drawing control cannot be seen in the Windows Form application. This is the expected behavior.   
4. Reconfigure the project to target the 64-bit platform. For more information about how to configure a project to target platforms, visit the following Microsoft Developer Network (MSDN) Web site: 
 
    [How to configure projects to target Platforms](https://msdn.microsoft.com/library/ms185328.aspx)
1. Use the 64-bit version of the MSBuild.exe tool to build the solution if the AxVisOcx wrapper assembly for the drawing control cannot be created by building the solution. To do this, follow these steps:
   1. Click **Start**, click **All Programs**, and then click **Accessories**.   
   2. Right-click **Command Prompt**, and then click **Run as administrator**.   
   3. At the command prompt, type the following command, and then press ENTER:cd **solution_path**   
   4. To build the solution, type the following command, and then press ENTER: **MSBuild_Path**\MSBuild.exe **solution_name**   

    **Notes**

    - **solution_path** is a placeholder for the path of the solution.   
    - **MSBuild_Path** is a placeholder for the path of the 64-bit version of the MSBuild.exe tool.   
    - **solution_name** is a placeholder for the name of the solution.   
    - You can safely ignore warnings that are related to setup projects. The MSBuild.exe tool does not support setup projects. Therefore, setup projects cannot be built.   
   
6. Build setup projects in the Visual Studio integrated development environment.   
