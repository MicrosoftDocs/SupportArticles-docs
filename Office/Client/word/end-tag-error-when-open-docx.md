---
title: You receive an end tag error when you open a DOCX file in Word 2013, 2010, or 2007
description: Provides an automated solution to fix errors you may get when opening Word 2013, 2010, or 2007 documents containing equations.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Word 2013
  - Microsoft Word 2010
  - Microsoft Word 2007
ms.date: 03/31/2022
---

# (end tag) error occurs when you open a DOCX file in Word 2013, 2010, or 2007

## Symptoms

When you try to open a Microsoft Word 2007, 2010 or 2013 document, you may receive this error message:

**In Word 2007 and Word 2010:**

> The file \<document filename> cannot be opened because there are problems with the contents.

Clicking the **Details** button provides this additional information:

> The name in the end tag of the element must match the element type in the start tag.

:::image type="content" source="media/end-tag-error-when-open-docx/error-message-2007-2010.png" alt-text="Screenshot to select the Details button in the error message window.":::

**In Word 2013:**

> We're sorry. We can't open \<document filename.docx> because we found a problem with its contents.

Clicking the **Details** button provides this additional information:

> The name in the end tag of the element must match the element type in the start tag.

:::image type="content" source="media/end-tag-error-when-open-docx/error-message-2013.png" alt-text="Screenshot to select the Details button in the error message window in Word 2013." border="false":::

##  Cause

This issue is related strictly to oMath tags and occurs when a graphical object or text box is anchored to the same paragraph that contains the equation. The document will display the equation and object on the same line as demonstrated in this image:

:::image type="content" source="media/end-tag-error-when-open-docx/equation-object-same-line.png" alt-text="Screenshot shows the document will display the equation and object on the same line." border="false":::

The error may not occur until the document is saved, re-edited and saved again.

##  Resolution

Office 2013 and Office 2010 Service Pack 1 resolves this issue for new files. It will also prevent the problem from recurring with any files that were recovered with the Fix it solution in this article.

If you currently have Office 2010 installed on your computer, we recommend that you follow these steps:

**Step 1**

Download Office 2010 Service Pack 1. To do this, follow the steps provided in this Microsoft knowledge base article:

[2460049](https://support.microsoft.com/help/2460049) - Description of Office 2010 SP1

**Step 2**

If you are familiar with editing XML, you can try to fix the problem yourself by correcting the mismatched oMath tags in the document. See the following example:

```xml
Incorrect tags:

<mc:AlternateContent>

<mc:Choice Requires="wps">

<m:oMath>

…

</mc:AlternateContent>

</m:oMath>

Correct tags:

<m:oMath>

<mc:AlternateContent>

<mc:Choice Requires="wps">

…

</mc:AlternateContent>

</m:oMath>
```

**Note** You will have to use an application such as Notepad to edit the XML.

**Did this fix the problem?**

- Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).   
- We would appreciate your feedback. To provide feedback or to report any issues with this solution, please send us an [email](mailto:fixit4me@microsoft.com?subject=kb) message.   


##  More Information

The Fix it solution in this article should let you recover your Word document. However, the symptoms will reappear when you make any further edits to the document unless the core problem in the structure of the document is resolved.

To try to correct the core problem, follow one of these workarounds:

Install Office 2013 or install Office 2010 Service Pack 1

Office 2013 and Office 2010 Service Pack 1 resolves this issue for new files. It will also prevent the problem from recurring with any files that were recovered with the Fix it solution in this article.

To download Office 2010 Service Pack 1, follow the steps provided in this Microsoft knowledge base article:

[2460049](https://support.microsoft.com/help/2460049) - Description of Office 2010 SP1

Grouping Objects

The steps provided work best under Word 2010 and Word 2013:

1. After you open the recovered document, turn on the **Selection** pane. This can be found in the **Home** tab of the ribbon. The editing group of the **Home** tab has a dropdown button named **Select**.   
2. Click the **Select** button, and then click **Selection Pane...**   
3. Press the Ctrl button on your keyboard and then click each text box in the selection pane.   
4. Click the **Group** button under the **Format** tab. This will group all the objects together.   
5. As soon as you have all objects grouped on each page, save the document under a new name.   


Save the document in the .RTF file format

The steps provided work for both Word 2007, Word 2010 and Word 2013:

1. After you open the recovered document, click **File** and select **Save** (for Word 2007 click the Office button and select **Save As**).   
2. In the **Save As** dialog box, click "Save as type:" dropdown and select **Rich Text format (*.rtf)**.   
3. Click **Save**.   

Click to view  [Error when opening a Word 2007 or 2010 document "The name in the end tag of the element must match the element type in the start tag"](https://cybertext.wordpress.com/2011/12/21/word-error-opening-a-word-2010-document-in-word-2007) for more information about this issue.
