---
title: SharePoint app Import Spreadsheet fails with error An unexpected error has occurred. (-2147352567)
description: Describes what to do if you receive an unexpected error (-2147352567) when using the Import Spreadsheet app in SharePoint.
author: helenclu
ms.author: luche
ms.reviewer: 
manager: dcscontentpm
search.appverid: 
  - MET150
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Files and Documents
  - CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# SharePoint app "Import Spreadsheet" fails with error "An unexpected error has occurred. (-2147352567)"

## Symptoms
When clicking the Import button using the SharePoint app "Import Spreadsheet" in SharePoint, you receive the following error:

> An unexpected error has occurred. (-2147352567).

## Cause
Security restrictions are preventing the web page from starting or accessing Excel.exe.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756) in case problems occur.

Delete or modify the following registry value:

1. Start the Registry Editor. To do this, use one of the following procedures, as appropriate for your situation:

   - Windows 10: Right-click or tap and hold the **Start** button, and then select **Run** to open a Run dialog box.
   - Windows 8: Press Windows Key+R to open a **Run** dialog box.
   - Windows 7 or Windows Vista: Select **Start**, and then select Run to open a **Run** dialog box.

2. Type regedit.exe, and then press Enter.
3. Locate and then click the following subkey:

   ```asciidoc   
   [HKEY_CURRENT_USER\Software\Microsoft\Office\Common\Security]
   ```

4. Click **Edit**, and then click **New String Value**. Enter the following text as the value name, and then press Enter:

   ```asciidoc
   "automationsecurity"=dword:00000003
   ```

5. On the File menu, click **Exit** to exit Registry Editor.

This policy setting controls whether macros can run in an Office application that is opened programmatically by another application.

If you enable this policy setting, you can choose from three options for controlling macro behavior in Excel, PowerPoint, and Word when the application is opened programmatically:

- **Macros enabled** (default) - Macros can run in the programmatically opened application. This option enforces the default configuration in Excel, PowerPoint, and Word.
- **User application macro security level** - Macro functionality is determined by the setting in the "Macro Settings" section of the Trust Center.
- **Disable macros by default** - All macros are disabled in the programmatically opened application.

If this policy setting is disabled or not set, any separate program used to launch Microsoft Excel, PowerPoint, or Word programmatically can run macros without being blocked.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
