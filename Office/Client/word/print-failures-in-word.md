---
title: Troubleshooting why Word won't print
description: Describes how to diagnose print failures in Word, how to isolate the cause of the print failure, how to resolve the issue.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
  - Word 2007
ms.date: 3/31/2022
---

# Troubleshoot why Word does not print

> [!NOTE]
> If you're using **Microsoft 365** (Microsoft Word for Microsoft 365 with Windows 10), see [Troubleshoot print failures in Word for Microsoft 365 on Windows 10](print-failures-word-for-office-365-on-win-10.md).

This article describes how to diagnose print failures in Microsoft Word. It also explains how to isolate the cause of the print failure and how to resolve the issue.

Examples of print failure include the following situations:

- You receive error messages and other messages when you try to print a file.
- The printer doesn't respond.
- A file is printed as meaningless symbols.

> [!IMPORTANT]
> This article doesn't discuss printer output issues, such as envelope-positioning problems, missing graphics, or inaccurate page numbers.

To resolve a print failure in Word, you must determine its cause. Causes typically fit into one of the following categories:

- Corrupted files or corrupted content in documents
- The Word program itself
- The printer driver
- The Windows operating system
- Connectivity or hardware

Don't make assumptions about what is causing your printing problem. Instead, rely on systematic troubleshooting to reveal the cause.

Use the following tests to help determine the cause of the printing failure.

## Step 1: Test printing in other documents

Corrupted files or documents that contain corrupted graphics or fonts can cause print errors in Word. Before you reinstall drivers or software, test whether Word can print. To do this, follow these steps for your version of Word.

### Word 2007 through Word 2019

1. Open a new document in Word.
1. On the first line of the document, type **=rand(10)**, and then press **Enter**:

    > [!NOTE]
    > The **=rand(10)** command inserts 10 paragraphs of sample text.

1. Try to print the document.
1. If the document prints successfully, change to a different font, or insert clip art, a table, or a drawing object.

   - To change the font, follow these steps:  
       1. Select the sample text.
       2. Open the **Home** tab.
       3. In the **Font** group, select a different font in the font list.

   - To insert clip art, follow these steps:  
       1. Open the **Insert** tab, and then select **Online Pictures**. (In **Word 2010** and **Word 2007**, select the **Insert** tab, and then select **Clip Art**.)
       2. On the **Clip Art** task pane, leave the **Search text** box blank, and then select **Go**. (In **Word 2013**, type a term in the **Office . com Clip Art** search box, and then select **Search**.)
       3. Right-click one of the pictures, and then select **Insert**.
       4. Close the **Clip Art** task pane.

   - To insert a table, follow these steps:  
       1. Select **Insert**, select **Table**, and then select **Insert Table**.
       2. Select the number of columns and rows that you want, and then select **OK**.

   - To insert a drawing object, follow these steps:  
       1. Select **Insert**, and then select **Shapes**.
       1. Double-click one of the shapes.

1. Test the print function again.

The success or failure of these tests shows whether Word can print generally. These tests may also give you clues about certain fonts or graphics that Word cannot print.

If you don't receive errors in the test document but still cannot print the original document, the file may be corrupted. This situation might be true even if you can print the same document on another computer because the symptoms of file corruption don’t necessarily appear on all computers.

For more information about how to troubleshoot corrupted Word files, see [How to troubleshoot damaged documents in Word](damaged-documents-in-word.md).

If Word cannot print at all, or if Word cannot print a certain font or a specific type of graphic, go to the next step.

## Step 2: Test printing in other programs

The scope of the printing problem may reveal its cause. For example, some printing problems affect only Word, whereas other printing problems affect several of or all Windows-based programs.

The following tests can help determine whether this problem involves programs other than Word.

### Test in WordPad

#### Print a plain text file

1. Select **Start**, point to **Programs**, point to **Accessories**, and then select  **WordPad**.

   > [!NOTE]
   >
   > - In **Windows 8**, press the **Windows key** to open the Start menu, type **WordPad**, and then select the **WordPad** icon.
   > - In **Windows 7**, point to **All Programs**, point to **Accessories**, and then select  **WordPad**.

1. In the blank WordPad document, type **This is a test**.
1. On the **File** menu, select **Print**.
1. Select **OK** or **Print** to print the file.

#### Print specific fonts or images

