---
title: Scroll bars are missing in Word for Mac
description: Describes resolutions to a problem in which the vertical and horizontal scroll bars are missing in Word for Mac. 
author: simonxjx
manager: dcscontentpm
ms.date: 2/20/2020
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: 
- CI 113892
- CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Word for Mac
---

# Scroll bars are missing in Word for Mac

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you start Microsoft Word for Mac, the vertical and horizontal scroll bars are not displayed on the screen.

## Cause

This behavior can occur if the **Horizontal scroll bar** and **Vertical scroll bar** check boxes under Preferences are not selected. This behavior can also occur if your Word preferences or the Normal template is corrupted.

> [!NOTE]
> In full-screen mode, there are no horizontal or vertical scroll bars. Press ESC on your keyboard to exit full-screen mode.

## Resolution

To resolve this issue, make sure that the scroll bars in both Word and the Apple iOS System Preferences are both on. To do this, follow these steps:

**Step 1: Adjust the preferences**
1.    Select the **Apple** menu. 
2.    Select **System Preferences**.
3.    Select **General**.
4.    Set the "Show scroll bars" option to **Always**.

**Step 2: Adjust the Word preferences**

1.    Start Word.
2.    On the **Word** menu, select **Preferences**.
3.    Open **View**.
4.    Select the **Horizontal scroll bar** and the **Vertical scroll bar** check boxes in the "Show Window Elements" section.
5.    Close the **View** dialog bo.

### Restore the preferences and Normal template to the default settings

If the issue still occurs, try to restore the preferences and Normal template to the default settings. To do this, follow these steps:

1. Quit all applications.
2. On the Go menu, select **Home**.
3. Open Library.

   > [!NOTE]
   > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you select the **Go** menu.

4. Open the **Preferences** folder.
5. Look for a file that is named **com.microsoft.Word.plist**.
6. If you locate the file, move it to the desktop. If you cannot locate the file, the application is using the default preferences.
7. If you locate the file and move it to the desktop, start Word, and then check whether the problem still occurs. If the problem still occurs, quit Word, and restore the file to its original location. Then, go to the next step. If the problem is resolved, you can move the com.microsoft.Word.plist file to the trash.
8. Quit all Microsoft Office for Mac applications.
9. On the **Go** menu, select **Home**.
10. Open Library.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you select the Go menu.

11. Open the **Preferences** folder.
12. Open the Microsoft folder.
13. Locate the file that is named **com.microsoft.Word.prefs.plist**.
14. Move the file to the desktop.
15. Start Word, and then check whether the problem still occurs. If the problem still occurs, quit Word, and then restore the file to its original location. Then, go to the next step. If the problem is resolved, you can move the com.microsoft.Word.prefs.plist file to the trash.
16. On the **Go** menu, select **Home**.
17. Open **Library**.

    > [!NOTE]
    > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you select the **Go** menu.

18. Open the **Application Support** folder.
19. Open the **Microsoft** folder.
20. Open the **Office** folder.
21. Open the **User Templates** folder.
22. Locate the file that is named **Normal**, and move the file to the desktop.
23. Start Word, and then check whether the problem still occurs. If the problem is resolved, you can move the Normal file to the trash.