---
title: How to troubleshoot printing failures in Word for O365 on Windows 10
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 3/4/2020
audience: Admin
ms.topic: article
ms.prod: word
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Word for Office 365
ms.custom: 
- CI 113851
- CSSTroubleshoot 
ms.reviewer: mmaxey
description: Describes how to troubleshoot problems when printing documents from Word for Office 365 running on Windows 10.
---

# Troubleshoot print failures in Word for Office 365 on Windows 10

## Summary

This article suggests ways in which you can diagnose and resolve issues when you cannot print a Microsoft Word for Office 365 document on Windows 10.

> [!NOTE]
> For previous versions of this article to troubleshoot Word on Windows, see [Troubleshoot print failures in Word](https://docs.microsoft.com/office/troubleshoot/word/print-failures-in-word). 

## More Information

Examples of print failure are as follows:
- You receive error messages and other messages when you try to print a file.
- The printer does not respond.
- Files print as meaningless symbols.

> [!NOTE]
> This article does not discuss printer output issues, such as envelope-positioning problems, missing graphics, and inaccurate page numbers.

To resolve a print failure in Word, you must determine its cause. Causes typically fit into one of the following categories:
- Damaged documents or damaged content in documents.
- The Word program itself.
- The printer driver.
- The Windows operating system.
- Connectivity or hardware.

Do not make assumptions about what is causing your printing problem. Instead, rely on systematic troubleshooting to reveal the cause.

Use the following tests to help determine the cause of your printing failure.

### Step 1: Update Windows 10 
Make sure that [Windows is up to date](https://support.microsoft.com/help/4027667/windows-10-update).

### Step 2: Test printing in other documents

Damaged documents or documents that contain damaged graphics or damaged fonts can cause print errors in Word. Before you reinstall drivers or software, test the Word program's ability to print. To do this, follow these steps.

1.	Open a new blank document in Word.
2.	On the first line of the document, type the following text:
=rand(10)
3.	Press **Enter**. This inserts 10 paragraphs of sample text.
4.	Try to print the document.
5.	If the document prints successfully, change to a different font, or insert clip art, a table, or a drawing object.
    - To change the font, follow these steps:
        1.	Select a section of the sample text.
        2.	In the **Home** menu, use the font drop-down box to select a different font.
    - To insert clip art, follow these steps:
        1. Select the **Insert** tab, and then select **Online Pictures**.
        2. Type any term in the search box, and then press **Enter** or select **Search**.
        3. Select one of the pictures, and then select **Insert**.
        4.	Close the task pane.
     - To insert a table, follow these steps:
        1. Select **Insert**, select **Table**, and then select **Add a Table**.
        2. Select the number of columns and rows that you want, and then select **OK**.
     - To insert a drawing object, follow these steps:
        1. Select **Insert**, and then select **Shapes**.
        2. Select one of the shapes.
        3. Click and drag your cursor across the document to place the shape. 
6.	Test the print function again.

The success or failure of these tests shows whether Word is functionally able to print. These tests may also give you clues about certain fonts or graphics that Word cannot print.

If you do not receive errors in the test document but still cannot print your original document, your original document may be damaged. This may be true even if you can print the same document on another computer, because there are many situations in which the symptoms of file damage appear on some computers and not on other computers.

Again, rely on systematic troubleshooting instead of on assumptions about what is causing the problem. If you cannot print a particular document but can print other documents in Word, you may have a damaged document. 

For more information about how to troubleshoot damaged Word documents, see [How to troubleshoot damaged Word documents](https://docs.microsoft.com/office/troubleshoot/word/damaged-documents-in-word). 

If Word cannot print at all, or if Word cannot print a certain font or a certain kind of graphic, go to the next step.

### Step 3: Test printing in other programs

The scope of the printing problem may reveal its cause. For example, some printing problems affect only Word, whereas other printing problems affect several of or all Windows-based programs.

The following tests can help determine whether this problem involves programs other than Word.

#### Test in WordPad

1.	In the **Windows** menu, search for and start WordPad. 
2.	In the blank WordPad document, type This is a test.
3.	On the **File** menu, select **Print**.
    > [!NOTE] 
    > Make sure that your printer is selected. If your printer is not listed, select **Add Printer…** from the **Printer** drop-down box and add your printer.  

4.	Select **OK** or **Print** to print the file.

If you found in “Step 3: Test printing in other documents" that the print problem occurs only with certain fonts or certain graphics images, try to reproduce this problem in WordPad. To do this, apply the same font, or insert the same kind of graphics image. (To select a different font in WordPad, use the same method that you used in Word.) Then try printing the same document again. 

To insert a graphics image in WordPad, follow these steps:

1.	On the **Home** tab, select **Insert object**.
2.	Follow one or both of the following steps:
    - To create a new graphics image, select **Create New**, and then select one of the object types from the list. For example, select **Paintbrush Picture** to create a test bitmap in the Microsoft Paint program.
    - To insert a graphics image from a file, select **Create from File**, and then select **Browse** to select the file.

### Test printing from other programs

After you finish creating the document in WordPad, you can test the print functions in your web browser or another Office program. You can also try to print a test page for your printer. To print a text page, follow these steps:

1.	Select **Start**, point to **Settings**, then **Devices**, and then select **Printers & scanners**.
2.	Select the icon for your printer.
3.	Under **Manage your device**, select **Print Test Page**.
    - If you cannot print a test page, or if you cannot print in several (or all) Windows-based programs, you have a printer driver problem, a Windows problem, a hardware problem, or a connectivity problem.
    - If the problem is limited to a particular font, a damaged font file may be the cause. For more information about how to test and reinstall fonts, see the following Microsoft Knowledge Base article:<br/><br/>
    [314960](https://support.microsoft.com/help/314960/how-to-install-or-remove-a-font-in-windows) How to install or remove a font in Windows<br/><br/>
    - If you can print without problems in all programs except Word, go to "Step 4: Test printing with different printer drivers."

You might be able to use the Windows 10 printing help and troubleshooting wizard to resolve the printing problem. Select **Start**, type printing, and then select **Find and fix problems with printing**.

### Step 4: Test printing with different printer drivers

If Word is the only program on your computer that cannot print, you might think that Word is the cause of the problem. Be aware that Word is a very printer-intensive program. Therefore, a minor problem with the printer driver affects Word before it affects other programs.

To determine whether the printer driver is the cause of the problem, you can test different drivers. If the Word printing problem occurs only when you print documents that use a certain font or a certain kind of graphics image, try to print to another printer.

If no other printer is available, contact the manufacturer to determine whether there is an updated version of the driver or a different driver that works with your printer model. 

If the Word printing problem occurs even when you print documents that are made up only of text, you can use a generic, text-only printer driver to test printing from Word. To do this, follow these steps:

1.	Select **Start**, and then **Settings**.
2.	Select **Devices**, and then **Printers & scanners**.
3.	Select **Add a printer or scanner**.
4.	Select **The printer that I want isn’t listed**. 
    > [!NOTE]
    > You may have to search for a printer first to see this option.
5.	In the "Find a printer by other options" screen, select **Add a local printer or network printer with manual settings**. Select **Next**.
6.	Make sure that the **Use an existing port** check box is selected, then change the dropdown option to **File: (Print to file)**, and select **Next**.
7.	Under Manufacturer, select **Generic**. Under Printers, select **Generic/Text Only**, and then select **Next**.
8.	In the screen “Type a printer name,” leave the name as **Generic/Text Only** and select **Next**.
9.	In the "Printer Sharing" screen, select **Share this printer so that others on your network can find and use it**. 
10.	Leave the default Share name, and then select **Next**. 
11.	Select **Finish**.
12.	When the driver installation is complete, open a document in Word, and on the **File** menu, select **Print**. 
13.	Select **Generic/Text Only**, and then select **Print**. 
14.	Change the location to **My Documents**, and then name the file **Test.prn**.
15.	Select **OK**.

If you receive an error message in Word when you print files that contain only text but do not receive the error message when you print with the generic, text-only printer driver, your printer driver may be damaged. In this case, contact the manufacturer for help in removing the printer driver and installing an updated version. 

If the printing problem continues to occur with a different printer driver, go to the next step.

### Step 5: Repair the Word program files 

After you verify that the printing problem is not limited to a particular document or to a particular printer driver, and that the problem is limited to the Word program, test the Word program by using only the default settings.

For more information about how to start by using the default settings, see the following Microsoft Knowledge Base：

[921541](https://docs.microsoft.com/office/troubleshoot/word/issues-when-start-or-use-word) How to troubleshoot problems that occur when you start or use Word

If the printing problem continues to occur, run the repair program to reinstall the missing or damaged program files. To run the repair program, follow these steps.

1.	Exit all Office programs.
2.	In Windows 10, select **Start**, and then type uninstall.
3.	Open **Add or Remove Programs**.
4.	Under the "Apps & features" list, find and select your version of Microsoft Office Word you have installed.
5.	Select **Modify**.
6.	Select **Online Repair**, and then follow the onscreen instructions to repair the program.

### Step 6: Test for problems in Windows

To look for device drivers or memory-resident programs that might be interfering with the Word print function, start Windows in safe mode, and then test printing to a file in Word. To start Windows in safe mode, follow the steps below.

1.	Remove all floppy disks, CDs, and DVDs from your computer, and then restart your computer.
2.	Select **Start**, then the **Power button**, and then select **Restart**.
3. Press and hold the F8 key as your computer restarts.
   > [!NOTE]
   > You must press F8 before the Windows logo appears. If the Windows logo appears, restart your computer and try again. To do this, wait until the Windows logon prompt appears, and then shut down and restart your computer.
4. On the "Advanced Boot Options" screen, use the arrow keys to select the **Safe Mode** option, and then press **Enter**.
5. Log on to your computer by using a user account that has administrative credentials. 
6.	Try printing from Word again.

If the Word printing problem does not occur when you start Windows in safe mode, use clean-boot troubleshooting to help determine the source of the problem.

## Need More Help?

Get help from the [Microsoft Community](https://answers.microsoft.com/) online community, search for more information on [Microsoft Support](https://support.microsoft.com/) or [Office Help and How To](https://office.microsoft.com/support/), or learn more about [Assisted Support](https://support.microsoft.com/contactus/) options.

