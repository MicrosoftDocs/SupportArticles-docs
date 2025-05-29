---
title: Text that is in a text box control of a report or a form may not appear correctly in Access
description: Explains that the text that is in a text box control of a report or of a form does not appear correctly when the vertical property of the text box is changed to Yes.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
ms.date: 05/26/2025
---
# Text that is in a text box control of a report or a form may not appear correctly in Access

_Original KB number:_ &nbsp; 839779

This article applies to either a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file, and to a Microsoft Access project (.adp) file. Novice: Requires knowledge of the user interface on single-user computers.  

## Symptoms

In Microsoft Access, you can set the **Vertical** property of a text box control to Yes in a report or in a form. When you do this, you may notice that the text that is in the text box control does not appear correctly. You may notice any one of the following problems:

- The font of the text that is in the text box control changes to a different font.
- The text box control appears blank.
- The text that is in the text box control changes to text that is not readable.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To work around this problem, add the following registry entry, and then set the DWORD value to 1.

`HKEY_CURRENT_USER\Software\Microsoft\CTF\Disable Thread Input Manager`

To do this, follow these steps:

1. Click **Start**, click **Run**, type **regedit**, and then press ENTER.

2. Locate the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\CTF`

3. Right-click **CTF**, point to **New**, and then click **DWORD Value** to create the following entry:

   **Disable Thread Input Manager**

   > [!NOTE]
   > If you are running an x64-based version of Windows, click **DWORD (32-bit) Value** to create the entry.

4. Double-click **Disable Thread Input Manager**, type **1**, and then click **OK**.

5. Exit Registry Editor, and then restart the computer.