If Step 1 indicated that the print problem involves only certain fonts or certain graphics images, try to reproduce this problem in WordPad. To do this, apply the same font, or insert the same kind of graphics image. (To select a different font in WordPad, use the same method that you use in Word.)

To insert a graphics image in WordPad, follow these steps:

1. On the **Insert** menu, select **Object**.

   > [!NOTE]
   > In **Windows 8** and **Windows 7**, select **Insert Object** on the **Home** tab.  
  
2. Follow one or both of the following steps:
   - To create a new graphics image, select **Create New**, and then select one of the object types from the list. For example, select **Paintbrush Picture** to create a test bitmap in the Microsoft Paint program.
   - To insert a graphics image from a file, select **Create from File**, and then select **Browse** to select the file.
3. On the **File** menu, select **Print**.
4. Select **OK** or **Print**.

#### Printing from other programs

If you still cannot print from WordPad, test the print functions from either your web browser, or your other **Office** programs.

### Print a test page from the printer

You can also try to print a test page on your printer. To print a test page, follow these steps:

1. Select **Start**, point to **Settings**, and then select **Printers**.

   > [!NOTE]
   >
   > - In **Windows 8**, press the **Windows key** to go to the **Start Screen**, type **Printers**, select **Settings**, and then select **Devices and Printers**.
   > - In **Windows 7**, select **Start**, and then select **Devices and Printers**.
   > - In **Windows Vista**, select **Start**, and then select **Printers**.

2. Right-click the icon for your printer, and then select **Properties**.
3. On the **General** tab, select **Print Test Page**.

If you can't print a test page, or if you cannot print in several or all Windows-based programs, the problem might be related to a printer driver, hardware, the operating system, or internet connectivity.

