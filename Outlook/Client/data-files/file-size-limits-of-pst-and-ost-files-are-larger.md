---
title: File size limits of .pst and .ost files are larger
description: Describes an issue in which the file size limits of .pst and .ost files are larger in Outlook 2010 and Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, aruiz, tsimon, laurentc, amkanade, doakm, randyto, gbratton, bobcool, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# The file size limits of .pst and .ost files are larger in Outlook 2010 and Outlook 2013

_Original KB number:_ &nbsp; 982577

## Introduction

By default, Personal Folders (.pst) and offline Outlook Data File (.ost) files are in Unicode format in Microsoft Outlook 2010 and Outlook 2013. The overall size of .pst and .ost files has a preconfigured limit of 50 GB. This limit is larger than the limit for Unicode .pst and .ost files in Outlook 2007 and Outlook 2003.

> [!NOTE]
> The new Outlook file size limit of 50 GB can be increased or decreased by making changes to the Windows registry. For more information, see [How to configure the size limit for both (.pst) and (.ost) files in Outlook](https://support.microsoft.com/help/832925).

## More information

The default .pst file size limit in Outlook 2007 and in Outlook 2003 is 20 GB. If you are using a computer that has Outlook 2007 or Outlook 2003 installed, and you want to access a Unicode .pst file that was created in Outlook 2010 or later, you may have to reduce the size of the .pst file if the file size is at or near 20 GB. If the file size is greater than 20 GB, you will be unable to open the .pst file.

If you have to reduce the size of your Outlook 2010 or Outlook 2013 .pst file, you can export data from that .pst file to another .pst file. To do this, follow these steps:

1. Start Outlook 2010 or later with a profile that contains your original .pst file that is larger than 20 GB.
2. On the **File** tab, select **Info**. (The screenshot for this step is listed below).

   :::image type="content" source="media/file-size-limits-of-pst-and-ost-files-are-larger/file-tab-info.png" alt-text="Screenshot to select Info option on the File tab." border="false":::

3. Select **Cleanup Tools**, and then select **Archive**. (The screenshot for this step is listed below).

   :::image type="content" source="media/file-size-limits-of-pst-and-ost-files-are-larger/cleanup-tool-archive.png" alt-text="Screenshot to select Archive option after selecting Cleanup Tools." border="false":::

4. In the **Archive** dialog box, make the following changes: (The screenshot for this step is listed below).

   :::image type="content" source="media/file-size-limits-of-pst-and-ost-files-are-larger/archive-dialog-box.png" alt-text="Screenshot shows the changes in the Archive dialog box." border="false":::

   - Enable the **Archive this folder and all subfolders** option.
   - In the list of folders, select the .pst file that you want to archive.
   - In the **Archive items older than** drop-down list, specify a date during which a fairly large number of items will be archived. The date that you use depends on too many factors to provide an example date in this article.
   - In the **Archive file** box, select the destination .pst file for your archived messages.

   Because you may be archiving a large number of email messages, you should consider using a new .pst file for your archive.

### Video: How to reduce the .pst file size for Outlook

> [!NOTE]
> The archive process in Outlook 2010 and Outlook 2013 uses the Modified date on messages to determine the age of the item, but the archive process may not archive as many messages as expected. For more information, see [How to change the criteria that Outlook 2010 and Outlook 2013 use to archive different item types](https://support.microsoft.com/help/2553550).

If the archiving process does not reduce the Outlook .pst file size to less than 20 GB, you can break up the large .pst file and manually move messages from your large .pst file to another .pst file.

To quickly move one folder from a .pst file into a different .pst file, follow these steps:

1. Make sure that your large .pst file and the destination .pst file are both open in Outlook.
2. Right-click the folder in your large .pst file that you want to move to the other (smaller).pst file, and then select **Move Folder**.
3. In the **Move Folder** dialog box, select the destination .pst file, and then select **OK**.
