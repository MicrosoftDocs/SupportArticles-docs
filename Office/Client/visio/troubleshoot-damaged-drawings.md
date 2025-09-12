---
title: Troubleshoot damaged drawings in Visio
description: Contains information about how to troubleshoot damaged drawings in Visio 2013, Visio 2010, Visio 2007, Visio 2003 and Visio 2002. Lists methods that you can use to try to recover the damaged drawing.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Reliability
  - CSSTroubleshoot
ms.author: meerak
ms.reviewer: v-dahedm
search.appverid: 
  - MET150
appliesto: 
  - Visio 2013
  - Visio 2010
  - Visio 2007
  - Visio 2003
ms.date: 06/06/2024
---

# How to troubleshoot damaged drawings in Visio

## Summary

This article discusses how to troubleshoot damaged drawings in Microsoft Office Visio 2013, Visio 2010, Visio 2007, Microsoft Office Visio 2003, and Microsoft Visio 2002. This article describes some symptoms that may indicate that the drawing that you're working with in Visio is damaged. 

Additionally, this article lists some recovery methods that you can use on the damaged drawing. They include general troubleshooting methods, methods to try if you can or can't open the drawing, and methods to help prevent damage that may occur to drawings.

## Introduction 

### Overview

If you experience unexpected behavior when you work with a Visio drawing, the Visio drawing may be damaged. You may receive the following error messages if you have a damaged drawing:

- "Invalid Page Fault," "General Protection Fault," or "Illegal Instruction" error messages   
- Error messages that are similar to one of the following when you open a drawing: 

  "An error (100) occurred during the action Open"

  "Visio cannot open the file because it's not a Visio file or it has become corrupted."

- "Out of memory" error messages or error messages that indicate low system resources   

> [!NOTE]
> These error messages do not always mean that your drawing is damaged. However, if you repeatedly experience one or more of these error messages when you work with a particular drawing, that drawing may be damaged. 

This article lists some methods that you can use to try to recover the damaged drawing. The methods that are described in this article don't guarantee the successful recovery of a damaged drawing. Sometimes, depending on the type of damage, you may not be able to recover any data. You may have to re-create the drawing or restore the drawing from your backup files. 

### General troubleshooting methods

#### Start Visio without Automation events and without Microsoft Visual Basic for Applications

Start Visio without Automation events and without Visual Basic for Applications by using one of the following methods: 

#### Method 1: Microsoft Office Visio 2013 and Visio 2010

1. Start Visio.    
2. On the **File** tab, select **Options**, and then select **Trust Center**.    
3. Select ****Trust Center** Settings**, and then select **Disable all macros without notification**.    
4. Select **Add-ins**.    
5. Select the **Disable all Application Add-ins** check box.    
6. Select **OK**.    
7. Exit Visio, and then restart Visio.    

#### Method 2: Microsoft Office Visio 2007

1. Start Visio normally.   
2. On the **Tools** menu, select **Trust Center**.   
3. Select **Macro Settings**, and then select **Disable all macros without notification**.   
4. Select **Add-ins**.   
5. Select the **Disable all Application Add-ins** check box.   
6. Select **OK**.   
7. Exit Visio, and then restart Visio.   

#### Method 3: Microsoft Office Visio 2003 and earlier versions of Visio

1. Start Visio normally.   
2. Use one of the following procedures, depending on the version of Visio that you're running: 
   - If you're running Visio 2003, select **Options** on the **Tools** menu, and then select the **Security** tab.   
   - If you're running Visio 2002, select **Options** on the **Tools** menu, and then select the **Advanced** tab.   
3. Follow these steps: 
   - Clear the **Enable Microsoft Visual Basic for Applications** check box. 

     **Note** After you clear the **Enable Microsoft Visual Basic for Applications** check box, the **Enable Microsoft Visual Basic for Applications project creation** check box and the **Load Microsoft Visual Basic for Applications project from text** check box becomes unavailable.    
   - Clear the **Enable COM add-ins** check box.   
   - Clear the **Enable Automation events** check box.   

4. Select **OK**, and then quit Visio.   
5. Restart Visio.   

#### Method 4: Use the 'Copy Drawing' command to copy each page into a page in a new drawing

For Visio 2013 and Visio 2010:

