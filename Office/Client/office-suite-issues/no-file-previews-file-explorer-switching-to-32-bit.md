---
title: Office shows one of the following error messages - “could not create the work file,” “Access denied,” or “file cannot be previewed”
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 02/13/2020
audience: ITPro
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Office
ms.custom: 
- CI 113658
- CI 146008
- CSSTroubleshoot 
ms.reviewer: salarson 
description: What to do if document previews don't show up after uninstalling the 64-bit version of Office and then installing the 32-bit version.
---

# Office shows one of the following error messages - “could not create the work file,” “Access denied,” or “file cannot be previewed”

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When trying to preview or save an Office file, the Office app might show one of the following errors:

- Word : "Word could not create the work file. Check the temp environment variable."
- PowerPoint : "Access denied. Contact your administrator."
- Excel : "This file cannot be previewed."

## Cause

The cause of the errors could be:
- A 64-bit version of Office 365 was installed, then uninstalled, and then a 32-bit version of Office 365 was installed, File Explorer encounters an error trying to show document previews. 
- The Temporary Internet Files folder for Windows Internet Explorer is in a location where you do not have permission to create new temporary files. 

## Workaround

### Method 1

Turn off the Preview Pane in File Explorer.

   :::image type="content" source="./media/no-file-previews-file-explorer-switching-to-32-bit\preview-pane.png" alt-text="In File Explorer, choose the View tab, and then Preview Pane.":::

If you want to keep the Preview Pane active, you can try the following registry key edit to solve the error:

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur.

To work around this issue, delete the following registry keys:

1. Press and hold or right-click the **Start** button, then select **Run**.
1. Enter regedit in the **Open:**box and select **OK**.
1. Search for and delete the following registry keys:
    - Word Preview: HKCR\CLSID\{84F66100-FF7C-4fb4-B0C0-02CD7FB668FE}
    - PowerPoint Preview: HKCR\CLSID\{65235197-874B-4A07-BDC5-E65EA825B718}
    - Excel Preview: HKCR\CLSID\{00020827-0000-0000-C000-000000000046}

1. Close Registry Editor and restart Windows.

### Method 2

If you’re still getting the error, create a new folder for the Temporary Internet Files:

1. Start Windows Explorer
1. Navigate to the folder location C:\Users\XXXX\AppData\Local\Microsoft\Windows (where XXXX represents your user profile name)
1. Create a folder with the title **INetCacheContent.Word**
> [!NOTE]
> It may be necessary to turn on Hidden Items in the View Ribbon of Windows Explorer.
