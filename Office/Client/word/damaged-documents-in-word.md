---
title: How to troubleshoot damaged documents in Word
description: Describes how to identify a damaged Word document in Microsoft Office Word. Provides steps for how to recover the text and data that is contained in a document.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
ms.date: 03/31/2022
---

# How to troubleshoot damaged documents in Word

## Summary

This article describes how to identify a damaged document in Word 2007 and later versions. Additionally, this article includes steps that explain how to recover the text and data that is contained in a document after you have identified the document as damaged.

This article is intended for a beginning to intermediate computer user.
You may find it easier to follow the steps if you print this article first.

## Update Microsoft Office and Windows

Many software issues can be resolved by updating the Microsoft Office and Windows programs.  

[Windows Update FAQ](https://support.microsoft.com/help/12373/windows-update-faq) 

[Install Office updates](https://support.office.com/article/install-office-updates-2ab296f3-7f03-43a2-8e50-46de917611c5)

[Update Office with Microsoft Update](https://support.office.com/article/update-office-with-microsoft-update-f59d3f9d-bd5d-4d3b-a08e-1dd659cf5282) 

## A damaged document or a software issue?

A Word document can become corrupted for several reasons that will prevent you from opening it. This behavior may be related to damage to the document or to the template on which the document is based. This behavior might include the following: 
 
- Repeatedly renumbers the existing pages in the document    
- Repeatedly redoes the page breaks in the document    
- Incorrect document layout and formatting    
- Unreadable characters on the screen    
- Error messages during processing    
- A computer that stops responding when you open the file    
- Any other unexpected behavior that cannot be attributed to the typical operation of the program    
 
Sometimes, this behavior can be caused by factors other than document damage. It is important to determine whether the document is damaged or whether the problem is a software issue. To eliminate these other factors, follow these steps: 
 
1. Look for similar behavior in other documents. Try to open other Word documents to see whether the same problem occurs. If they open correctly, then the problem might be with the Word document.    
2. Look for similar behavior in other Microsoft Office programs. If this is the case, then the issue might be with another application or the operating system.    
 
If any of these steps indicate that the problem is not in the document, you will then have to troubleshoot Word, the Office suite, or the operating system that is running on the computer.  

## Troubleshooting steps to try if the damaged document does not open 

Try the methods in the order given. If one does not work for you, try the next one.

### Method 1: Open the damaged document in draft mode without updating links 
 
#### Step 1: Configure Word

1. Start Word.    
2. On the **View** tab, select **Draft** in the **Views** group.    
3. Select the **File Menu**, and then **Options**, and then **Advanced**.    
4. In the **Show document content** section, select **Use draft font in Draft and Outline views** and **Show picture placeholders**.    
5. Scroll down to the **General** section, clear the check box **Update automatic links at open**, select **OK**, and then close Word.    
 
#### Step 2: Open the damaged document

1. Start Word.    
2. Select the **File Menu**, and then select **Open**.    
3. Select the damaged document, and then select **Open**.    
 
If you can open the document, close the document and then reopen it by using method 6, and repair the document. Otherwise go to method 2.

### Method 2: Insert the document as a file in a new document
  
#### Step 1: Create a new blank document

1. Select the **File Menu**, and then select **New**.    
2. Select **Blank document**, and then select **Create**.    

#### Step 2: Insert the damaged document into the new document

1. On the **Insert** tab, select **Insert Object**, and then select **Text From File**.    
2. In the **Insert File** dialog box, locate and then select the damaged document. Then, select **Insert**.    

   > [!NOTE]
   > You might have to reapply some formatting to the last section of the new document.

### Method 3: Create a link to the damaged document  

#### Step 1: Create blank document

 
1. In Word, select the **File Menu**, and then select **New**.    
2. Select **Blank document**, and then select **Create**.    
3. In the new document, type "This is a test."    
4. Select the **File Menu**, and then select **Save**.    
5. Type "Rescue link," and then select **Save**.    
 
#### Step 2: Create link
 
1. Select the text you typed in step 1-3.    
2. On the **Home** tab, select **Copy** in the **Clipboard** group.    
3. Select the **File Menu**, and then select **New**.    
4. Select **Blank document**, and then select **Create**.    
5. On the **Home** tab, select the arrow on the **Paste** button in the **Clipboard** group, and then select **Paste Special**.    
6. Select **Paste link**, select **Formatted Text (RTF)**.    
7. Select **OK**.    
 
#### Step 3: Change the link to the damaged document
 
1. Right-click the linked text in the document, point to **Linked Document Object**, and then select **Links**.    
2. In the **Links** dialog box, select the file name of the linked document, and then select **Change Source**.    
3. In the **Change Source** dialog box, select the document that you cannot open, and then select **Open**.    
4. Select **OK** to close the **Links** dialog box.
   
   > [!NOTE]
   > The information from the damaged document will appear if there was any recoverable data or text.         
5. Right-click the linked text, point to **Linked Document Object**, and then select **Links**.    
6. In the **Links** dialog box, select **Break Link**.    
7. When you receive the following message, select **Yes**: Are you sure you want to break the selected links?

### Method 4: Use the "Recover Text from Any File" converter

> [!NOTE]
> The "Recover Text from Any File" converter has limitations. For example, document formatting is lost. Additionally, graphics, fields, drawing objects, and any other items that are not text are lost. However, field text, headers, footers, footnotes, and endnotes are retained as simple text.

1. In Word, select the **File Menu**, and then select **Open**.
2. In the **Files of type** box, select **Recover Text from Any File(*.*)**.
3. Select the document from which you want to recover the text.
4. Select **Open**.

After the document is recovered by using the "Recover Text from Any File" converter, there is some binary data text that is not converted. This text is primarily at the start and end of the document. You must delete this binary data text before you save the file as a Word document.

> [!NOTE]
> If you are using Word 2007 and there is not a file button in the User Interface, choose the Office Button and follow the directions when necessary.

## Troubleshooting steps to try if you can open the damaged document

### Method 1: Copy everything except the last paragraph mark to a new document

#### Step 1: Create a new document

1. In Word, select **File** on the Ribbon, and then select **New**.
2. Select **Blank document**, and then select **Create**.

#### Step 2: Open the damaged document

1. Select **File** on the Ribbon, and then select **Open**.
2. Select the damaged document, and then select **Open**.

#### Step 3: Copy the contents of document, and then paste the contents into the new document

> [!NOTE]
> If your document contains section breaks, copy only the text between the sections breaks. Do not copy the section breaks because this may bring the damage into your new document. Change the document view to draft view when you copy and paste between documents to avoid transferring section breaks. To change to draft view, on the **View** tab, select **Draft** in the **Document Views** group.

1. In the damaged document, press CTRL+END, and then press CTRL+SHIFT+HOME.
2. On the **Home** tab, select **Copy** in the **Clipboard** group.
3. On the **View** tab, select **Switch Windows** in the **Window** group.
4. Select the new document that you created in step 1.
5. On the **Home** tab, select **Paste** in the **Clipboard** group.

If the strange behavior persists, go to method 8.

### Method 2: Change the template that is used by the document  

#### Step 1: Determine the template that is used by the document

1. Open the damaged document in Word.
2. Select **File** on the Ribbon, and then select **Options**.
3. Select **Add-Ins**.
4. In the **Manage** box, select **Templates** under **View and manage Office add-ins.**
5. Select **Go**.
The **Document template** box will list the template that is used by the document. If the template that is listed is **Normal**, go to step 2. Otherwise, go to step 3.

#### Step 2: Rename the global template (Normal.dotm)

1. Exit Word.
2. Select the **Start** button.
3. In your operating system, search for  normal.dotm. It's typically found in this location: %userprofile%\appdata\roaming\microsoft\templates
4. Right-click **Normal.dotm**, and then select **Rename**.
5. Type "Oldword.old", and then press ENTER.
6. Close File Explorer.
7. Start Word, and then open the document.

#### Step 3: Change the document template

1. Open the damaged document in Word.
2. Select **File** on the Ribbon, and then select **Options**.
3. Select **Add-Ins**.
4. In the **Manage** box, select **Templates**, and then select **Go**.
5. Select **Attach**.
6. In the **Templates** folder, select **Normal.dotm**, and then select **Open**.
7. Select **OK** to close the **Templates and Add-ins** dialog box.
8. Exit Word.

#### Step 4: Verify that changing templates worked

1. Start Word.
2. Select **File** on the Ribbon, and then select **Options**.
3. Select the damaged document, and then select **Open**.

If the strange behavior persists, go to method 3.

### Method 3: Start Word using default settings  

You can use the /a switch to start Word by using only the default settings in Word. When you use the /a switch, Word does not load any add-ins. Additionally, Word does not use your existing Normal.dotm template. Restart Word by using the /a switch.

#### Step 1: Start Word by using the /a switch

1. Exit Word.
2. Select the **Start** button and search for Run. In the Run dialog box type the following:

   winword.exe /a

#### Step 2: Open the document

1. In Word, select **File** on the Ribbon, and then select **Open**.
2. Select the damaged document, and then select **Open**.

If the strange behavior persists, go to method 4.

### Method 4: Change printer drivers

#### Step 1: Try a different printer driver

1. In your operating system search for Devices and Printers.
2. Select **Add a printer**.
3. In the **Add Printer** dialog box, select **Add a local printer**.
4. Select **Use an existing port**, and then select **Next**.
5. In the **Manufacturer** list, select **Microsoft**.
6. Select **Microsoft XPS Document Writer**, and then select **Next**.
7. Select **Use the driver that is currently installed (recommended)**, and then select **Next**.
8. Select to select the **Set as the default printer** check box, and then select **Next**.
9. Select **Finish**.

#### Step 2: Verify that changing printer drivers fixes the problem

1. Start Word.
2. Select **File** on the Ribbon, and then select **Open**.
3. Select the damaged document, and then select **Open**.

If the strange behavior persists, go to step 3.

#### Step 3: Reinstall original printer driver

Windows 10 and Windows 7

1. In your operating system search for Printers.    
2. Select the original default printer, and then select **Delete**.

   If you are prompted for an administrator password or for a confirmation, type the password, or select **Continue**.    
1. If you are prompted to remove all the files that are associated with the printer, select **Yes**.    
1. Select **Add a printer or scanner**, and then follow the instructions in the **Add Printer Wizard** to reinstall the printer driver.    

#### Step 4: Verify that changing printer drivers fixes the problem

1. Start Word.    
2. Select **File** on the Ribbon, and then select **Open**.    
3. Select the damaged document, and then select **Open**.    
 
If the strange behavior persists, go to method 5.

### Method 5: Force Word to try to repair a file
  
#### Step 1: Repair document

In Word, select **File** on the Ribbon, and then select **Open**. 
 
1. In the **Open** dialog box, click once to highlight your Word document.    
2. Select the arrow on the **Open** button, and then select **Open and Repair**.    
 
#### Step 2: Verify that repairing the document fixes the problem

Verify that the strange behavior no longer occurs. If the strange behavior persists, restart Windows, and then go to method 6.

### Method 6: Change the document format, and then convert the document back to the Word format  

#### Step 1: Open the document

1. Start Word.    
2. Select **File** on the Ribbon, and then select **Open**.    
3. Select the damaged document, and then select **Open**.    
 
#### Step 2: Save the document in a different file format

1. Select **File** on the Ribbon, and then select **Save as**.    
2. Select **Other Formats**.    
3. In the **Save as file type** list, select **Rich Text Format (*.rtf)**.    
4. Select **Save**.    
5. Select **File** on the Ribbon, and then select **Close**.    
 
#### Step 3: Open the document, and then convert document back to Word file format

1. In Word, select **File**, and then select **Open**.    
2. Select the converted document, and then select **Open**.    
3. Select **File**, and then select **Save as**.    
4. Choose **Word Document** for the **Save As** type.    
5. Rename the document's file name, and then select **Save**.    
 
#### Step 4: Verify that converting the document file format fixes the problem

Verify that the strange behavior no longer occurs. If the behavior persists, try to save the file in another file format. Repeat step 1 to step 4, and then try to save the file in the following file formats, in the following order:

- Webpage (.htm; .html)    
- Any other word processing format    
- Plain Text (.txt)    
   
> [!NOTE]
> When you save files in the **Plain Text (.txt)** format, you might resolve the damage to the document. However, all document formatting, macro codes, and graphics are lost. When you save files in the **Plain Text (.txt)** format, you must reformat the document. Therefore, use the **Plain Text (.txt)** format only if the other file formats do not resolve the problem.     

If the strange behavior persists, go to method 7.

### Method 7: Copy the undamaged parts of the damaged document to a new document 
 
#### Step 1: Create a new document

1. In Word, select **File**, and then select **New**.    
2. Select **Blank document**, and then select **Create**.    
 
#### Step 2: Open the damaged document

1. Select **File**, and then select **Open**.    
2. Select the damaged document, and then select **Open**.    
 
#### Step 3: Copy the undamaged parts of document, and then paste the undamaged parts to the new document

> [!NOTE]
> If your document contains section breaks, copy only the text between the sections breaks. Do not copy the section breaks because this might bring the damage into your new document. Change the document view to draft view when you copy and paste between documents to avoid transferring section breaks. To change to draft view, on the **View** tab, select **Draft** in the **Document Views** group.     
 
1. In the damaged document, locate and then select an undamaged part of the document's contents.    
2. On the **Home** tab, select **Copy** in the **Clipboard** group.    
3. On the **View** tab, select **Switch Windows** in the **Window** group.    
4. Select the new document that you created in step 1.    
5. On the **Home** tab, select **Paste** in the **Clipboard** group.    
6. Repeat steps 3a to 3e for each undamaged part of the document. You must reconstruct the damaged sections of your document.   

### Method 8: Switch the document view to remove the damaged content  

If the document appears to be truncated (not all pages in the document are displayed), it might be possible to switch the document view and remove the damaged content from the document. 
 
1. Determine the page number on which the damaged content is causing the document to appear to be truncated.  
   1. In Word, select **File**, and then select **Open**.    
   2. Select the damaged document, and then select **Open**.    
   3. Scroll to view the last page that is displayed before the document appears to be truncated. Make a note of the content which appears on that page.    
     
2. Switch views, and then remove the damaged content.  
   1. On the **View** tab in the **Document Views** group, select **Web Layout** or **Draft view**.    
   2. Scroll to view the content that was displayed before the document appeared to be truncated.    
   3. Select and delete the next paragraph, table, or object in the file.    
   4. On the **View** tab in the **Document Views** group, select **Print Layout**. If the document continues to appear to be truncated, continue to switch views and delete content until the document no longer appears truncated in **Print Layout** view.
   5. Save the document.

### Method 9: Open the document with Notepad
If the document is corrupted and none of the previous methods work, try to recover its content by opening the document with Notepad.

> [!NOTE]
> By using this method, you will lose all formatting. The intention is to recover the content.

1. Locate the damaged document using Windows File Explorer.
2. Right click the document and select **Open with**.
3. Select *Notepad*:

:::image type="content" source="media/damaged-documents-in-word/damaged-documents-in-word.png" alt-text="Screenshot of opening the Word doc in Notepad.":::

4. The document will open in Notepad with extra code and text around the content.
   > [!NOTE]
   > You may have to change the file type from "Text Documents (*.txt)" to "All Files (*.*)".

5. Clean the text by deleting all or most of the extra characters.
6. Select **File**, and then select **Save As…** Rename the document to make sure that you don't overwrite the damaged one.

Go back to Word and open the new document. Once in Word, you can clean it up and try to reapply the lost format.
