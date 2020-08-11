---
title: Toolbars missing in Word for Mac
description: Toolbars are missing and cannot be added when using Word for Mac.
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

# Toolbars missing in Word for Mac

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

While using Word for Mac one or more Toolbars are missing and cannot be added. 

## Cause

This behavior can be caused by one of these things:

- The oval button in the upper-right corner of the document was clicked. This button "toggles" display of toolbars on and off.
- There is an issue with the Normal template in Word.
- The toolbars or menus are modified.

## Resolution

To resolve this problem, try the following methods.

### Method 1: Make sure that tool bar display is not turned off

1. In the upper-right corner of the window click the oval button.

   > [!NOTE]
   > When this button is clicked, it hides all the toolbars. A second click causes the toolbars to be displayed.

1. If the toolbars reappear, quit, and then restart Word to make sure that the appropriate toolbars are displayed.

If Method 1 did not resolve the problem, try Method 2.

### Method 2: Reset the toolbars and menus in Word

You can reset the toolbars and menus in the Customize Toolbars and Menus option, any saved customization is removed, and all settings are reverted to the original default settings.

1. Open Word.
2. Go to **View** in the menu.
3. Choose **Toolbars**.
4. Select **Customize Toolbars and Menus**.
5. Select **Toolbars and Menus** in the top of the Customize Toolbars and Menus window.
6. Select the item in the list you want to reset (**Menu Bar**, **Standard**, **Formatting**).
7. Click **Reset**.
8. Click **OK** when getting prompt: "Are you sure you want to reset the changes made..."
9. Click **OK**.

> [!NOTE]
> When View is missing from the menu, then you can also Control Click the Standard Toolbar and go to Customize Toolbars and Menus here.

If Method 2 did not resolve the problem, try Method 3.

### Method 3: Create a new Normal template Note

When a new Normal template is created, any saved customization is removed, and all settings are reverted to the original default settings.

**Step 1: Quit all programs**

To quit active applications, follow these steps:

1. On the **Apple** menu, click **Force Quit**.
2. Select an application in the "Force Quit Applications" window.
   
   > [!NOTE]
   > You cannot quit Finder.
3. Click **Force Quit**.
4. Repeat the previous steps until you quit all active applications.

> [!WARNING]
> When an application is force quit, any unsaved changes to open documents are not saved.

When you are finished, click the red button in the upper-left corner and proceed to Step 2.

**Step 2:  Word 2008 and 2011: Move the Normal.dotm template file to the Trash**

1. Quit all Microsoft Office applications.
2. On the **Go** menu, click **Home**.
3. Open Library.
       
   > [!NOTE]
   > The Library folder is hidden in MAC OS X Lion. To display this folder, hold down the OPTION key while you click the Go  menu.
4. Select the **Application Support** folder.
5. Select the **Microsoft** folder.
6. Open the **Office** folder.
7. Open the **User Templates** folder.
8. Move Normal.dotm to the Trash.
9. Start Word, a new Normal.dotm template will be created when you choose Quit Word in the Word menu.

> [!NOTE]
> When you had Word 2004 on your Mac previously and you now have Word 2008 or Word 2011, also check if the Word 2004 Normal file is present on the system, if so, trash this Normal template file as well.

**Step 3: Word 2004: Move the Normal template file to the Trash**

1. Quit all Microsoft Office applications.
2. On the **Go** menu, click **Home**.
3. Select the **Documents** folder.
4. Select the **Microsoft User Data **folder.
5. Move Normal to the Trash.
6. Start Word, a new Normal template will be created when you choose Quit Word in the Word menu.