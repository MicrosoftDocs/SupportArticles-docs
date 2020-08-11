---
title: How to recover a lost Word document
description: Describes a range of options to locate and recover lost Microsoft Word documents. Discusses Word 2019, Word 2016, Word 2013, and Word 2010 under various versions of Windows.
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
ms.date: 5/28/2020
---

# Recover a lost Word document

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

> [!NOTE]
> This article suggests ways in which you can recover a lost Microsoft Word document.<br /><br />
> If you're looking for information about how to recover recent Office documents, see the following articles:
> - [Recover your Office files](https://support.office.com/article/recover-your-office-files-dc901de2-acae-47f2-9175-fb5a91e9b3c8) (for Word versions through Office 2019)
> - [Find lost files after the upgrade to Windows 10](https://support.microsoft.com/help/12386/)

> [!NOTE]
> For more information about earlier versions of Word, see the following Knowledge Base article:
> - [How Word creates and recovers the auto-recover files](https://support.microsoft.com/help/107686)

## Quick resolution

Try the following options to help recover your Word document. Select the image at the left or the option heading to see more detailed instructions about that option.

<table align="left">
<tr>
<td valign="top"> 
<a href="#option1">

![Option 1](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-1.png)

</a>
</td><td>**<a href="#option1">Search for the original document</a>**

**Windows 10** and **Windows 7**

1.	On the taskbar, select the **Start** or **Search** icon.
2.	Type the document name, and then press **Enter**. 
    - If the **File** list contains the document, double-click the document to open it in Word.
    - If the **File** list does not contain the file, go to Option 2.



</td>
</tr>
<tr>
<td valign="top">
<a href="#option2">

![Option 2](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-2.png)

</a>
</td>
<td>**<a href="#option2">Search for Word backup files</a>**

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
<td>**<a href="#option3">Search for auto-recover files</a>**

1. Right-click the taskbar, and select **Task Manager**.
2. On the **Processes** tab, select any instance of **Winword.exe** or **Microsoft Word**, and then select **End Task** or **End Process**. Repeat this step until you have exited all instances of Winword.exe and Microsoft Word.
3. Close the **Windows Task Manager** dialog box, and then start Word.

   Double-click the file in the **Document Recovery** pane, select **Save As** on the **File** menu, and then save the document as a .docx file. To manually change the extension to .docx, right-click the file and select **Rename**.

</td>
</tr>
<tr>
<td valign="top">
<a href="#option4">

![Option 4](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-4.png)

</a>
</td>
<td>**<a href="#option4">Search for temporary files</a>**

1.	On the taskbar, select the **Start** or **Search** icon, type **.tmp** in the search field, and then press **Enter**.
2.	In the toolbar, select **Documents**.
3. Scroll through the files, and search for files that match the last few dates and times that you edited the document. 


</td>
</tr>
<tr>
<td valign="top">
<a href="#option5">

![Option 5](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-5.png)

</a>
</td>
<td>**<a href="#option5">Search for "~" files</a>**

**Windows 10** and **Windows 7**

1.	On the taskbar, select the **Start** or **Search** icon, and then type the tilde character (**~**) in the search field.
2.	On the toolbar, select **Documents**.

   Scroll through the files, and look for any files that may match the last few dates and times that you edited the document. 


</td>
</tr>
<tr>
<td valign="top">
<a href="#option6">

![Option 6](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-6.png)

</a>
</td>
<td>**<a href="#option6">How to troubleshoot damaged documents</a>**

For information about how to troubleshoot damaged Word documents, see [How to troubleshoot damaged documents in Word](https://support.microsoft.com/help/826864).

</td>
</tr>

</table>


## Microsoft Support options

If you can't resolve this problem, you can use Microsoft Support to search the Microsoft Knowledge Base and other technical resources for answers. You can also customize the site to control your search. To start your search, go to the [Microsoft Support](https://www.microsoft.com/support/) website. 

## Additional resources
 
If you experience specific issues when you use Word, go to the following website to search for more information about your program version:

[Microsoft Word Product Solution Center: Word](https://support.office.com/search/results?query=word)

### Detailed view of the options 

The following section provides more detailed descriptions of these options.

<a id="option1">

### Option 1: Search for the original document

</a>

Type the document name, in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the Start Search box on the Start menu (in earlier versions of Windows), and then press **Enter**. 

- If the **File** list contains the document, double-click the document to open it in Word.
- If the **File** list does not contain the file, go to Option 2.


<a id="option2">

### Option 2: Search for Word Backup files

</a>

Word backup file names end with the .wbk extension. If you have the option **Always create Backup copy** selected, there may be a backup copy of the file.

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
3.	Right-click the backup file that you found and select **Open**.

If there are no .wbk files in the original folder, search the computer for any .wbk files. To do this, follow these steps.

1. Select Start, type ***.wbk** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows). Then, press **Enter**.

- If the **File** list contains the backup file, repeat the steps in Option 2 to open the file. 
- If the **File** list does not contain the backup file, go to Option 3.


If you find any files that have the name "Backup of" followed by the name of the missing file, use one of the following procedures, as appropriate for the version of Word that you're running.

**Word for Office 365**, **Word 2019**, **Word 2016**, and **Word 2013**

1. On the **File** menu, select **Open** > **Browse**. (In some versions of Word, select **Computer** > **Browse**.)
2. In the **Files of type** list (All Word Documents), select **All Files**.
3. Right-click the backup file that you found, and  select **Open**.

**Word 2010**

1. On the **File** menu, select **Open**.
2. In the **Files of type** list (All Word documents), select **All Files**.
3. Right-click the backup file that you found, and select **Open**.

<a id="option3">

### Option 3: Search for AutoRecover files

</a>

AutoRecover file names end in the .asd file name extension. By default, Word searches for auto-recover files every time that it starts, and then it displays any files found in the **Document Recovery** task pane.

1. Use Word to automatically find the auto-recovered files. To do this, follow these steps:

   1. Right-click the taskbar, and select **Task Manager**.
   2. On the **Processes** tab, select any instance of **Winword.exe** or **Microsoft Word**, and then select **End Task** or **End Process**. Repeat this step until you have exited all instances of Winword.exe and Word.
   3. Close the **Windows Task Manager** dialog box, and then start Word.

If Word finds the auto-recovered file, the **Document Recovery** task pane opens on the left side of the screen, and the missing document is listed as "**document name** [Original]" or as "**document name** [Recovered]." If this occurs, double-click the file in the Document Recovery pane, select **File** > **Save As**, and then save the document as a .docx file. To manually change the extension to .docx, right-click the file, and select **Rename**.

**Manually search for auto-recovered files**

If the **Document Recovery** pane does not open, manually search for auto-recovered files. To do this, use one of the following procedures, as appropriate for the version of Word that you're running.

**Word for Office 365**, **Word 2019**, **Word 2016**, and **Word 2013** 

1.	On the **File** menu, select **Open**, and then **Browse**. (In Word 2013, select **File** > **Open** > **Computer** > **Browse**.) 
2.	Browse to the folder where you last saved your document and look for files that end in .asd. 
3.	If you don't see your document listed, select **File** > **Info** > **Manage Documents** (or **Manage Versions**) > **Recover Unsaved Documents**. 


   **Word 2010**

   1. On the **File** menu, select **Recent**.
   2. If you don't see your document listed, select **Recover Unsaved Documents**.

**Search for .asd files**

If you can't locate an auto-recovered file in the location that is identified in the **Folder name** list, search your whole drive for any .asd files. To do this, follow these steps:

Type **.asd** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press **Enter**.

   - If the **File** list does not contain auto-recovered files, go to Option 4.
  
   - If you find any files that have the .asd extension, use one of the following procedures, as appropriate for the version of Word that you're running:

      **Word 2019**, **Word 2016**, or **Word 2013**  
      1. On the **File** menu, select **Open**, and then **Browse**. (In some versions, you may have to select **Computer **and then **Browse**.)
      2. In the **Files of type** list (All Word Documents), select **All Files**.
      3. Select the .asd file that you found, and then select **Open**.

      **Word 2010**
      1. On the **File** menu, select **Open**.
      2. In the **Files of type** list (All Word Documents), select **All Files**.
      3. Select the .asd file that you found, and then select **Open**.

   > [!NOTE]
   > In the **Recovery** pane, if you find an auto-recovered file that does not open correctly, go to Option 6 for more information about how to open damaged files.

<a id="option4">

### Option 4: Search for temporary files

</a>

Temporary file names end in a .tmp extension. To find these files, follow these steps:

1.	Type **.tmp** in the Search box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press **Enter**.
2. On the **Show only** toolbar, select **Other**.
3. Scroll through the files and search for files that match the last few dates and times that you edited the document. If you find the document that you're looking for, go to Option 6 to find out how to recover information from the file.

<a id="option5">

### Option 5: Search for "~" files

</a>

Some temporary file names start in a tilde (~) character. To find these files, follow these steps:

1. Type **~** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the Start menu (in earlier versions of Windows), and then press **Enter**.
2. Select **See more results**.

3. Scroll through the files, and look for any that match the last few dates and times that you edited the document. 

If you find the document that you're looking for, go to Option 6 to find out how to recover information from the file.

For more information about how Word creates and uses temporary files, see [Description of how Word creates temporary files](https://support.microsoft.com/help/211632).

<a id="option6">

### Option 6: How to troubleshoot damaged documents

</a>

For information about how to troubleshoot damaged Word documents, see [How to troubleshoot damaged documents in Word](https://support.microsoft.com/help/826864).

## More information

In certain situations, it's possible to completely lose a Word document. For example:

- If an error occurs that forces Word to close
- If you experience a power interruption while editing
- If you close the document without saving your changes

> [!NOTE]
> The whole document may be lost if you have not recently saved the document. If you have saved your document, you may lose only the changes that you made since the last save. **Be aware that some lost documents may not be recoverable.**

The AutoRecover feature in Word performs an emergency Backup of open documents when an error occurs. Some errors can interfere with the auto-recovery functionality. The AutoRecover feature is not a substitute for saving your files.

We do not provide any utilities to recover deleted documents. However, some third-party utilities to recover deleted documents might be available from the internet.

For more information about AutoRecover, see the following articles:

- [What is Auto-Save?](https://support.office.com/article/What-is-AutoSave-6d6bd723-ebfd-4e40-b5f6-ae6e8088f7a5)
- [WD2000: Why you are unable to recover a lost document](https://support.microsoft.com/help/212273)
- [WD2000: Automatically Saving Current Work (Open Document)](https://support.microsoft.com/help/211762)
- [How Word creates and recovers the AutoRecover files](https://support.microsoft.com/help/107686)

#### Third-party information disclaimer

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).