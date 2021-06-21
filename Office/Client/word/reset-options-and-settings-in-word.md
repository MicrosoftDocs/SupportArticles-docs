---
title: How to reset user options and registry settings in Word
description: Provides a step-by-step guide to reset registry settings and user options in Office Word 2007, Office Word 2003, Word 2002, and Word 2000.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 147051
ms.author: luche
appliesto:
- Microsoft Word
---

# How to reset user options and registry settings in Word

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Description of the Microsoft Windows registry](https://support.microsoft.com/help/256986).

## Summary

This article describes various methods that you can use to reset user options and registry settings in Microsoft Office Word.

There are two basic types of options that you can define in Word. These options are as follows:

- Options that affect the way that the program operates. (The information for this kind of option is generally stored in the Microsoft Windows registry.)   
- Options that affect the formatting or the appearance of one or more documents. (The information for this kind of option is stored in templates or documents.)   

When you troubleshoot unusual behavior in the program or in a document, first determine whether the problem might be caused by formatting, options, or settings. If the behavior occurs in multiple documents, we recommend that you try to reset Microsoft Word to the program's default settings.

### How to reset user options and registry settings in Word

To have us reset user options and registry settings in Microsoft Word for you, go to the "Here's an easy fix" section. If you prefer to reset user options and registry settings in Microsoft Word yourself, go to the "Let me fix it myself" section.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To manually reset a registry key, you must first delete it. To do this, follow these steps.

Important Always export a registry key before you delete it. This step is important because you may have to restore the functionality that is provided by the key.

1. Exit all Microsoft Office programs.
2. Click **Start**, click **Run**, type regedit, and then click **OK**.
3. Expand the appropriate folders to locate the registry key that you want to delete. (Refer to the "Main locations of Word settings in the Windows Registry" section.)
4. Click to select the key that you want to delete.
5. Use one of the following methods, as appropriate for your operating system:
   - In Microsoft Windows 2000, click **Export Registry File** on the **Registry** menu, type a file name for the backup copy of the key, and then click **Save**.
   - In Windows XP and later versions or in Microsoft Windows Server 2003 and later versions, click **Export** on the **File** menu, type a file name for the backup copy of the key, and then click **Save**.
6. Make sure that the key that you just exported is selected, and then click **Delete** on the **Edit** menu.
7. When you are prompted to respond to one of the following messages, click **Yes**:
   - Are you sure you want to delete this key?
   - Are you sure you want to delete this key and all of its subkeys?
8. Exit Registry Editor.

After you delete a registry key, and then you restart the program, Word runs the Setup program to correctly rebuild the registry key. If you want to rebuild the registry key before you run the program, repair your installation by following the steps in the "Repair Word (Office)" section.

## More Information

### Main locations of Word settings in the Windows Registry

You can reset some Word settings, such as the Word Data and Options keys in the Windows registry, by using the troubleshooting utility that is contained in the Support.dot template. 

#### Word key

Word 2016 or later

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word**

Word 2007

**HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word**

Word 2003

**HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word**

Word 2002

**HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word**

Word 2000

**HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word**

Changes made to this HKEY_CURRENT_USER key are mirrored in the following keys for Word 2003, for Word 2002, and for Word 2000:

Word 2003

**HKEY_USERS\.DEFAULT\Software\Microsoft\Office\11.0\Word**

Word 2002

**HKEY_USERS\.DEFAULT\Software\Microsoft\Office\10.0\Word**

Word 2000

**HKEY_USERS\.DEFAULT\Software\Microsoft\Office\9.0\Word**

The difference between the "HKEY_CURRENT_USER" location and the HKEY_USER" location is that the first applies only to the current user of the system, and the second is the default location for all users. However, Word entries are the same for both locations. Therefore, any change that is made to one location is automatically reflected in the other location.

> [!NOTE]
> For the rest of this section, all references to the HKEY_CURRENT_USER tree apply also to the HKEY_USERS tree, except for the 2007 Microsoft Office 2007 programs and where otherwise noted.

The Data key and the Options key are the most frequently changed areas.

#### Data key

Word 2016

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Data**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Data**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Data**

Word 2007

**HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Data**

Word 2003

**HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Data**

Word 2002

**HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Data**

Word 2000

**HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Data**

This key contains binary information for "most recently used" lists, including the most recently used file list and the most recently used address book list. This key also contains "Track Changes" settings and "Edit" settings.

#### Options key

Word 2016

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Options**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Options**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options**

Word 2007

**HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options**

Word 2003

**HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options**

Word 2002

**HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options**

Word 2000

**HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Options**

This key stores the options that you can set from Microsoft Word, either by changing menu options or by running the Registry Options Utility. For more information, see the "Use the Registry Options Utility" section.

The options are in two groups: default options and optional settings. Default options are established during the setup process. You can change them by modifying options in Word. (To modify options in Word, click **Options** on the Tools menu.)

These options may or may not appear in the registry.

#### Wizards key

Word 2003

**HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Wizards**

Word 2002

**HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Wizards**

Word 2000

**HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Wizards**

All wizard defaults are stored in this key. These settings are created the first time that you run a wizard.

#### Common key

Word 2016

**HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common**

Word 2013

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common**

Word 2010

**HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common**

Word 2007

**HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Common**

Word 2003

**HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Common**

Word 2002

**HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Common**

Word 2000

**HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Common**

This key is used by other Microsoft programs, such as the Office programs. These settings are shared between programs. Changes made in one program's settings also appear in the other program's settings.

#### Shared Tools key

Word 2016, 2013, 2010, 2007, 2003, 2002 and 2000:

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools**

This key contains the paths for all Windows utilities. (The path may include utilities such as Equation, WordArt, and MS Graph.) Paths for graphics filters and text converters are also registered in this location.

### Repair Word (Office)

Word can detect and repair problems associated with Setup. This feature uses the Windows Installer to correct problems with missing files and to repair registry settings.

You can use the following methods to repair or reset Word files and values:

- Method 1: Use the "Detect and Repair" feature
- Method 2: Repair Word in Maintenance Mode Setup
- Method 3: Reinstall Word (Office)

#### Method 1: Use the "Detect and Repair" or "Microsoft Office Diagnostics" feature

> [!NOTE]
> This method is the least aggressive mode of repair. If this method does not resolve the problem, you may still have to use one of the other methods.

To run the Detect and Repair feature in Word 2003 and in earlier versions of Word, click **Detect and Repair** on the **Help** menu in Word. The Detect and Repair feature fixes and repairs Word. All files, registry entries, and optional shortcuts for all Office programs are verified and repaired. If you run Detect and Repair from Word, all other Office programs are also checked. This feature performs only a checksum.

The Detect and Repair feature can also restore the Word program shortcuts on the **Start** menu. To restore the Word program shortcuts, click **Help**, click **Detect and Repair**, and then click to select the **Restore my shortcuts while repairing** check box.

If Detect and Repair does not correct the problem, you may have to reinstall Word. The **Reinstall** feature in the **Maintenance Mode** dialog box performs the same action as Detect and Repair, except that **Reinstall** copies a file when the files are of equal versions. Detect and Repair does not copy over the file when the installation file has the correct version and checksum.

> [!NOTE]
> The Detect and Repair feature does not repair damaged documents or damaged data keys in the registry or in the Normal template.

If a file that Word uses at Startup is missing, the Windows Installer automatically installs that file before it starts the program.

In Word 2007, run the Microsoft Office Diagnostics feature. To do this, click the **Microsoft Office Button**, click **Word Options**, click **Resources**, and then click **Diagnose**. 

In Word 2010, repair Word or the installed Office suite in **Control Panel**.

#### Method 2: Repair Word in Maintenance Mode setup

> [!NOTE]
> This method is a moderate mode of repair. If this method does not resolve the problem, you may still have to reinstall Word.

The Maintenance Mode Setup process is similar to the process found in earlier versions of Word. The Maintenance Mode Setup process allows you to repair, add or remove features, and remove the program. "Repair" is a feature in Maintenance Mode that finds and then fixes errors in an installation.

To perform a Maintenance Mode repair, follow these steps:

1. Exit all Office programs.
2. Use one of the following methods, depending upon your operating system:
   - In Windows 7 or Windows Vista, click **Start**, and then type add remove.
   - In Windows XP or Windows Server 2003, click **Start**, and then click **Control Panel**.
   - In Windows 2000, click **Start**, point to **Settings**, and then click **Control Panel**.
3. Open **Add or Remove Programs**.
4. Click **Change or Remove Programs**, click **Microsoft Office **(**Microsoft Office Word**) or the version of Office or Word that you have in the **Currently installed programs** list, and then click **Change**.
5. Click **Repair** or **Repair Word** (**Repair Office**), and then click **Continue** or **Next**.
6. In Word 2003 and in earlier versions of Word, click **Detect and Repair errors in my Word installation** or click **Detect and Repair errors in my Office installation**, click to select the **Restore my Start Menu Shortcuts** check box, and then click **Install**.

#### Method 3: Reinstall Word (Office)

> [!NOTE]
> This method is the most aggressive mode of repair. This mode resets Word to its default settings, except for settings that are stored in your global template (Normal.dot or Normal.dotm). To do this in Word 2003 and in earlier versions of Word, follow these steps:

1. Exit all Office programs.
2. Use one of the following methods, depending upon your operating system:
   - In Windows 7 or Windows Vista, click **Start**, and then type add remove.
   - In Windows XP or Windows Server 2003, click **Start**, and then click **Control Panel**.
   - In Windows 2000, click **Start**, point to **Settings**, and then click **Control Panel**.
3. Open **Add or Remove Programs**.
4. Click **Change or Remove Programs**, click **Microsoft Office 2003** (**Microsoft Office Word 2003**) or the version of Office or Word that you have in the **Currently installed programs** list, and then click **Change**.
5. Click **Repair Word** (**Repair Office**), and then click **Next**.
6. Click **Reinstall Word** (**Reinstall Office**), and then click **Install**.

### Templates and add-ins

#### Global Template (Normal.dotm or Normal.dot)

To prevent formatting changes, AutoText entries, and macros that are stored in the global template (Normalm.dot or Normal.dot) from affecting the behavior of Word and documents that are opened, rename your global template (Normal.dotm or Normal.dot). Renaming the template lets you quickly determine whether the global template is causing the issue.

When you rename the Normal.dotm template in Word 2007 or later or the Normal.dot template in Word 2003 and in earlier versions of Word, you reset several options to the default settings. These include custom styles, custom toolbars, macros, and AutoText entries. We strongly recommend that you rename the template instead of deleting the Normal.dotm template or the Normal.dot template. If you determine that the template is the issue, you will be able to copy the custom styles, custom toolbars, macros, and AutoText entries from the Normal.dot template that was renamed. 

Certain types of configurations may create more than one Normal.dotm template or Normal.dot template. These situations include cases where multiple versions of Word are running on the same computer or cases where several workstation installations exist on the same computer. In these situations, make sure that you rename the correct copy of the template. 

To rename the global template file, follow these steps:

1. Exit all Office programs.
2. Click **Start**, click **Run**, type cmd, and then click **OK**.
3. Type the following command, as appropriate for the version of Word that you are running, and then press Enter:
   - Word 2002 and Word 2003:
ren %userprofile%\Application Data\Microsoft\Templates\Normal.dot OldNormal.dot
   - Word 2007 and Word 2010:
ren %userprofile%\Application Data\Microsoft\Templates\Normal.dotm OldNormal.dotm
4. Type exit, and then press Enter.
When you restart Word, a new global template (Normal.dot) is created that contains the Word default settings.

#### Add-ins (WLLs) and templates in the Word and Office Startup folders

When you start Word, the program automatically loads templates and add-ins that are located in the Startup folders. Errors in Word may be the result of conflicts or problems with an add-in.

To determine whether an item in a Startup folder is causing the problem, you can temporarily empty the folder. Word loads items from the Office Startup folder and the Word Startup folder. 

To remove items from the Startup folders, follow these steps:

1. Exit all instances of Word, including Microsoft Outlook if Word is set as your email editor.
2. Use one of the following methods, as appropriate for the version of Word that you are running:
   - Word 2002:

     Click **Start**, click **Run**, type %programfiles%\Microsoft\Office\Office10\Startup\, and then click **OK**.
   - Word 2003:

     Click ****Start****, click ****Run****, type %programfiles%\Microsoft\Office\Office11\Startup\, and then click **OK**.
   - Word 2007:

     Click ****Start****, click ****Run****, type %programfiles%\Microsoft\Office\Office12\Startup\, and then click **OK**.
   - Word 2010: 

     Click ****Start****, click ****Run****, type %programfiles%\Microsoft\Office\Office14\Startup\, and then click **OK**.
   - Word 2013:

     Click ****Start****, click ****Run****, type %programfiles%\Microsoft\Office\Office15\Startup\, and then click **OK**.
3. Right-click one of the files that is contained in the folder, and then click **Rename**.
4. After the file name, type .old, and then press Enter. 
ImportantNote the original name of the file. You may have to rename the file by using its original name.
5. Start Word.
6. If you can no longer reproduce the problem, you have found the specific add-in that causes the problem. If you must have the features that the add-in provides, contact the vendor of the add-in for an update.

    If the problem is not resolved, rename the add-in by using its original name, and then repeat steps 3 through 5 for each file in the Startup folder.
7. If you can still reproduce the problem, click **Start**, click **Run**, type %userprofile%\Application Data\Microsoft\Word\Startup, and then click **OK**.
8. Repeat steps 3 through 5 for each file in this Startup folder.

#### COM add-ins

COM add-ins can be installed in any location, and they are installed by programs that interact with Word.

To view the list of COM add-ins in Word 2010, click the Microsoft Office Button, click **Options**, and then click **Add-Ins**.

To view the list of COM add-ins in Word 2007, click the Microsoft Office Button, click **Word Options**, and then click **Add-Ins**.

To view the list of installed COM add-ins in Word 2003 and in earlier versions of Word, follow these steps: 

1. On the **Tools** menu, click **Customize**.
2. Click the **Commands** tab.
3. In the **Category** list, click **Tools**.
4. Drag the **COM Add-Ins** command to a toolbar.
5. Click **Close**.
6. Click the new **COM Add-Ins** button to view the COM add-ins that are loaded together with Word.

If add-ins are listed in the **COM Add-Ins** dialog box, temporarily turn off each add-in. To do this, clear the check box for each listed COM add-in, and then click **OK**. When you restart Word, Word does not load the COM add-ins.

### Use the Registry Options utility

You can use the Registry Options Utility to examine and change Word settings in the Windows registry. The Registry Options Utility is located in the Support.dot template.

> [!NOTE]
> The Support.dot template is not included in Word 2007 or later versions.

For more information about the Registry Options Utility, click the following article number to view the article in the Microsoft Knowledge Base:

[820917](https://support.microsoft.com/help/820917) How to change Word options in the Windows registry for Word 2003

### Summary of Word options and where they are stored
Note In the following table, "Template" refers to either the Normal.dot template or a custom template.

|Setting name|Storage location|
|-|-|
|AutoCorrect-Formatted text|Normal.dotm or Normal.dot|
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
|||

AutoCorrect lists are shared between Office programs. Any changes that you make to the AutoCorrect entries and settings when you are in one program are immediately available to the other programs. Additionally, Word can store AutoCorrect items that are made up of formatted text and graphics.

Information about AutoCorrect is stored in various locations. These locations are listed in the following table.

|AutoCorrect information|Storage location|
|-|-|
|AutoCorrect entries shared by all programs|.ACL file in the %UserProfile%\Application Data\Microsoft\Office folder|
|AutoCorrect entries used only by Word (formatted text and graphics)|Normal.dot|
|AutoCorrect settings (correct two initial capitals, capitalize names of days, replace text as you type)|Registry|
|AutoCorrect settings used only by Word (corrects accidental usage of CAPS LOCK key, capitalizes first letter of sentences)|Registry|
|||
