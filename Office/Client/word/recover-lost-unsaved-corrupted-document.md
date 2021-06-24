---
title: How to recover a lost or unsaved Word document
description: Describes a range of options to locate and recover lost or unsaved Microsoft Word documents.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: 
- CSSTroubleshoot
- CI 118866
- CI 150212
ms.topic: article
ms.author: luche
appliesto:
- Word for Office 365
- Word 2019
- Word 2016
- Word 2013
- Word 2010
ms.date: 6/24/2021
---

# Recover a lost or unsaved Word document

Recover a lost or unsaved Microsoft Word document using these methods:

- [Search for Word documents](#searchdocs)
- [Search for Word backup files](#searchbackup)
- [Check the Recycle bin](#checkrecycle)
- [Restart Word to open AutoRecover files](#restartword)
- [Search for AutoRecover files](#autorecover)
- [Search for temporary files](#tempfiles)

If you're looking for information about how to recover other recent Office files, see the following articles:
- [Recover your Office files](https://support.office.com/article/recover-your-office-files-dc901de2-acae-47f2-9175-fb5a91e9b3c8)
- [Find lost files after the upgrade to Windows 10](https://support.microsoft.com/help/12386)

If you can’t open the document, or the content in the document is damaged, see [How to troubleshoot damaged documents in Word](./damaged-documents-in-word.md).

## Find a lost document

### <a id="searchdocs">Search for Word documents</a>

First, try searching for the document in Windows.

1. Select **Start**, type the document name (in Windows 8.1, type the name in the **Search** box), and then press Enter.
1. Take the following action, as appropriate:
    - If the **Documents** list (or **Files** list in Windows 8.1) contains the document, double-click the document to open it in Word.
    - If the list doesn't contain the file, try searching for Word backup files using the steps below.

### <a id="searchbackup">Search for Word backup files</a>

Word backup file names have a ".wbk" extension. If you have the "backup copy" option selected in Word, there might be a backup copy of the file.

To check if this option is on, select **File** > **Options** > **Advanced**, scroll down to the **Save** section, and then select **Always create backup copy**.

If you have a Microsoft 365 subscription, check these two folder locations for a backup first:
- *C:\Users\UserName\AppData\Roaming\Microsoft\Word*
- *C:\Users\UserName\AppData\Local\Microsoft\Office\UnsavedFiles*
    (Replace UserName in this example with your user name)

To find the backup copy of the file, select **Start**, and enter *.wbk* in the **Search** box. Then, press Enter. If you find any files that have the name "Backup of" followed by the name of the missing file, double-click the file name to open it.

If you don’t find a backup file for the document, check the Recycle Bin using the steps below.

### <a id="checkrecycle">Check the Recycle Bin</a>

If you deleted a Word document without emptying the Recycle Bin, you might be able to restore the document.

1. Double-click the Recycle Bin on the Desktop.
1. Search through the list of documents to see whether the deleted Word document is still there. If you don't know the name, look for file types such as .doc, .docx, and .dot.
1. If you find the desired Word file, right-click the file name, and then select **Restore** to recover the file.

**Windows File Recovery Tool**

If you are using Windows 10 version 2004 or above, you can also try the [Windows File Recovery tool](https://www.microsoft.com/p/windows-file-recovery/9n26s50ln705). Windows File Recovery is available from the Microsoft Store, and can be used to recover files that have been permanently deleted. For more information about this tool, see [Recover lost files on Windows 10](https://support.microsoft.com/windows/recover-lost-files-on-windows-10-61f5b28a-f5b8-3cc2-0f8e-a63cb4e1d4c4).

**Restore documents saved to SharePoint and OneDrive**

For documents saved or synced to SharePoint, see [Restore items in the recycle bin that were deleted from SharePoint or Teams](https://support.microsoft.com/office/restore-items-in-the-recycle-bin-that-were-deleted-from-sharepoint-or-teams-6df466b6-55f2-4898-8d6e-c0dff851a0be).

For documents saved or synced to OneDrive, see [Restore deleted files or folders in OneDrive](https://support.microsoft.com/office/restore-deleted-files-or-folders-in-onedrive-949ada80-0026-4db3-a953-c99083e6a84f).

## Find missing content or a newer version

Word takes different actions to protect your changes in Word documents.

- If Word opens a document from SharePoint or OneDrive, Word uses AutoSave to save changes into the “cloud” document. We suggest leaving AutoSave on.
    :::image type="content" source="./media/recover-lost-document\autosave-on.png" alt-text="Image shows the Autosave option in the On position.":::

- If Word opens a document from your local disk or network shared folder, Word uses AutoRecover to save changes into an AutoRecover file. The default AutoRecover save interval is 10 minutes. We suggest leaving AutoRecover on.
    :::image type="content" source="./media/recover-lost-document/word-options.png" alt-text="Image shows the Save Documents section of Word options, with Autorecover set to every ten minutes.":::

### <a id="restartword">Restart Word to open AutoRecover files</a>

Word searches for AutoRecover files every time it boots, so try closing and re-opening Word. If Word finds any automatically recovered file, the **Document Recovery** task pane opens, and the missing document is listed as "document name [Original]" or as "document name [Recovered]." If this occurs, double-click the file in the **Document Recovery** pane, select **File** > **Save as**, and then save the document as a .docx file. To manually change the extension to .docx, right-click the file, and select **Rename**.

**Note** In Microsoft 365 Subscription, when Word boots, it searches for AutoRecover files. If any recovered files are found, Word will open them with a Message Bar. Select Save to save the recovered file as a .docx file. When there are many recovered files, Word usually opens latest changed files and put the left files in **Document Recovery** task pane.
    :::image type="content" source="./media/recover-lost-document/recovered-unsaved-file.png" alt-text="Image shows header that says Recovered Unsaved File. This is a recovered file that is temporarily stored on your computer. There is a Save button next to it.":::

### <a id="autorecover">Search for AutoRecover files</a>

If you have a Microsoft 365 subscription, check these two folder locations for a backup first:
- *C:\Users\UserName\AppData\Roaming\Microsoft\Word*
- *C:\Users\UserName\AppData\Local\Microsoft\Office\UnsavedFiles*
    (Replace UserName in this example with your user name)

If you don’t find the file in those locations, open Word and select **File** > **Info** > **Manage Document** > **Recover Unsaved Documents**.

:::image type="content" source="./media/recover-lost-document/manage-document.png" alt-text="Image shows the Manage Document option, with Recover Unsaved Documents selected.":::

If you still haven’t found the file, try searching for recovered files manually:

1. Select **Start** and enter *.asd* in the **Search** box, then press Enter. If you find any files that have the .asd extension, do the following:
    - In Word, go to **File** > **Open** > **Browse**.
    - In the **files of type** list to the right of **File name**, select **All Files**.
    - Right-click the backup file that you found, and then select **Open**.
1. If there are no .asd files, try searching for temporary files using the instructions below.

### <a id="tempfiles">Search for temporary files</a>

Temporary file names have a .tmp extension. To find these files, follow these steps:

1. Select Start, type *.tmp* (in Windows 8.1, type .asd in the Search box), and then press Enter.
1. Select the **Documents** tab.
1. Scroll through the files, and search for file names that match the last few dates and times that you edited the document. If you find the document, skip to step 4, below.
    - If you don’t find it by searching for .tmp, try repeating steps 1 through 3 above, but search for ~ instead of .tmp (temporary file names start with ~).
1. In Word, go to **File** > **Open** and select the **Folders** tab.
1. Navigate or search for the folder where you found the .tmp file.
1. Select the name of the folder at the top. This will open File Explorer.
1. In File Explorer, change the file type (next to the file name field, near the bottom) to *All files*.
1. Open the .tmp file.

## References

- [What is AutoSave?](https://support.microsoft.com/topic/what-is-autosave-6d6bd723-ebfd-4e40-b5f6-ae6e8088f7a5)
- [How Word creates and recovers the AutoRecover files](https://support.microsoft.com/topic/how-word-creates-and-recovers-the-autorecover-files-a33ec235-9d68-cf62-e66a-6a740cf51821)