---
title: Troubleshoot a damaged presentation in PowerPoint 2007 and PowerPoint 2010
description: Describes how to troubleshoot a damaged presentation in PowerPoint 2007 and PowerPoint 2010.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to troubleshoot a damaged presentation in PowerPoint 2007 and PowerPoint 2010

## Summary

You may experience unexpected behavior when you work with a Microsoft Office PowerPoint 2007 or PowerPoint 2010 presentation. This behavior may occur because the presentation is damaged. This article contains step-by-step methods to try that may help you partially restore or fully restore your presentation. 
This article is intended for a beginning to intermediate computer user.

You may find it easier to follow the steps if you print this article first.

## Symptoms of the problem 

When you try to open or change a presentation that is damaged, you may experience the following symptoms:

- When you try to open a presentation, you receive one of the following error messages:
 
    **This is not a PowerPoint Presentation**
    
    **PowerPoint cannot open the type of file represented by \<file_name>.ppt** 
    
    **Part of the file is missing.** 
  
- You receive the following types of error messages:
 
    **General Protection Fault**
    
    **Illegal Instruction**
    
    **Invalid Page Fault**
    
    **Low system resources**
    
    **Out of memory**   

## Methods to determine whether you have a damaged presentation 

There are several ways to help determine whether you have a damaged presentation. You can try to open the file on another computer that has PowerPoint 2007 installed to see whether the unexpected behavior occurs on the other computer. You can try to create a new file in PowerPoint and see whether the unexpected behavior occurs with the new file. This section describes how to use existing presentations and how to create a new file in PowerPoint to determine whether the presentations have the same behavior.

### Method 1: Open an existing presentation

1. In PowerPoint 2007 click the **Microsoft Office Button. **In PowerPoint 2010 click the **File menu **and then click **Open**.   
2. Click a different presentation, and then click **Open**.   

If this presentation opens and appears to be undamaged, go to method 3 in this section. Otherwise, go to method 2 to create a new presentation.

### Method 2: Create a new presentation

#### Step 1: Create the presentation

1. In PowerPoint 2007 click the **Microsoft Office Button**, and then click **New**. In PowerPoint 2010 click the File menu.   
2. In PowerPoint 2007, click **Installed ****Templates**, and then click **Introducing PowerPoint 2007**. In PowerPoint 2010 click the **File menu, **click **New, **click **Sample templates, **click **Introducing PowerPoint 2010.** 
3. Click **Create**. This process creates a presentation based on the template.   
4. In PowerPoint 2007 click the **Microsoft Office Button**, and then click **Save**. In PowerPoint 2010 click the **File menu** and then click **Save.**   
5. Type a name for the presentation, and then click **Save**.    
6. Exit PowerPoint.   

#### Step 2: Open the new presentation

1. In PowerPoint 2007 click the **Microsoft Office Button**, and then click **Open**. In PowerPoint 2010 click the **File menu**, and then click **Open**.   
2. Click the new presentation, and then click **Open**.   

If you cannot open or save the new presentation, go to method 3. If you cannot create a new presentation, PowerPoint may be damaged and must be repaired.

### Method 3: General troubleshooting

#### Windows 7, Windows 8/8.1, Windows 10

##### Part I

For the clean reboot, please follow the steps:

1. Log on to the computer by using an account that has administrator rights.   
2. Click Start, type msconfig.exe in the Start Search box, and then press Enter to start the System Configuration utility. 

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, you should type the password or provide confirmation.   
3. On the General tab, click the Selective startup option, and then click to clear the Load startup items check box. (The Use Original Boot.ini check box is unavailable.)   
4. On the Services tab, click to select the Hide all Microsoft services check box, and then click Disable all. 

    > [!NOTE]
    > This step lets Microsoft services continue to run. After you do a clean reboot, please check Office performance and resume normal startup.   

##### Part II

Go to control panel, repair office programs (right-click it, select change), we suggest a quick repair first and online repair later.

## Methods to try if you cannot open a presentation 

### Method 1: Drag the presentation to the PowerPoint program file icon

Windows 7

