---
title: How to troubleshoot problems that occur when you start or use Word
description: Provides a guide to identify and resolve problems that you experience when you start Word 2010, Word 2007, or Word 2003 by using different troubleshooting steps.
author: simonxjx
manager: dcscontentpm
ms.date: 5/5/2020
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: 
- CI 117479
- CSSTroubleshoot
ms.author: v-six
appliesto:
- Word 2016
- Word 2013
- Word 2010
- Word 2007
- Word 2003
---

# Troubleshoot problems that occur when you start or use Word

> [!NOTE]
> This article describes how to troubleshoot problems that may occur when you start or use Microsoft Word.
> - If you experience specific issues when you use Word, visit the [Word help center](https://support.office.com/word) to search for information about your issue.
> - Before you begin, make sure that [Windows is up to date](https://support.microsoft.com/help/4027667/windows-10-update) and that [your version of Office is also up to date](https://support.office.com/article/install-office-updates-2ab296f3-7f03-43a2-8e50-46de917611c5?ui=en-US&rs=en-US&ad=US).

## Quick resolution

Try the following options to help determine the root cause of your problem in Word. Select the image at the left or the option heading to see more detailed instructions about that option.


> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.



<table align="left">
<tr>
<td valign="top"> 
<a href="#option1">

![Option 1](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-1.png)

</a>
</td><td>**<a href="#option1">Insert your document into another file</a>**
<ol>
<li>On the **File** menu, select **New**, and then select **Blank Document**.</li>
<li>On the **Insert tab**, select **Object** in the **Text** group, and then select **Text from File**.</li>
<li>Select the file that you want to open and insert, and then select **Insert**.</li>
</ol>
</td>
</tr>
<tr>
<td valign="top">
<a href="#option2">

![Option 2](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-2.png)

</a>
</td>
<td>**<a href="#option2">Start Word by using the /a switch</a>**
<ol>
<li>Type **Run** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.</li>
<li>In the **Run** dialog box, type **winword /a**, and then press Enter.</li>
</ol>
</td>
</tr>
<tr>
<td valign="top">
<a href="#option3">

![Option 3](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-3.png)

</a>
</td>
<td>**<a href="#option3">Delete the Word Data registry subkey</a>**
<ol>
<li>Exit all Office programs.</li>
<li>Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.</li>
<li>Locate the following registry subkey, as appropriate for the version of Word that you are using.

|||
|---|---|
| **Word 2016** | HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Data |
| **Word 2013** | HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Data |
| **Word 2010** | HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Data |
| **Word 2007** | HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Data |
| **Word 2003** | HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Data |


</li>
<li>Select **Data**, and then select **Export** on the **File** menu.</li>
<li>Name the file Wddata.reg, and then save the file to the desktop.</li>
<li>On the **Edit** menu, select **Delete**, and then select **Yes**.</li>
<li>Exit Registry Editor.</li>
<li>Start Word.</li>
</ol>

</td>
</tr>
<tr>
<td valign="top">
<a href="#option4">

![Option 4](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-4.png)

</a>
</td>
<td>**<a href="#option4">Delete the Word Options registry key</a>**

<ol>
<li>Exit all Office programs.</li>
<li>Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.</li>
<li>Locate the following registry subkey, as appropriate for the version of Word that you are running.

|||
|---|---|
| **Word 2016** | HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Options |
| **Word 2013** | HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Options |
| **Word 2010** | HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options |
| **Word 2007** | HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options |
| **Word 2003** | HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options |


</li>
<li>Select **Options**, and then select **Export** on the **File** menu.</li>
<li>Name the file Wddata.reg, and then save the file to the desktop.</li>
<li>On the **Edit** menu, select **Delete**, and then select **Yes**.</li>
<li>Exit Registry Editor.</li>
<li>Start Word.    </li>
</ol>

</td>
</tr>
<tr>
<td valign="top">
<a href="#option5">

![Option 5](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-5.png)

</a>
</td>
<td>**<a href="#option5">Replace the Normal.dot or Normal.dotm global template file</a>**
<ol>
<li>Exit all Office programs.</li>
<li>Type **cmd** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.</li>
<li>At the command prompt, type the following command, as appropriate for the version of Word that you are running, and then press Enter:

   **Word 2016, Word 2013, Word 2010, or Word 2007**
  
   ```powershell
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\Normal.dotm OldNormal.dotm  
   ```
   **Word 2003**  
   ```powershell   
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\Normal.dot OldNormal.dot    
   ``` 


</li>
<li>At the command prompt, type **exit**, and then press Enter.</li>
<li>Start Word.</li>
</ol>

</td>
</tr>
<tr>
<td valign="top">
<a href="#option6">

![Option 6](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-6.png)

</a>
</td>
<td>**<a href="#option6">Disable the Startup folder add-ins</a>**

<ol>
<li>Exit all Office programs.</li>
<li>Start Windows Explorer. To do this, type **windows ex** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.</li>
<li>Type the following command in the address bar, as appropriate for the version of Word that you're running and its installation type, and then press Enter.



| | | |
|---|---|---|
|**Word 2016**|64-bit C2R installation:|%programfiles%\Microsoft Office\root\office16\Startup\ |
||32-bit C2R installation:|%programfiles% (x86)\Microsoft Office\root\office16\Startup\ |
||64-bit MSI installation:|%programfiles%\Microsoft Office\office16\Startup\|
||32-bit MSI installation:|%programfiles% (x86)\Microsoft Office\office16\Startup\ |
|**Word 2013**| 64-bit C2R installation: | %programfiles%\Microsoft Office\root\office15\Startup\ |
|| 32-bit C2R installation: | %programfiles% (x86)\Microsoft Office\root\office15\Startup\ |
|| 64-bit MSI installation: | %programfiles%\Microsoft Office\office15\Startup\ |
|| 32-bit MSI installation: | %programfiles% (x86)\Microsoft Office\office15\Startup\ |
| **Word 2010** || %programfiles%\Microsoft Office\Office14\Startup\ |
| **Word 2007** || %programfiles%\Microsoft Office\Office12\Startup\ |
| **Word 2003** || %programfiles%\Microsoft\Office\Office11\Startup\ |

</li>
<li>Right-click one of the files in the folder, and then select **Rename**.</li>
<li>After the file name, type **.old**, and then press Enter.

   > [!IMPORTANT]
   >  Make a note of the original file name so that you can restore the file, if it is necessary.

</li>
<li>Start Word.</li>
<li>If you can no longer reproduce the problem, you have found the specific add-in that causes the problem. If you must have the features that the add-in provides, contact the vendor of the add-in for an update.

   If the problem is not resolved, rename the add-in by using its original name, and then repeat steps 3 through 6 for each file in the Startup folder.</li>
<li>If you can still reproduce the problem, type the following path in the address bar of Windows Explorer, and then select **OK**.

| Windows 10, Windows 8.1, Windows 8, Windows 7, or Windows Vista ||
|---|---|
| **%userprofile%\AppData\Roaming\Microsoft\Word\Startup** ||

| Windows XP ||
|---|---|
| **%userprofile%\Application Data\Microsoft\Word\Startup** ||

</li>
<li>Repeat steps 3 through 6 for each file in this Startup folder.</li>

 
</ol>
</td>
</tr>
<tr>
<td valign="top">
<a href="#option7">

![Option 7](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-7.png)

</a>
</td>
<td>**<a href="#option7">Delete the COM add-ins registry keys</a>**

<ol>
<li>Exit all Office programs.</li>
<li>Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.</li>
<li>Locate the following registry subkey:<br/>
HKEY_CURRENT_USER\Software\Microsoft\Office\Word\Addins

</li>  
<li>Select **Addins**, and then select **Export** on the **File** menu.</li>
<li>Name the file WdaddinHKCU.reg, and then save the file to the desktop.</li>
<li>On the **Edit** menu, select **Delete**, and then select **Yes**.</li>
<li>Locate the following registry subkey:<br/>
HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Word\Addins
</li>
<li>Select **Addins**, and then on the **File** menu, select **Export**.</li>
<li>Name the file WdaddinHKLM.reg, and then save the file to the desktop.</li>
<li>On the **Edit** menu, select **Delete**, and then select **Yes**.</li>
<li>Exit Registry Editor.</li>
<li>Start Word.</li>
</ol>
 If the problem is resolved, you have determined that a COM add-in program is causing the problem. Next, you must determine which COM add-in program is causing the problem.


</td></tr>
<tr>
<td valign="top">
<a href="#option8">

![Option 8](media/print-failures-word-for-office-365-on-win-10/print-failures-word-for-office-365-on-win-10-8.png)

</a>
</td>
<td>**<a href="#option8">Change the default printer</a>**

<ol>
<li>Exit all Office programs.</li>
<li>Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.</li>
<li>Right-click **Microsoft XPS Document Writer**, and then select **Set as default printer**.</li>
<li>Start Word.</li>
</ol>

</td>
</tr>
</table>

## Resolution

### Verify or install the latest updates

For list of the latest Office updates, see [Office Updates](https://technet.microsoft.com/library/dn789213%28v=office.14%29.aspx). If your issue is not resolved after you install the latest Windows and Office updates, go to Option 2.

## Microsoft Support options

If you can't resolve this problem, you can use Microsoft Support to search the Microsoft Knowledge Base and other technical resources for answers. You can also customize the site to control your search. To start your search, go to the [Microsoft Support](https://www.microsoft.com/support/) website. 

## Additional resources
 
If you experience specific issues when you use Word, go to the following website to search for more information about your program version:

[Microsoft Office Support search: Word](https://support.office.com/search/results?query=word)

### Detailed view of the options

The following section provides more detailed descriptions of these options.

<a id="option1">

#### Option 1: Insert your document into another file

</a>
 
The final paragraph mark in a Word document contains information about the document. If the document is damaged, you may be able to retrieve the text of the document if you can omit this final paragraph mark.

To access a document but leave its final paragraph mark behind, follow these steps:

1. On the **File** menu, select **New** and then select **Blank Document**.    
2. On the **Insert tab**, select **Object** in the **Text** group, and then select **Text from File**.    
3. Select the file that you want to open and insert, and then select **Insert**.    
 
<a id="option2">

#### Option 2: Start Word by using the /a switch

</a>

The /a ("administrative installation") switch is a troubleshooting tool that is used to determine where a problem may exist in Word. The /a switch prevents add-ins and global templates from being loaded automatically. The /a switch also locks the settings files to prevent it from being read or modified. To start Word by using the /a switch, follow these steps:

1. Type **Run** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press **Enter**.    
2. In the **Run** dialog box, type **winword /a**, and then press **Enter**.    
 
For more information about the /a switch, see the following Knowledge Base article:

[826857](https://support.microsoft.com/help/826857) "Description of the "/a" startup switch in Word."
 
If the problem does not occur when you start Word by using the /a switch, try the next option.

<a id="option3">

#### Option 3: Delete the Word Data registry subkey

</a>

Most of the frequently used options in Word are stored in the Word Data registry subkey. A common troubleshooting step is to delete the Word Data registry subkey. When you restart Word, the program rebuilds the Word Data registry subkey by using the default settings.

> [!NOTE]
> When you delete the Word Data registry subkey, Word resets several options to their default settings. For example, Word resets the "most recently used file" list on the **File** menu. Also, Word resets many of the settings that you may have customized in the **Options** dialog box.

> [!IMPORTANT]
>  Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To delete the Word Data registry subkey, follow these steps:

1. Exit all Office programs.    
2. Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press **Enter**.    
3. Locate the following registry subkey, as appropriate for the version of Word that you are using.

   |||
   |---|---|
   | **Word 2016** | HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Data |
   | **Word 2013** | HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Data |
   | **Word 2010** | HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Data |
   | **Word 2007** | HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Data |
   | **Word 2003** | HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Data |

4. Select **Data**, and then select **Export** on the **File** menu.    
5. Name the file Wddata.reg, and then save the file to the desktop.    
6. On the **Edit** menu, select **Delete**, and then select **Yes**.    
7. Exit Registry Editor.    
8. Start Word.    
 
If Word starts and works correctly, you have resolved the problem (a damaged Word Data registry key). You may now have to change several settings to restore your favorite options in Word.

If the problem is not resolved, restore the original Word Data registry subkey, and then try the next option.

##### Restore the original Word Data registry key

To restore the original Word Data registry subkey, follow these steps:

 
1. Exit all Office programs.    
2. Double-click the **Wddata.reg** icon on the desktop.    
3. Select **Yes**, and then select **OK**.    
 
If restoring the Word Data registry subkey doesn't work, go to the next option.

<a id="option4">

#### Option 4: Delete the Word Options registry key

</a>

The Word Options registry key stores options that you can set in Word. These settings are divided into default and optional groups. Default settings are created during the program setup. Optional settings are not created during setup. You can change both the default and optional settings in Word.

To delete the Word Options registry key, follow these steps:
 
1. Exit all Office programs.    
2. Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press **Enter**.    
3. Locate the following registry subkey, as appropriate for the version of Word that you are running.

   |||
   |---|---|
   | **Word 2016** | HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Options |
   | **Word 2013** | HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Options |
   | **Word 2010** | HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options |
   | **Word 2007** | HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options |
   | **Word 2003** | HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options |

4. Select **Options**, and then on the **File** menu select **Export**.    
5. Name the file Wddata.reg, and then save the file to the desktop.    
6. On the **Edit** menu, select **Delete**, and then select **Yes**.    
7. Exit Registry Editor.    
8. Start Word.    
 
If Word starts and works correctly, you have resolved the problem (a damaged Word Options registry key). You may now have to change several settings to restore your favorite options in Word.

If the problem is not resolved, restore the original Word Options registry subkey, and then try the next option.

##### To restore the original Word Options registry subkey
 
To restore the original Word Options registry key, follow these steps:

1. Exit all Office programs.    
2. Double-click the **Wdoptn.reg** icon on the desktop.    
3. Select **Yes**, and then select **OK**.  

<a id="option5">

#### Option 5: Replace the Normal.dot or Normal.dotm global template file

</a>
 
You can prevent formatting, AutoText, and macros that are stored in the global template file from affecting the behavior of Word and any documents that you open. To do this, replace the global template file.

> [!IMPORTANT]
> This Option includes renaming the global template file so that Word does not find it as expected when it restarts. This forces Word to re-create the global template file. By doing this, you save the original file in case you have to restore it. Be aware that when you rename the global template file, several settings are reset to their default values, including custom styles, custom toolbars, macros, and AutoText entries. **Therefore, we strongly recommend that you save the global template file and do not delete it.**<br/><br/>
> Additionally, in certain situations, you may have more than one global template file. For example, this occurs if multiple versions of Word are running on the same computer, or if several workstation installations exist on the same computer. In these situations, make sure that you rename each global template file so that it clearly reflects the appropriate Word installation.

To rename the global template file, follow these steps:

1. Exit all Office programs.    
2. Type **cmd** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press Enter.    
3. At the command prompt, type the following command, as appropriate for the version of Word that you are running, and then press **Enter**:

   **Word 2016, Word 2013, Word 2010, or Word 2007**
  
   ```powershell
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\Normal.dotm OldNormal.dotm  
   ```
   **Word 2003**  
   ```powershell   
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\Normal.dot OldNormal.dot    
   ``` 
4. At the command prompt, type **exit**, and then press **Enter**.    
5. Start Word.    
 
If Word starts correctly, you have resolved the problem (a damaged global template file). You may have to change several settings to restore your favorite options.

> [!NOTE]
> The old global template file may contain customizations that can't be easily re-created. These customizations may include styles, macros, and AutoText entries. In this case, you may be able to copy the customizations from the old global template file to the new global template file by using the Organizer. <br/><br/>For more information about how to use the Organizer to copy macros and styles, press **F1** in Word to open Microsoft Word Help, type **rename macros** in the **Search** box, and then select **Search** to view the topic.

If the problem is not resolved, restore the original global template file (see below), and then go to the next option.

##### Restore the original global template file
 
To restore the original global template file, follow these steps:

1. Exit all Office programs.    
2. Type **cmd** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press **Enter**.    
3. At the command prompt, type the following command, as appropriate for the version of Word that you are running, and then press **Enter**:

   **Word 2016, Word 2013, Word 2010 and Word 2007**
   ```powershell
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\OldNormal.dotm Normal.dotm  
   ``` 
   
   **Word 2003**  
   ```powershell
   ren %userprofile%\AppData\Roaming\Microsoft\Templates\OldNormal.dot Normal.dot   
    ```
4. Type **exit**, and then press **Enter**.    
5. Start Word.    
 
<a id="option6">

#### Option 6: Disable the Startup folder add-ins

</a>

When you start Word, Word automatically loads templates and add-ins that are located in the Startup folders. Conflicts or problems that affect an add-in can cause problems in Word. To determine whether an item in a Startup folder is causing the problem, temporarily disable the registry setting that points to these add-ins.

To do this, follow these steps:
 
1. Exit all Office programs.    
2. Start Windows Explorer. Type **windows ex** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press **Enter**.    
3. Type the following command in the address bar, as appropriate for the version of Word that you're running and its installation type, and then press **Enter**:

   | | | |
   |---|---|---|
   |**Word 2016**|64-bit C2R installation:|%programfiles%\Microsoft Office\root\office16\Startup\ |
   ||32-bit C2R installation:|%programfiles% (x86)\Microsoft Office\root\office16\Startup\ |
   ||64-bit MSI installation:|%programfiles%\Microsoft Office\office16\Startup\|
   ||32-bit MSI installation:|%programfiles% (x86)\Microsoft Office\office16\Startup\ |
   |**Word 2013**| 64-bit C2R installation: | %programfiles%\Microsoft Office\root\office15\Startup\ |
   || 32-bit C2R installation: | %programfiles% (x86)\Microsoft Office\root\office15\Startup\ |
   || 64-bit MSI installation: | %programfiles%\Microsoft Office\office15\Startup\ |
   || 32-bit MSI installation: | %programfiles% (x86)\Microsoft Office\office15\Startup\ |
   | **Word 2010** || %programfiles%\Microsoft Office\Office14\Startup\ |
   | **Word 2007** || %programfiles%\Microsoft Office\Office12\Startup\ |
   | **Word 2003** || %programfiles%\Microsoft\Office\Office11\Startup\ |
   

4. Right-click one of the files in the folder, and then select **Rename**.    
5. After the file name, type **.old**, and then press **Enter**.

   > [!IMPORTANT]
   >  Make a note of the original file name so that you can restore the file, if it becomes necessary.    
6. Start Word.    
7. If you can no longer reproduce the problem, you have found the specific add-in that causes the problem. If you must have the features that the add-in provides, contact the vendor of the add-in for an update.

   If the problem is not resolved, rename the add-in by using its original name, and then repeat steps 3 through 6 for each file in the Startup folder.    
8. If you can still reproduce the problem, type the following path in the address bar of Windows Explorer, and then select **OK**.
   
    **For Windows 10, Windows 8.1, Windows 8, Windows 7, or Windows Vista**
    
    **%userprofile%\AppData\Roaming\Microsoft\Word\Startup**
    
   **For Windows XP**
    
   **%userprofile%\Application Data\Microsoft\Word\Startup**    
9. Repeat steps 3 through 6 for each file in this Startup folder.    
 
If the problem is not resolved after you disable the Startup folder add-ins, go to the next option.

<a id="option7">

#### Option 7: Delete the COM add-ins registry keys

</a>
 
You can install COM add-ins to any location. Programs that interact with Word install COM add-ins. To determine whether a COM add-in is causing the problem, temporarily disable the COM add-ins by deleting the registry keys for the COM add-ins.

To delete the COM add-ins registry keys, follow these steps:
 
1. Exit all Office programs.    
2. Type **regedit** in the **Search** box (in Windows 10, Windows 8.1, or Windows 8) or in the **Start Search** box on the **Start** menu (in earlier versions of Windows), and then press **Enter**.    
3. Locate the following registry subkey: **HKEY_CURRENT_USER\Software\Microsoft\Office\Word\Addins**    
4. Select **Addins**, and then select **File** > **Export**.    
5. Name the file WdaddinHKCU.reg, and then save the file to the desktop.    
6. On the **Edit** menu, select **Delete**, and then select **Yes**.    
7. Locate the following registry subkey: **HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Word\Addins**    
8. Select **Addins**, and select **File** > **Export**.
9. Name the file WdaddinHKLM.reg, and then save the file to the desktop.    
10. On the **Edit** menu, select **Delete**, and then select **Yes**.    
11. Exit Registry Editor.    
12. Start Word.

If the problem is resolved, you have determined that a COM add-in program is causing the problem. Next, you must determine which COM add-in program is causing the problem.

##### Determine which COM add-in program is causing the problem
 
To determine the problematic COM add-in program, follow these steps:

1. Exit all Office programs.    
2. Double-click the **Wdaddin.reg** icon on your desktop.    
3. Select **Yes**, and then select **OK**.    
4. Use one of the following procedures, as appropriate for the version of Word that you are running.

   **Word 2016**, **Word 2013**, or **Word 2010**

   1. On the **File** menu, select **Options**.    
   2. Select **Add-Ins**.    
   3. In the **Manage** list, select **COM Add-Ins**, and then select **Go**.

   > [!NOTE]
   > If an add-in is listed in the **COM Add-Ins** dialog box, clear the add-in check box. If more than one add-in is listed, clear only one add-in check box at a time. This procedure helps you determine which add-in is causing the problem.

   4. Select **OK** to close the COM Add-Ins dialog box.    
   5. On the **File** menu, select **Exit**.    
 
   **Word 2007**

   1. Select the Microsoft Office button, and then select **Word options**.    
   2. Select **Add-ins**.    
   3. In the **Manage** list, select **COM Add-ins**, and then select **Go**.

      If an add-in is listed in the **COM Add-Ins** dialog box, clear the add-in check box. If more than one add-in is listed, clear only one add-in check box at a time. This procedure helps you determine which add-in is causing the problem.    
   4. select **OK** to close the **COM Add-Ins** dialog box.    
   5. select the Microsoft Office Button, and then select **Exit Word**.    
   6. On the **File** menu, select **Exit**.    
     
5. Start Word.

- If the problem is resolved when you start Word, you have determined which COM add-in is causing the problem. If you must have the features that the add-in provides, you must determine which add-in includes those features so that you can contact the vendor for an update.

- If the problem is not resolved when you start Word, repeat steps 4 and 5 for each COM add-in that's listed until you determine which add-in is causing the problem.

To restore the COM add-ins, repeat step 4, but select the check box for each COM add-in that you want to restore.  

<a id="option8">

#### Option 8: Change the default printer

</a>
 
To change the default printer, follow these steps:

1. Exit all Office programs.
2. Select the **Start** button and then **Settings**.
3. Go to **Devices**, and then select **Printers & scanners**.
3. Right-click **Microsoft XPS Document Writer**, and then select **Set as default printer**.    
4. Start Word.

If the problem is resolved after you start Word, you have determined that the printer is causing the problem. If this is the case, contact the vendor to see whether there is an update for the printer driver.

