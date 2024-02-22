---
title: How to export contacts via OWA
description: Describes how to export contacts from Outlook 2011 for Mac to Exchange Online by using Outlook Web App in a Microsoft 365 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: dahans
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 10/30/2023
---
# How to export contacts from Outlook 2011 for Mac to Exchange Online by using OWA in Microsoft 365

_Original KB number:_ &nbsp; 2648667

## Summary

This step-by-step article describes how to export contacts from Microsoft Outlook 2011 for Mac to Microsoft Exchange Online by using Microsoft Outlook Web App in a Microsoft 365 environment.

## Symptoms

A user sets up a profile in Outlook 2011 for Mac to connect to their Exchange Online mailbox in Microsoft 365. However, external contacts aren't synced with Exchange Online. This occurs because external contacts must be exported from Outlook 2011 for Mac and then imported to Outlook Web App. However, the existing method to export contacts from Outlook 2011 for Mac is to use a text-delimited file, and this file type isn't supported in Microsoft 365.

## Resolution

To export contacts from Outlook 2011 for Mac to Exchange Online by using Outlook Web App, follow these steps.

### Step 1 - Export the contacts from Outlook 2011 for Mac

1. In Outlook 2011 for Mac, on the **File** menu, select **Export**.
2. In the Export Assistant, select **Contacts to a list (tab-delimited text)**, and then select the right arrow button.

   :::image type="content" source="media/how-to-export-contacts-via-owa/contacts-to-a-list-(tab-delimited-text).png" alt-text="screenshot of the Export Assistant page, showing Contact to a list (tab-delimited text) is selected.":::

3. Select **Done** to finish.

   :::image type="content" source="media/how-to-export-contacts-via-owa/export-complete-page.png" alt-text="screenshot of the Export Complete page.":::

> [!NOTE]
>
> - Tab-delimited files are saved with a .txt extension.
> - Contacts that are already associated with a Microsoft Exchange Server account or a directory services account aren't exported.

### Step 2 - Open the contacts by using Excel 2011 for Mac

1. In Excel 2011 for Mac, on the **File** menu, select **Open**, and then select the .txt file that you created in step 1.
2. In the Text Import Wizard, follow these steps. Be aware that in these next three steps, the default settings are used.
   1. Select **Delimited** as the file type, and then select **Next**.

      :::image type="content" source="media/how-to-export-contacts-via-owa/delimited-option.png" alt-text="Screenshot of the Text Import Wizard, showing the delimited file type is selected." border="false":::

   2. Under **Delimiter**, select the **Tab** check box, and then select **Next**.

      :::image type="content" source="media/how-to-export-contacts-via-owa/the-tab-checkbox-under-delimiters.png" alt-text="Screenshot of the Text Import Wizard, showing the Tab check box is selected." border="false":::

   3. Under **Column data format**, select **General**, and then select **Finish**.

      :::image type="content" source="media/how-to-export-contacts-via-owa/general-option-under-column-data-format.png" alt-text="Screenshot of the Text Import Wizard, showing the General is selected as column data format." border="false":::

### Step 3 - Export the contacts to a .csv file by using Excel 2011 for Mac

1. In Excel 2011 for Mac, on the **File** menu, select **Save As**.
2. In the **Save As** box, type a name for the file.
3. On the **Format** pop-up menu, select **MS-DOS Comma Separated (.csv)**, and then select **Save**.
4. A dialog box appears that contains the following message:

   > This workbook contains features that will not work or may be removed if you save it in the selected file format. Do you want to continue?

5. Select **Continue**.

### Step 4 - Import the contacts to Outlook Web App

1. In Outlook Web App, on the **Options** menu, select **See All Options**.
2. On the right side, under **Shortcuts to other things you can do**, select **Import your contacts from an existing e-mail account**.
3. Browse to the .csv file that you created in step 3, and then select **Next**.
4. When you are finished, the contacts are displayed in the Contacts folder in Outlook Web App.

## References

For more information about how to import contacts, visit the following Microsoft website:

[Import contacts to Outlook](https://support.microsoft.com/office/import-contacts-to-outlook-bb796340-b58a-46c1-90c7-b549b8f3c5f8).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
