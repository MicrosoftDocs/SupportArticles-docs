---
title: Troubleshooting damaged documents in Word for Mac
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Word for Mac 2008
---

# Troubleshooting damaged documents in Word for Mac

## Summary

This article contains troubleshooting procedures that you can use to identify damaged document files by using Microsoft Word 2008 for Mac and, in some cases, recover such files. A "damaged" document is a document that you cannot open or that you can open but that contains an error in a section of the document. In a damaged document, you cannot change any information in a section.

Damaged document files can cause any program to exhibit unusual behavior. Such behavior occurs because the program is receiving incorrect information from the damaged document file.

## More information

Damaged files frequently cause behavior that is not part of the program design, such as infinite repagination, incorrect document layout and formatting, unreadable characters, error messages during processing, system freezes or crashes when you load or view the file, or any other unusual behavior that is not part of the ordinary operation of the program. However, such behavior also can be caused by factors other than document damage. To eliminate other factors, follow these troubleshooting tips:

- Check for similar behavior in other documents.   
- Check for similar behavior in other programs.   
- Test the file in question in Office for Mac on another Macintosh and try to duplicate the behavior.   
- Rename any templates that are attached to the document, and then try to duplicate the behavior.   

Start the computer in safe mode, and then try to duplicate the behavior.

1. Shut down the computer.   
2. Press the power button.   
3. When you hear the startup tone, immediately hold down the SHIFT key. 

    > [!NOTE]
    > Press the SHIFT key as soon as possible after you hear the startup tone. However, do not press the SHIFT key before you hear the startup tone.
4. Release the SHIFT key when you see the gray Apple and the progress indicator on the screen. The progress indicator resembles a spinning gear. During startup, the words "Safe Boot" appear on the Mac OS X startup screen.   
5. Start Word 2008 for Mac, and then try to duplicate the behavior.

If the problem behavior does not recur, something that was normally set to start together with the operating system was causing this problem. Because safe mode boot affects different items in different ways, this problem could be related to startup items, fonts, or other items.

If this problem occurs only with a single document after you perform the previous steps, the specific document is probably damaged. If the program unexpectedly closed before the file was closed and the AutoRecoveryoption was enabled, an AutoRecovery file may have been created. You can use this AutoRecovery file to recover the file in question. 

The AutoRecovery feature in Word for Mac tries to automatically recover text from a document that was open when Word for Mac crashed. When you restart Word for Mac after the program crashes, a dialog box will display the following message:

```asciidoc
Word encountered file damage while opening File Name.

Part of this document may be recoverable. Attempt Recovery Now?
```

> [!NOTE]
> This recovery may take some time, depending on the size of the document and how much damage is in the document. 

After the document is recovered, immediately use the Save Ascommand on the Filemenu to save the document with a new file name. This makes sure that the original document will be available for other recovery attempts. This automatic recovery method strips all formatting, graphics, and objects from the document. 

You also can browse to HD\users\your user\Documents\Microsoft User Data\Office 2008 AutoRecovery and review the documents in this folder. Move the documents from this folder to another location and then access them with Wordto determine whether any of them are the damaged document. 

Additional methods that are listed later in this article may enable you to recover more of the original formatting from the damaged document. 

For more information about the AutoRecovery feature, see the "Recover text from a damaged document" topic in Word 2008 for Mac Help.

### How to correct a damaged document

There are several techniques that you can use to try to correct a damaged document. The method that you use depends on the kind and the severity of the damage and the type of behavior that is exhibited. Although these methods succeed frequently, not every damaged document can be recovered. Keeping a backup copy of a document is the best way to make sure that you can recover it. 

The following troubleshooting procedures are divided into two sections: "If the file can be opened in Word for Mac" and "If the file cannot be opened in Word for Mac." Use the appropriate section for your situation.

#### If the file can be opened in Word for Mac

If you can open the file in Word for Mac, use one of the following methods. 

Method 1: Convert the file to another format, and then convert it back to its native format.

This is the easiest and most complete document recovery method. Always try it first. Save the file in Rich Text Format (RTF). This format preserves the formatting in your Word for Mac document. After you save the file in RTF, reopen the file in Word for Mac, and then convert it from RTF. If this method succeeds, the file damage is removed during conversion.

To save the file as RTF, follow these steps:

1. On the **File** menu, click **Save As**.
2. Click the **Format** list, and then select **Rich Text Format**.
3. Change the name of the document. (This is recommended so that you can continue with the other steps by using the original unmodified document.)   
4. Click **Save**. 

If the damage persists after you save the file as RTF, instead save the file in one of the following file formats:

- Other word processing formats
- Text only   

> [!NOTE]
> Saving a file in text-only format frequently corrects the damage problem. However, all formatting is lost, including graphics and field codes in Word 2008 for Mac. Therefore, this method requires more reformatting. So use it only if other file formats do not enable you to resolve the problem.

Method 2: Copy everything except the last paragraph mark to a new document.

Word for Mac associates a variety of formatting with the last paragraph mark, especially section and style formatting. If you copy everything in the file except the last paragraph mark to a new file, the damage may be left behind in the original document. 

To copy everything except the last paragraph mark in the document, follow these steps:

