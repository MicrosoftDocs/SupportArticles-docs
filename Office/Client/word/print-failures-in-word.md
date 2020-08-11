---
title:  Print failure troubleshooting in Word
description: Describes how to diagnose print failures in Word 2013, Word 2010, Word 2007, and Word 2003. Explains how to isolate the cause of the print failure and how to resolve the issue.
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
---

# Troubleshoot print failures in Word

> [!NOTE]
> If you are using Microsoft 365 (Microsoft Word for Office 365 with Windows 10), see [Troubleshoot print failures in Word for Office 365 on Windows 10](https://docs.microsoft.com/office/troubleshoot/word/print-failures-word-for-office-365-on-win-10).

## Summary

This article suggests ways in which you can diagnose and resolve issues when you cannot print a Microsoft Word document.

## More Information

Examples of print failure are as follows: 
 
- You receive error messages and other messages when you try to print a file.    
- The printer does not respond.    
- Files print as meaningless symbols.    
 This article does not discuss printer output issues, such as envelope-positioning problems, missing graphics, and inaccurate page numbers.

> [!NOTE]
> Before you continue, see the "References" section for known issues in Word that might match your printer's behavior. If you do not find a match for your error message or your printer's behavior, follow the steps in this article to troubleshoot your printing problem.

To resolve a print failure in Word, you must determine its cause. Causes typically fit into one of the following categories: 
 
- Damaged documents or damaged content in documents    
- The Word program itself    
- The printer driver    
- The Windows operating system    
- Connectivity or hardware    
 
Do not make assumptions about what is causing your printing problem. Instead, rely on systematic troubleshooting to reveal the cause.

Use the following tests to help determine the cause of your printing failure.

### Step 1: Test printing in other documents

Damaged documents or documents that contain damaged graphics or damaged fonts can cause print errors in Word. Before you reinstall drivers or software, test the Word program's ability to print. To do this, follow these steps. 

#### Word 2013, Word 2010, and Word 2007

1. Open a new blank document in Word.    
2. On the first line of the document, type the following text:
   
   =rand(10)

1. Press Enter. This inserts 10 paragraphs of sample text.    
1. Try to print the document.    
1. If the document prints successfully, change to a different font, or insert clip art, a table, or a drawing object.

   To change the font, follow these steps:  
   1. Use your pointing device to select your sample text.    
   2. Click **Home**.    
   3. In the **Font** list, click to select a different font.    
 
   To insert clip art, follow these steps:  
   1. Click the **Insert** tab, and then click **Clip Art**. (In Word 2013, click the **Insert** tab, and then click **Online Pictures**.)    
   2. On the **Clip Art** task pane, leave the **Search text** box blank, and then click **Go**. (In Word 2013, type a term in the **Office.com Clip Art** search box, and then click **Search**.)    
   3. Right-click one of the pictures, and then click **Insert**.    
   4. Close the Clip Art task pane.    
   
   To insert a table, follow these steps:  
   1. Click **Insert**, click **Table**, and then click **Insert Table**.    
   2. Type the number of columns and rows that you want, and then click **OK**.

   To insert a drawing object, follow these steps:  
   1. Click **Insert**, and then click **Shapes**.    
   1. Double-click one of the shapes.    
     
6. Test the print function again.    
 
#### Word 2003
 
1. Open a new blank document in Word.    
2. On the first line of the document, type the following text: 
   =rand(10)
1. Press Enter. This inserts 10 paragraphs of sample text.    
1. Try to print the document.    
1. If the document prints successfully, change to a different font, or insert clip art, a table, or a drawing object.

   To change the font, follow these steps:  
   1. Use your pointing device to select your sample text.    
   2. On the **Format** menu, click **Font**.    
   3. In the **Font** list, click to select a different font, and then click **OK**.    
  
   To insert clip art, follow these steps:  
   1. On the **Insert** menu, point to **Picture**, and then click **Clip Art**.    
   2. On the **Insert Clip Art** task pane, leave the **Search text** box blank, and then click **Search**.    
   3. Right-click one of the pictures, and then click **Insert**.    
   4. Close the Insert Clip Art task pane.    
  
   To insert a table, follow these steps:  
   1. On the **Table** menu, point to **Insert**, and then click **Table**.    
   2. Click **OK**.    
  
   To insert a drawing object, follow these steps:  
   1. On the **View** menu, point to **Toolbars**, and then click **Drawing**.    
   2. On the **Drawing** toolbar, select one of the drawing shapes.    
   3. Click anywhere in the document, drag the mouse pointer, and then release the button.    
     
6. Test the print function again.    
 
The success or failure of these tests shows whether Word can print generally. These tests may also give you clues about certain fonts or graphics that Word cannot print.

If you do not receive errors in the test document but still cannot print your original document, your original document may be damaged. This may be true even if you can print the same document on another computer, because there are many situations in which the symptoms of file damage appear on some computers and not on other computers.

Again, rely on systematic troubleshooting instead of on assumptions about what is causing the problem. Therefore, if you cannot print a particular document but can print other documents in Word, you may have a damaged document. Troubleshoot the problem accordingly.  For more information about how to troubleshoot damaged Word documents, click the following article number to view the article in the Microsoft Knowledge Base:

[826864](https://support.microsoft.com/help/826864) How to troubleshoot damaged Word documents

If Word cannot print at all, or if Word cannot print a certain font or a certain kind of graphic, go to "Step 2: Test Printing in Other Programs." 

### Step 2: Test printing in other programs

The scope of the printing problem may reveal its cause. For example, some printing problems affect only Word, whereas other printing problems affect several of or all Windows-based programs.

The following tests can help determine whether this problem involves programs other than Word. 

#### Test in WordPad

1. Click **Start**, point to **Programs** (in Windows XP, point to **All Programs**), point to **Accessories**, and then click
 **WordPad**. (In Windows 8, press the Windows key to go to the Start Screen, type WordPad, and then click the icon.)  
2. In the blank WordPad document, type This is a test.    
3. On the **File** menu, click **Print**. 
4. Click **OK** or **Print** to print the file.    
 
If you found in Step 1: Test printing in other documents" that the print problem occurs only with certain fonts or certain graphics images, try to reproduce this problem in WordPad. To do this, apply the same font, or insert the same kind of graphics image. (To select a different font in WordPad, use the same method that you use in Word.)

To insert a graphics image in WordPad, follow these steps: 
 
1. On the **Insert** menu, click **Object**.

   **Note** In Windows 8 and Windows 7, click **Insert Object** on the **Home** tab.  
  
2. Follow one or both of the following steps: 
   - To create a new graphics image, click **Create New**, and then select one of the object types from the list. For example, click **Paintbrush Picture** to create a test bitmap in the Microsoft Paint program.    
   - To insert a graphics image from a file, click **Create from File**, and then click **Browse** to select the file.    
     
After you finish your testing in WordPad, you can test the print functions in your web browser or your other Office programs. You can also try to print a test page for your printer. To print a text page, follow these steps: 
 
1. Click **Start**, point to **Settings**, and then click **Printers**.

   Notes  
   - In Windows XP, click **Start**, and then click **Printers and Faxes**.    
   - In Windows Vista, click **Start**, and then click **Printers**.    
   - In Windows 7, click **Start**, and then click **Devices and Printers**. 
   - In Windows 8, press the Windows key to go to the Start Screen, type Printers, click **Settings**, and then click **Devices and Printers**.    
  
2. Right-click the icon for your printer, and then click **Properties**.    
3. On the **General** tab, click **Print Test Page**.    

If you cannot print a test page, or if you cannot print in several or all Windows-based programs, you have a printer driver problem, a Windows problem, a hardware problem, or a connectivity problem.

If the problem is limited to a particular font, a damaged font file may be the cause.  For more information about how to test and reinstall fonts, click the following article numbers to view the articles in the Microsoft Knowledge Base: 

[314960](https://support.microsoft.com/help/314960) How to install or remove a font in Windows

If you can print without problems in all programs except Word, go to "Step 3: Test printing with different printer drivers."

You may be able to use Windows printing help and troubleshooters to resolve the printing problem. 
 
- In Windows 8 and Windows 7, you can run the printing troubleshooting wizard by clicking **Start**, typing printing, and then selecting **Find and fix printing problems**.    
- In Windows Vista or Windows XP, click **Start**, select **Help and Support**, and search on printingor printing troubleshoot.    
   
### Step 3: Test printing with different printer drivers
 
If Word is the only program on your computer that cannot print, you may think that Word is the cause of the problem. Be aware that Word is a very printer-intensive program. Therefore, a minor problem with the printer driver affects Word before it affects other programs.

To determine whether the printer driver is the cause of the problem, you can test different drivers. If the Word printing problem occurs only when you print documents that use a certain font or a certain kind of graphics image, try to print to another printer.

If no other printer is available, contact the manufacturer to determine whether there is an updated version of the driver or a different driver that works with your printer model. See the "References" section for information about how to contact a third-party vendor.

If the Word printing problem occurs even when you print documents that are made up only of text, you can use a generic, text-only printer driver to test printing from Word. To do this, follow these steps for your version of Windows.

Note On some versions of Windows, these steps may require access to the Windows installation CD-ROM or access to a network drive that contains the Windows installation files. 

#### Windows 8, Windows 7, and Windows Vista

1. Take one of the following actions, as appropriate for your situation:  
   - For Windows Vista: Click **Start**, and then click **Printers**.    
   - For Windows 7: Click **Start**, and then click **Devices and Printers**.
2. Click **Add a printer**.
3. Click **Add a local printer** on the first screen of the Add Printer Wizard.
4. Make sure that the **Use an existing port** check box is selected, change the dropdown option to **File: (Print to file)**, and then click **Next**.    
5. In the **Manufacturers** list, click **Generic**, and then click **Next**.    
6. Leave the default printer name, click **Next**, and then click **Finish**.    
7. When the driver installation is complete, open a document in Word, and then do the following, as appropriate for your situation:  
   - For Word 2007: Click the **Microsoft Office Button**, and then click **Print**.    
   - For other versions: On the **File**menu, click **Print**.    
     
8. Do the following, as appropriate for your situation:  
   - For Word 2010: Click the printer dropdown menu, and then click **Print**.    
   - For other versions: Click to select the **Print to File** check box, and then click **OK**.    
     
9. Change the location to **My Document**, and then name the file Test.prn.    
10. Click **OK**.    
 
#### Windows XP
 
1. Click **Start**, and then click **Printers and Faxes**.    
2. Click **Add a printer** under **Printer Tasks**.    
3. Click **Next** on the first screen of the Add Printer Wizard.    
4. Click **Local printer attached to this computer**, make sure that the **Automatically detect and install my Plug and Play printer** check box is cleared, and then click **Next**.    
5. Click **FILE** for the port, and then click **Next**.    
6. In the **Manufacturers** list, click **Generic**, and then click **Next**.    
7. Click **FILE** for the port, and then click **Next**.    
8. Click **Yes** when you are prompted for whether Windows will use the printer as the default, and then click **Next**.    
9. Click **No** when you are prompted to print a test page, and then click **Finish**.    
10. When the driver installation is complete, open a document in Word, and then click **Print** on the **File**menu.    
11. When the **Print to file** dialog box appears, click **My Documents** for the location of the file, and then type the following file name: Test.prn     
12. Click **OK**.    
 
#### Windows 2000
 
1. Click **Start**, point to **Settings**, and then click **Printers**.    
2. Double-click the **Add Printer** icon.
3. Click **Next** on the first screen of the Add Printer Wizard.    
4. Click **Local printer**, and then click **Next**.    
5. Click **FILE** for the port, and then click **Next**.    
6. In the **Manufacturers** list, click **Generic**.    
7. In the **Printers** list, click **Generic/Text Only**, and then click **Next**.    
8. Click **Yes** when you are prompted for whether Windows will use the printer as the default, and then click **Next**.    
9. Click **Do not share this printer**, and then click **Next**.    
10. Click **No** when you are prompted to print a test page, and then click **Finish**.    
11. When the driver installation is complete, open a document in Word, and then click **Print**.    
12. When the **Print to file** dialog box appears, click **My Documents** for the location of the file, and then type the following file name: Test.prn     
13. Click **OK**.    
 
If you receive an error message in Word when you print files that contain only text but do not receive the error message when you print with the generic, text-only printer driver, your printer driver may be damaged. In this case, contact the manufacturer for help in removing the printer driver and installing an updated version. See the "References" section for information about how to contact a third-party vendor.

If the printing problem occurs with a different printer driver, go to "Step 4: Test the Word program files and settings."

### Step 4: Test the Word program files and settings
 
After you verify that the printing problem is not limited to a particular document or to a particular printer driver, and that the problem is limited to the Word program, test the Word program by starting by using only the default settings.
  
For more information about how to start by using the default settings, click the following article numbers to view the articles in the Microsoft Knowledge Base：

[921541](https://support.microsoft.com/help/921541) How to troubleshoot problems that occur when you start or use Word 

If the printing problem continues to occur, run Detect and Repair to reinstall the missing or damaged program files. To run Detect and Repair, follow these steps.

#### Word 2013 and Word 2010

1. Exit all Office programs.    
2. Use one of the following procedures, depending on your version of Windows:  
   - In Windows 7 or Windows Vista, click **Start**, and then type add remove.    
   - In Windows XP or Windows Server 2003, click **Start**, and then click **Control Panel**.    
   - In Windows 2000, click **Start**, point to **Setting**, and then click **Control Panel**.    
     
3. Open **Add or Remove Programs**.    
4. Click **Change or Remove Programs**, click **Microsoft Office (Microsoft Office Word)** or the version of Office or Word that you have in the **Currently installed programs** list, and then click **Change**.    
5. Click **Repair or Repair Word (Repair Office)**, and then click **Continue** or **Next**.    
 
#### Word 2007

1. Start Word 2007.    
2. Click the Microsoft Office button, and then click **Word Options**.    
3. Click **Resources**, click **Diagnose**, and then follow the prompts on the screen.    
 
#### Word 2003

1. On the **Help** menu in Word, click **Detect and Repair**.    
2. Click **Start**.    
3. Insert the Word CD-ROM or Office CD-ROM if you are prompted, and then click **OK**.    
 If the printing problem continues to occur after you repair the Word installation or the Office installation, look for problems in Windows.

### Step 5: Test for problems in Windows
 
To look for device drivers or memory-resident programs that might be interfering with the Word print function, start Windows in safe mode, and then test printing to a file in Word. To start Windows in safe mode, follow these steps, as appropriate for your version of Windows. 

#### Windows 8, Windows 7, and Windows Vista

1. Remove all floppy disks, CDs, and DVDs from your computer, and then restart your computer.    
2. Click **Start**, click the arrow next to the **Lock** button, and then click **Restart**.

  **Note** In Windows 8, click **Settings** from the Charms menu, click **Power**, and then click **Restart**.    
3. Press and hold the F8 key as your computer restarts.

  **Note** You have to press F8 before the Windows logo appears. If the Windows logo appears, you must try to restart your computer. To do this, wait until the Windows logon prompt appears, and then shut down and restart your computer.    
4. On the **Advanced Boot Options** screen, use the arrow keys to select the **Safe Mode** option, and then press ENTER.    
5. Log on to your computer by using a user account that has administrative credentials.    
 
#### Windows XP
 
**Note** You must be logged on as an administrator or as a member of the Administrators group to finish this procedure. If your computer is connected to a network, network policy settings may also prevent you from completing this procedure.

> [!WARNING]
> When you follow the steps in this article, you may disable the System Restore Service and may remove any previously created restore points.
  
For more information about how to use the System Restore utility to restore the computer to an earlier state, click the following article number to view the article in the Microsoft Knowledge Base: 

[306084](https://support.microsoft.com/help/306084) How to restore Windows XP to a previous state

1. Click **Start**, click **Run**, and then type the following command in the **Open** box: msconfig     
2. Click **OK**.    
3. On the **General** tab, click **Selective Startup**, and then click to clear all the successive check boxes.

   **Note** You cannot click to clear the **Use Original BOOT.INI** check box.    
4. Click **OK**, and then click **Restart** to restart your computer.    
  
For more information about how to perform a clean restart in Windows XP, click the following article number to view the article in the Microsoft Knowledge Base:

[310353](https://support.microsoft.com/help/310353) How to configure Windows XP to start in a "clean boot" state

#### Windows 2000

1. Restart the computer.    
2. Press F8 when you receive the following message:    
3. On the **Windows 2000 Advanced Options** menu, click **Safe mode**, and then press ENTER.    
4. After Windows starts in safe mode, start Word, and then type some text in a new document.    
5. On the **File** menu, click **Print**. 
6. In the **Print** dialog box, click to select the **Print to file** check box, and then click **OK**.    
7. When the **Print to file** dialog box appears, click **My Documents** for the location of the file, and then type the following file name: Test.prn     
8. Click **OK**.    
  
If the Word printing problem does not occur when you start Windows in safe mode, use clean-boot troubleshooting to help determine the source of the problem.
