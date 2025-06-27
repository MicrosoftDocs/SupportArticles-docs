---
title: The application Microsoft Excel quit unexpectedly error
description: Describes an issue in which you receive an error or Excel closes unexpectedly.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - CSSTroubleshoot
appliesto:
- Excel for Mac 2011
- Excel 2016 for Mac
- Excel for Microsoft 365 for Mac
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 06/06/2024
---
# Excel for Mac error: "The application Microsoft Excel quit unexpectedly"

## Symptoms

When you start Microsoft Excel for Mac or try to open a new Excel workbook, you experience one of the following issues:

- The program closes unexpectedly.
- You receive an error message that resembles as follows:
  
  > The application Microsoft Excel quit unexpectedly. Mac OS X and other applications are not affected. Click relaunch to launch the application again. Click report to see more details or send a report to Apple

## Resolution

To resolve this problem, use one of the following methods, depending on your version of Office for Mac.

### Excel 2016 for Mac

#### Step 1: Quit all programs and close all windows

1. On the **Apple** menu, select **Force Quit**.
2. Select an application in the **Force Quit Applications** window.

    > [!NOTE]
    > You cannot quit **Finder**.
3. Select **Force Quit**.

    :::image type="content" source="media/excel-mac-error-application-quit-unexpectedly/force-quit-application.png" alt-text="Screenshot of the Force Quit Applications window with an application selected.":::

4. Repeat steps A through C for all the applications that are causing issues until you exit all active applications.

#### Step 2: Remove Excel preferences and Office settings

1. Make sure that all Microsoft Office for Mac programs are closed.
2. On the **Go** menu, open the root/hidden *Library* folder.

    > [!NOTE]
    > The *Library* folder is hidden in Mac OSX Yosemite. To display this folder, hold down the OPTION key while you select the **Go** menu.
3. Open the *Group Containers* folder.
4. Look for a folder whose name ends ".Office", and open it.
5. In this folder, look for the *Com.microsoft.officeprefs.plist* file.
6. Delete this file by dragging it to the trash. This will delete the Office preferences that you set during the initial start of the application.
7. Restart the application, and check whether the issue is resolved. If the issue is not resolved, delete the whole folder that you found in step D. This will delete all previous settings and preferences that were set across all applications.

    > [!NOTE]
    > This will reset Office back to the first-run phase of initial set up. It will also re-create a folder in the *~/Library/Group Containers* location.

#### Step 3: Perform a clean restart

For information about how to clean start your operating system (OS), see [How to use a "clean startup" to determine whether background programs are interfering with Office for Mac](https://support.microsoft.com/help/2398596).

If the problem continues to occur, go to the next step.

#### Step 4: Remove and then reinstall Office

For information about how to remove and then reinstall Office, see [How to download and install or uninstall Office 2016 for Mac](https://support.office.com/article/how-to-install-or-uninstall-office-2016-for-mac-preview-39472eb3-c5cc-41ac-af3f-9db7c7f5fe36).

If the issue continues to occur in safe mode, go to the next step.

#### Step 5: Use the Repair Disk Permissions feature

You can use the Repair Disk Permissions feature to troubleshoot permissions problems in Mac OS X 10.2 or later versions. To use the Repair Disk Permissions feature, follow these steps:

1. On the **Go** menu, select **Utilities**.
2. Start the **Disk Utility** program.
3. Select the primary hard disk drive for your computer.
4. On the **First Aid** tab, select **Repair Disk Permissions**.

> [!NOTE]
> The Disk Utility program repairs only software that is installed by Apple. This utility also repairs folders, such as the *Applications* folder. However, this utility does not repair software that is in your home folder.

### Excel for Mac 2011

#### Step 1: Quit all programs and close all windows

1. On the **Apple** menu, select **Force Quit**.
2. Select an application in the **Force Quit Applications** window.

    > [!NOTE]
    > You cannot quit **Finder**.
3. Select **Force Quit**.

    :::image type="content" source="media/excel-mac-error-application-quit-unexpectedly/force-quit-application.png" alt-text="Screenshot of the Force Quit Applications window with an application selected.":::

4. Repeat steps A through C until you exit all active applications.

#### Step 2: Remove Excel preferences and Office settings

1. Quit all Microsoft Office for Mac programs.
2. On the **Go** menu, select **Home**.
3. Open the *Library* folder.

    > [!NOTE]
    > The *Library* folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you select the **Go** menu.
4. Open the *Preferences* folder.
5. Select **View**, and then select **Arrange by Name**.
6. Look for a file that is named *Com.microsoft.Excel.plist*.
7. Locate the file, move it to the desktop. If you can't locate the file, the program is using the default preferences.
8. If you located the file and moved it to the desktop, start Microsoft Excel, and then check whether the problem still occurs. If the problem still occurs, quit Excel, and then restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the *Com.microsoft.Excel.plist* file to the trash.
9. Quit all Microsoft Office for Mac programs.
10. On the **Go** menu, select **Home**.
11. Open the *Library* folder.

    > [!NOTE]
    > The *Library* folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you select the **Go** menu.
12. Open the *Preferences* folder.
13. Open the *Microsoft* folder.
14. Look for a file that is named *Com.microsoft.Excel.prefs.plist*.
15. If you located the file, move it to the desktop. If you don't locate the file, the program is using the default preferences.
16. If you located the file and moved it to the desktop, start Excel, and check whether the problem still occurs. If the problem still occurs, quit Excel, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the *Com.microsoft.Excel.prefs.plist* file to the trash.
17. Close all Microsoft Office applications.
18. On the **Go** menu, select **Home**.
19. Open the *Library* folder.

    > [!NOTE]
    > The *Library* folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you select the **Go** menu.
20. Open the *Preferences* folder.
21. Open the *Microsoft* Folder.
22. Open the *Office 2011* folder.
23. Look for a file that is named *Excel Toolbars (12)* or *Microsoft Excel Toolbars*.
24. If you located the file, move it to the desktop. If you don't locate the file, the program is using the default preferences.
25. If you located the file and moved it to the desktop, start Excel, and then check whether the problem still occurs. If the problem still occurs, quit Excel, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the toolbars file to the trash. If the problem continues to occur, go to the next step.

#### Step 3: Perform a clean restart

For information about how to clean start your operating system, see [How to use a "clean startup" to determine whether background programs are interfering with Office for Mac](https://support.microsoft.com/help/2398596).

If the problem continues to occur, go to the next step.

#### Step 4: Remove and then reinstall Office

For information about how to remove and then reinstall Office, see [Troubleshoot Office for Mac 2011 issues by completely uninstalling before you reinstall](https://support.microsoft.com/help/2398768).

If the issue continues to occur in safe mode, go to the next step.

#### Step 5: Use the Repair Disk Permissions feature

You can use the Repair Disk Permissions feature to troubleshoot permissions problems in Mac OS X 10.2 or later versions. To use the Repair Disk Permissions feature, follow these steps:

1. On the **Go** menu, select **Utilities**.
2. Start the **Disk Utility** program.
3. Select the primary hard disk drive for your computer.
4. On the **First Aid** tab, select **Repair Disk Permissions**.

> [!NOTE]
> The **Disk Utility** program repairs only software that is installed by Apple. This utility also repairs folders, such as the *Applications* folder. However, this utility does not repair software that is in your home folder.
