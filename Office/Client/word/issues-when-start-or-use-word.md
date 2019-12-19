---
title: How to troubleshoot problems that occur when you start or use Word
description: Provides a guide to identify and resolve problems that you experience when you start Word 2010, Word 2007, or Word 2003 by using different troubleshooting steps.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Office Word 2003
- Microsoft Word 2010
- Word 2013
- Windows 8.1
---

# How to troubleshoot problems that occur when you start or use Word

> [!NOTE]
> If you experience specific issues when you use Word, visit the [Word help center](https://support.office.com/word) to search for information about your issue. 

## Summary

This article describes how to troubleshoot problems that may occur when you start or use Microsoft Word. Use the following methods in the order in which they are presented. If you try one of these methods and it does not help, go to the next method.

## Resolution

### Verify or install the latest updates
 
You might have to set Windows Update to automatically download and install recommended updates. Installing any important, recommended, and optional updates can frequently correct problems by replacing out-of-date files and fixing vulnerabilities. To install the latest Microsoft Office updates, see [Update Office and your computer with Microsoft Update](https://support.office.com/article/update-office-and-your-computer-with-microsoft-update-2ab296f3-7f03-43a2-8e50-46de917611c5).

For list of the latest Office updates, see [Office Updates](https://technet.microsoft.com/library/dn789213%28v=office.14%29.aspx). If your issue is not resolved after you install the latest Windows and Office updates, go to method 2.

It's a good idea to make sure that your computer has the latest updates installed for Windows. Updates often fix software problems. Before you use any of the following methods, try first to install updates. After you install the updates, restart your computer, and then start Word.

### Troubleshoot problems that occur when you start Word
 
> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

#### Method 1: Insert your document into another file
 
The final paragraph mark in a Word document contains information about the document. If the document is damaged, you may be able to retrieve the text of the document if you can omit this final paragraph mark.

To access a document but leave its final paragraph mark behind, follow these steps:

1. On the **File** menu, click **New** and then click **Blank Document**.    
2. On the **Insert tab**, click **Object** in the **Text** group, and then click **Text from File**.    
3. Select the file that you want to open and insert, and then click **Insert**.    
 
#### Method 2: Start Word by using the /a switch

The /a switch is a troubleshooting tool that is used to determine where a problem may exist in Word. The /a switch prevents add-ins and global templates from being loaded automatically. The /a switch also locks the settings files to prevent it from being read or modified. To start Word by using the /a switch, follow these steps:

1. Type **Run** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
2. In the **Run **dialog box, type **winword /a**, and then press Enter.    
 
For more information about the /a switch, go to the following article in the Microsoft Knowledge Base:

[826857](https://support.microsoft.com/help/826857) Description of the "/a" startup switch in Word
 
If the problem does not occur when you start Word by using the /a switch, try the next method to determine the source of the problem.

#### Method 3: Delete the Word Data registry subkey

Most of the frequently used options in Word are stored in the Word Data registry subkey. A common troubleshooting step is to delete the Word Data registry subkey. When you restart Word, the program rebuilds the Word Data registry key by using the default settings.

**Note** When you delete the Word Data registry subkey, Word resets several options to their default settings. For example, Word resets the "most recently used file" list on the **File** menu. Also, Word resets many settings that you customize in the **Options** dialog box.

> [!IMPORTANT]
>  Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To delete the Word Data registry subkey, follow these steps:

1. Exit all Office programs.    
2. Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
3. Locate the following registry subkey, as appropriate for the version of Word that you are using: 

    Word 2016
      HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Data
    
    Word 2013
     HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Data
    
    Word 2010
     HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Data
    
    Word 2007
     HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Data
    
    Word 2003
     HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Data     
4. Click **Data**, and then click **Export** on the **File** menu.    
5. Name the file Wddata.reg, and then save the file to the desktop.    
6. On the **Edit** menu, click **Delete**, and then click **Yes**.    
7. Exit Registry Editor.    
8. Start Word.    
 
If Word starts and works correctly, you have resolved the problem (a damaged Word Data registry key). You may now have to change several settings to restore your favorite options in Word.

If the problem is not resolved, restore the original Word Data registry subkey, and then try the next method.

##### Restore the original Word Data registry key

To restore the original Word Data registry subkey, follow these steps:

 
1. Exit all Office programs.    
2. Double-click the **Wddata.reg** icon on the desktop.    
3. Click **Yes**, and then click **OK**.    
 If restoring the Word Data registry subkey doesn’t work, go to the next procedure.

#### Method 4: Delete the Word Options registry key
 
The Word Options registry key stores options that you can set in Word. These settings are divided into default and optional groups. Default settings are created during the program setup. Optional settings are not created during setup. You can change both the default and optional settings in Word.

To delete the Word Options registry key, follow these steps:
 
1. Exit all Office programs.    
2. Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
3. Locate the following registry subkey, as appropriate for the version of Word that you are running:
 
    Word 2016
     HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Options
    
    Word 2013
     HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Options
    
    Word 2010
     HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options
    
    Word 2007
     HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options
    
    Word 2003
     HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options

4. Click **Options**, and then click **Export** on the **File** menu.    
5. Name the file Wddata.reg, and then save the file to the desktop.    
6. On the **Edit** menu, click **Delete**, and then click **Yes**.    
7. Exit Registry Editor.    
8. Start Word.    
 
If Word starts and works correctly, you have resolved the problem (a damaged Word Options registry key). You may now have to change several settings to restore your favorite options in Word.

If the problem is not resolved, restore the original Word Options registry key, and then try the next method.

##### To restore the original Word Options registry key
 
To restore the original Word Options registry key, follow these steps:

1. Exit all Office programs.    
2. Double-click the **Wdoptn.reg** icon on the desktop.    
3. Click **Yes**, and then click **OK**.  
 
#### Method 5: Replace the Normal.dot or Normal.dotm global template file
 
You can prevent formatting, AutoText, and macros that are stored in the global template file from affecting the behavior of Word and any documents that you open. To do this, replace the global template file.

> [!IMPORTANT]
> This method includes renaming the global template file so that Word does not find it as expected when it restarts. This forces Word to re-create the global template file. By doing this, you save the original file in case you have to restore it. Be aware that when you rename the global template file, several settings are reset to their defaults, including custom styles, custom toolbars, macros, and AutoText entries. Therefore, we strongly recommend that you save the global template file and do not delete it.

Additional note In certain situations, you may have more than one global template file. For example, this occurs if multiple versions of Word are running on the same computer, or if several workstation installations exist on the same computer. In these situations, make sure that you rename each global template file so that it clearly reflects the appropriate Word installation.

To rename the global template file, follow these steps:

1. Exit all Office programs.    
2. Type **cmd** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
3. At the command prompt, type the following command, as appropriate for the version of Word that you are running, and then press Enter:

   Word 2016, Word 2013, Word 2010, or Word 2007
  
   ```powershell
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\Normal.dotm OldNormal.dotm  
   ```
   Word 2003  
   ```powershell   
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\Normal.dot OldNormal.dot    
   ``` 
4. At the command prompt, type exit, and then press Enter.    
5. Start Word.    
 
If Word starts correctly, you have resolved the problem. In this case, the problem is a damaged global template file. Now, you may have to change several settings to restore your favorite options.

> [!NOTE]
> The old global template file may contain customizations that can't be easily re-created. These customizations may include styles, macros, and AutoText entries. In this case, you may be able to copy the customizations from the old global template file to the new global template file by using the Organizer. For more information about how to use the Organizer to copy macros and styles, press F1 in Word to open Microsoft Word Help, type rename macros in the **Search** box, and then click **Search** to view the topic.

If the problem is not resolved, restore the original global template file, and then go to the next section.

##### Restore the original global template file
 
To restore the original global template file, follow these steps:

1. Exit all Office programs.    
2. Type **cmd** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
3. At the command prompt, type the following command, as appropriate for the version of Word that you are running, and then press Enter:

   Word 2016, Word 2013, Word 2010 and Word 2007
   ```powershell
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\OldNormal.dotm Normal.dotm  
   ``` 
   
   Word 2003  
   ```powershell
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\OldNormal.dot Normal.dot   
    ```
4. Type exit, and then press Enter.    
5. Start Word.    
 
#### Method 6: Disable the Startup folder add-ins
 
When you start Word, Word automatically loads templates and add-ins that are located in the Startup folders. Conflicts or problems that affect an add-in can cause problems in Word. To determine whether an item in a Startup folder is causing the problem, temporarily disable the registry setting that points to these add-ins.

To do this, follow these steps:
 
1. Exit all Office programs.    
2. Start Windows Explorer. Type windows ex in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
3. Type the following command in the address bar, as appropriate for the version of Word that you're running and its installation type, and then press Enter:
   
    Word 2016
    
    64-bit C2R installation:
     %programfiles%\Microsoft Office\root\office16\Startup\
    
    32-bit C2R installation:
     %programfiles% (x86)\Microsoft Office\root\office16\Startup\
    
    64-bit MSI installation:
     %programfiles%\Microsoft Office\office16\Startup\
    
    32-bit MSI installation:
     %programfiles% (x86)\Microsoft Office\office16\Startup\
    
    Word 2013
    
    64-bit C2R installation:
     %programfiles%\Microsoft Office\root\office15\Startup\
    
    32-bit C2R installation:
     %programfiles% (x86)\Microsoft Office\root\office15\Startup\
    
    64-bit MSI installation:
     %programfiles%\Microsoft Office\office15\Startup\
    
    32-bit MSI installation:
     %programfiles% (x86)\Microsoft Office\office15\Startup\
    
    Word 2010
    
    %programfiles%\Microsoft Office\Office14\Startup\
    
    Word 2007
    
    %programfiles%\Microsoft Office\Office12\Startup\
    
    Word 2003
    
    %programfiles%\Microsoft\Office\Office11\Startup\     
4. Right-click one of the files that is contained in the folder, and then click **Rename**.    
5. After the file name, type .old, and then press Enter.

   > [!IMPORTANT]
   >  Make a note of the original file name so that you can restore the file, if it is necessary.    
6. Start Word.    
7. If you can no longer reproduce the problem, you have found the specific add-in that causes the problem. If you must have the features that the add-in provides, contact the vendor of the add-in for an update.

   If the problem is not resolved, rename the add-in by using its original name, and then repeat steps 3 through 6 for each file in the Startup folder.    
8. If you can still reproduce the problem, type the following path in the address bar of Windows Explorer, and then click **OK**.
   
    For Windows 10, Windows 8.1, Windows 8, Windows 7, or Windows Vista
    
    %userprofile%\AppData\Roaming\Microsoft\Word\Startup
    
    For Windows XP
    
    %userprofile%\Application Data\Microsoft\Word\Startup     
9. Repeat steps 3 through 6 for each file in this Startup folder.    
 
If the problem is not resolved after you disable the Startup folder add-ins, go to the next method.

#### Method 7: Delete the COM add-ins registry keys
 
You can install COM add-ins in any location. Programs that interact with Word install COM add-ins. To determine whether a COM add-in is causing the problem, temporarily disable the COM add-ins by deleting the registry keys for the COM add-ins.

To delete the COM add-ins registry keys, follow these steps:
 
1. Exit all Office programs.    
2. Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
3. Locate the following registry subkey: HKEY_CURRENT_USER\Software\Microsoft\Office\Word\Addins     
4. Click **Addins**, and then click **Export** on the **File** menu.    
5. Name the file WdaddinHKCU.reg, and then save the file to the desktop.    
6. On the **Edit** menu, click **Delete**, and then click **Yes**.    
7. Locate the following registry subkey: HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Word\Addins     
8. Click **Addins**, and then on the **File** menu, click **Export**.    
9. Name the file WdaddinHKLM.reg, and then save the file to the desktop.    
10. On the **Edit** menu, click **Delete**, and then click **Yes**.    
11. Exit Registry Editor.    
12. Start Word.    
 If the problem is resolved, you have determined that a COM add-in program is causing the problem. Next, you must determine which COM add-in program is causing the problem.

##### Determine which COM add-in program is causing the problem
 
To determine which COM add-in program is causing the problem, follow these steps:

1. Exit all Office programs.    
2. Double-click the **Wdaddin.reg** icon on your desktop.    
3. Click **Yes**, and then click **OK**.    
4. Use one of the following procedures, as appropriate for the version of Word that you are running: 

   Word 2016, Word 2013, or Word 2010

   1. On the **File** menu, click **Options**.    
   2. Click **Add-Ins**.    
   3. In the **Manage** list, click **COM Add-Ins**, and then click **Go**.

   **Note** If an add-in is listed in the **COM Add-Ins** dialog box, clear the add-in check box. If more than one add-in is listed, clear only one add-in check box at a time. This procedure helps determine which add-in is causing the problem.    
   4. Click **OK** to close the COM Add-Ins dialog box.    
   5. On the **File** menu, click **Exit**.    
 
   Word 2007

   1. Click the Microsoft Office Button, and then click **Word options**.    
   2. Click **Add-ins**.    
   3. In the **Manage** list, click **COM Add-ins**, and then click **Go**.

      If an add-in is listed in the **COM Add-Ins** dialog box, click to clear the add-in check box. If more than one add-in is listed, click to clear only one add-in check box at a time. This procedure helps determine which add-in is causing the problem.    
   4. Click **OK** to close the **COM Add-Ins** dialog box.    
   5. Click the Microsoft Office Button, and then click **Exit Word**.    
   6. On the **File** menu, click **Exit**.    
     
5. Start Word.    
 If the problem is resolved when you start Word, you have determined which COM add-in is causing the problem. If you must have the features that the add-in provides, you must determine which add-in includes those features so that you can contact the vendor for an update.

If the problem is not resolved when you start Word, repeat steps 4 and 5 for each COM add-in that's listed until you determine which add-in is causing the problem.

To restore the COM add-ins, repeat step 4, but select the check box for each COM add-in that you want to restore.  

#### Method 8: Change the default printer
 
To change the default printer, follow these steps:

1. Exit all Office programs.    
2. Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
3. Right-click **Microsoft XPS Document Writer**, and then click **Set as default printer**.    
4. Start Word.    
 If the problem is resolved after you start Word, you have determined that the printer is causing the problem. If this is the case, contact the vendor to see whether there is an update for the printer driver. 

## Microsoft Support options

If you can't resolve this problem, you can use Microsoft Support to search the Microsoft Knowledge Base and other technical resources for answers. You can also customize the site to control your search. To start your search, go to the [Microsoft Support](https://www.microsoft.com/support/) website. 

## Additional resources
 
If you experience specific issues when you use Word, go to the following websites to search for specific information about your program version:

[Microsoft Word Product Solution Center: Word](https://support.office.com/search/results?query=word)