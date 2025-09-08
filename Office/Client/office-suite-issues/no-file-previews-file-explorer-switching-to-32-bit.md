---
title: Office error “could not create the work file”
description: What to do if document previews don't show up after uninstalling the 64-bit version of Office and then installing the 32-bit version.
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 06/06/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Office
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Save
  - CI 113658
  - CI 146008
  - CI 150116
  - CSSTroubleshoot
ms.reviewer: salarson
---

# "Could not create the work file” error in Office

## Symptoms

When you try to preview or save a document, Word returns the following error message:

> Word could not create the work file. Check the temp environment variable.

## Resolution

### Scan for malware and disk errors

1. Run an antivirus scan. If your antivirus program doesn’t detect any malware, check for corrupted files or disk errors.

1. Open an elevated Command Prompt window. To do this, select **Start**, enter *cmd*, and then press Enter.

1. In the search results, right-click **Command Prompt**, and then select **Run as administrator**.

1. Enter *sfc.exe /scannow*, and press Enter.

1. After the check is done and any errors are repaired, enter *chkdsk /r /f*, and then press Enter.

1. Restart your device, and try the action in Word again. If the error still occurs, try the next method.

### Add an Environment Variable

1. Select **Start** > **Settings** > **System** > **About**.

1. Scroll down to **Related settings**, and then select **Advanced system settings**.

1. Select **Environment Variables**.

1. Under **User variables for \<username>** (where **\<username>** is your user name), select the **New** button.

1. In the **Variable name** field, enter **%userprofile%**.
 
1. In the **Variable value** field, enter **C:\Users\\<username\>** (where **\<username\>** is the same value as **\<username>** in step 4).

1. Select **OK**, and then select **OK** on any confirmation window that opens.

1. Restart your device, and try the action in Word again. If the error still occurs, try the next method.

### Create a Temporary Internet Files folder

1. Start Windows Explorer.

1. Navigate to the following folder:

   C:\Users\\<username\>\AppData\Local\Microsoft\Windows\INetCache

   Note: In this path, **\<username>** represents your user profile name.

1. Create a folder, and name it *Content.Word*.

   Note: It might be necessary to turn on **Hidden Items** on the View ribbon of Windows Explorer.

1. Restart your device, and try the action in Word again. If the error still occurs, try the next method.

### Turn off Preview pane or edit registry

To work around the issue, turn off the Preview pane in File Explorer.

   :::image type="content" source="media/no-file-previews-file-explorer-switching-to-32-bit/preview-pane.png" alt-text="Screenshot of selecting the Preview Pane after selecting View tab in File Explorer.":::

If you want to keep the Preview Pane active, edit the following registry subkeys to fix the error.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur.

To work around this issue, delete the following registry keys:

1. Select **Start** > **Run**.
1. Enter *regedit* in the **Open:** box, and then select **OK**.
1. Search for and delete the following registry subkeys:
    - Word Preview: `HKCR\CLSID\{84F66100-FF7C-4fb4-B0C0-02CD7FB668FE}`
    - PowerPoint Preview: `HKCR\CLSID\{65235197-874B-4A07-BDC5-E65EA825B718}`
    - Excel Preview: `HKCR\CLSID\{00020827-0000-0000-C000-000000000046}`

1. Close Registry Editor, and restart Windows.
