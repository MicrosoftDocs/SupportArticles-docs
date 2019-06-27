---
title: Scroll bars are missing in Word for Mac
description: Describes a problem in which the vertical and horizontal scroll bars are missing in Word for Mac. Provides two resolution methods.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Scroll bars are missing in Word for Mac

## Symptoms

When you start Microsoft Word for Mac, the vertical and horizontal scroll bars are not displayed on the screen.

## Cause

This behavior can occur if the **Horizontal scroll bar** and **Vertical scroll bar** check boxes under Preferences are not selected. This behavior can also occur if your Word preferences or the Normal template is corrupted.

> [!NOTE]
> In full-screen mode, there are no horizontal or vertical scroll bars. Press ESC on your keyboard to exit full-screen mode.

## Resolution

To resolve this issue, make sure that the **Horizontal scroll bar** and **Vertical scroll bar** check boxes are selected. To do this, follow these steps.

Step 1: Adjust the preferences

1. Start Word.
2. On the Word menu, click Preferences.
3. Open View.
4. Click to select the **Horizontal scroll bar** and the **Vertical scroll bar** check boxes in the Window section, and then click OK.

If the issue continues to occur, go to the next step.

Step 2: Remove the Word preferences and reset the Normal template

To restore the preferences and Normal template to the default settings, follow these steps:

1. Quit all applications.
2. On the Go menu, click Home.
3. Open Library.

   > [!NOTE]
   > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

4. Open the Preferences folder.
5. Look for a file that is named com.microsoft.Word.plist.
6. If you locate the file, move it to the desktop. If you cannot locate the file, the application is using the default preferences.
7. If you locate the file and move it to the desktop, start Word, and then check whether the problem still occurs. If the problem still occurs, quit Word, and restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Word.plist file to the trash.
8. Quit all Microsoft Office for Mac applications.
9. On the Go menu, click Home.
10. Open Library.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

11. Open the Preferences folder.
12. Open the Microsoft folder.
13. Locate the file that is named com.microsoft.Word.prefs.plist.
14. Move the file to the desktop.
15. Start Word, and then check whether the problem still occurs. If the problem still occurs, quit Word, and then restore the file to its original location. Then, go to the next step. If the problem seems to be resolved, you can move the com.microsoft.Word.prefs.plist file to the trash.
16. On the Go menu, click Home.
17. Open Library.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go menu.

18. Open the Application Support folder.
19. Open the Microsoft folder.
20. Open the Office folder.
21. Open the User Templates folder.
22. Locate the file that is named Normal, and move the file to the desktop.
23. Start Word, and then check whether the problem still occurs. If the problem seems to be resolved, you can move the Normal file to the trash.