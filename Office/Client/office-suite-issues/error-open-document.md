---
title: You receive error messages when you try to open an Office document
description: Describes the issue that occurs when you receive an error message after you open a specific file in an Office program. 
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: troubleshoot
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Office Products
- Access 2010
- Microsoft Office Access 2007
ms.reviewer: 
---
# You receive error messages when you try to open an Office document

This article describes an issue that occurs when you open a specific file in an Office program.

_Original KB number:_ &nbsp; 325573

## Symptoms

If you try to open a specific file with any Microsoft Office program, listed in the "Applies to" section, you may receive one of the following error messages

> Filename is not valid.  
The file could not be accessed.  
The path you entered, '**filename**', is too long. Enter a shorter path.  
**filename** could not be found. Check the spelling of the filename, and verify that the file location is correct.  
A DDE error has occurred, and a description of the error cannot be displayed because it is too long. If the filename or path is long, try renaming the file or copying it to a different folder.

:::image type="content" source="./media/error-open-document/error.jpg" alt-text="Error message":::

> [!NOTE]
> This issue occurs when you open a file from a mapped drive, a UNC path, or a URL (Web address).

## Cause

This issue occurs because of a 259-character limitation on creating and saving files in the Office products. Also, you receive an error message when you save or open a file if the path of the file meets the following condition for the appropriate program.

- Microsoft Word: The total length of the path and the file name, including file name extension, exceeds 259 characters.
- Microsoft PowerPoint: The total length of the path and the file name, including file name extension, exceeds 259 characters.
- Microsoft Access: The total length of the path and the file name, including file name extension exceeds 259 characters.
- Microsoft Excel: The total length of the path and the file name, including file name extension, exceeds 218 characters.

> [!NOTE]
> This limitation includes the three characters that represent the drive, the characters in folder names, the backslash character between folders, and the characters in the file name.

## Workaround

Make sure that the path of the file contains no more than the maximum number of characters. To do this, use one of the following methods.

- Rename the file so that it has a shorter name.
- Rename one or more folders that contain the file so that they have shorter names.
- Move the file to a folder that has a shorter path name.

### Solution 1: Manually Access, Open, and Repair

Not as tricky as it sounds, follow the steps below.

1. Open Word and select the **File** tab.
1. Select **Open** to select the damaged file。

    :::image type="content" source="./media/error-open-document/open.jpg" alt-text="Open dialog box":::

1. Go to the **Open** menu at the bottom of the window and select **Open and Repair** from the drop-down list of options.

    :::image type="content" source="./media/error-open-document/open-and-repair.jpg" alt-text="Open and Repair":::

That’s it! This option repairs the damages to the file and opens the document so you can get back to action. After repairing the Word document, it is important to verify that the issue has been resolved successfully. To do this, begin working with the file and check to make sure everything is working properly.

If we've ruled out file corruption as the culprit, then the next thing we want to check are the file associations & unrecognized file formats. Sometimes the file you received won’t open on your computer because the device the file was created on used a program or software your device doesn’t have. That said, the system triggers the error alert. If the file format is something your computer should be able to open but isn’t, the format may be associated with the wrong program. For example, let's say you wanted to view a PDF attached to an e-mail. However, you don't have a PDF viewer such as Acrobat installed. Your device doesn’t know what program to launch to view the file. Luckily, you can change the format of the file to function on a program that you do have installed by changing the file format.

### Solution 2: Change document format & resave to Word

1. Start the application (Microsoft Word) and select the **File** menu on the ribbon
1. Open the file by selecting the **Open** icon and choosing the damaged Word file
1. Save the document in another file format:

    1. Go to **File** menu and then select **Save as**.
    1. In Word, select the drop-down menu next to the Save icon.
    1. Select the Rich Text Format (*rtf) in the Save as type list.

       :::image type="content" source="./media/error-open-document/save-as.jpg" alt-text="Save as":::

    1. Select **Save**.
    1. Go to **File** menu and select **Close**.

1. Save the document back to the Word file as earlier:

    1. Go to **File** menu and select **Open**.
    1. Highlight the new document, save it as a rich text file and then select **Open**.
    1. Go to **File** menu in the ribbon and select the **Save as** option.
    1. Under the **Save as** type, select **Word Document**.
    1. Rename the file and then select **Save**.

       :::image type="content" source="./media/error-open-document/save-a-copy.jpg" alt-text="Save a copy":::

You only have to do this once to ensure that your document will now function on your device. Keep in mind, however, that by saving the file as a new document you are creating a different file. It is easy to get mixed up with duplicate files, so consider naming your new file something distinctive and archiving/deleting the damaged version. This way you don’t accidentally reopen the previous file that hasn’t been reformatted.

### Solution 3: Open unrecognized file format

Instead of trying to open the attachment directly from your e-mail, save the attachment to your computer. This can be done in a few simple steps as well:

1. Save the added attachment to your computer.
1. Right-click the file to see the **Open with** option.
1. Select a different program to open the file. (Word, Notepad, etc.)
1. If this works, and you would like the program to always open this type of file, select the **Always use this app to open .docx files** box.

    :::image type="content" source="./media/error-open-document/always-use-this-app.jpg" alt-text="Always use this app":::

If you're interested in learning more about file formats and how to manage them, please read this support article: Learn about file formats.

### Solution 4: Clear some disk space

Sometimes the reason we can’t open a new file or save it to our device is because we are running out of space on the hard drive. Most of the time that space is being used up by temporary, duplicate, or unnecessary items. Using the Disk Cleanup app included in Windows is the easiest and fastest way to free up space on your hard drive.

1. To use Disk Cleanup, select the Search bar in the bottom-left corner of the screen and type "Disk Cleanup."

    :::image type="content" source="./media/error-open-document/disk-cleanup.jpg" alt-text="Disk Cleanup":::

1. This will search your computer for the program so you can select it once it populates near the top of the list.
1. After selecting the icon, Disk Cleanup will open with options to delete cluttering files.
1. To select the files you wish to remove, select the checkbox next to each category of items you want to delete from your computer. Everything in this menu can be deleted safely.
1. Then, select **OK** to delete your files.

    :::image type="content" source="./media/error-open-document/disk-cleanup-c.jpg" alt-text="Disk Cleanup for C disk":::

1. Finally, verify that you are sure you want to permanently delete the unnecessary files.

    :::image type="content" source="./media/error-open-document/delete-files.jpg" alt-text="Delete files":::

Below is an example of some removable items you might see on your menu and what they mean.

- Windows Update: Removes the last Windows Update files from your computer (this does not remove the current update).
- Downloaded Program Files: Removes unnecessary files from programs.
- Temporary Internet Files: Removes saved Internet files.
- System created Windows Error Reporting: Removes error reporting files.
- Recycle Bin: Removes any files stored in the Recycle Bin.
- Temporary files: Removes other temporary files created by programs or web use.
- User file history: Removes history of browsing (for example, Windows Explorer searches)
