---
title: How to recover a lost Word document
description: Describes a range of methods to locate and recover lost Microsoft Word documents. Discusses Word 2002, Word 2003, Word 2007, and Word 2010 under various versions of Windows.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Word for Office 365
- Word 2019
- Word 2016
- Word 2013
- Word 2010
---

# How to recover a lost Word document

If you're looking for recent Word document recovery info, see:

- [Recover your Office files](https://support.office.com/article/recover-your-office-files-dc901de2-acae-47f2-9175-fb5a91e9b3c8) (For versions through Office 2019)
- [Find lost files after the upgrade to Windows 10](https://support.microsoft.com/help/12386/)

For more on earlier versions of Word, see:

- [How Word creates and recovers the AutoRecover files](https://support.microsoft.com/help/107686)

## Resolution

To fix this problem, use the following methods in the order in which they're presented, as appropriate for your situation.

### Method 1: Search for the original document

To do this, follow these steps, as appropriate for the version of Windows that you're running.

**Windows 10** and **Windows 7**

1. Select **Start**, type the document name in the **Start Search** box (.doc or .docx), and then press Enter. If the **File** list contains the document, double-click the document to open it in Word.
2. If the **File** list does not contain the file, go to Method 2.

### Method 2: Search for Word backup files

Word backup file names end with the .wbk extension. If the **Always create backup copy** option is selected, there may be a backup copy of the file.

> [!NOTE]
> To locate this option:
>
> - **Word for Office 365**, **Word 2019**, **Word 2016**, and **Word 2013**:
 Select File, then **Options**, and then **Advanced**. Scroll down to the **Save** section and select **Always create backup copy**.
> - **Word 2010**:
 Select File, then Options. In the **Save** tab, select **Always create backup copy**.

To find the backup copy of the file, follow these steps:

1. Locate the folder in which you last saved the missing file.
2. Search for files that have the .wbk file name extension.

If there's no .wbk file in the original folder, search the computer for any .wbk files. To do this, follow these steps:

**Windows 10** and **Windows 7**

1. Select **Start**, type *.wbk in the **Start Search** box, and then press Enter.
2. If the **File** list contains the backup file, repeat the steps in step 2 ("Search for files that have the .wbk file name extension") to open the file. If the **File** list does not contain the backup file, go to Method 3.

If you find any files that have the name "Backup of" followed by the name of the missing file, use one of the following procedures, as appropriate for the version of Word that you're running.

**Word for Office 365**, **Word 2019**, **Word 2016**, and **Word 2013**

1. On the **File** menu, select **Open**, and then **Browse**. (In some versions, select **Computer** and then **Browse**.)
2. In the **Files of type** list (All Word Documents), select **All Files**.
3. Select the backup file that you found, and then select **Open**.

**Word 2010**

1. On the **File** menu, select Open.
2. In the **Files of type** list (All Word documents), select **All Files**.
3. Select the backup file that you found, and then select **Open**.

### Method 3: Search for AutoRecover files

AutoRecover file names end with the .asd extension. By default, Word searches for AutoRecover files every time that it starts, and then it displays all that it finds in the Document Recovery task pane.

1. Use Word to automatically find the AutoRecover files. To do this, follow these steps:

   1. Right-click the taskbar, and then select **Task Manager**.
   2. On the **Processes** tab, select any instance of **Winword.exe** or **Microsoft Word**, and then select **End Task** or **End Process**. Repeat this step until you have exited all instances of Winword.exe and Word.
   3. Close the **Windows Task Manager** dialog box, and then start Word.

      If Word finds the AutoRecover file, the Document Recovery task pane opens on the left side of the screen, and the missing document is listed as "**document name** [Original]" or as "**document name** [Recovered]." If this occurs, double-click the file in the Document Recovery pane, select **Save As** on the **File** menu, and then save the document as a .docx file. Manually change the extension to .docx, if necessary, by right-clicking the file and selecting **Rename**.

2. If the Recovery pane does not open, manually search for AutoRecover files. To do this, use one of the following procedures, as appropriate for the version of Word that you're running.

   **Word for Office 365**, **Word 2019**, **Word 2016**, and **Word 2013**  
   1. On the **File** menu, select **Open**, and then Browse.
   2. If you don't see your document listed, select **Recover Unsaved Documents**.

   **Word 2010**
   1. On the File menu, select Recent.
   2. If you don't see your document listed, select **Recover Unsaved Documents**.

3. If you can't locate an AutoRecover file in the location that is identified in the **Folder name** list, search your whole drive for any .asd files. To do this, follow these steps:

   **Windows 10 and Windows 7**
   1. Select **Start**, type .asd in the **Start Search** box, and then press Enter.
   2. If the **File** list does not contain AutoRecover files, go to Method 4.
  
   If you find any files that have the .asd extension, use one of the following procedures, as appropriate for the version of Word that you're running:

   **Word 2019**, **Word 2016**, or **Word 2013**  
   1. On the **File** menu, select **Open**, and then **Browse**. (In some versions, select **Computer **and then **Browse**.)
   2. In the **Files of type** list (All Word Documents), select **All Files**.
   3. Select the .asd file that you found, and then select **Open**.

   **Word 2010**
   1. On the **File** menu, select **Open**.
   2. In the **Files of type** list (All Word Documents), select **All Files**.
   3. Select the .asd file that you found, and then select **Open**.

> [!NOTE]
> If you find an AutoRecover file in the Recovery pane that does not open correctly, go to "Method 6: How to troubleshoot damaged documents" for more information about how to open damaged files.

### Method 4: Search for temporary files

Temporary file names end with the .tmp extension. To find these files, use one of the following procedure.

**Windows 10** and **Windows 7**

1. Select **Start**, type .tmp in the **Start Search** box, and then press Enter.
2. On the **Show only** toolbar, select **Other**.
3. Scroll through the files and search for files that match the last few dates and times that you edited the document. If you find the document that you're looking for, go to "Method 6: How to troubleshoot damaged documents" for more information about how to recover information from the file.

### Method 5: Search for "~" files

Some temporary file names start with the tilde (~) character. To find these files, follow these steps:

**Windows 10** and **Windows 7**

1. Select **Start**, type ~ in the **Start Search** box.
2. Select **See more results**.

   Scroll through the files, and look for any that may match the last few dates and times that you edited the document. If you find the document that you’re looking for, go to "Method 6: How to troubleshoot damaged documents" for more information about how to recover information from the file.

For information about how Word creates and uses temporary files, see [Description of how Word creates temporary files](https://support.microsoft.com/help/211632).

### Method 6: How to troubleshoot damaged documents

For information about how to troubleshoot damaged Word documents, see the following articles in the Microsoft Knowledge Base:

[How to troubleshoot damaged documents in Word](https://support.microsoft.com/help/826864)  

## More information

You can lose a Word document in certain situations. For example, the document may be lost if an error occurs that forces Word to close, if you experience a power interruption while editing, or if you close the document without saving your changes.

> [!NOTE]
> The whole document may be lost if you have not recently saved the document. If you have saved your document, you may lose only the changes that you made since the last save. Be aware that some lost documents may not be recoverable.

The AutoRecover feature in Word performs an emergency backup of open documents when an error occurs. Some errors can interfere with the AutoRecover functionality. The AutoRecover feature is not a substitute for saving your files.

We do not provide any utilities to recover deleted documents. However, some third-party utilities to recover deleted documents might be available on the Internet.

For more information about AutoRecover, see the following articles in the Microsoft Knowledge Base:

- [What is AutoSave?](https://support.office.com/article/What-is-AutoSave-6d6bd723-ebfd-4e40-b5f6-ae6e8088f7a5)
- [WD2000: Why you are unable to recover a lost document](https://support.microsoft.com/help/212273)
- [WD2000: Automatically Saving Current Work (Open Document)](https://support.microsoft.com/help/211762)
- [How Word creates and recovers the AutoRecover files](https://support.microsoft.com/help/107686)

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.