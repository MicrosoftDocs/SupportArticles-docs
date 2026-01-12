---
title: Cannot import an ANSI .pst file
description: Error occurs when you try to import an ANSI .pst file in Microsoft Outlook for Mac.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Errors, Crashes, and Performance
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tsimon
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook for Mac cannot import an ANSI .pst file

_Original KB number:_ &nbsp; 2632329

## Symptoms

When you try to import a .pst file into Microsoft Outlook 2016 for Mac or Outlook for Mac 2011, you receive one of the following errors depending on your version of Outlook for Mac:

Outlook 2016 for Mac:

> There's something wrong with this file. Please try another file.

:::image type="content" source="media/cannot-import-ansi-pst-file/there-is-something-wrong-with-this-file.png" alt-text="Screenshot of the error There's something wrong with this file.":::

Outlook for Mac 2011:

> The Data File could not be imported. This Outlook Data File is saved in ANSI format, which cannot be imported by Outlook for Mac.

:::image type="content" source="media/cannot-import-ansi-pst-file/import-incomplete.png" alt-text="Screenshot of the Import Incomplete warning details.":::

## Cause

The .pst file is saved in the 97-2002 format, ANSI, that Outlook for Mac does not support.

## Workaround

Open the .pst file in Microsoft Outlook 2010, and move the contents to a new .pst file that is saved in Unicode format. To do this, follow these steps:

1. Open Outlook 2010, and select **File**, **Open**, **Open Outlook Data File**.
2. Browse to and select the ANSI .pst file.
3. Select the ANSI .pst file root in the Navigation Pane.

   :::image type="content" source="media/cannot-import-ansi-pst-file/select-ansi-pst-file-in-navigation.png" alt-text="Screenshot of the files under the ANSI .pst file root in the Navigation Pane." border="false":::

4. Select **File**, select **Options**, and then select **Advanced**.
5. Select **Export**, and then select **Export to a file** and select **Next**.
6. Select **Outlook Data File (.pst)**, and select **Next**.
7. Make sure the root of the ANSI .pst file is selected, and that **Include subfolders** is enabled, and then select **Next**.
8. Select **Browse** to choose a location for the new .pst file to be created, and enter a file name for it, and select **OK**.
9. Select **Finish**, enter a password for the PST if you prefer (optional), and select **OK**.
10. This creates a Unicode PST file in the location that you specified, that you can later import into Outlook for Mac successfully.
11. Open Outlook for Mac, and import the .pst file. For more information about how to import .pst files, see [Import a .pst file into Outlook for Mac from Outlook for Windows](https://support.microsoft.com/office/import-a-pst-file-into-outlook-for-mac-from-outlook-for-windows-b4a6a1d6-94bb-4c85-a4fc-a83dc690e18c).
