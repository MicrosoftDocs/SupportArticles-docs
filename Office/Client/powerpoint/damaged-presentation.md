---
title: Troubleshoot a damaged presentation in PowerPoint
description: Describes how to troubleshoot a damaged presentation in PowerPoint.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - PowerPoint 2019
  - PowerPoint 2016
  - PowerPoint 2013
  - PowerPoint 2010
  - Microsoft Office PowerPoint 2007
ms.date: 03/31/2022
---

# How to troubleshoot a damaged presentation in PowerPoint

## Summary

You may experience unexpected behavior when you work with a Microsoft PowerPoint presentation. This behavior may occur because the presentation is damaged. This article contains step-by-step methods that may help you partly or fully restore your presentation. 

This article is intended for a beginning to intermediate computer user. You may find it easier to follow the steps if you print this article first.


## Symptoms

When you try to open or change a presentation that is damaged, you may experience the following symptoms:

- When you try to open a presentation, you receive one of the following error messages:
 
    **This is not a PowerPoint Presentation**
    
    **PowerPoint cannot open the type of file represented by \<file_name>.ppt** 
    
    **Part of the file is missing.** 
  
- You receive the following kinds of error messages:
 
    **General Protection Fault**
    
    **Illegal Instruction**
    
    **Invalid Page Fault**
    
    **Low system resources**
    
    **Out of memory**   

## More Information

### How to determine whether you have a damaged presentation

There are several ways to determine whether you have a damaged presentation. You can try to open the file on another computer that has PowerPoint installed to see whether the unexpected behavior occurs on the other computer. You can try to create a new file in PowerPoint and see whether the unexpected behavior occurs with the new file. This section describes how to use existing presentations and how to create a new file in PowerPoint to determine whether the presentations have the same behavior.

#### Method 1: Open an existing presentation

1. On the **File** menu, select **Open**.
   - In PowerPoint 2007 select the **Microsoft Office Button**.
2. Select a different presentation, and then select Open.

If this presentation opens and seems to be undamaged, go to Method 3 in this section. Otherwise, go to Method 2 to create a new presentation.

#### Method 2: Create a new presentation

##### Step 1: Create the presentation

1. On the **File** menu, select **New**, and then **Welcome to PowerPoint** (or **Introducing PowerPoint 2010**).
    - In PowerPoint 2007, select **Installed Templates**, and then select **Introducing PowerPoint 2007**.
1. Select **Create**. This process creates a presentation that is based on the template.
1. On the **File** menu, select **Save**.
    - In PowerPoint 2007 select the **Microsoft Office Button**, and then select **Save**.
1. Type a name for the presentation, and then select **Save**.
1. Exit PowerPoint.

##### Step 2: Open the new presentation

1. On the **File** menu, select **Open**.
    - In PowerPoint 2007 select the **Microsoft Office Button**, and then select **Open**.
1. Select the new presentation, and then select **Open**.

If you cannot open or save the new presentation, go to Method 3.

If you cannot create a new presentation, PowerPoint may be damaged and a repair should be initiated. (See Method 3, Part 2 below.)

#### Method 3: General troubleshooting

##### Windows 10, Windows 8.1, Windows 8, and Windows 7

**Part 1**

This procedure allows your computer to restart without startup add-ons. For a clean restart, follow these steps:

1. Sign in to the computer by using an account that has administrator rights.
1. Select Start, type msconfig.exe in the Start Search box, and then press **Enter** to start the System Configuration utility.

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, you should type the password or provide confirmation.

1. On the **General** tab, select the **Selective startup** option, and then clear the **Load startup items** check box. (The Use Original Boot.ini check box is unavailable.)
1. On the Services tab, select the Hide all Microsoft services check box, and then select Disable all.

    > [!NOTE]
    > This step lets Microsoft services continue to run. After you do a clean restart, you should check Office performance and then resume usual startup.

**Part 2**

This procedure will cause the Office program to check for issues and repair itself.
1. Select the **Start** button and type Control Panel.
1. Open the Control Panel, go to **Uninstall or change a program** (or **Add or Remove Programs**).
1. Scroll through the list of programs and find your version of Microsoft Office. Right-select and then select **Change**.

    > [!NOTE]
    > We suggest that you do the online repair option.

### Methods to try if you cannot open a presentation

#### Method 1: Drag the presentation to the PowerPoint program file icon

##### Windows 10, Windows 8.1, and Windows 8 

1. Right-click the Windows icon on the Taskbar, and then select Run.

1. Type one of the following depending on your version of PowerPoint:

    ```powershell
    %ProgramFiles%\Microsoft Office
    %ProgramFiles(x86)%\Microsoft Office
    ```
1. Select the Enter key.
1. Locate the Powerpnt.exe icon in Windows Explorer.
1. Drag the damaged presentation icon from one window to the Powerpnt.exe icon in the other window.

PowerPoint will try to open the presentation. If PowerPoint does not open the presentation, go to Method 2.

##### Windows 7

