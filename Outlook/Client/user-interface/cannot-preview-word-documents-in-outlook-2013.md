---
title: Cannot preview Word documents
description: Describes a problem that triggers an error when you try to preview Word documents in Outlook 2013. The fix requires you to delete an Assist subkey from the registry.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# You can't preview Word documents in Outlook 2013

_Original KB number:_ &nbsp; 2998218

## Symptoms

You have Microsoft Office 2013 installed, and you try to preview a Microsoft Word document in Outlook 2013. In this situation, you receive the following error message:

> This file cannot be previewed because of an error with the following previewer:  
> Microsoft Word previewer  
> To open this file in its own program, double-click it.

## Cause

This problem occurs when the system registry contains the following subkey:

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\Word\Options\Assist`

When the registry contains this subkey, Outlook cannot preview a Word document.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To fix this issue, delete the Assist subkey from the registry. To do this, follow these steps:

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your situation:

   - Windows 10, Windows 8.1 and Windows 8: Press Windows key+R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.
   - Windows 7 or Windows Vista: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

3. Locate and then select the following subkey:  
   `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\ 15.0 \Word\Options\Assist`

4. Right-click the Assist key, and then select **Delete**.
5. When you are prompted to confirm the deletion, select **Yes**.
6. On the File menu, select **Exit** to exit Registry Editor.

## More information

The `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\word\options\assist` path is used by Group Policy for proofing tools such as those that correct capitalization, replace text as you type, and insert smart quotes.
