---
title: How to edit Windows registry to clear the list of most recently used files
description: Provides a step-by-step guide about how to use the Windows registry to clear the most recently used files list that appear in Office programs.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Office
ms.date: 03/31/2022
---

# Edit the Windows registry to clear the list of most recently used files in Office

## Summary

You can edit a single registry entry to clear the most recently used files list that appears in most Microsoft Office programs.

Many Office programs maintain a list of the most recently used (MRU) files. Additionally, the programs display this list on the **File** menu and in several other locations. These locations include the **Open** dialog box, the
 **Save As** dialog box, and the **Insert Hyperlink** dialog box. 

The purpose of this feature is to provide quick access to files that a user is working on. In the interest of enhanced privacy, many users and administrators prefer not to have these files listed. 

Although you can prevent this list from being shown on the **File** menu in the programs, there is no built-in method for removing the list or for preventing its display in other locations. You can, however, edit the Microsoft Windows registry to clear the list of the most recently used files.

> [!NOTE]
> This article describes how to delete the files that are listed when you click **File**, click **Open** or **Save As**, and then look under the **File name** box. After following the steps listed in this article, no files will be listed under the **File name** box. 

This article does not discuss how to delete the files that are listed on the **File** menu. To do this, you must change the **File** menu settings in the Office or Office XP program.

This article does not discuss how to prevent shortcuts for recently used files from being saved in the location that is specified by the **HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Common\General\RecentFiles** registry entry. By default, that location is C:\Documents and Settings\user profile\Application Data\Microsoft\Office\Recent.

### Delete the Most Recently Used files list in Office

> [!NOTE]
> When the **Recently used file list** option is not checked on the **General** tab of the **Options** dialog box in Office 2000, in Office XP, or in Office 2003 programs, Word continues to save shortcuts in the default location. The default location is as follows:
>
> C:\Documents and Settings\user profile\Application Data\Microsoft\Office\Recent
>
> The default location is specified by the following registry entry:
>
>HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Common\General\RecentFiles

To delete the most recently used files list in Microsoft Office XP or in Microsoft Office 2003, follow these steps: 

1. Start the program that you want to modify.   
2. On the **Tools** menu, click
**Options**.    
3. On the **General** tab, click to clear the
**Recently used file list** check box, and then click
**OK**.    

To delete the most recently used files list in the 2007 Microsoft Office suites, follow these steps: 

1. Start the program that you want to modify.   
2. Click the **Microsoft Office Button**, and then click **Program Name** Options. 

    > [!NOTE]
    > **Program Name** is the name of the program that you want to modify.
3. Click Advanced.   
4. In the Display area, click to select the number of files in the Show this number of Recent Documentslist.   
5. Type the number of files that you want to display, and then click OK.

    If you do not want to display any files, type 0.

To modify the registry key and to clear the most recently used files list in a program in Office, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.    
2. Locate the following registry key, as appropriate for your version of Office: 

    2007 Office suite
    
    **HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Common\Open Find**
    
    Office 2003

    **HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Common\Open Find**
    
    Office XP
    
    **HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Common\Open Find**
3. In the Open Find subkey, locate the program for which you want to clear the most recently used files list. 

    In each program subkey, you find another subkey that is named Settings. In that subkey, you find several additional subkeys. Each of these subkeys contains a most recently used files list. 
    
    For example, the Microsoft Office Word\Settings subkey contains subkeys such as Insert File, Save As, Open, or Modify Location. These keys may vary depending on the past actions that were performed in Microsoft Word. 
    
    Under each subkey is another subkey that is named File Name MRU.
4. To delete a specific list of most recently used files, delete the **Value** entry in any File Name MRU subkey.    

### Troubleshooting

Office rebuilds the File Name MRU subkey after you delete it, and begins to track the most recently used files again. Therefore, you must periodically delete the list.

You can also create a registry file (.reg) by exporting that subkey of the registry in Registry Editor. Use that registry file to automatically apply the registry settings (in this case, the deletion of the most recently used files list). 

You can also delete the whole Open Find subkey (or create a registry file to do it for you automatically) to remove all most recently used files lists at the same time.