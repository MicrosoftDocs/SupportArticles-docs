---
title: How to recover a lost Word document
description: Describes a range of methods to locate and recover lost Microsoft Word documents. Discusses Word 2010, Word 2007, Word 2003, and Word 2002 under various versions of Windows.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: 
- CSSTroubleshoot
- CI 118866
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

## Summary

> [!NOTE]
> **Office 365 ProPlus** is being renamed to **Microsoft 365 Apps for enterprise**. For more information about this change, [read this blog post](https://go.microsoft.com/fwlink/p/?linkid=2120533).

If you're looking for recent Word document recovery info, see:

- [Recover your Office files](https://support.office.com/article/recover-your-office-files-dc901de2-acae-47f2-9175-fb5a91e9b3c8) (For versions through Office 2019)
- [Find lost files after the upgrade to Windows 10](https://support.microsoft.com/help/12386/)

For more on earlier versions of Word, see:

- [How Word creates and recovers the Auto-Recover files](https://support.microsoft.com/help/107686)

## Quick resolution

*Try the following options to help determine the cause of your printing failure. Select the arrow image to see more detailed instructions about that option.*

<table align="left">
<tr>
<td valign="top"> 
<a href="#option1">

![Option 1](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-1.png)

</a>
</td><td><b>Search for the original document</b>

**Windows 10** and **Windows 7**

Select **Start**, type the document name in the **Start Search** box (.doc or .docx), and then press Enter. If the **File** list contains the document, double-click the document to open it in Word.


</td>
</tr>
<tr>
<td valign="top">
<a href="#option2">

![Option 2](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-2.png)

</a>
</td>
<td><b>Search for Word Backup files</b>

1. Locate the folder in which you last saved the missing file.
2. Search for files that have the .wbk file name extension.

</td>
</tr>
<tr>
<td valign="top">
<a href="#option3">

![Option 3](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-3.png)

</a>
</td>
<td><b>Search for Auto-Recover files</b>

1. Right-click the taskbar and select **Task Manager**.
2. On the **Processes** tab, select any instance of **Winword.exe** or **Microsoft Word**, and then select **End Task** or **End Process**. Repeat this step until you have exited all instances of Winword.exe and Word.
3. Close the **Windows Task Manager** dialog box, and then start Word.

   Double-click the file in the Document Recovery pane, select **Save As** on the **File** menu, and then save the document as a .docx file. Manually change the extension to .docx, if necessary, by right-clicking the file and selecting **Rename**.



</td>
</tr>
<tr>
<td valign="top">
<a href="#option4">

![Option 4](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-4.png)

</a>
</td>
<td><b>Search for temporary files</b>

1. Select **Start**, type .tmp in the **Start Search** box, and then press Enter.
2. On the **Show only** toolbar, select **Other**.
3. Scroll through the files and search for files that match the last few dates and times that you edited the document. 


</td>
</tr>
<tr>
<td valign="top">
<a href="#option5">

![Option 5](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-5.png)

</a>
</td>
<td><b>Search for "~" files</b>

**Windows 10** and **Windows 7**

1. Select **Start**, type ~ in the **Start Search** box.
2. Select **See more results**.

   Scroll through the files, and look for any that may match the last few dates and times that you edited the document. 


</td>
</tr>
<tr>
<td valign="top">
<a href="#option6">

![Option 6](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-6.png)

</a>
</td>
<td><b>How to troubleshoot damaged documents</b>

For information about how to troubleshoot damaged Word documents, see the following articles in the Microsoft Knowledge Base:

[How to troubleshoot damaged documents in Word](https://support.microsoft.com/help/826864) 

</td>
</tr>

</table>


## Microsoft Support options

If you can't resolve this problem, you can use Microsoft Support to search the Microsoft Knowledge Base and other technical resources for answers. You can also customize the site to control your search. To start your search, go to the [Microsoft Support](https://www.microsoft.com/support/) website. 

## Additional resources
 
If you experience specific issues when you use Word, go to the following websites to search for specific information about your program version:

[Microsoft Word Product Solution Center: Word](https://support.office.com/search/results?query=word)

### Recover lost Word documents

<a id="option1">

### Option 1: Search for the original document

</a>

**Windows 10** and **Windows 7**

1. Select **Start**, type the document name in the **Start Search** box (.doc or .docx), and then press Enter. If the **File** list contains the document, double-click the document to open it in Word.
2. If the **File** list does not contain the file, go to Option 2.

<a id="option2">

### Option 2: Search for Word Backup files

</a>

Word Backup file names end with the .wbk extension. If the **Always create Backup copy** option is selected, there may be a Backup copy of the file.

> [!NOTE]
> To locate this option:
>
> - **Word for Office 365**, **Word 2019**, **Word 2016**, and **Word 2013**:
 Select File, then **Options**, and then **Advanced**. Scroll down to the **Save** section and select **Always create backup copy**.
> - **Word 2010**:
 Select File, then Options. In the **Save** tab, select **Always create backup copy**.

To find the Backup copy of the file, follow these steps:

1. Locate the folder in which you last saved the missing file.
2. Search for files that have the .wbk file name extension.

If there's no .wbk file in the original folder, search the computer for any .wbk files. To do this, follow these steps:

**Windows 10** and **Windows 7**

1. Select **Start**, type *.wbk in the **Start Search** box, and then press Enter.
2. If the **File** list contains the Backup file, repeat the steps in step 2 ("Search for files that have the .wbk file name extension") to open the file. If the **File** list does not contain the Backup file, go to Method 3.

If you find any files that have the name "Backup of" followed by the name of the missing file, use one of the following procedures, as appropriate for the version of Word that you're running.

**Word for Office 365**, **Word 2019**, **Word 2016**, and **Word 2013**

1. On the **File** menu, select **Open**, and then **Browse**. (In some versions, select **Computer** and then **Browse**.)
2. In the **Files of type** list (All Word Documents), select **All Files**.
3. Select the Backup file that you found, and then select **Open**.

**Word 2010**

1. On the **File** menu, select Open.
2. In the **Files of type** list (All Word documents), select **All Files**.
3. Select the Backup file that you found, and then select **Open**.

<a id="option3">

### Option 3: Search for Auto-Recover files

</a>

Auto-Recover file names end with the .asd extension. By default, Word searches for Auto-Recover files every time that it starts, and then it displays all that it finds in the Document Recovery task pane.

1. Use Word to automatically find the Auto-Recover files. To do this, follow these steps:

   1. Right-click the taskbar, and then select **Task Manager**.
   2. On the **Processes** tab, select any instance of **Winword.exe** or **Microsoft Word**, and then select **End Task** or **End Process**. Repeat this step until you have exited all instances of Winword.exe and Word.
   3. Close the **Windows Task Manager** dialog box, and then start Word.

      If Word finds the Auto-Recover file, the Document Recovery task pane opens on the left side of the screen, and the missing document is listed as "**document name** [Original]" or as "**document name** [Recovered]." If this occurs, double-click the file in the Document Recovery pane, select **Save As** on the **File** menu, and then save the document as a .docx file. Manually change the extension to .docx, if necessary, by right-clicking the file and selecting **Rename**.

2. If the Recovery pane does not open, manually search for Auto-Recover files. To do this, use one of the following procedures, as appropriate for the version of Word that you're running.

   **Word for Office 365**, **Word 2019**, **Word 2016**, and **Word 2013**  
   1. On the **File** menu, select **Open**, and then Browse.
   2. If you don't see your document listed, select **Recover Unsaved Documents**.

   **Word 2010**
   1. On the File menu, select Recent.
   2. If you don't see your document listed, select **Recover Unsaved Documents**.

3. If you can't locate an Auto-Recover file in the location that is identified in the **Folder name** list, search your whole drive for any .asd files. To do this, follow these steps:

   **Windows 10 and Windows 7**
   1. Select **Start**, type .asd in the **Start Search** box, and then press Enter.
   2. If the **File** list does not contain Auto-Recover files, go to Method 4.
  
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

<a id="option4">

### Option 4: Search for temporary files

</a>

Temporary file names end with the .tmp extension. To find these files, use one of the following procedures.

**Windows 10** and **Windows 7**

1. Select **Start**, type .tmp in the **Start Search** box, and then press Enter.
2. On the **Show only** toolbar, select **Other**.
3. Scroll through the files and search for files that match the last few dates and times that you edited the document. If you find the document that you're looking for, go to "Method 6: How to troubleshoot damaged documents" for more information about how to recover information from the file.

<a id="option5">

### Option 5: Search for "~" files

</a>

Some temporary file names start with the tilde (~) character. To find these files, follow these steps:

**Windows 10** and **Windows 7**

1. Select **Start**, type ~ in the **Start Search** box.
2. Select **See more results**.

   Scroll through the files, and look for any that may match the last few dates and times that you edited the document. If you find the document that you're looking for, go to "Method 6: How to troubleshoot damaged documents" for more information about how to recover information from the file.

For information about how Word creates and uses temporary files, see [Description of how Word creates temporary files](https://support.microsoft.com/help/211632).

<a id="option6">

### Option 6: How to troubleshoot damaged documents

</a>

For information about how to troubleshoot damaged Word documents, see the following articles in the Microsoft Knowledge Base:

[How to troubleshoot damaged documents in Word](https://support.microsoft.com/help/826864)  

## More information

You can lose a Word document in certain situations. For example, the document may be lost if an error occurs that forces Word to close, if you experience a power interruption while editing, or if you close the document without saving your changes.

> [!NOTE]
> The whole document may be lost if you have not recently saved the document. If you have saved your document, you may lose only the changes that you made since the last save. Be aware that some lost documents may not be recoverable.

The Auto-Recover feature in Word performs an emergency Backup of open documents when an error occurs. Some errors can interfere with the Auto-Recover functionality. The Auto-Recover feature is not a substitute for saving your files.

We do not provide any utilities to recover deleted documents. However, some third-party utilities to recover deleted documents might be available on the Internet.

For more information about Auto-Recover, see the following articles in the Microsoft Knowledge Base:

- [What is Auto-Save?](https://support.office.com/article/What-is-AutoSave-6d6bd723-ebfd-4e40-b5f6-ae6e8088f7a5)
- [WD2000: Why you are unable to recover a lost document](https://support.microsoft.com/help/212273)
- [WD2000: Automatically Saving Current Work (Open Document)](https://support.microsoft.com/help/211762)
- [How Word creates and recovers the Auto-Recover files](https://support.microsoft.com/help/107686)

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).