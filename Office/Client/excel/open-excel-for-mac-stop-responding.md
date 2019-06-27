---
title: Opening Excel for Mac stops responding with spinning wheel
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Opening Excel for Mac stops responding with spinning wheel

## Symptoms

When trying to open Excel for Mac, the application stops responding and you may see a spining wheel.

## Resolution

> [!IMPORTANT]
> The location of certain files are different if you have Service Pack 2 (SP2) installed. To check if it is installed, open Excel, and then click AboutExcelfrom the Excel menu. If the version number is 14.2.0 or above, you have Service Pack 2 and you should follow the Service Pack 2 steps when provided in this article.

Try opening another file, if all Excel files do not open then proceed with the steps below.

To empty the AutoRecovery folder, follow these steps if you have update 14.2.0 (also known as Service Pack 2) installed: 

### Step 1: Empty Auto-Recovery folder

Move AutoRecovery files to the Desktop or another folder to see if they are causing the problem.

1. Quit all applications.
2. In the File menu, click New Folder.
A new folder is created on the desktop. The folder will be called "New Folder".
3. On the Go menu, click Home.
4. Open Library.
    > [!NOTE]
    > The Library folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.
5. Open Application Support, and then open Microsoft.
6. Open Office 2011 AutoRecovery.
7. On the Edit menu, click Select All.
8. Drag all files into "New Folder" on the desktop.

    The AutoRecovery folder should be empty.
9. Open Excel for Mac 2011 and try to save a file.
If you can save a file, review the contents of "New Folder" to decide which files that you want to keep.

    If the problem continues to occur, go to the next method.

To empty the AutoRecovery folder, follow these steps if you do not have Service Pack 2 installed:

1. Quit all applications.
2. On the File menu, click New Folder.
A new folder is created on the desktop. The folder will be called "New Folder".
3. On the Go menu, click Documents.
4. Open Microsoft User Data, and then open Office 2011 AutoRecovery.
5. On the Edit menu, click Select All.
6. Drag all files into "New Folder" on the desktop.

    The AutoRecovery folder should be empty.
7. Open Excel for Mac 2011 and try to save a file.
If you can save a file, review the contents of "New Folder" to decide which files that you want to keep.

    If the problem continues to occur, go to the next method.

### Step 2:  Check Hard drive name

Check to ensure the hard drive does not have any special characters in its name. It should have text and can have numbers, but not at the start of the name. To view your hard drive information:

1. Quit all applications.
2. In the Finder menu, click Go and then select Computer. Your hard drive should be listed. The common name of the hard drive is "Macintosh HD". E.g. "Mac HD 1" \<sans quotes is good> "1 Mac HD" \<not good with or without the quotes>.

To rename your hard disk:

1. Click to select the hard disk.
2. On the Finder menu, click File, then select Get Info.
3. In the Name & Extension type or edit the name. For example, type Macintosh HD.
4. When done, click the red circle button on top.

### Step 3: Download and Install the latest update

To view the Word version, open Word and then click About Word.

To download the latest update, see [Where and How to obtain Office for Mac software updates](https://support.microsoft.com/help/323601).

### Step 4: Check the document name

Another cause of the issue is the document name.  If the name has symbols, such as the percent symbol, the file will not open when double clicked. Renaming the file will resolve this.

If these file(s) are being downloaded from a website, the browser will sometimes add a symbol to the file name.  If this is the case, try using a different browser to access your email and download the files again.

### Step 5: Try Excel in Safe Mode

Restart your computer in the Safe Mode.

If the issue continues to occur, proceed to the next step. 

### Step 6: Use of Third party fonts

If you are using third party fonts, Excel for Mac might have problems with the font you have installed. See [Third party fonts installed](https://support.microsoft.com/help/295062).