1. Open the document that exhibits the problem behavior.   
2. On the **Edit** menu, click **Select All**.
3. With the document selected, hold down the SHIFT key, and then press the LEFT ARROW key one time. (This removes only the last paragraph mark from the selection.) Release the SHIFT key.   
4. On the **Edit** menu, select **Copy**.
5. On the **File** menu, select **New Blank Document**.
6. In the new document, click **Paste** on the **Edit** menu. 

> [!NOTE]
> In the new document, you may have to reapply section formatting or style formatting.

Method 3: Copy the undamaged parts of the file to a new file.

Sometimes you can determine the location of damage in your file by looking at the file or by testing the file to determine where the problem behavior originates. Another way to determine what area of the file is damaged is to copy one page at a time or a series of pages into a new file. Save the new file, and then test for the problem behavior. If the behavior does not occur, continue to copy pages, saving the file and testing until the problem behavior recurs.

If you can determine what area of the file is damaged, you can then copy everything except the damaged part to a new file, and then follow these steps to reconstruct your document:

1. Copy the undamaged part of your document and paste them into a new file. (You may not want to select the final paragraph mark of this selection, because that paragraph mark may contain problematic information).   
2. Save a copy of the damaged document in text-only format.   
3. Open the text-only file.   
4. Copy the text from the file, and then paste it into the file that contains the undamaged part of your file.   
5. Reformat the sections of the document that you pasted in step 4, and then save the recovered document. 

#### If the file cannot be opened in Word for Mac

If you cannot open the file in Word for Mac, use one of the following methods as appropriate.

Method 1: Insert the file into a blank document.

Even if you cannot open a file to copy all the text (except the final paragraph mark), you may be able to insert the file into a new document. This inserts a new final paragraph mark onto the file that you are correcting. To do this, follow these steps:

1. Create a new document based on the template.   
2. On the Insert menu, click File.Select the damaged document, and then click OK.   
Method 2: Use the Paste Link command to open the document by using a link.

This method uses a "dummy" document to create a link and then switches the link between the "dummy" document and the damaged document. 

To use a paste-link operation to open a damaged document, follow these steps:

1. Close all open documents in Word for Mac, and then open a new blank document.   
2. Type Test.   
3. Select the word **Test**.   
4. On the **Edit** menu, click **Copy**.   
5. On the **File** menu, click **New**, and then open a new blank document.   
6. On the **Edit** menu, click **Paste Special**.   
7. In the **Paste Special** dialog box, click **Paste Link**. In the **As** box, click **Formatted Text (RTF)**, and then click **OK**.   
8. On the **Edit** menu, click **Links**.   
9. In the **Links** dialog box, click **Change Source**. In the **Open** dialog box, locate and select the document that you want to recover. Click **Open**, and then click **OK**.   
10. When the document opens, click **Save As** on the **File** menu. Type a new name for the document, and then click **Save**.   
11. With the document open, click **Links** on the **Edit** menu.   
12. In the **Links** dialog box, click **Break Links**.   
13. In the dialog box that appears, click **Yes** to break the link.    

> [!NOTE]
> After the link is broken, you should save the document before you close it or modify it.

Method 3: Open the file by using "Recover Text from Any File"

You can use the special "Recover Text from Any File" converter to manually open damaged documents. This converter removes all formatting, graphics, and embedded objects from the file and leaves only readable text (ASCII characters). However, because of the way that Word for Mac document files are organized and saved, the text may be disjointed or duplicated.

With even the simplest files, extensive reformatting is required with this option. With smaller files, you may want to open a new, second document and paste the text from the recovered document into the new document because there is so much unwanted text recovered.

To use the "Recover Text from Any File" converter to open a document, follow these steps:

1. On the **File** menu, click **Open**.   
2. Click the **Enable** list, and then click **Recover Text from Any File**.   
3. Locate the folder that contains the damaged file, and then select the file.   
4. Click Open. 

> [!NOTE]
> The recovery process can take some time, depending on the size of the document and the extent of the damage. As soon as the recovery is complete, click Openon the Filemenu, and then change List Files of Typeback to Word Documentsor to All Readable Documents.

Tip Save the recovered file with a new name at this point. This prevents you from accidentally overwriting the original document and makes sure that the original document remains available for other recovery attempts.

Method 4: Open the file as a copy

To open a copy of a damaged document, follow these steps:

1. Close all open documents.   
2. Click **Open** on the **File** menu.   
3. In the **Open** list in the lower-left corner of the **Open**  box, click **Copy**.   
4. Select the damaged file.   
5. Click **Open**. 

Method 5: Open the document in another version of Microsoft Word.

As a last resort, you can try to access the document in Microsoft Word X or Word 2004 on a Mac, as some older documents are inaccessible with the Word 2008 compatibility mode. If the document can be opened with an older version of the program, save the file with a new name, and then again try to use it on the Mac with Word 2008.

Another option is to try one of the Windows versions of Microsoft Word (2003, 2007, or 2010) as these versions come with repair tools that may repair a damaged document and make some or all of it recoverable. Again, if the document opens in one of the Word for Windows versions, save the file with a new name, and then again try to access it on the Mac with Word 2008. For more information, see [Documents do not open in Microsoft Word 2008 for Mac that were created in an earlier version](https://support.microsoft.com/help/953266).
