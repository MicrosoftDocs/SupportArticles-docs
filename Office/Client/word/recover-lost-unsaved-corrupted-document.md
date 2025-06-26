---
title: How to recover unsaved Word documents
description: Describes a range of options to locate and recover lost or unsaved Microsoft Word documents.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open\Recovery
  - CSSTroubleshoot
  - CI 118866
  - CI 150212
  - CI 155568
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
ms.date: 06/06/2024
---

# How to recover unsaved Word documents

You can try to recover an unsaved Word document by:

- [Searching for AutoRecover files](#autorecover)
- [Searching for Word documents](#searchdocs)
- [Searching for Word backup files](#searchbackup)
- [Checking the Recycle Bin](#checkrecycle)
- [Restarting Word to open AutoRecover files](#restartword)
- [Searching for temporary files](#tempfiles)

If you're looking for information about how to recover other recent Office files, see the following articles:

- [Recover your Microsoft 365 files](https://support.microsoft.com/office/recover-your-microsoft-365-files-dc901de2-acae-47f2-9175-fb5a91e9b3c8)
- [Recover files in Office for Mac](https://support.microsoft.com/office/recover-files-in-office-for-mac-6c6425b1-6559-4bbf-8f80-4f038402ff02)
- [Find lost files after the upgrade to Windows 10 or 11](https://support.microsoft.com/windows/find-lost-files-after-the-upgrade-to-windows-10-or-11-10af49aa-b372-b067-a334-2314401297a9)

If you can't open the document, or the content in the document is damaged, see [How to troubleshoot damaged documents in Word](./damaged-documents-in-word.md).

**To find a lost document:**

### <a id="autorecover">Searching for AutoRecover files</a>

If you have a Microsoft 365 subscription, check the following folder locations for backup files:
- C:\Users\\<UserName\>\AppData\Roaming\Microsoft\Word
- C:\Users\\<UserName\>\AppData\Local\Microsoft\Office\UnsavedFiles
    
**Note:** In these paths, replace \<UserName\> with your username.

If you don't find the missing file in these locations, open Word, and select **File** > **Info** > **Manage Document** > **Recover Unsaved Documents**.

:::image type="content" source="media/recover-lost-document/manage-document.png" alt-text="Screenshot shows the Manage Document option, with Recover Unsaved Documents selected.":::

If you still haven’t found the file, try manually searching for AutoRecover files. To do this, select **Start**, enter *.asd* in the **Search** box, then press Enter.

If you find any files that have the .asd extension, follow these steps:

1. Open Word, and then go to **File** > **Open** > **Browse**.
1. In the **files of type** list to the right of  **File name**, select  **All Files**.
1. Right-click the backup file that you found, and then select  **Open**.
 
If there are no .asd files, go to the next method.

### <a id="searchdocs">Search for Word documents</a>

Try searching for the document in Windows:

1. Select **Start**, type the document name (in Windows 8.1, type the name in the **Search** box), and then press Enter.
1. If the **Documents** list (or **Files** list in Windows 8.1) contains the document, double-click the document to open it in Word.
   
If the search results don't contain the file, go to the next method.

### <a id="searchbackup">Searching for Word backup files</a>

Word backup file names have a ".wbk" extension. If you have the "backup copy" option selected in Word, there might be a backup copy of the file.

To check whether this option is on, select  **File** > **Options** > **Advanced**, scroll down to the  **Save**  section, and then select  **Always create backup copy**.

If you have a Microsoft 365 subscription, check these two folder locations for a backup file:
- C:\Users\\<UserName\>\AppData\Roaming\Microsoft\Word
- C:\Users\\<UserName\>\AppData\Local\Microsoft\Office\UnsavedFiles
    
**Note:** In these paths, replace \<UserName\> with your username.

To find the backup copy of the file, select **Start**, enter *.wbk* in the **Search** box, and then press Enter. If you find any files that have the name "Backup of" followed by the name of the missing file, double-click the file name to open it.

If you don’t find a backup file for the document, go to the next method.

### <a id="checkrecycle">Checking the Recycle Bin</a>

If you deleted a Word document without emptying the Recycle Bin, you might be able to restore the document.

1. Double-click the Recycle Bin on the Desktop.
1. Search through the list of documents to see whether the deleted Word document is still there. If you don't know the file name, look for file types such as .doc, .docx, and .dot.
1. If you find the desired Word file, right-click the file name, and then select **Restore** to recover the file.

If you don't find the desired file, go to the next method.

**Windows File Recovery Tool**

If you are using Windows 10, version 2004 or later, you can try the [Windows File Recovery tool](https://www.microsoft.com/p/windows-file-recovery/9n26s50ln705). Windows File Recovery is available from the Microsoft Store. You can use it to recover files that have been permanently deleted. For more information about this tool, see [Recover lost files on Windows 10](https://support.microsoft.com/windows/recover-lost-files-on-windows-10-61f5b28a-f5b8-3cc2-0f8e-a63cb4e1d4c4).

**Restoring documents saved to SharePoint and OneDrive**

For documents that you saved or synced to SharePoint, see [Restore items in the recycle bin that were deleted from SharePoint or Teams](https://support.microsoft.com/office/restore-items-in-the-recycle-bin-that-were-deleted-from-sharepoint-or-teams-6df466b6-55f2-4898-8d6e-c0dff851a0be).

For documents that you saved or synced to OneDrive, see [Restore deleted files or folders in OneDrive](https://support.microsoft.com/office/restore-deleted-files-or-folders-in-onedrive-949ada80-0026-4db3-a953-c99083e6a84f).

**To find missing content or a newer version:**

Word takes different actions to protect your changes in Word documents:

- If Word opens a document from SharePoint or OneDrive, the program uses AutoSave to save changes to the “cloud” document. We recommend that you leave the AutoSave feature set to **On**.
    :::image type="content" source="media/recover-lost-document\autosave-on.png" alt-text="Image shows the AutoSave option in the On position.":::

- If Word opens a document from your local disk or network shared folder, Word uses AutoRecover to save changes to an AutoRecover file. We recommend that you leave the AutoRecover feature set to **On**, and set the AutoRecover save interval to five minutes or less.

    :::image type="content" source="media/recover-lost-document/word-options.png" alt-text="Screenshot shows the Save Documents section of Word options, with Autorecover set to every five minutes.":::

### <a id="restartword">Restarting Word to open AutoRecover files</a>

Word searches for AutoRecover files every time it starts. Therefore, you can try using the AutoRecover feature by closing and reopening Word. If Word finds any automatically recovered file, the **Document Recovery** task pane opens, and the missing document should be listed as "document name [Original]" or as "document name [Recovered]." If this occurs, double-click the file name in the **Document Recovery** pane, select **File** > **Save as**, and then save the document as a .docx file. To manually change the extension to .docx, right-click the file, and select **Rename**.

**Note:** In Microsoft 365 Subscription, when Word starts, it searches for AutoRecover files. If any recovered files are found, Word opens them by having a Message Bar. Select **Save** to save the recovered file as a .docx file. If there are many recovered files, Word usually opens the last-changed files, and puts the remaining files into the **Document Recovery** task pane.
    :::image type="content" source="media/recover-lost-document/recovered-unsaved-file.png" alt-text="Screenshot shows a header that reads, Recovered Unsaved File. This is a recovered file that is temporarily stored on your computer. There is a Save button next to it." border="false":::

### <a id="tempfiles">Searching for temporary files</a>

Temporary file names have a .tmp extension. To find these files, follow these steps:

1. Select Start, type *.tmp* (in Windows 8.1, type .asd in the Search box), and then press Enter.
1. Select the **Documents** tab.
1. Scroll through the files to search for file names that match the last few dates and times that you edited the document. 
    - If you find the missing file, go to step 4.
    - If you don’t find the file, repeat steps 1 through 3, but search on the tilde character (~) instead of .tmp (temporary file names start with a tilde).
1. In Word, go to **File** > **Open**, and then select the **Folders** tab.
1. Navigate to or search for the folder where you found the .tmp file, and then select the folder name to open the folder contents pane.
1. At the top of the pane, select the name of the folder. This opens File Explorer.
1. In File Explorer, change the file type (next to the file name field, near the bottom) to *All files*.
1. Open the .tmp file.

**References**

- [What is AutoSave?](https://support.microsoft.com/topic/what-is-autosave-6d6bd723-ebfd-4e40-b5f6-ae6e8088f7a5)
- [How Word creates and recovers the AutoRecover files](https://support.microsoft.com/topic/how-word-creates-and-recovers-the-autorecover-files-a33ec235-9d68-cf62-e66a-6a740cf51821)