1. Select Start, and then select Documents. Or select Start and then search for Windows Explorer.
1. If you have the MSI version of PowerPoint 2013 installed, type %ProgramFiles%\Microsoft Office\office15 (PowerPoint 2013 64 bit) or %ProgramFiles(x86)%\Microsoft Office\office15 (PowerPoint 2013 32 bit), and then press Enter. 

    If you have PowerPoint 2013 Select-to-Run installed, type C:\Program Files\Microsoft Office 15\root\office15 (PowerPoint 2013 64 bit) or C:\Program Files(x86)\Microsoft Office 15\root\office15 (PowerPoint 2013 32 bit), and then press Enter.

    If you have the MSI version of PowerPoint 2016 installed, type %ProgramFiles(x86)%\Microsoft Office\office16, and then press Enter.

    If you have PowerPoint 2016 Select-to-Run installed, type %ProgramFiles%\Microsoft Office\root\Office16 (PowerPoint 2016 64 bit) or %ProgramFiles(x86)%\Microsoft Office\root\Office16 (PowerPoint 2016 32 bit), and then press Enter.
1. Locate the Powerpnt.exe icon in Windows Explorer.
1. Drag the damaged presentation icon from one window to the Powerpnt.exe icon in the other window.

#### Method 2: Try to insert slides into a blank presentation

##### Step 1: Create a blank presentation

1. In the File menu, select New.
    - In PowerPoint 2007, click the **Microsoft Office Button**, and then click **New**.
1. Select Blank Presentation, and then select Create.

This process creates a blank title slide. You can delete this slide later after you re-create the presentation.

##### Step 2: Insert the damaged presentation as slides

1. On the Home tab, select the arrow next to New slides in the Slides group, and then select Reuse Slides.
1. In the Reuse Slides task pane, select Browse. Select the damaged presentation, and then select Open.
1. Select **Insert Slide** for each slide in the damaged presentation.
1. In the **File** menu, select Save.
    - In PowerPoint 2007 click the **Microsoft Office Button**, and then click **Save**.
1. Type a new name for the presentation, and then select Save.

##### Step 3: Apply the damaged presentation as a template

If the presentation does not look the way that you expect after you try these steps, try to apply the damaged presentation as a template. To do this, follow these steps:

1. On the File menu, select Save as.
    - In PowerPoint 2007 click the **Microsoft Office Button**, and then click **Save as**.
1. Type a new name for the presentation, and then select Save.

    > [!NOTE]
    > This will make a backup copy of the restored presentation that you can use in case the damaged presentation damages this new presentation.

1. On the Design tab, select More in the Themes group, and then select Browse for Themes.
1. Select the damaged presentation, and then select Apply. The slide master of the damaged presentation replaces the new slide master.

> [!NOTE]
> If you start to experience unexpected behavior after you follow these steps, the template may have damaged the presentation. In this case, use the backup copy to re-create the master slide.

If the backup copy of the new presentation exhibits the same damage or strange behavior as the original presentation, go to Method 3.

#### Method 3: Try to open the temporary file version of the presentation

When you edit a presentation, PowerPoint creates a temporary copy of the file. This temporary file is named PPT ####.tmp.

> [!NOTE]
> The placeholder #### represents a random four-digit number.

This temporary file may be located in the same folder as the location to which the presentation is saved. Or it may be located in the temporary file folder.

##### Rename the file, and then try to open the file in PowerPoint

1. Right-select the file, and then select Rename.
1. Change the old file-name extension from .tmp to .pptx so that the file name resembles the following file name: 

    PPT ####.pptx
1. Start PowerPoint.
1. On the File menu, select Open.
1. Browse to the folder that contains the renamed file.
1. Try to open the file in PowerPoint.

> [!NOTE]
> More than one file may correspond to the temporary file that was created the last time that you saved the presentation. In this case, you may have to open each file to see whether one is the temporary copy of the presentation.

If there are no temporary files, or if the temporary files display the same kind of damage or strange behavior, go to Method 4.

#### Method 4: Make a copy of the damaged presentation

1. Right-select the presentation, and then select Copy.
1. In the Windows Explorer window, right-select in a blank space, and then select Paste.

If you cannot copy the file, the file may be damaged, or the file may reside on a damaged part of the computer's hard disk. In this case, go to Method 5.

If you can copy the file, try to open the copy of the damaged presentation in PowerPoint. If you cannot open the copy of the damaged presentation, try to repeat Method 1 through Method 5 in the "Methods to try if you cannot open a presentation" section below by using the copy of the damaged presentation.

#### Method 5: Run Error Checking on the hard disk drive

##### Windows 10, Windows 8.1, and Windows 8

1. Exit all open programs.
1. Right-click the **Start** menu and select **File Explorer**.
1. Right-select the hard disk drive that contains the damaged presentation.
1. Select Properties, and then select the Tools tab.
1. In Error-checking, select Check Now.
1. Select the check box Automatically fix file system errors.
1. Select the check box Scan for and attempt recovery of bad sectors.
1. Select Start.

##### Windows 7