1. Make sure that nothing in the drawing is selected.    
2. On the **Home** tab, under the **Clipboard** group, select **Copy**.    
3. Open the document in which you want to embed the drawing, and then on the **Home** tab, in the **Clipboard** group, select **Paste**.   

For Visio 2007 and Visio 2003:

1. In the Microsoft Office Visio drawing, make sure that nothing is selected. 
2. On the **Edit** menu, select **Copy Drawing**. 
 
   > [!NOTE]
   > This command copies the entire drawing, including shapes on other drawing pages and on backgrounds. When you embed a multiple-page Visio drawing, the visible page will be the one that is active when you select **Copy Drawing**.

3. Open the document in which you want to embed the drawing, and then on the **Edit** menu, select **Paste**(or the equivalent command). 

#### Start Windows in Safe Mode

Start Windows in Safe Mode by following these steps:

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

1. Shut down, and then restart your computer.   
2. When you see the "Please select the operating system to start" message, press F8. 
3. On the **Windows Advanced Options** menu, use the ARROW keys to select **Safe Mode**, and then press ENTER. 
4. If you have a dual-boot or multi-boot computer, select the appropriate operating system from the list that appears, and then press ENTER.
5. Start Visio, and then try to open your drawing.   

For more information about Safe Mode, see [Advanced startup options (including safe mode)](https://support.microsoft.com/help/315222).

### Methods to try if you can't open a drawing

#### Method 1: Drag the drawing file to the Visio.exe file icon

Drag the drawing file to the icon that represents the Visio.exe file. If you're running Visio 2010, the Visio.exe file is located in the following folder: `Drive:\Program Files\Microsoft Office\Office14`, *If you installed Visio 32-bit on Windows 64-bit the Program Files folder has a (x86) behind the folder name. Visio 2010 now has a native 64-bit version.

1. Quit Visio.   
2. Start Microsoft Windows Explorer, and then locate the Visio.exe file on your hard disk. If you installed Visio to the default location, the Visio.exe file is located in one of the following folders, depending on the version of Visio that you are running:
   - If you are running Visio 2013, the Visio.exe file is located in the following folder: `Drive:\Program Files\Microsoft Office\Office15` 

     > [!NOTE]
     > If you installed a 32-bit version of Visio on a 64-bit version of Windows, the Program Files folder has a (x86) behind the folder name. Visio 2013 now has a native 64-bit version.   
   - If you're running Visio 2010, the Visio.exe file is located in the following folder: `Drive:\Program Files\Microsoft Office\Office14` Note: If you installed a 32-bit version of Visio on a 64-bit version of Windows, the Program Files folder will have a (x86) behind the folder name. Visio 2010 now has a native 64-bit version.

     If you're running Visio 2007, the Visio.exe file is located in the following folder: 

     **Drive**:\Program Files\Microsoft Office\Office12

     If you're running Visio 2003, the Visio.exe file is located in the following folder: 

     **Drive**:\Program Files\Microsoft Office\Visio11   

  - If you're running Visio 2002, the Visio.exe file is located in the following folder: 

     **Drive**:\Program Files\Microsoft Office\Visio10

     > [!NOTE]
     > If you installed Visio to a folder that is different from the default installation location, the path of the Visio.exe file is different on your computer.    

3. In Windows Explorer, locate the drawing file that you want to open.   
4. Drag the drawing file to the icon that represents the Visio.exe file.   

#### Method 2: Double-click the drawing file in Windows Explorer

Try to open the drawing file by using Windows Explorer: 

1. Quit Visio.   
2. Start Windows Explorer, and then locate the drawing file that you want to open.   
3. Double-click the drawing file.    

#### Method 3: Open the temporary copy of the drawing file

When you modify a Visio drawing, a temporary copy of the drawing file is created. The temporary copy of the drawing file is named ~$$**FileName**.~vsd. The temporary copy of the drawing file is typically created and stored in the same folder as where your drawing is located. 

To open the temporary copy of the drawing file, follow these steps: 

1. Start Visio, and then open your drawing.   
2. Start Windows Explorer, and then locate the folder where your drawing is stored. Look in this folder for the temporary copy of the drawing file. The temporary copy of the drawing file is named ~$$**FileName**.~vsd.

    > [!NOTE]
    > If the temporary copy of the drawing file is not located in the folder where your drawing is stored, search the hard disk for the temporary copy of the drawing file. 
    
    To search the hard disk for the temporary copy of the drawing file, follow these steps: 
    
    **Note** Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

    1. Select **Start**, and then select **Search**.   
    2. Select **All files and folders**.   
    3. In the **All or part of the file name** box, type `~$$**FileName**.~vsd`, and then select **Search**.   
   
3. Change the extension of the temporary copy of the drawing file to .vsd. Follow these steps:

    1. Right-click the temporary copy of the drawing file, and then select **Rename**.    
    2. Change the extension of the temporary copy of the drawing file from ~.vsd to .vsd.   

4. Try to open the temporary copy of the drawing file that you renamed.   

#### Method 4: Use the Microsoft Office Visio Viewer to open the drawing

Install Microsoft Office Visio Viewer 2010, and then use Visio Viewer to open and view your drawing. When you install Visio Viewer 2010, you can use Microsoft Internet Explorer 5.0 or a later version of Internet Explorer to view Visio drawings and diagrams that are created with Visio 2010, Visio 2007, Visio 2003, Visio 2002, Microsoft Visio 2000, or Microsoft Visio 5. For more information about Visio Viewer 2010, visit the following Microsoft website:

[https://www.microsoft.com/download/details.aspx?id=21701](https://www.microsoft.com/download/details.aspx?id=21701)

If you can open your drawing in the Visio Viewer, the installation of Visio on your computer may be damaged, or your drawing may contain one or more objects that may be damaged. 

#### Method 5: Copy the drawing file to another computer

Copy the drawing file to another computer that has Visio installed on it. If you can open your drawing on that computer, save the drawing file to a different folder on the hard disk of that computer, and then copy the drawing file back to the original computer. 

#### Method 6: Copy the drawing file to another disk on your computer

Windows may not be able to read the drawing file from where the drawing file is currently saved. Copy the drawing file to another disk on your computer. For example, copy the file from a floppy disk to the hard disk. After you copy the drawing file to a different disk on your computer, try to open the drawing file.

> [!NOTE]
> If you cannot copy the drawing file from the disk where the drawing file is saved, the drawing file may be cross-linked with other files or folders, or the drawing file may be located in a damaged sector of the disk. To troubleshoot this issue, follow the steps in Method 7. 

#### Method 7: Detect and repair errors on the hard disk

If you are running Microsoft Windows Server 2003, Microsoft Windows XP, Microsoft Windows 2000, or Microsoft Windows NT 4.0, use the Check Disk tool to detect file system errors or bad sectors on your hard disk. 

For more information, select the following article numbers to view the articles in the Microsoft Knowledge Base:

[Check your hard disk for errors](https://support.microsoft.com/help/2641432)

If you're running Microsoft Windows Millennium Edition (Me) or Microsoft Windows 98, use the Scandisk tool to detect file system errors or bad sectors on your hard disk. 

> [!NOTE]
> Although the Check Disk tool or the ScanDisk tool can detect and repair file-system errors or bad sectors on the hard disk, Visio may still not be able to open or read the file. 

#### Method 8: Open a previous "Shadow Copy" using the Previous Versions tab

1. Right-click the **Visio** file.
2. Choose **Properties**.
3. Select the **Previous Versions** tab, give some time for the list to populate.
4. Select an older version of the file.
5. Select **Open**.
6. If the file opens successfully, from the **File** menu, select **Save As** and save a copy of the file.

### Methods to try if you can open the drawing

#### Method 1: Save the file as an XML drawing

 Save the drawing as an XML drawing (.vdx file), and then save the XML drawing as a drawing (.vsd file). Follow these steps:

1. Start Visio, and then open your drawing.   
2. On the **File** menu, select **Save As**.   
3. In the **Save As** dialog box, select **XML Drawing (*.vdx)** in the **Save as type** box, and then type a file name in the **File name** box. Specify a location where you want to save the drawing file, and then select **Save**.   
4. Close all the drawings that are currently open.   
5. On the **File** menu, select **Open**.    
6. Locate the XML drawing (.vdx) that you saved earlier in step 3, and then select **Open**.   
7. On the **File** menu, select **Save As**.   
8. In the **Save As** dialog box, select **Drawing (*.vsd)** in the **Save as type** box, and then type a file name in the **File name** box. Specify a location where you want to save the drawing file, and then select **Save**.   
9. Close the drawing.   
10. On the **File** menu, select **Open**   
11. Locate the drawing (.vsd file) that you saved earlier in step 8, and then select **Open**.   

#### Method 2: Insert the drawing to a new blank drawing

Insert the drawing to a new blank drawing. To do this:

For Visio 2013 and Visio 2010:

1. Start Visio    
2. Under the **File** tab, under **New**, select **Blank Drawing**, and then select the **Create** button.   
3. On the **Insert** tab, select **Object**.   
4. Select **Create from file**, and then select **Browse**.    
5. Select the drawing, select **Open**, and then select **OK**.    
6. Depending on your situation, determine whether the drawing file is damaged or whether there's another problem. 
   - If you receive an "Error 3400" error message, the drawing file may be damaged. Use the methods that are described in this article to try to recover the drawing.    
   - If you don't receive an "Error 3400" error message, there may be another issue that may be preventing Visio from opening the drawing. For example, a conflict may exist between certain components on the computer that prevent Visio from opening the drawing.    
   
For Visio 2007 and Visio 2003:

1. Start Visio.   
2. On the **File** menu, point to **New**, and then select **New Drawing**.   
3. On the **Insert** menu, select **Object**.    
4. Select **Create from file**, and then select **Browse**.   
5. Select the drawing, select **Open**, and then select** OK**.   
6. Depending on your situation, determine whether the drawing file is damaged or whether there's another problem.
   - If you receive an "Error 3400" error message, the drawing file may be damaged. Use the methods that are described in this article to try to recover the drawing.   
   - If you don't receive an "Error 3400" error message, there may be another issue that may be preventing Visio from opening the drawing. For example, a conflict may exist between certain components on the computer that prevent Visio from opening the drawing.      

### Methods to try to help prevent damage to drawings

You can't prevent all corruption that may occur to files. Hard disks may wear out, power supplies may fail, and other unforeseeable events may occur that cause files to become damaged. The following tips and suggestions may help reduce the number of damaged files that occur in Visio and in other programs. 

#### Optimize the AutoRecover setting in Visio

Configure the **AutoRecover** setting to a value that works for you. If your computer stops responding or if you lose power unexpectedly, Visio opens the AutoRecovery file the next time that you start the program. The AutoRecovery file may contain unsaved information that would otherwise be lost from your original drawing file. If your original drawing file was damaged, you may be able to recover information from the AutoRecovery file.

To configure the **AutoRecover** setting in Visio:

1. Start Visio.   
2. On the **Tools** menu, select **Options**.   
3. Select the **Save** tab or the **Save/Open** tab.   
4. Select the **Save AutoRecover info every** check box, and then specify the time in minutes that you want. By default, the **AutoRecover** setting is set for 10 minutes.    
5. Select **OK**.

#### Make sure that the power supply is consistent

A power supply that isn't consistent can cause damage to files, even if you don't lose power. A power supply that spikes or that isn't sufficient can affect the read process and write processes on your computer, and may cause damage. If the power supply in your area is inconsistent, use a surge protector. Surge protectors can help prevent damage on your computer if power spikes occur. You may also consider using an uninterruptible power supply (UPS). UPS units supply your computer with power even if there is a power outage. Contact your hardware vendor for more information about how to obtain either of these devices.


#### Back up your data

Make sure that you back up your data regularly. For example, store a backup copy of your drawing on a different volume on the hard disk. Or, depending on your requirements and on your environment, implement other backups or other fault-tolerant solutions on your computer. Some fault-tolerant solutions, such as Redundant Array of Independent Disks (RAID), are typically only practical for larger networks. Other backup options include: 

- Tape backup   
- CD backup   
- Mirrored volume   
- RAID-5 volume   
- External hard disk drive   
- USB (Flash) drive   

#### Work with your data locally

If you work in a network environment and you experience corruption frequently, you may want to consider copying your files to your local computer before you open the file or before you modify the file. Copy the file to your desktop by using My Computer or by using Windows Explorer. When you work with files that are stored on your local computer, you prevent read issues or write issues that may be caused by network connectivity issues such as: 

- Slow network connections   
- Dropped network connections   
- Spikes in network traffic   
 
You may also want to consider working from the hard disk and not working from removable media such as a floppy disk or a ZIP drive. The more media and the more device drivers that are involved in a save operation, the more the increased chance of file damage.
