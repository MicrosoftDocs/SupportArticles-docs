---
title: Word for Mac closes or quit unexpectedly
description: Discusses that Word for Mac closes unexpectedly or that files experience formatting problems when you start the program. Provides a resolution for the problem.
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

# Word for Mac closes unexpectedly or error "The application Microsoft Word quit unexpectedly"

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you start Microsoft Word for Mac, or when you try to open a new document, you experience one of the following conditions:

- The program closes unexpectedly.
- Error message:

  ```asciidoc
  The application Microsoft Word quit unexpectedly. Mac OS X and other applications are not affected. Click relaunch to launch the application again. Click report to see more details or send a report to Apple.
  ```

> [!NOTE]
> This error message may also occur during usage of application such as saving a document.

## Resolution

To resolve this problem, follow steps below.

#### Microsoft Word for Mac 2008 or Later

Step 1: Quit all applications

1. On the Apple menu, click Force Quit.
2. Select an application in the "Force Quit Applications" window.
   
   > [!NOTE]
   > You cannot quit Finder.

3. Click Force Quit.

   ![Clicking Force Quit button in the Force Quit Applications window](./media/word-mac-closes-unexpectedly/force-quit.png)

4. Repeat the previous steps until all active applications.

> [!WARNING]
> When an application is force quit, any unsaved changes to open documents are not saved.

Step 2: Remove Preferences

1. Quit all Microsoft Office for Mac programs.
2. On the Go menu, click Home.
3. Open Library.

   > [!NOTE]
   > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

4. Open the Preferences folder.
5. Look for a file that is named com.microsoft.Word.plist.
6. If you locate the file, move it to the desktop. If you do not locate the file, the program is using the default preferences.
7. If you locate the file and move it to the desktop, start Word, and check whether the problem still occurs. If the problem still occurs, quit Microsoft Word, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Word.plist file to the trash.
8. Quit all Microsoft Office for Mac programs.
9. On the Go menu, click Home.
10. Open Library.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

11. Open the Preferences folder.
12. Open the Microsoft folder.
13. Locate the file that is named com.microsoft.Word.prefs.plist.
14. Move the file to the desktop.
15. Start Word, and check whether the problem still occurs. If the problem still occurs, quit Word, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Word.prefs.plist file to the trash.
16. On the Go menu, click Home.
17. Open Library.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

18. Open the Application Support folder.
19. Open the Microsoft folder.
20. Open the Office folder.
21. Open the User Templates folder.
22. Locate the file that is named Normal, and move the file to the desktop.
23. Start Word and check whether the problem still occurs. If the problem seems to be resolved, you can move the Normal file to the Trash. If the issue continues to occur, proceed to the next step.

If the issue continues to occur, go to the next step.

Step 3: Peform clean boot

For information how to clean start your Operating system (OS), see Microsoft Knowledge Base article:  

[2398596](https://support.microsoft.com/help/2398596) How to use a "clean startup" to determine whether background programs are interfering with Office for Mac

If the issue continues to occur in Safe mode, go to the next step.

Step 4: Remove and then reinstall Office

For information how to remove and then reinstall Office, see the following article:

[Troubleshoot Office 2011 for Mac issues by completely uninstalling before you reinstall](https://support.office.com/article/Troubleshoot-Office-2011-for-Mac-issues-by-completely-uninstalling-before-you-reinstall-ba8d8d13-0015-4eea-b60b-7719c2cedd17
)

If after removing and then reinstalling Office, the problem continues to occur, go to the next step.

Step 5: Use the "Repair Disk Permissions" option

You can use the Repair Disk Permissions option to troubleshoot permissions problems in Mac OS X 10.2 or later versions. To use the Repair Disk Permissions option, follow these steps:

1. On the Go menu, click Utilities.
2. Start the Disk Utility program.
3. Click the primary hard disk drive for your computer.
4. Click the First Aid tab.
5. Click Repair Disk Permissions.

> [!NOTE]
> The Disk Utility program only repairs software that is installed by Apple. This utility also repairs folders, such as the Applications folder. However, this utility does not repair software that is in your home folder.

#### Microsoft Word 2004 for Mac

1. Quit all Microsoft Office for Mac programs.
2. On the **Go** menu, click **Home**.
3. Open Library.

   > [!NOTE]
   > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.
4. Open the Preferences folder.
5. Look for a file that is named com.microsoft.Word.plist.
6. If you locate the file, move it to the desktop. If you do not locate the file, the program is using the default preferences.
7. If you locate the file and move it to the desktop, start Word, and check whether the problem still occurs. If the problem still occurs, quit Word, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Word.plist file to the trash.
8. Qit all Microsoft Office for Mac programs.
9. On the **Go** menu, click **Home**.
10. Open Library.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.
11. Open the Preferences folder.
12. Open the Microsoft folder.
13. Look for a file that is named com.microsoft.Word.prefs.plist.
14. Move the file to the desktop.
15. Start Word, and check whether the problem still occurs. If the problem still occurs, quit Word, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Word.prefs.plist file to the trash.
16. On the **Go** menu, click **Home**.
17. Open the Documents folder.
18. Open the Microsoft User Data folder.
19. Locate the file that is named Normal, and move the file to the desktop.
20. Start Word, and check whether the problem still occurs. If the problem seems to be resolved, you can move the Normal file to the trash.

## Third-party disclaimer information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

The information and the solution in this document represent the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.