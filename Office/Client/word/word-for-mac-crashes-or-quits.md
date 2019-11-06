---
title: Word for Mac crashes or quits when you save
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Word for Mac
---

# When you save, Word for Mac crashes or quits

## Symptoms

When you save a Word for Mac document, the application crashes or quits unexpectedly.

## Resolution

### Step 1: Download and install all Office updates

To obtain updates with Office for Mac applications, follow these steps:

Microsoft AutoUpdate for Mac, which comes with Office, can keep your Microsoft software up to date. When AutoUpdate is set to check for updates automatically on a daily, weekly, or monthly basis, there's no need to search for critical updates and information; AutoUpdate delivers them directly to your computer. To do this:

1. Start any Office for Mac application on your computer.
1. Click **Help** menu, click **Check for Updates**.

For additional information about Office for Mac updates, see
[Where and how to obtain Office for Mac software updates](https://support.microsoft.com/kb/323601).

If the issue continues to occur, proceed to the next step.

### Step 2: Check the hard disc name

Make sure that your hard disc has a name. The name cannot be all numbers but can contain numbers. The name must start with a letter. It must not contain any special characters, such as periods, commas, semi-colons, quotation marks, and so on.

### Step 3: Save to a different location

If you are saving a file in your Documents folder, instead try saving the file to the desktop or to a different location.

Remember that there is a 255-character limit to the file name, and the path of the saved file is included in the name. For example, a file that is saved to the desktop has the path "HD\users\your user name\Desktop." These characters are counted toward the 255-character limit.

If you want to save to a network share or to an external device (such as a flash drive), first save the file to your local hard disc. If you can save the file to  the hard disc (your Documents folder), there is nothing wrong with the Excel installation or with the file. If you cannot save to your local hard disc, go to step 3. 

If you cannot save the file to an external device, contact Apple or the manufacturer of the external device. If you cannot save to a network share, contact the network administrator (your IT department) or the owner of the share. If you do not have an IT department and you want to save to a network, contact Microsoft Professional Support.

### Step 4: Empty the AutoRecovery folder

> [!IMPORTANT]
> The location of certain files are different if you have Service Pack 2 (SP2) installed. To check if it is installed, open Word, and then click **About Word** from the **Word** menu. If the version number is 14.2.0 or above, you have Service Pack 2 and you should follow the Service Pack 2 steps when provided in this article.

If there are too many items in the AutoRecovery folder (user\Documents\Microsoft User Data\Office 2008 AutoRecovery or Office 2010 AutoRecovery), this can cause memory problems and save problems because these files are loaded into memory when Word is started.

Move AutoRecovery files to the desktop or to another folder to see whether they are causing the problem. To do this, follow these steps:

To empty the AutoRecovery folder, follow these steps if have version 14.2.0 (also known as Service Pack 2) installed:

1. Quit all applications.
1. On the **File** menu, click **New Folder**.

    A new folder is created on the desktop. The folder will be called "New Folder."
1. On the **Go** menu, click **Home**.
1. Open **Library**.
    > [!NOTE]
    > The **Library** folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.
1. Open **Application Support**, and then open **Microsoft**.
1. Open **Office 2011 AutoRecovery**.
1. On the **Edit** menu, click **Select All**.
1. Drag all files into "New Folder" on the desktop.

     The AutoRecovery folder should be empty.
1. Open Excel for Mac 2011 and try to save a file.

    If you can save a file, review the contents of "New Folder" to decide which files that you want to keep.

    If the problem continues to occur, go to the next method.

To empty the AutoRecovery folder, follow these steps if you do not have Service Pack 2 installed:

1. Quit all applications.
1. On the **File** menu, click **New Folder**.

     A new folder is created on the desktop. The folder will be called "New Folder."
1. On the **Go** menu, click **Documents**.
1. Open **Microsoft User Data**, and then open **Office 2011 AutoRecovery**.
1. On the **Edit** menu, click **Select All**.
1. Drag all files into "New Folder" on the desktop.

     The AutoRecovery folder should be empty.
1. Open Excel for Mac 2011 and try to save a file.

     If you can save a file, review the contents of "New Folder" to decide which files that you want to keep.

     If the problem continues to occur, go to the next method.

### Step 5: Remove Word preferences

> [!NOTE]
> Removing the preferences will remove any customizations that you made. These customizations include changes to toolbars and custom dictionaries and keyboard shortcuts that you created.

1. Quit all Microsoft Office for Mac applications.    
1. On the **Go** menu, click **Home**.    
1. Open **Library**.

     > [!NOTE]
     >  The **Library** folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.
1. Open **Preferences**.
1. Look for a file that is named com.microsoft.Word.plist.    
1. If you locate the file, move it to the desktop. If you cannot locate the file, the application is using the default preferences.
1. If you locate the file and move it to the desktop, start Word, and check whether the problem still occurs. If the problem still occurs, quit Word, and then restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Word.plist file to the trash.
1. Quit all Office for Mac applications.
1. On the **Go** menu, click **Home**.
1. Open **Library**. 

    > [!NOTE]
    > The **Library** folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.
1. Open **Preferences**, and then open **Microsoft**.
1. Locate the file that is named com.microsoft.Word.prefs.plist.
1. Move the file to the desktop.
1. Start Word, and then check whether the problem still occurs. If the problem still occurs, quit Word, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Word.prefs.plist file to the trash.
1. On the **Go** menu, click **Home**.
1. Open **Library**. 

    > [!NOTE]
    >  The **Library** folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.
1. Open **Application Support**, and then open **Microsoft**.
1. Open **Office**, and then open **User Templates**.
1. Locate the file that is named Normal, and then move the file to the desktop.
1. Start Word, and then check whether the problem still occurs. If the problem seems to be resolved, you can move the Normal file to the Trash. If the issue continues to occur, go to the next step.

### Step 6: Create a new user account

Sometimes, user-specific information can become corrupted. This can interfere with installing or using the application. To determine whether this is the case, you can log on as a different user or create a new user account, and then test the application.

If the issue occurs even when you use the alternative account, go to the next step.

### Step 7: Test saving the file in safe mode

Try to save when the computer is operating in safe mode. If you can save while in safe mode, the problem probably concerns software that is running in the background.

For information about how to enter safe mode in Mac OS, see
[Clean startup to see if background programs are interfering with Office for Mac](https://support.microsoft.com/kb/2398596).

## More information

If the steps in this article did not resolve the issue, visit the [Mac forums ](https://www.microsoft.com/mac/help.mspx?app=1&qu2=save+file)for possible resolutions/workarounds.