1. Exit all open programs.
1. Select Start, and then select Computer.
1. Right-click the hard disk drive that contains the damaged presentation.
1. Select Properties, and then select the Tools tab.
1. In Error-checking, select Check Now.
1. Select to select the Automatically fix file system errors check box.
1. Select to select the Scan for and attempt recovery of bad sectors check box.
1. Select Start.

> [!NOTE]
> Error checking may verify that the presentation is cross-linked and attempt to repair the presentation. However, this is not a guarantee that PowerPoint will be able to read the presentation.

### Methods to try if you can open a damaged presentation

#### Method 1: Try to apply the damaged presentation as a template

##### Step 1: Create a blank presentation

1. On the **File** menu, select **New**.
    - In PowerPoint 2007, select the **Microsoft Office Button**, and then select **New**.
1. Select **Blank Presentation**, and then select **Create**. This process creates a blank title slide. (You can delete this slide after you re-create the presentation.) 

##### Step 2: Insert the damaged presentation into the blank presentation

1. On the **Home** tab, select the arrow next to **New slides** in the **Slides** group, and then select **Reuse Slides**.
1. In the **Reuse Slides** task pane, select **Browse**.
1. Select the damaged presentation, and then select **Open**.
1. Select **Insert Slide** for each slide in the damaged presentation. 
1. Select the **Microsoft Office** button, and then select **Save**.
1. Type a new name for the presentation, and then select Save.

##### Step 3: Apply the damaged presentation as a template

If the presentation does not look the way that you expect it to look after you try follow these steps, try to apply the damaged presentation as a template. To do this, follow these steps: 

1. On the **File** menu, select **Save as**.
- In PowerPoint 2007, select the **Microsoft Office Button**, and then select **Save as**.
1. Type a new name for the presentation, and then select **Save**.

    > [!NOTE]
    > This will make a backup copy of the restored presentation that you can use in case the damaged presentation damages this new presentation.

1. On the **Design** tab, select **More** in the **Themes** group, and then select **Browse for Themes**.
1. Select the damaged presentation, and then select **Apply**. The slide master of the damaged presentation replaces the new slide master.

> [!NOTE]
> If you start to experience unexpected behavior after you follow these steps, the template may have damaged the presentation. In this case, use the backup copy to re-create the master slide.

If the backup copy of the new presentation still displays damage or strange behavior, go to Method 2.

#### Method 2: Transfer the slides from the damaged presentation to a blank presentation

##### Step 1: Create a blank presentation

1. On the **File** menu in PowerPoint, select **Open**.
    - In PowerPoint 2007, select the **Microsoft Office Button**, and then select **Open**.
1. Locate the damaged presentation, and then select **Open**.
1. On the **File** menu in PowerPoint, select **New**.
    - In PowerPoint 2007, select the **Microsoft Office Button**, and then select **New**.
1. Select **Blank Presentation**, and then select **Create**. This process creates a blank title slide.

##### Step 2: Copy slides from the damaged presentation to the new presentation

1. On the **View** tab, select **Slide Sorter**. If you receive error messages when you switch views, try to use Outline view. 
1. Select a slide that you want to copy.
On the **Home** tab, select **Copy**.

    > [!NOTE]
    > If you want to copy more than one slide at a time, hold down the Shift key, and then select each slide that you want to copy.

1. Switch to the new presentation. To do this, on the **Window** tab, select **Switch Window** in the **View** group, and then select the new presentation that you created in step 1. 
1. On the **View** tab, select **Slide Sorter**.
1. On the **Home** tab, select **Paste**.
1. Repeat steps 2a through 2f until the whole presentation is transferred.

> [!NOTE]
> In some cases, one damaged slide may cause a problem for the whole presentation. If you notice unexpected behavior in the new presentation after you copy a slide to the presentation, that slide is likely to be damaged. Re-create the slide, or copy sections of the slide to a new slide.

If the new presentation shows damage or strange behavior, go to method 3.

#### Method 3: Save the presentation as a Rich Text Format (RTF) file

If there is damage throughout the presentation, the only option to recover the presentation may be to save the presentation as a Rich Text Format (RTF) file. If this method is successful, it recovers only the text that appears in Outline view. 

##### Step 1: Save the presentation in the RTF file format

1. Open the presentation.
1. On the **File** menu, select **Save As**, select a location to save the file, and then select **More options**.
    - In PowerPoint 2007, select the **Microsoft Office Button**, select **Save As**, and then select **Other Formats**.
1. In the **Save as type** list, select **Outline/RTF(*.rtf)**.
1. In the **File Name** box, type the name that you want to use, select a location in which to save the presentation, and then select **Save**.
1. Close the presentation.

> [!NOTE]
> Any graphics, tables, or other text in the original presentation will not be saved in the .rtf file.

##### Step 2: Open the .rtf file in PowerPoint

1. On the **File** menu, select **Open**.
1. In the **Files of type** list, select **All Outlines** or **All Files**.
1. Select the .rtf file that you saved in step 1d, and then select **Open**.

This procedure will re-create the presentation based on the original presentation's outline view. 