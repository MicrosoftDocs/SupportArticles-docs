---
title: Powerpoint for Mac closes unexpectedly
description: Discusses that PowerPoint for Mac closes unexpectedly or that files experience formatting problems when you start the program. Provides a resolution for the problem.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- PowerPoint for Mac
---

# PowerPoint for Mac closes or quit unexpectedly when you start it or open a new presentation

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you start Microsoft PowerPoint for Mac, or when you try to open a new presentation, you experience one of the following conditions:

- The program closes unexpectedly.
- Error message:

  ```asciidoc
  The application Microsoft Powerpoint quit unexpectedly. Mac OS X and other applications are not affected. Click relaunch to launch the application again. Click report to see more details or send a report to Apple.
  ```

## Resolution

To resolve this problem, follow these steps.

#### Microsoft PowerPoint 2008 or later

Step 1: Remove Powerpoint Preferences

1. Quit all Microsoft Office for Mac programs.
2. On the **Go** menu, click **Home**.
3. Open Library.

   > [!NOTE]
   > The Library folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.

4. Open Preferences.
5. Drag *com.microsoft.powerpoint.plist* to the desktop.
If you cannot locate the file, PowerPoint is using the default preferences. Go to step 7.

6. Open PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, restore the file to its original location, and go to the next step. If the problem is resolved, drag *com.microsoft.powerpoint.plist* to the **Trash**.
7. Quit all Microsoft Office for Mac programs.
8. On the **Go** menu, click **Home**.
9. Open Library.

   > [!NOTE]
   > The Library folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key while you click the **Go** menu.

10. Open Preferences.
11. Open Microsoft, and then drag *com.microsoft.powerpoint.prefs.plist* to the desktop.
If you cannot locate the file, PowerPoint is using the default preferences. Go to step 13.
12. Open PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, restore the file to its original location, and go to the next step. If the problem is resolved, drag *com.microsoft.powerpoint.prefs.plist* to the **Trash**.
13. Quit all Microsoft Office for Mac programs.
14. On the **Go** menu, click **Home**.
15. Open Library.

    > [!NOTE]
    > The Library folder is hidden in Mac OS X Lion. To display this folder, hold down the OPTION key whil you click the **Go** menu.

16. Open Preferences.
17. Open Microsoft, and then Office 2008 (or Office 2011).
18. Drag PowerPoint Toolbars (12) or Microsoft PowerPoint Toolbars to the desktop.

    If you cannot locate the file, PowerPoint is using the default preferences. Go to "Step 2: Try PowerPoint in Safe Mode Boot."

19. Open PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, restore the file to its original location, and go to "Step 2: Try PowerPoint in Safe Mode Boot." If the problem is resolved, drag PowerPoint Toolbars (12) or Microsoft PowerPoint Toolbars to the **Trash**.

Step 2: Try Powerpoint in Safe Mode Boot

Restart your computer in the Safe Mode. For more information about how to restart your computer in the Safe Mode, click the following article number to view the article in the Microsoft Knowledge Base

[2398596](https://support.microsoft.com/help/2398596) How to use a "clean startup" to determine whether background programs are interfering with Office for Mac

Once in safe mode, test Powerpoint. If the issue continues to occur, proceed to next step.

Step 3: Remove and then reinstall Office

For information how to remove and then reinstall Office, see the following article:

[Troubleshoot Office 2011 for Mac issues by completely uninstalling before you reinstall](https://support.office.com/article/Troubleshoot-Office-2011-for-Mac-issues-by-completely-uninstalling-before-you-reinstall-ba8d8d13-0015-4eea-b60b-7719c2cedd17)

If the issue continues to occur in Safe mode, proceed to Step 3.

Step 4: Use the "Repair Disk Permissions" option

You can use the Repair Disk Permissions option to troubleshoot permissions problems in Mac OS X 10.2 or later versions.  To use the Repair Disk Permissions option, follow these steps:

1. On the **Go** menu, click **Utilities**.
2. Start the **Disk Utility** program.
3. Click the primary hard disk drive for your computer.
4. Click the **First Aid** tab.
5. Click **Repair Disk Permissions**.

> [!NOTE]
> Disk Utility program only repairs software that is installed by Apple. This utility also repairs folders, such as the Applications folder. However, this utility does not repair software that is in your home folder.

#### Microsoft PowerPoint 2004

1. Quit all Microsoft Office for Mac programs.
2. On the **Go** menu, click **Home**.
3. Open Library, and then open Preferences.
4. Drag *com.microsoft.powerpoint.plist* to the desktop.

   If you cannot locate the file, PowerPoint is using the default preferences. Go to step 6.

5. Open PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, restore the file to its original location, and go to the next step. If the problem is resolved, drag *com.microsoft.powerpoint.plist* to the **Trash**.
6. Quit all Microsoft Office for Mac programs.
7. On the **Go** menu, click **Home**.
8. Open Library, and then open Preferences.
9. Open Microsoft, and then drag *com.microsoft.powerpoint.prefs.plist* to the desktop.

   If you cannot locate the file, PowerPoint is using the default preferences. Go to step 11.

10. Open PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, restore the file to its original location, and go to the next step. If the problem is resolved, drag *com.microsoft.powerpoint.prefs.plist* to the **Trash**.
11. Quit all Microsoft Office for Mac programs.
12. On the **Go** menu, click **Home**.
13. Open Library, and then open Preferences.
14. Open Microsoft, and then drag PowerPoint Toolbars (11) to the desktop.

    If you cannot locate the file, PowerPoint is using the default preferences. The problem is not related to the preference files.

15. Open PowerPoint, and check whether the problem still occurs. If the problem still occurs, quit PowerPoint, and then restore the file to its original location. The problem is not related to the preference files. If the problem is resolved, drag PowerPoint Toolbars (11) to the **Trash**.

## Third-party disclaimer information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

The information and the solution in this document represent the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.