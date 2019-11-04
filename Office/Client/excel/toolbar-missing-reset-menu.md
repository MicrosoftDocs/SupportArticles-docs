---
title: Toolbar missing, or how to reset menus in Excel for Mac
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Excel for Mac
---

# Toolbar missing, or how to reset menus in Excel for Mac

## Symptoms

One or more toolbars are missing and cannot be added in Microsoft Excel for Mac.  

## Cause

There are two possible causes of this behavior:

- The oval button in the upper-right corner of the document was clicked. This button "toggles" the display of toolbars on and off.
- There is an issue with Excel preferences.

## Resolution

To resolve this issue, use the following methods in order.

### Method 1: Make sure that toolbar display is not turned off

1. In the upper-right corner of the Excel window, click the oval button.

    > [!NOTE]
    > When this button is clicked, the toolbars are hidden (in any Microsoft Office for Mac application). A second click causes the toolbars to be displayed.
2. If the toolbars reappear, quit Excel, and then restart Excel to make sure that the appropriate toolbars are displayed.

If Method 1 did not resolve the problem, try Method 2.

### Method 2: Remove the Excel preferences

#### Step 1: Quit all applications

To quit active applications, follow these steps:

1. On the **Apple** menu, click **Force Quit**.    
2. Select an application in the "Force Quit Applications" window.
    > [!NOTE]
    > You cannot quit **Finder**.
3. Click **Force Quit**.
4. Repeate the previous steps until you quit all active applications.    

> [!WARNING]
> When an application is force quit, any unsaved changes to open documents are not saved.

#### Step 2: Remove the Excel Preferences

To remove the Excel preferences, follow these steps. 

1. Quit all Microsoft Office for Mac applications.    
2. On the **Go** menu, click **Home**.    
3. Open **Library**.

    > [!NOTE]
    > The **Library** folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.
4. Open the Preferences folder. Click **View**, click **Arrange by**, and then select **Name**.    
5. Look for a file that is named com.microsoft.Excel.plist.    
6. If you locate the file, drag the file to the desktop. If you cannot locate the file, the application is using the default preferences.    
7. If you locate the file and move it to the desktop, start Excel, and check whether the problem still occurs. If the problem still occurs, quit Excel, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Excel.plist file to the trash.    
8. Quit all Office for Mac applications.    
9. On the **Go** menu, click **Home**.   
10. Open **Library**.

    > [!NOTE]
    > The **Library** folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.
11. Open the Preferences folder.    
12. Open the Microsoft Folder.    
13. Look for a file that is named com.microsoft.Excel.prefs.plist.    
14. If you locate the file, move it to the desktop. If cannot locate the file, the application is using the default preferences.    
15. If you locate the file and move it to the desktop, start Excel, and then check whether the problem still occurs. If the problem still occurs, quit Excel, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Excel.prefs.plist file to the trash.    
16. Close all Office applications.    
17. On the **Go** menu, click **Home**.    
18. Open **Library**.

    > [!NOTE]
    > The **Library** folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.
19. Open the Preferences folder.    
20. Open the Microsoft Folder.    
21. Open the Office 2008 or Office 2011 folder.    
22. Look for a file that is named Excel Toolbars (12) or Microsoft Excel Toolbars.    
23. If you locate the file, move it to the desktop. If you cannot locate the file, the application is using the default preferences.

If you locate the file and move it to the desktop, start Excel, and check whether the problem still occurs. If the problem still occurs, quit Excel, and restore the file to its original location. If the problem seems to be resolved, you can move the Excel Toolbars (12) file or the Microsoft Excel Toolbars to the trash.

> [!NOTE]
> If the problem still occurs after you follow these steps, the problem is not related to these files. If the problem no longer occurs, one of these files was causing the problem. If this is the case, restore the files to their original location one at a time. Test the application after you restore each file. Continue to do this until the problem occurs again. When the problem recurs, you can then assume that it is caused by the last file that you restored. Drag that file to the trash.