If the problem is limited to a particular font, a corrupted font file may be the cause. For more information about how to test and reinstall fonts, see [How to install or remove a font in Windows](https://support.microsoft.com/windows/how-to-install-or-remove-a-font-in-windows-f12d0657-2fc8-7613-c76f-88d043b334b8).

If you can print without problems in all programs except Word, go to the next step.

You might be able to use Windows printing help and troubleshooters to resolve the printing problem:

1. Select **Start** > **Settings**.
2. Type **printer problems**, and then select **Find and fix problems with printing**.

    > [!NOTE]
    >
    > - To correct printer connection and printing problems in **Windows 10**, see [Fix printer connection and printing problems in Windows 10](https://support.microsoft.com/windows/fix-printer-connection-and-printing-problems-in-windows-10-fb830bff-7702-6349-33cd-9443fe987f73).
    > - In **Windows 8** and **Windows 7**, you can run the printing troubleshooting wizard by selecting **Start**, typing printing, and then selecting **Find and fix printing problems**.
    > - In **Windows Vista**, select **Start**, select **Help and Support**, and search on printing or printing troubleshoot.

## Step 3: Test printing with different printer drivers

If Word is the only program on your computer that cannot print, be aware that Word is a very printer-intensive program. Therefore, a minor problem in the printer driver tends to affect Word before it affects other programs.

To determine whether the printer driver is the cause of the problem, you can test different drivers. If the Word printing problem occurs only when you print documents that use a certain font or a specific type of graphics image, try to print to another printer.

If no other printer is available, contact the manufacturer to determine whether there is an updated version of the driver or a different driver for your printer model.

If the Word printing problem occurs even when you print documents that contain only text, you can use a generic, text-only printer driver to test printing from Word. To do this, follow these steps for your version of Windows.

> [!NOTE]
> On some versions of Windows, these steps may require access to the Windows installation CD-ROM or access to a network drive that contains the Windows installation files.

### Test printing in Windows 10

1. In the **Windows search box**, type **printers**, and then select **Printers & scanners**.
2. Select **Add a printer or scanner**.
3. Under “Printers & scanners,” select **Generic/Text Only**.
4. Open a Word document, and then try to print to the **Generic/Text Only** printer option.
5. Name the file Test.prn, and save it to your **Documents** folder.

### Test printing in Windows 8, Windows 7, and Windows Vista

1. Take one of the following actions, as appropriate for your situation:  
   - For **Windows 8** and **Windows 7**: Select **Start**, and then select **Devices and Printers**.
   - For **Windows Vista**: Select **Start**, and then select **Printers**.

2. On the first screen of the Add Printer wizard, select  **Add a printer**.
3. Select **Add a local printer** on the first screen of the Add Printer Wizard.
4. Make sure that the **Use an existing port** check box is selected, change the dropdown option to **File: (Print to file)**, and then select **Next**.
5. In the **Manufacturers** list, select **Generic**, and then select **Next**.
6. Leave the default printer name, select **Next**, and then select **Finish**.
7. When the driver installation is complete, open a document in Word, and then do the following, as appropriate for your situation:  
   - For Word 2013 and later versions: On the **File** menu, select **Print**.
   - For Word 2010: Select the printer dropdown menu, and then select **Print**.
   - For Word 2007: Select the **Microsoft Office Button**, and then select **Print**.
   - For other Word versions: Select the **Print to File** check box, and then select **OK**.

8. Change the location to **My Document**, and then name the file Test.prn.
9. Select **OK** or **Print** (depending on your version of Word).

If you receive an error message in Word when you print files that contain only text, but you do not receive the error message when you print by using the generic, text-only printer driver, your printer driver might be corrupted. If this is the case, contact the manufacturer for help with removing the printer driver and install an updated version.

If the printing problem occurs when you use a different printer driver, go to the next step.

## Step 4: Test the Word program files and settings

After you verify that the printing problem is not limited to a particular document or to a particular printer driver, and that the problem is limited to the Word program, test the Word program by using resetting the user options.
  
For more information about how to reset the user options, see [How to reset user options and registry settings in Word](reset-options-and-settings-in-word.md).

If the printing problem continues to occur, run **Detect and Repair** to reinstall the missing or corrupted program files. To run **Detect and Repair**, follow these steps for your version of Word.

### Word 2019, 2016, 2013, and 2010

1. Exit all **Office** programs.
2. Select **Start**, and then type **add remove**.
3. Open the **Add or Remove Programs** item.
4. Select **Change or Remove Programs**, select **Microsoft Office (Microsoft Office Word)** or the version of Office or Word that you have in the **Currently installed programs** list, and then select **Change** or **Modify**.
5. Select **Repair or Repair Word (Repair Office)**, and then select **Continue** or **Next**.

#### Word 2007

1. Start **Word 2007**.
2. Select the **Microsoft Office** button, and then select **Word Options**.
3. Select **Resources**, select **Diagnose**, and then follow the prompts on the screen.

If the printing problem continues to occur after you repair the Word installation or the Office installation, go to the next step.

## Step 5: Test for problems in Windows

To look for device drivers or memory-resident programs that might be interfering with the Word print function, start Windows in safe mode, and then test print to a file in Word. To start Windows in safe mode, follow these steps for your version of Windows.

### Test for problems in Windows 10

To start Windows 10 in safe mode, see [Start your PC in safe mode in Windows 10](https://support.microsoft.com/windows/start-your-pc-in-safe-mode-in-windows-10-92c27cff-db89-8644-1ce4-b3e5e56fe234).

### Test for problems in Windows 8, Windows 7, and Windows Vista

1. Remove all DVDs, CDs, floppy disks, and any other external media from your computer, and then restart your computer.
2. Select **Start**, select the arrow next to the **Lock** button, and then select **Restart**.

    > [!NOTE]
    > In **Windows 8**, select **Settings** from the Charms menu, select **Power**, and then select **Restart**.
3. Press and hold the **F8 key** as your computer restarts.

    > [!NOTE]
    > You must press the **F8 key** before the Windows logo appears. If the Windows logo appears, you must restart the computer. To do this, wait until the Windows logon prompt appears, and then shut down and restart the computer.
4. On the **Advanced Boot Options** screen, use the arrow keys to select the **Safe Mode** option, and then press **Enter**.
5. Sign in to your computer by using a user account that has administrative credentials.
  
If the Word printing problem does not occur when you start Windows in safe mode, use clean-boot troubleshooting to help determine the source of the problem.

For more information about how to perform a clean restart in Windows, see [How to perform a clean boot in Windows](https://support.microsoft.com/help/929135).

## Related articles

- [Print background color or image](https://support.microsoft.com/office/print-background-color-or-image-9aa93bd0-4279-4f0b-9432-152f8549ef15)
- [Print on both sides of the paper (duplex printing) in Word](https://support.microsoft.com/office/print-on-both-sides-of-the-paper-duplex-printing-in-word-2cd60d2f-3a57-4210-96ac-9a6ca71ca7a3)
- [Turn off track changes](https://support.microsoft.com/office/turn-off-track-changes-85a31f26-d593-42eb-9fe1-2fdf081d18f6)
