---
title: Troubleshoot a Visual Basic compile or runtime error in Word
description: Describes how to troubleshoot a runtime or compile error that means there is an error in a macro or add-in attempting to run.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Word 2002
- Word 2000
---

# How to troubleshoot a Visual Basic compile or runtime error in Word

## Symptoms

Errors messages could be similar to the following:

- Microsoft Visual Basic Compile Error in Hidden Module
- Compile Error in Hidden Module

## Cause

A **runtime** or **compile** error means there is an error in a macro or add-in attempting to run. Typically these macros are created by a third-party and are not part of the Word installation. These errors could be caused by a malfunctioning virus as well.

## Resolution

A Visual Basic Runtime or Compile error indicates the error lies in a global template (.dot) or add-in (.wll) located in one of the Startup folders recognized by Word.

If you are unable to start Word then you should be able to utilize the Run command and the **/a** startup switch to start Word in a troubleshooting mode which uses the application defaults and prevents add-ins from loading.

### Starting Word with the /a switch

1. On the **Start** menu, click **Run**.
2. In the Run command text box, type: **winword /a** (note the space before the forward slash).
3. Click **OK** to start Word.

### To determine if you are using global templates or add-ins:

1. On the **Tools** menu, click **Templates and Add-Ins…**.
2. If any files are listed under the **Global templates and add-ins** section, then typically they are located in either your **Word Startup** folder or your **Office Startup** folder.

#### Locating the Word Startup folder

1. On the **Tools** menu, click **Options…**.
1. Select the **File Locations** tab.
1. Select **Startup** folder.
1. Click **Modify**.

**Word 2000 and below:**

1. Select the path in the Folder Name dialog and press Ctrl + C to copy the path.
1. Open an **Exploring** window, such as **My Computer**.
1. Click in the **Address** bar.
1. Press Ctrl + V to paste the Startup folder path.
1. Press **Enter** to navigate to the folder.
1. Follow the directions in the **Resolution** section at the end of this article.

**Word 2002 and above:**

1. Note the folder listed in the **Look in** drop down.
2. Click the **Up one Level** command in the **Modify Location** dialog.
3. Right-click the folder previously noted and click **Explore**.
4. Follow the directions in the **Resolution** section at the end of this article.

#### Locating the Office Startup folder

1. Open an **Exploring** window, such as **My Computer**.
1. Navigate to the Office Installation location.
1. Locate the **Startup** folder.

> [!NOTE]
> - The installation path for Office would be similar to: C:\Program Files\Microsoft Office\Office\Startup.
> - You can also use Windows Search and search for the file names listed in the Templates and Add-ins dialog box. Some COM Add-ins may manually add a global template and using Windows Search is the only means of locating the file.

### Resolution

To prevent a global template or add-in from loading when Word starts:

1. Exit Word.
1. Move the template out of its respective Startup folder. If more than one file is found then they should be moved one at a time in order to determine the exact file causing the error.

> [!NOTE]
> You can also rename the files in the Startup folder however it is imperative to rename the file extension and not the file name. Otherwise they will still load but under a different name. If in doubt move the files as they can be moved back into the folder at anytime.

## More information

This article also applies to Word 2003