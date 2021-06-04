---
title: Office error “could not create the work file”
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 06/4/2021
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
- CI 150116
- CSSTroubleshoot 
ms.reviewer: salarson 
description: What to do if document previews don't show up after uninstalling the 64-bit version of Office and then installing the 32-bit version.
---

# Office error “could not create the work file”

## Symptoms

When trying to preview or save a file, Word shows the following error:

> Word could not create the work file. Check the temp environment variable.

## Resolution

First, run an antivirus scan. If your antivirus app doesn’t detect any malware, check for corrupt files or disk errors.

1. In Windows 10, select Start, type *cmd*, and then press Enter.

1. Right-click Command Prompt in the search results and select **Run as administrator**.

1. Type *sfc.exe /scannow* and press Enter.

1. After the check is done and any errors are repaired, type *chkdsk /r /f* and press Enter.

Restart your device and try the action in Word again. If the error still occurs, try the next method.

### Add an Environment Variable

1. Select the Windows Start button, then **Settings** > **System** > **About**.

1. Scroll down to **Related settings**, and then select **Advanced system settings**.

1. Select **Environment Variables**.

1. Under **User variables for username** (where “username” is your user name), select the **New…** button.

1. Enter the **Variable name** *%userprofile%* and the **Variable value** *C:\Users\username* (where username is the same as username in step 4, above).

1. Select **OK**, and then select **OK** on any confirmation windows that come up.

Restart your device and try the action in Word again. If the error still occurs, try the next method.

### Create a new folder for Temporary Internet Files

1. Start Windows Explorer

1. Navigate to the folder location `C:\Users\XXXX\AppData\Local\Microsoft\Windows` (where XXXX represents your user profile name).

1. Create a folder with the title *INetCacheContent.Word*.

> [!Note]
> It may be necessary to turn on Hidden Items in the View Ribbon of Windows Explorer.

Restart your device and try the action in Word again. If the error still occurs, try the next method.

### Turn off Preview pane or edit registry

To work around the issue, turn off the Preview pane in File Explorer.

   :::image type="content" source="./media/no-file-previews-file-explorer-switching-to-32-bit\preview-pane.png" alt-text="In File Explorer, choose the View tab, and then Preview Pane.":::

If you want to keep the Preview Pane active, you can try the following registry key edit to solve the error:

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur.

To work around this issue, delete the following registry keys:

1. Press and hold or right-click the **Start** button, then select **Run**.
1. Enter regedit in the **Open:**box and select **OK**.
1. Search for and delete the following registry subkeys:
    - Word Preview: `HKCR\CLSID\{84F66100-FF7C-4fb4-B0C0-02CD7FB668FE}`
    - PowerPoint Preview: `HKCR\CLSID\{65235197-874B-4A07-BDC5-E65EA825B718}`
    - Excel Preview: `HKCR\CLSID\{00020827-0000-0000-C000-000000000046}`

1. Close Registry Editor and restart Windows.