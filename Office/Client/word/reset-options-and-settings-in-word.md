---
title: How to reset user options and registry settings in Word
description: Provides a step-by-step guide to reset registry settings and user options in Word.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Reliability
  - CSSTroubleshoot
  - CI 147051
ms.author: luche
appliesto: 
  - Microsoft Word
ms.date: 06/06/2024
---

# How to reset user options and registry settings in Word

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Description of the Microsoft Windows registry](https://support.microsoft.com/help/256986).

## Summary

This article describes various methods that you can use to reset user options and registry settings in Microsoft Office Word.

There are two basic types of options that you can define in Word:

- Options that affect the way that the program operates. The information for this kind of option is generally stored in the Microsoft Windows registry.  
- Options that affect the formatting or the appearance of one or more documents. The information for this kind of option is stored in templates or documents.   

When you troubleshoot unusual behavior in the program or a document, first determine whether the problem might be caused by formatting, options, or settings. If the behavior occurs in multiple documents, we recommend that you try to reset Microsoft Word to the program's default settings.

### How to reset user options and registry settings in Word

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To manually reset a registry key, you must first delete it.

> [!IMPORTANT]
> Always export a registry key before you delete it. This step is important because you may have to restore the functionality that's provided by the key.

1. Exit all Microsoft Office programs.
2. Open Registry Editor.
3. Locate and select the registry key that you want to delete. Refer to the [Main locations of Word settings in the Windows Registry](#main-locations-of-word-settings-in-the-windows-registry) section.
5. Select **File** > **Export**, type a file name for the backup copy of the key, and then click **Save**.
6. Make sure that the key that you just exported is selected, and then click **Delete** on the **Edit** menu.
7. When you are prompted to respond to one of the following messages, click **Yes**:
   - Are you sure you want to delete this key?
   - Are you sure you want to delete this key and all of its subkeys?
8. Exit Registry Editor.

After you delete a registry key and restart the program, Word runs the Setup program to correctly rebuild the registry key. If you want to rebuild the registry key before you run the program, repair your installation by following the steps in [Repair an Office application](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

## More Information

### Main locations of Word settings in the Windows Registry

You can reset some Word settings, such as the Word Data and Options keys in the Windows registry. 

#### Word key

Word for Microsoft 365, Word 2019, and Word 2016

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word**

The **Data** and **Options** key are the most frequently changed areas.

#### Data key

Word for Microsoft 365, Word 2019, and Word 2016

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Data**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Data**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Data**

This key contains binary information for "most recently used" lists, including the most recently used file list and the most recently used address book list. This key also contains "Track Changes" settings and "Edit" settings.

#### Options key

Word for Microsoft 365, Word 2019, and Word 2016

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Options**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Options**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options**

This key stores the options that you can set from Microsoft Word.

The options are in two groups: default options and optional settings. Default options are established during the setup process. You can change them by modifying options in Word. These options may or may not appear in the registry.

#### Wizards key

Word for Microsoft 365, Word 2019, and Word 2016

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Wizards**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Wizards**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Wizards**

All wizard defaults are stored in this key. These settings are created the first time that you run a wizard.

#### Common key

Word for Microsoft 365, Word 2019, and Word 2016

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common**

This key is used by other Microsoft programs, such as the Office programs. These settings are shared between programs. Changes made in one program's settings also appear in the other program's settings.

#### Shared Tools key

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools**

This key contains the paths for all Windows utilities. (The path may include utilities such as Equation, WordArt, and MS Graph.) Paths for graphics filters and text converters are also registered in this location.

### Templates and add-ins

#### Global Template (Normal.dotm)

To prevent formatting changes, AutoText entries, and macros that are stored in the global template from affecting the behavior of Word and documents that are opened, rename your global template (Normal.dotm). Renaming the template lets you quickly determine whether the global template is causing the issue.

When you rename the Normal.dotm template in Word 2007 or later, you reset several options to the default settings. These options include custom styles, custom toolbars, macros, and AutoText entries. We strongly recommend that you rename the template instead of deleting the Normal.dotm template. If you determine that the template is the issue, you will be able to copy the custom styles, custom toolbars, macros, and AutoText entries from the Normal.dotm template that's renamed. 

Certain types of configurations may create more than one Normal.dotm template. These situations include cases where multiple versions of Word are running on the same computer or cases where several workstation installations exist on the same computer. In these situations, make sure that you rename the correct copy of the template. 

To rename the global template file, follow these steps:

1. Exit all Office programs.
2. Open Command Prompt.
3. Run the following command:
  
   `ren %appdata%\Microsoft\Templates\Normal.dotm OldNormal.dotm`

When you restart Word, a new global template is created that contains the Word default settings.

#### Add-ins (WLLs) and templates in the Word and Office Startup folders

When you start Word, the program automatically loads templates and add-ins that are located in the Startup folders. Errors in Word may be the result of conflicts or problems with an add-in.

To determine whether an item in a Startup folder is causing the problem, you can temporarily empty the folder. Word loads items from the Office Startup folder and the Word Startup folder. 

To remove items from the Startup folders, follow these steps:

1. Exit all instances of Word, including Microsoft Outlook if Word is set as your email editor.
2. Open the [Office startup folder](issues-when-start-or-use-word.md#option-6-disable-the-startup-folder-add-ins).
3. Right-click one of the files that's contained in the folder, and then click **Rename**.
4. After the file name, type .old, and then press Enter. Note the original name of the file. You may have to rename the file by using its original name.
5. Start Word.
6. If you can no longer reproduce the problem, you have found the specific add-in that causes the problem. If you must have the features that the add-in provides, contact the vendor of the add-in for an update.

   If the problem isn't resolved, rename the add-in by using its original name, and then repeat steps 3 through 5 for each file in the Startup folder.
7. If you can still reproduce the problem, open the `%AppData%\Microsoft\Word\STARTUP` folder.
8. Repeat steps 3 through 5 for each file in this Startup folder.

#### COM add-ins

COM add-ins can be installed in any location, and they are installed by programs that interact with Word.

To view the list of COM add-ins in Word, see [View, manage, and install add-ins in Office programs](https://support.microsoft.com/office/view-manage-and-install-add-ins-in-office-programs-16278816-1948-4028-91e5-76dca5380f8d).

If add-ins are listed in the **COM Add-Ins** dialog box, temporarily turn off each add-in. To do so, clear the check box for each listed COM add-in, and then click **OK**. When you restart Word, Word doesn't load the COM add-ins.

### Summary of Word options and where they are stored

In the following table, "Template" refers to either the Normal.dotm template or a custom template.

|Setting name|Storage location|
|-|-|
|AutoCorrect-Formatted text|Normal.dotm|
|AutoCorrect-Shared entries|.ACL files user.acl|
|AutoSave path|Registry|
|AutoText|Template|
|Company name|Winword.exe|
|Custom keystroke assignments|Template|
|Font substitution|Registry|
|Macros|Template/document|
|Picture editing|Registry|
|Print data forms|Document|
|Snap to grid|Registry|
|Styles|Template/document|
|Toolbars|Template/document|
|User info|Registry|
|View toolbars|Template|
|View/toolbar|Template|
|Document Parts|Template|

AutoCorrect lists are shared between Office programs. Any changes that you make to the AutoCorrect entries and settings when you are in one program are immediately available to the other programs. Additionally, Word can store AutoCorrect items that are made up of formatted text and graphics.

Information about AutoCorrect is stored in various locations. These locations are listed in the following table.

|AutoCorrect information|Storage location|
|-|-|
|AutoCorrect entries shared by all programs|.ACL file in the `%appdata%\Microsoft\Office` folder|
|AutoCorrect entries used only by Word (formatted text and graphics)|Normal.dotm|
|AutoCorrect settings (correct two initial capitals, capitalize names of days, replace text as you type)|Registry|
|AutoCorrect settings used only by Word (corrects accidental usage of CAPS LOCK key, capitalizes first letter of sentences)|Registry|
