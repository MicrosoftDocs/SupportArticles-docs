---
title: Loss of image quality in an Office document
description: Discusses an issue in which a loss of image quality such as blur may occur after you save a document, spreadsheet, or presentation which contains an image. Provides a solution.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Save
  - CSSTroubleshoot
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: wbrandt, abraeg
appliesto: 
  - Office 2007
ms.date: 06/06/2024
---

# Loss of image quality after you save in Word, Excel, or PowerPoint 2007

## Symptoms

After saving a document, spreadsheet, or presentation which contains an image, a loss of image quality such as blur may occur.

## Cause

This issue occurs because PowerPoint, Excel, and Word perform a basic compression of images on save.

## Resolution

It isn't possible to recover pictures that have already been compressed.
For future saves, compression can be disabled on a per-file basis using the following steps:

1. Click the **Office** Button, and then click **Save As**. 
2. Click **Tools**, and then click **Compress Pictures**. 
3. Click Options. 
4. Click to clear the Automatically perform basic compression on save check box. 
5. Click **OK**. 
6. In the **Compress Pictures** dialog box, click **Cancel**.

   **Note**:  Clicking OK on this dialog won't prevent the issue from occurring.

You can also modify the following registry setting to prevent basic compression from occurring by default.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

> [!WARNING]
> Using Registry Editor incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems resulting from the incorrect use of Registry Editor can be solved. Use Registry Editor at your own risk.

1. Quit all applications.
2. Start the registry editor. To do this, click **Start**, click **Run**, type **regedit** in the **Open** box, and then click **OK**.
3. Browse to the following registry key:

   **for PowerPoint:**

    HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\PowerPoint\Options 

    **for Word:**

    HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options 

    **for Excel:**

    HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Excel\Options

4. Create a new **DWORD value** named **AutomaticPictureCompressionDefault**.
5. Make sure the value for the registry key is set to **0**.
6. Close the registry editor.
