---
title: Office 2010 Setup programs not restart
description: Describes a problem in which you cannot rerun an Office suite installation or Office program installation after the first installation is interrupted.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: off12set
appliesto: 
  - Office 2010
  - IIS Media Services 2.0
ms.date: 03/31/2022
---

# The 2010 Office suite Setup program will not restart after an initial installation is interrupted

## Symptoms

Consider the following scenario. When you install a Microsoft Office suite or an Office program, the installation process is interrupted. Additionally, the Setup program is prevented from rolling back the Office installation. In this scenario, when you try to install the same Office suite or the Office program again, you receive the following error message: **Microsoft Office suite_name** encountered an error during setup.

## Cause

This problem may occur if the Rgstrtn.lck file is not removed from the computer. If this file is present when you try to install the same Office suite or the Office program that you previously tried to install, the Setup program detects the file. Then, the Setup program stops the installation.

## Workaround

To work around this problem, delete the Rgstrtn.lck file. To do this, follow the steps, as appropriate for the operating system that you are using.

> [!WARNING]
> If you install another Microsoft program after you receive the error message that is mentioned in the "Symptoms" section, you may experience problems with the program's Help system if you follow these steps. If you installed another Microsoft program after you receive the error message that is mentioned in the "Symptoms" section, uninstall the program before you follow these steps.

To work around this problem, delete the Rgstrtn.lck file. To do this, follow the steps, as appropriate for the operating system that you are using.

In Windows XP

1. Click **Start**, click **Run**, type cmd, and then click **OK**.   
2. Type cd "%allusersprofile%\Application Data\Microsoft Help", and then press ENTER.   
3. Type attrib -h rgstrtn.lck, and then press ENTER.   
4. Type del rgstrtn.lck, and then press ENTER.   
5. Type dir /b /od /ad, and then press ENTER.   
6. Type rd /q /s "\<folder names>", and then press ENTER.

   **Note** The \<folder names> are the folder names that are listed after you run the command in step 5. There should be a space between each folder-name. For example: rd /q /s "foldername1" "foldername2" "foldername3".   
7. Type exit, and then press ENTER.   

In Windows Vista and Windows 7

1. Click **Start**, and then type cmd in the **Start Search** box, and then click OK.   
2. Type cd "%allusersprofile%\Microsoft Help", and then press ENTER,   
3. Type attrib -h rgstrtn.lck, and then press ENTER.   
4. Type del rgstrtn.lck, and then press ENTER.   
5. Type dir /b /od /ad, and then press ENTER.   
6. Type rd /q /s "\<folder names>", and then press ENTER.

   **Note** The \<folder names> are the folder names that are listed after you run the command in step 5. There should be a space between each folder-name. For example: rd /q /s "foldername1" "foldername2" "foldername3"   
7. Type exit, and then press ENTER.   

After you perform these steps, you can try to install the Office suite or the Office program that you tried to install earlier.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.