1. Click **Start** ![Start button](https://support.microsoft.com/library/images/support/kbgraphics/public/en-us/vistastartbutton.jpg), and then click Documents, or Click Startand then search for Windows Explorer.   
2. In the Address Bar, type %ProgramFiles(x86)%\Microsoft Office\Office12 (PowerPoint 2007), and then press ENTER. If you have PowerPoint 2010 installed type %ProgramFiles%\Microsoft Office\office14 (PowerPoint 2010 64 bit), or %ProgramFiles(x86)%\Microsoft Office\office14 (PowerPoint 2010 32 bit), and then press ENTER.   
3. Locate the Powerpnt.exe icon in Windows Explorer.   
4. Drag the damaged presentation icon from one window to the Powerpnt.exe icon in the other window.

Windows 8/8.1/10

1. Right click ![Start button ](https://support.microsoft.com/Library/Images/3103312.png), and then click Run.   
2. In the Open box, type C:\Program Files (x86)\Microsoft Office\Office12 (PowerPoint 2007). If you have PowerPoint 2010 installed type C:\Program Files\Microsoft Office\office14 (PowerPoint 2010 64 bit), or C:\Program Files(x86)\Microsoft Office\office14 (PowerPoint 2010 32 bit), and then press ENTER.   
3. Click **OK**.   
4. Locate the Powerpnt.exe icon in Windows Explorer.   
5. Drag the damaged presentation icon from one window to the Powerpnt.exe icon in the other window.   

PowerPoint will try to open the presentation. If PowerPoint does not open the presentation, go to method 2.

### Method 2: Try to insert slides into a blank presentation

#### Step 1: Create a blank presentation

1. In PowerPoint 2007, click the **Microsoft Office Button**, and then click **New**. In PowerPoint 2010, click the **File menu**, and then click **New**.   
2. Click **Blank Presentation**, and then click **Create**. 

This process creates a blank title slide. You can delete this slide later after you re-create the presentation.

#### Step 2: Insert the damaged presentation as slides

1. On the **Home** tab, click the arrow next to **New slides ** in the **Slides** group, and then click **Reuse Slides**. 
2. In the **Reuse Slides** task pane, click **Browse**. Click the damaged presentation, and then click **Open**. 
3. Right-click one of the slides in the **Reuse Slides** task pane, and then click **Insert All**. 

    If this operation is successful, all the slides from the damaged presentation, except the slide master, are inserted into the new presentation.

4. In PowerPoint 2007 click the **Microsoft Office Button**, and then click **Save**. In PowerPoint 2010 click the **File menu**, and then click **Save**.   
5. Type a new name for the presentation, and then click **Save**.    

#### Step 3: Apply the damaged presentation as a template

If the presentation does not look the way that you expect after you try these steps, try to apply the damaged presentation as a template. To do this, follow these steps: 

1. In PowerPoint 2007 click the Microsoft Office Button, and then click Save as. In PowerPoint 2010 click the File menu, and then click Save as.   
2. Type a new name for the presentation, and then click **Save**. 

    This will make a backup copy of the restored presentation, in case the damaged presentation damages this new presentation.   
1. On the **Design** tab, click **More** in the **Themes** group, and then click **Browse for Themes**. 

4. Click the damaged presentation, and then click **Apply**. The slide master of the damaged presentation replaces the new slide master. 

> [!NOTE]
> If you start to experience unexpected behavior after you follow these steps, the template may have damaged the presentation. In this case, use the backup copy to re-create the master slide.

If the backup copy of the new presentation exhibits the same damage or strange behavior as the original presentation, go to method 3.

### Method 3: Try to open the temporary file version of the presentation

When you edit a presentation, PowerPoint creates a temporary copy of the file. This temporary file is named PPT **####**.tmp. Occasionally, if there are issues with your presentation, the temp file will remain in the saved file location.

Note** ####** represents a random four-digit number. 

This temporary file may reside in the same folder as the presentation save location. Alternatively, it may reside in the temporary file folder.

#### Rename the file, and then try to open the file in PowerPoint

1.  Right-click the file, and then click **Rename**.    
2.  Change the old file name extension from .tmp to .pptx so that the file name resembles the following file name: PPT **####**.pptx   
3. Start PowerPoint.   
4. In PowerPoint click the File menu, and then click Open.   
5. Browse to the folder that contains the renamed file.   
6. Try to open the file in PowerPoint.   

> [!NOTE]
> More than one file may correspond to the temporary file that was created the last time that you saved the presentation. In this case, you may have to open each file to see whether one is the temporary copy of the presentation. 

If there are no temporary files, or if the temporary files display the same kind of damage or strange behavior, go to method 4.

### Method 4: Try to open the presentation in PowerPoint Viewer.

Windows 7/8/8.1/10

#### Step 1: Visit the PowerPoint Viewer download Web page 

1. Open Internet Explorer or Edge.

2. Visit the following Microsoft Web site for PowerPoint 2007 Viewer:

    [https://www.microsoft.com/en-us/download/details.aspx?id=27806](https://www.microsoft.com/en-us/download/details.aspx?id=27806)

#### Step 2: Install PowerPoint Viewer

1. Click **Download**.
2. Click **Run**.   
3. Click to select the **Click here to accept the Microsoft Software License Terms** check box, and then click **Continue**.

4. Click **OK**.

If you are prompted for an administrator password or for confirmation, type the password, or click **Continue**.   

#### Step 3: Open the damaged presentation in PowerPoint Viewer

1. Click **Start** ![Start button ](https://support.microsoft.com/library/images/support/kbgraphics/public/en-us/vistastartbutton.jpg), and then click All Programs or ![Start button ](https://support.microsoft.com/Library/Images/3103313.png) and All Apps.
2. Click **Microsoft Office PowerPoint Viewer [2007/2010]**.
3. Click **Accept**.
4. Click the damaged presentation, and then click **Open**.

If you can open the presentation in PowerPoint Viewer 2007 or PowerPoint 2010, the copy of PowerPoint installed on the computer may be damaged.

If you cannot open the presentation in PowerPoint Viewer 2007, go to method 5.

### Method 5: Make a copy of the damaged presentation

1. Right-click the presentation, and then click **Copy**.
2. In the Windows Explorer window, right-click in a blank space, and then click **Paste**.

If you cannot copy the file, the file may be damaged, or the file may reside on a damaged part of the computer's hard disk. In this case, go to method 6. 

If you can copy the file, try to open the copy of the damaged presentation in PowerPoint 2007. If you cannot open the copy of the damaged presentation, try to repeat method 1 through method 5 in the "Methods to try if you cannot open a presentation" section by using the copy of the damaged presentation.

### Method 6: Run Scandisk on the hard disk drive 

Windows 7

1. Exit all open programs.
2. Click **Start**, and then click **Computer**.
3. Right-click the hard disk drive that contains the damaged presentation.
4. Click **Properties**, and then click the **Tools** tab.
5. In **Error-checking**, click **Check Now**.
6. Click to select the **Automatically fix file system errors** check box.
7. Click to select the **Scan for and attempt recovery of bad sectors** check box.
8. Click **Start**.

Windows 8/8.1/10

1. Exit all open programs.
2. On the Windows desktop, click File Explorer ![Windows Explorer ](https://support.microsoft.com/Library/Images/3103314.png).
3. Right-click the hard disk drive that contains the damaged presentation.
4. Click **Properties**, and then click the **Tools** tab.
5. In **Error-checking**, click **Check Now**.
6. Click to select the **Automatically fix file system errors** check box.
7. Click to select the **Scan for and attempt recovery of bad sectors** check box.
8. Click **Start**.

> [!NOTE]
> Scandisk may verify that the presentation is cross-linked and may then repair the presentation. However, this is not a guarantee that PowerPoint 2007 will be able to read the presentation. 

## Methods to try if you can open a damaged presentation 

### Method 1: Try to apply the damaged presentation as a template

#### Step 1: Create a blank presentation

1. In PowerPoint 2007, click the **Microsoft Office Button**, and then click **New**. In PowerPoint 2010, click the **File menu**, and then click **New**.   
2. Click **Blank Presentation**, and then click **Create**. This process creates a blank title slide. You can delete this slide later after you re-create the presentation.

#### Step 2: Insert the damaged presentation into the blank presentation

1. On the **Home** tab, click the arrow next to **New slides** in the **Slides** group, and then click **Reuse Slides**. 
2. In the **Reuse Slides** task pane, click **Browse**. Select the damaged presentation, and then click **Open**. 
3. Right-click one of the slides in the **Reuse Slides** task pane, and then click **Insert All.**

    If this operation is successful, all the slides from the damaged presentation, except the slide master, are inserted into the new presentation.

4. Click the **Microsoft Office Button**, and then click **Save**.   
5. Type a new name for the presentation, and then click **Save**.    

#### Step 3: Apply the damaged presentation as a template

If the presentation does not look the way that you expect after you try these steps, try to apply the damaged presentation as a template. To do this, follow these steps: 

1. In PowerPoint 2007, click the **Microsoft Office Button**, and then click **Save as**. In PowerPoint 2010, click the **File menu**, and then click **Save as**.   
2. Type a new name for the presentation, and then click **Save**. 

    This will make a backup copy of the restored presentation, in case the damaged presentation damages this new presentation.   
3. On the **Design** tab, click **More** in the **Themes** group, and then click **Browse for Themes**. 

4. Select the damaged presentation, and then click **Apply**. The slide master of the damaged presentation replaces the new slide master. 

> [!NOTE]
> If you start to experience unexpected behavior after you follow these steps, the template may have damaged the presentation. In this case, use the backup copy to re-create the master slide.

If the backup copy of the new presentation still displays damage or strange behavior, go to method 2.

### Method 2: Transfer the slides from the damaged presentation to a blank presentation

#### Step 1: Create a blank presentation

1. Start PowerPoint 2007, click the **Microsoft Office Button**, and then click **Open**. In PowerPoint 2010, click the **File menu**, and then click **Open**.   
2. Locate the damaged presentation, and then click **Open**. 
3. In PowerPoint 2007, click the **Microsoft Office Button**, and then click **New**. In PowerPoint 2010, click the **File menu**, and then click **New**.   
4. Click **Blank Presentation**, and then click **Create**. This process creates a blank title slide. 

#### Step 2: Copy slides from the damaged presentation to the new presentation

1. On the **View** tab, click **Slide Sorter**. If you receive error messages when you switch views, try to use to Outline view. 
2. Click a slide that you want to copy. 
3. On the **Home** tab, click **Copy**. 

    > [!NOTE]
    > If you want to copy more than one slide at a time, hold down the SHIFT key, and then click each slide that you want to copy. 

4. Switch to the new presentation. On the **Window** tab, click **Switch Window** in the **View** group, and then click the new presentation that you created in step 2. 
5. On the **View** tab, click **Slide Sorter**. 
6. On the **Home** tab, click **Paste**. 
7. Repeat steps 2a through 2f until the whole presentation is transferred. 

> [!NOTE]
> In some cases, one damaged slide may cause a problem for the whole presentation. If you notice unexpected behavior in the new presentation after you copy a slide to the presentation, that slide is likely to be damaged. Re-create the slide, or copy sections of the slide to a new slide. 

If the new presentation shows damage or strange behavior, go to method 3.

### Method 3: Save the presentation as a Rich Text Format (RTF) file

If there is damage throughout the presentation, the only option to recover the presentation may be to save the presentation as a Rich Text Format (RTF) file. This method, if it is successful, recovers only the text that appears in Outline view. 

#### Step 1: Save the presentation in the RTF file format

1. Open the presentation.   
2. Click the **Microsoft Office Button**, click **Save As**, and then click **Other Formats**.    
3.  In the **Save File As Type** list, click **Outline/RTF(*.rtf)**.    
4.  In the **File Name** box, type the name that you want, pick a location in which to save the presentation, and then click **Save**.    
5. Close the presentation.   

> [!NOTE]
> Any graphics, charts, or other text in the original presentation will not be saved in the .rtf file.

#### Step 2: Open the .rtf file in PowerPoint

1. Click the **Microsoft Office Button**, and then click **Open**.   
2. Click **All Outlines** or **All Files** in the **Files of type** list.    
3. Click the .rtf file that you saved in step 1d, and then click **Open**.   
This will re-create the presentation based on the original presentation's outline view.