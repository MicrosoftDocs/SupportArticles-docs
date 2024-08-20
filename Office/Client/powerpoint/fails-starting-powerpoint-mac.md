---
title: Unable to start PowerPoint for Mac
description: Fixes an issue in which you cannot start PowerPoint for Mac with the error Microsoft PowerPoint has encountered a problem and needs to close.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open\Errors
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - PowerPoint for Mac
ms.date: 06/06/2024
---

# "Microsoft PowerPoint has encountered a problem and needs to close" in PowerPoint for Mac startup

## Symptoms

When you try to start PowerPoint for Mac, you may receive the following error message:

**Microsoft PowerPoint has encountered a problem and needs to close. We are sorry for the inconvenience.**

## Cause

This behavior may occur if any one of the following conditions is true:

- PowerPoint preferences are corrupted.
- Programs running in the background are interfering with PowerPoint.
- Application files are corrupted.
- A user account profile is corrupted.

## Resolution

To resolve this issue, follow these steps. You may find it helpful to print this article before you continue.

### Step 1: Quit all applications and close all windows

1. On the **Apple** menu, click **Force Quit**.
1. Select an application in the "Force Quit Applications" window.

   > [!NOTE]
   > You cannot quit Finder.

1. Click **Force Quit**.

   :::image type="content" source="media/fails-starting-powerpoint-mac/force-quit.png" alt-text="Screenshot to select the Force Quit option after selecting an application." border="false":::

1. Repeat the previous steps until you quit all active applications.

> [!WARNING]
> When an application is force quit, any unsaved changes to open documents are not saved.

When you are finished, click the red button in the upper-left corner of the screen, and then go to "Step 2."

### Step 2: Remove PowerPoint Preferences

1. Quit all Microsoft Office for Mac applications.
1. On the **Go** menu, click **Home**.
1. Open Library.

   > [!NOTE]
   > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

1. Open the Preferences folder.
1. Look for a file that is named com.microsoft.powerpoint.plist. If you locate the file, move it to the desktop. Start PowerPoint, and check whether the problem still occurs. If you cannot locate the file, the application is using the default preferences.
1. If the problem still occurs, quit PowerPoint, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.powerpoint.plist file to the trash.
1. Quit all Microsoft Office for Mac applications.
1. On the **Go** menu, click **Home**.
1. Open Library.

   > [!NOTE]
   > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

1. Open the Preferences folder.
1. Open the Microsoft folder.
1. Look for a file that is named com.microsoft.powerpoint.prefs.plist. If you locate the file, move it to the desktop. Start PowerPoint, and check whether the problem still occurs. If you do cannot locate the file, the application is using the default preferences.
1. If the problem still occurs, quit PowerPoint, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.powerpoint.prefs.plist file to the trash.

If the problem continues to occur, go to the next step.

### Step 3: Perform a clean startup

For information how to "clean start" your computer, click the following article number to view the article in the Microsoft Knowledge Base:

[2398596](https://support.microsoft.com/help/2398596) How to use a "clean startup" to determine whether background programs are interfering with Office for Mac

If the problem continues to occur, go to the next step.

### Step 4: Create a new user account

Sometimes, a specific user's information may become corrupted, and this may prevent installation, startup, or use of some applications. To determine whether this is the case, you can log on to the computer by using a different or new user account, and then test the application.

If the problem no longer occurs, the cause exists within the user's home folder. If you think that the user account was responsible, you can continue to troubleshoot by using the new user account.

> [!NOTE]
> For help moving your user files to the new account, contact Apple.

If the problem continues to occur, go to the next step.

### Step 5: Use the "Repair Disk Permissions" option

You can use the Repair Disk Permissions option to troubleshoot permissions problems in Mac OS X 10.2 and later versions. If the permissions for your Microsoft software are incorrect, Office for Mac applications may start slowly or perform slowly. To use the Repair Disk Permissions option, follow these steps:

1. On the Go menu, click Utilities.
2. Start the Disk Utility program.
3. Click the primary hard disk drive for your computer.
4. Click the First Aid tab.
5. Click Repair Disk Permissions.

> [!NOTE]
> The Disk Utility program only repairs software that is installed by Apple. This utility also repairs folders, such as the Applications folder. However, this utility does not repair software that is in your home folder.

### Step 6: Remove and then reinstall Office

For information about how to manually remove and then reinstall Office, see the following article:

[Troubleshoot Office 2011 for Mac issues by completely uninstalling before you reinstall](https://support.office.com/article/Troubleshoot-Office-2011-for-Mac-issues-by-completely-uninstalling-before-you-reinstall-ba8d8d13-0015-4eea-b60b-7719c2cedd17)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
