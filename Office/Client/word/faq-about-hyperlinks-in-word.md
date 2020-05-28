---
title: Frequently asked questions about hyperlinks in Word
description: Answers frequently asked questions about how to create and use hyperlinks in Word. Understanding these methods can help you use the method that best meets your requirements.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Word 2013
- Word 2010
- Word 2007
- Word 2003
- Word 2002
---

# Frequently asked questions about hyperlinks in Word

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

For a Microsoft Word 98 Macintosh Edition version of this article, see [211955](https://support.microsoft.com/help/211955).

## Summary

This article answers the most frequently asked questions about creating and using hyperlinks in Microsoft Word 2002 and in later versions of Word. 

## More Information

When I type a file address with spaces in it, Word replaces the address with a hyperlink after I press SPACEBAR. How can I finish typing an address that includes spaces before Word converts it to a hyperlink?
 
To ensure that Word will recognize an address that includes spaces as a single hyperlink, enclose the address in quotation marks. If the address is not enclosed in quotation marks, Word creates the hyperlink when you press SPACEBAR. 

### How do I turn off automatic hyperlinks?
 
To turn off automatic hyperlinks, follow these steps, as appropriate for the version of Word that you are running: 

- In Microsoft Office Word 2010 and 2013, follow these steps:  
  1. On the **File** menu, click **Options**.

  2.  Click **Proofing**, and then click **AutoCorrect Options**.   
  3.  On the **AutoFormat as you type** tab and on the **AutoFormat** tab, click to clear the **Internet and network paths with hyperlinks** check box, and then click **OK**.

  4. Click **OK** to close the **Word Options** dialog box.   
   
- In Microsoft Office Word 2007, follow these steps: 
  1. Click the **Microsoft Office Button**, and then click **Word Options**.   
  2. Click **Proofing**, and then click **AutoCorrect Options**.   
  3. On the **AutoFormat as you type** tab and on the **AutoFormat** tab, click to clear the **Internet and network paths with hyperlinks** check box, and then click **OK**.   
  4. Click **OK** to close the **Word Options** dialog box.   
   
- In Microsoft Office Word 2003 and in Microsoft Word 2002, follow these steps: 
  1. On the **Tools** menu, click **AutoCorrect Options**.   
  2. On the **AutoFormat as you type** tab and on the **AutoFormat** tab, click to clear the **Internet and network paths with hyperlinks** check box.   
  3. Click **OK**.   
   

### How do I change the display text or image of a hyperlink after it has been created?
 
You can change the display text or image for a hyperlink in the same way that you edit any text or image in your document.

To follow a hyperlink, press and hold CTRL, and then click the hyperlink.

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[279090](https://support.microsoft.com/help/279090) Cannot click to activate hyperlink

### How do I remove a hyperlink without losing the display text or image?
 
To remove a single hyperlink without losing the display text or image, right-click the hyperlink, and then click **Remove Hyperlink**. 

To remove all hyperlinks in a document, press CTRL+A to select the entire document and then press CTRL+SHIFT+F9. 

> [!NOTE]
> Performing this operation converts all fields, not just hyperlinks, to plain text.
 
### How do I change the underlying Uniform Resource Locator (URL) for a hyperlink?
 
To change the underlying URL for a hyperlink, follow these steps: 

1. Right-click the hyperlink text or image, and then click **Edit Hyperlink**.   
2. In the **Edit Hyperlink** dialog box, type or select a URL from the **Type the file or web page name** box.   
3. Click **OK**.   

### How do I create hyperlinks to locations within the same document?
 
To create a hyperlink to a location within the same document, use one of the following methods: 

- Use a drag-and-drop operation. To do this, follow these steps: 
  1. Save the document.   
  2. Select the word, phrase, or image that you want to use as the destination for the hyperlink.   
  3. Right-click and hold down the mouse button while dragging the selection to the new location; then, release the mouse button.   
  4. Click **Create Hyperlink Here**.   
- Create a bookmark, and then create a link. To do this, follow these steps, as appropriate for the version of Word that you are running: 
  - In Word 2007 and in Word 2010 and 2013, follow these steps: 
    1. Save the document.   
    2. Select the text or the image that you want to use as the destination for the hyperlink.   
    3. Click the **Insert** tab.   
    4.  In the **Links** group, click **Bookmark**.   
    5. In the **Bookmark name** box, type a unique name for the bookmark, and then click **Add**. 
    6. Move the insertion point to the location in the document where you want to create the hyperlink.   
    7. Click **Hyperlink** in the **Links** group.   
    8. Click **Bookmark**.   
    9. In the **Select Place in Document** dialog box, select the bookmark that you want to use as the destination hyperlink, and then click **OK**.    
    10. Click **OK** to close the **Insert Hyperlink** dialog box.      
  - In Word 2003 and in Word 2002, follow these steps: 
    1. Save the document.   
    2. Select the text or the image that you want to use as the destination for the hyperlink.   
    3. On the **Insert** menu, click **Bookmark**.   
    4. In the **Bookmark name** box, type a unique name for the bookmark, and then click **Add**. 
    5. Move the insertion point to the location in the document where you want to create the hyperlink.   
    6. On the **Insert** menu, click **Hyperlink**.   
    7. Click **Bookmark**.   
    8. In the **Select Place in Document** dialog box, select the bookmark that you want to use as the destination hyperlink, and then click **OK**.    
    9. Click **OK** again.      
   

### What is the difference between a relative hyperlink and an absolute hyperlink?
 
An absolute hyperlink uses the full address of the destination document. A relative hyperlink uses the address relative to the address of the containing document. This is also known as the hyperlink base.

For example, suppose that a document has the following address: 

C:\My Documents\1999 report.doc
 
This document has absolute and relative hyperlinks to a document that has the following full address (and absolute hyperlink): 

C:\My Documents\April\Sales.doc
 
The relative hyperlink contains only the relative address to Sales.doc. The relative address is as follows:

April\Sales.doc
 
Use a relative link if you want to move or to copy your files to another location, such as a Web server. 

### When I click a hyperlink in Word, I receive a message that indicates that no program is registered to open the file. What do I do to open the file?
 
You receive this message when Windows is unable to find the program that is associated with the type of document that is specified in the hyperlink path. This information is encoded in the extension of the hyperlink address. 

To view the hyperlink, turn on the Tool Tips option, and then position the mouse pointer over the hyperlink. 

To locate the Tool Tips option, use one of the following procedures, as appropriate for the version of Word that you are running: 

- In Word 2010 and 2013, click **File**, click **Options**, and then click **Display**.   
- In Word 2007, click the **Microsoft Office Button**, click **Word Options**, and then click **Display**.   
- In Word 2003 and in Word 2002, click **Options** on the **Tools** menu, and then click the **View** tab.   
 
To correct this problem, install the program that is associated with the document type that is specified in the hyperlink. 

The file name extension is the group of characters that follow the last period in the address. The following table lists some of the Office document types and their file name extensions. 

|Document type|File name extensions in Office 2003 and in earlier versions of Office|File name extensions in the 2007 Office programs|
|---|---|---|
|Microsoft Access database|.mdb|.accdb|
|Microsoft Excel workbook|.xls|.xlsx, .xlsm, .xlsb|
|Microsoft PowerPoint presentation|.pot|.potx, .potm|
|Microsoft Publisher publication|.pub|.pub|
|Microsoft Word document|.doc|.docx, .docm|