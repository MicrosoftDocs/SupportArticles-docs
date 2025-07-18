---
title: You receive error messages when opening an Office document
description: Describes the issue that occurs when you receive an error message after you open a specific file in an Office program.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Office Products
  - Access 2010
  - Microsoft Office Access 2007
ms.reviewer: 
ms.date: 06/06/2024
---
# You receive an error message when you try to open an Office document

## Symptoms

When you try to open a file in any Microsoft Office program that's listed in the "Applies to" section, you receive one of the following error messages:

> Filename is not valid.

> The file could not be accessed.  

> The path you entered, '***filename***', is too long. Enter a shorter path.  

> ***filename*** could not be found. Check the spelling of the filename, and verify that the file location is correct.  

> A DDE error has occurred, and a description of the error cannot be displayed because it is too long. If the filename or path is long, try renaming the file or copying it to a different folder.

:::image type="content" source="media/error-open-document/error.png" alt-text="Screenshot of the error message." border="false":::

> [!NOTE]
> This issue occurs when you open a file from a mapped drive, a UNC path, or a URL (web address).

## Cause

This issue occurs because of a character limit on creating and saving files in Office products. This issue occurs if the path of the file that you open or save meets the following condition:

- **Microsoft Word, Microsoft PowerPoint, and Microsoft Access**: The total length of the path and the file name, including file name extension, exceeds 259 characters.

- **Microsoft Excel**: The total length of the path and the file name, including file name extension, exceeds 218 characters.

> [!NOTE]
> This limit includes the three characters that represent the drive, the characters in folder names, backslash characters between folder names, and the characters in the file name itself.

## Workaround

To work around this issue, try any of the following workarounds.

### Workaround 1: Reduce the character count

- Rename the file so that it has a shorter name.
- Rename one or more folders that contain the file so that they have shorter names.
- Move the file to a folder that has a shorter path name.

### Workaround 2: Manually access, open, and repair

1. Start Word, Excel, or PowerPoint.
2. On the **File** tab, select **Open** > **Browse** to locate the damaged file.

    :::image type="content" source="media/error-open-document/open.png" alt-text="Screenshot of opening a dialog box.":::

3. Select the file, select the **Open** menu at the bottom of the window, and then select **Open and Repair**.

    :::image type="content" source="media/error-open-document/open-and-repair.png" alt-text="Screenshot of the Open and Repair option.":::

This option repairs the damage to the file, and then opens the file. After you repair the document, workbook, or presentation, it's important to verify that the issue has been resolved successfully. To do this, begin working on the file, and make sure that everything is working as expected.

### Workaround 3: Change file format and resave

You might be able to rescue a damaged file by resaving it in a different file format, and then reverting it to the original format. This example uses Word.

#### Step 1: Save the file to another format

1. Start Word.
2. On the **File** menu, select **Open**, and then locate and open the damaged file.
3. On the **File** menu, select **Save as** > **Browse**.
4. Navigate to the file location that you want to save in.
5. On the **Save as type** list, select the desired file format. For example, select **Rich Text Format (*rtf)**.

    :::image type="content" source="media/error-open-document/save-as.png" alt-text="Screenshot of the Save As option.":::

6. Select **Save**, and then select **File** > **Close**.

#### Step 2: Resave the file as a Word document

1. Select **File** > **Open**.
2. Select the new file that's saved as a **Rich Text File**, and then select **Open**.
3. Select **File** > **Save as**.
4. On the **Save as** type list, select **Word Document**.
5. Rename the file, and then select **Save**.

     :::image type="content" source="media/error-open-document/save-a-copy.png" alt-text="Screenshot of the Save a Copy option.":::

You have to do this only one time to make sure that the document will now function correctly on your device. However, keep in mind that by saving the file as a new document, you're creating a different file. To avoid confusion, name the new file something distinctive, and archive or delete the damaged version. By doing this, you won't accidentally reopen the original file that hasn't been reformatted.

### Workaround 4: Open unrecognized file format

If you can rule out file corruption as the culprit, check for file associations and unrecognized file formats. Sometimes, a file won't open on your device because the device that the file was created on used software that your device doesn't have.

For example, in Word, you want to view a PDF file that's attached to an email message. However, you don't have a PDF viewer installed. Therefore, your device doesn't know what program to open to view the file. In this case, you can change the format of the file to match a program that you do have installed.

1. Save the attachment to your computer. To do this, select the down arrow next to the attachment in the message, select **Save as**, navigate to the desired location, and then select **Save**.
2. On the **File** menu, select **Open** > **Browse** to locate the file.
3. Right-click the file, point to **Open with**, and then select a different program to open the file.
4. If the desired program isn't on the list, select "Choose another app" to locate a different program.

    > [!NOTE]
    > If this works, and you would like the selected program to always open this type of file, select the **Always use this app to open .docx files** (for example) check box.
    :::image type="content" source="media/error-open-document/always-use-this-app.png" alt-text="Screenshot of the Always use this app to open .docx files checkbox.":::

For more information about file formats and how to manage them, see [Learn about file formats](https://support.office.com/article/Learn-about-file-formats-56DC3B55-7681-402E-A727-C59FA0884B30).

### Workaround 5: Clear some disk space

You might not be able to open a new file or save a file to your device if you're running out of space on the hard disk. On a full disk, much of the space is being used up by temporary, duplicate, and unnecessary items. The fastest and easiest method to free up space on a hard disk is to use the Disk Cleanup app that's included in Windows.

1. Select **Search**, and type **Disk Cleanup**.
2. In the results list, select **Disk Cleanup**.

    :::image type="content" source="media/error-open-document/disk-cleanup.png" alt-text="Screenshot of Disk Cleanup.":::

3. A dialog box opens and provides options to delete unnecessary files. Select the check box next to each category of items that you want to delete from your device, and then select **OK**. Everything in this list can be deleted safely.

    :::image type="content" source="media/error-open-document/disk-cleanup-c.png" alt-text="Screenshot of Disk Cleanup for Local Disk (C:).":::

4. When you are prompted, confirm that you want to permanently delete the unnecessary files.

    :::image type="content" source="media/error-open-document/delete-files.png" alt-text="Screenshot of the Delete Files option.":::

The following files types are examples of removable items that you might see in the Disk Cleanup list:

- Windows Update: Recent files that were downloaded from Windows Update (selecting these does not remove currently installed update versions)
- Downloaded Program Files: Unnecessary program files, often related to the program installation
- Temporary Internet Files: Files saved automatically by web browsers when you visit websites
- Windows Error Reporting: Error reporting files that are created by the system
- Recycle Bin: Any files that are stored in the Recycle Bin that you have not manually deleted
- Temporary files: Other temporary files that are created by programs or web browsers
- User file history: Files that record your browsing history (websites that you accessed, search results, and so on)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
