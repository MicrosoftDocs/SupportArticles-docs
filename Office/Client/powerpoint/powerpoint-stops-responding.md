---
title: PowerPoint stops responding (spinning wheel)
description: Fixes an issue in which you cannot open a presentation in PowerPoint for Mac.
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
  - Microsoft PowerPoint for Mac
ms.date: 03/31/2022
---

# PowerPoint stops responding (spinning wheel)

## Symptoms

When you try to open a PowerPoint for Mac presentation or application, it either hangs with spinning wheel or does not open at all.

## Resolution

To resolve this issue, follow steps in this article. 

### Step 1: Check Hard Disc name

Check to ensure the Hard Drive icon has a name to it. The name should not be all numbers but can have numbers in it as along as the name starts with a text character(s). There should be no special characters like, periods, commas, semi-colons, quotes, etc.

1. Quit all applications.
2. On the Go menu, click Computer. Your hard drive should be listed. The common name of the hard drive is "Macintosh HD". E.g. "Mac HD 1" \<without quotes is appropriate> "1 Mac HD" \<this is not an appropriate name as the number 1 appears at the start of the name>.

To rename your hard disk:

1. Click to select the hard disk.
2. On the File menu, click Get Info.
3. In the Name & Extension type or edit the name. For example, type Macintosh HD.
4. When done, click the red circle button on top.

### Step 2: Move AutoRecovery files

> [!IMPORTANT]
> The location of certain files are different if you have Service Pack 2 (SP2) installed. To check if it is installed, open PowerPoint, and then click About PowerPoint from the PowerPoint menu. If the version number is 14.2.0 or above, you have Service Pack 2 and you should follow the Service Pack 2 steps when provided in this article.

If there are too many PowerPoint items in this folder user\Documents\Microsoft User Data\Office 2008 AutoRecovery or Office 2011 AutoRecovery these files will load into memory when Powerpoint launches and can cause memory issues as well as file save issues.

Move AutoRecovery files to the Desktop or another folder to see if they are causing the problem.  

To empty the AutoRecovery folder, follow these steps if you have version 14.2.0 (also known as Service Pack 2) installed: 

1. Quit all applications.     
2. One the File menu, click New Folder. 
A new folder is created on the desktop. The folder will be called "New Folder."        
3. On the Go menu, click Home.    
4. Open Library.
    > [!NOTE]
    > The Library folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

5. Open Application Support, and then open Microsoft.   
6. Open Office 2011 AutoRecovery.   
7. On the Edit menu, click Select All.   
8. Drag all files into "New Folder" on the desktop.     

    The AutoRecovery folder should be empty.

9. Open Excel for Mac 2011 and try to save a file.     

    If you can save a file, review the contents of "New Folder" to decide which files that you want to keep.

If the problem continues to occur, go to the next method.

To empty the AutoRecovery folder, follow these steps if you do not have Service Pack 2 installed:

1. Quit all applications.

1. On the File menu, click New Folder. A new folder is created on the desktop. The folder will be called "New Folder."

1. On the Go menu, click Documents.

1. Open Microsoft User Data, and then open Office 2011 AutoRecovery.

1. On the Edit menu, click Select All.

1. Drag all files into "New Folder" on the desktop.

    The AutoRecovery folder should be empty.

1. Open Excel for Mac 2011 and try to save a file.

    If you can save a file, review the contents of "New Folder" to decide which files that you want to keep.

If the problem continues to occur, go to the next method.

### Step 3: Remove PowerPoint Preferences

> [!NOTE]
> If you have used the software at all on this computer then removing the preferences may reset any customizations that you have made. These customizations include changes made to toolbars, custom dictionaries and keyboard shortcuts that have been created.

1. Quit all Microsoft Office for Mac programs.   
2. On the Go menu, click Home.   
3. Open Library.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.   
4. Open the Preferences folder.   
5. Look for a file that is named com.microsoft.powerpoint.plist.   
6. If you locate the file, move it to the desktop. If you do not locate the file, the program is using the default preferences.   
7. If you locate the file and move it to the desktop, start PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.powerpoint.plist file to the trash.   
8. Quit all Microsoft for Mac programs.   
9. On the Go menu, click Home.   
10. Open Library.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.
11. Open the Preferences folder.   
12. Open the Microsoft folder.   
13. Look for a file that is named com.microsoft.powerpoint.prefs.plist.   
14. If you locate the file, move it to the destop. If you do not locate the file, the program is using the default preferences.   
15. If you locate the file and move it to the destop, start PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.powerpoint.prefs.plist file to the trash.   
16. Quit all Microsoft Office for Mac programs.   
17. On the Go menu, click Home.   
18. Open Library.
    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.
19. Open the Preferences folder.
20. Open the Microsoft folder.
21. Open the Office 2008 or Office 2011 folder.   
22. Look for a file named PowerPoint Toolbars (12) or Microsoft PowerPoint Toolbars.   
23. If you locate the file, move it the desktop. If you do not locate the file, the program is using the default preferences.   
24. If you locate the file and move it to the desktop, start PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the PowerPoint Toolbars (12) file to the trash.   

If the issue continues to occur, proceed to the next step. 

### Step 4: Create a New User Account

Sometimes, a user's specific information may be corrupted. To determine if this is the case, you can log on as a new user or create a new user account, and then test an application.

If the issue occurs even in new user account, proceed to the next step.

### Step 5: Test saving the file in Safe Mode

For information on how to enter Safe Boot in Mac OS, see 
[Perform a clean startup (Safe boot) to determine whether background programs are interfering with Office for Mac](https://support.microsoft.com/help/2398596).

If you are able to save in Safe Mode, then the problem most likely related to programs that are running in the background.
