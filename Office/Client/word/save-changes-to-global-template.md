---
title: Prompted to save changes to global template
description: Describes a problem where you are prompted to save the changes to the Normal.dotm global template every time that you exit Word 2007. Provides workarounds.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: mmaxey
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Templates
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Word 2010
  - Word 2007
ms.date: 06/06/2024
---

# You are prompted to save the changes to the global template every time that you exit Word 2007 or Word 2010

## Summary

This article contains workarounds for an issue in which you are always prompted to save the changes to the global template, Normal.dotm, when you exit Microsoft Office Word 2007 or Word 2010. First, you can turn off the **Prompt before saving Normal template** option. However, when you do this, Word will not prompt you when it automatically saves the changes the global template. You may still have an issue. Second, you can remove any add-ins or templates that may be changing the global template. Third, you can help protect the computer from macro viruses that change the global template.

## Symptoms

Every time that you exit Microsoft Office Word 2007 or Word 2010, you receive the following message: 

"Changes have been made that affect the global template, Normal.dotm. Do you want to save those changes?"

## Cause

This issue may occur if any one of the following conditions is true:

- The **Prompt before saving Normal template** option is turned on.   
- An add-in or a macro that is changing the global template is installed on the computer. For example, this issue may occur the Stamps.com Internet postage add-in is installed on the computer.
  
  An add-in may add one or more of the following items to the computer: 
    - A WLL file    
    - A template   
    - A COM add-in   
    - An automatic macro   
   
- The computer is infected with a macro virus that changes the global template (Normal.dotm).    


## Workaround

To work around this issue, use one or more of the following workarounds.

### Workaround 1: Turn off the "Prompt before saving Normal template" option

To work around this issue if the **Prompt before saving Normal template** option is turned on, follow these steps.

> [!NOTE]
> If you turn off this option in Word, changes may still be made to the global template. However, you will not be prompted to save these changes. We recommend that you perform the other workarounds that are mentioned later in this article. 

1. In Word 2007, click the **Microsoft Office Button**, and then click **Word Options**.

   In Word 2010, click the **File**button, and then click **Options**.

2. Click **Advanced**.   
3. Under **Save**, click to clear the **Prompt before saving Normal template** check box.   
4. Click **OK** to close the **Word Options** dialog box.   

### Workaround 2: Remove add-ins or macros that are changing the global template

To work around this issue if add-ins or macros that are changing the global template are installed on the computer, use one of the following methods.
 
#### Method 1: Remove WLL add-ins and templates from the Word Startup folder and from the Office Startup folder

When you start Word, Word automatically loads templates and add-ins that are located in the Office Startup folder and in the Word Startup folder. You may experience the issue that is described in the "Symptoms" section if conflicts or problems occur with one of these items. To determine whether an item in a Startup folder is causing the issue, temporarily empty the folder. To do this, follow these steps:

1. Exit all instances of Word. If you use Word as your e-mail editor in Microsoft Outlook, make sure that you also exit Outlook.   
2. On the desktop, double-click **My Computer**, and then open the Office Startup folder. By default, the Office Startup folder is at the following location:
   
   For Word 2007:

   C:\Program Files\Microsoft Office\Office12\Startup

   For Word 2010:

   C:\Program Files\Microsoft Office\Office14\Startup

3. Drag each item from the Office Startup folder to the desktop. Or, create a folder on your desktop, and then drag each item to this new folder. 

   > [!NOTE]
   > To create a new folder on the desktop, right-click a blank area on the desktop, point to **New**, and then click **Folder**.   
4. Open the Word Startup folder. By default, the Word Startup folder is at the following location: 

   C:\Documents and Settings\**user name**\Application Data\Microsoft\Word\Startup
1. Drag each item from the Word Startup folder to the desktop. Or, create a folder on your desktop, and then drag each item to this new folder.    
1. Start Word.

If you can no longer reproduce the issue after you removed multiple items from the Office Startup folder and from the Word Startup folder, add the files back to the appropriate Startup folder one at a time to isolate the issue. Try to reproduce the issue after you add each file to find the file that causes the issue.

#### Method 2: Remove COM add-ins

COM add-ins can be installed in any location. COM add-ins are installed by programs that interact with Word 2007. To view the list of COM add-ins that are installed on the computer, follow these steps: 

1. In Word 2007, click the **Microsoft Office Button**, and then click **Word Options**.

   In Word 2010, click the **File**button, and then click **Options**.

2. Click **Add-Ins**.   
3. Under **Manage**, click **COM Add-ins**, and then click **Go**.

   The **COM Add-Ins** dialog box appears.   

If add-ins are listed in the **COM Add-Ins** dialog box, temporarily turn off each add-in. To do this, click to clear the check box for each COM add-in that is listed, and then click **OK**. When you restart Word, the COM add-ins that you turned off are not loaded. If the issue is resolved after you turn off the COM add-ins, one of these COM add-ins is causing this issue. To determine the add-in that is causing the issue, turn on the COM add-ins one at a time, and then restart Word.

#### Method 3: Remove Word automatic macros

Automatic macros run when you start Word or when you perform a specific action in Word 2007. The following table lists the Word automatic macros: 

|Macro|Storage location|Action|
|---|---|---|
|AutoExec|In the Normal template or in a global add-in|Runs when you start Word 2007|
|AutoNew|In a template|Runs when a new document that is based on the template is created|
|AutoOpen|In a document or in a template|Runs when a document that is based on the template or that contains the macro is opened|
|AutoClose|In a document or in a template|Runs when a document that is based on the template or that contains the macro is closed|
|AutoExit|In the Normal template or in a global add-in|Runs when you exit Word 2007|

To determine the automatic macros that you should remove, temporarily stop Word automatic macros from running. To temporarily stop the AutoExec macro from running, click **Start**, point to **All Programs**, hold the SHIFT key, and then click Microsoft Word. If you are using Windows Vista or Windows 7 type Word from the start button, hold down the SHIFT key, and then click Microsoft Word. To stop any one of the other macros that are listed in this table, hold SHIFT when you perform the action that causes the macro to run. 

To remove an automatic macro, follow these steps: 

1. Start Word.   
2. On the **Developer** tab, in the **Code** group, click **Macros**.

   If the **Developer** tab does not appear in Word 2007, follow these steps: 
    1. Click the **Microsoft Office Button**, and then click **Word Options**.
    2. Click **Personalize**.   
    3. Under **Top options for working with Word**, click to select the **Show Developer tab in the Ribbon** check box.   
    4. Click **OK** to close the **Word Options** dialog box.

   If the **Developer** tab does not appear in Word 2010, follow these steps:
 
    1. In the upper-left corner of the screen, click the Filebutton.   
    2. In the lower-right area of the drop-down box, click Options.    
    3. In the Word Options page, click Customize Ribbonin the left menu.   
    4. In the Top options for working with Wordsection, click to select the Show Developer tab in the Ribboncheck box, and then click OK.
3. In the **Macros** dialog box, remove any macro whose name starts with "Auto". To remove an automatic macro, click the macro, and then click **Delete**.

   **Note** An automatic macro may have been added by a Word add-in. To determine whether a template contains an automatic macro, click each template in the **Macros in** box. When you do this, the macros that are in the template are listed. If you determine that a template contains an automatic macro, you may want to remove this template from your computer. If you remove a template that was added by a Word add-in, the functionality of the add-in may be affected.   
4. Click **Cancel** to close the **Macros** dialog box.   
5. Exit Word.   

If the issue is resolved after you restart Word, one of the automatic macros was causing the issue.]

### Workaround 3: Help prevent a macro virus from infecting the computer

To work around this issue if the computer is infected with a macro virus, use one or more of the following methods.

#### Method 1: Install and update antivirus software

For a long-term strategy to help prevent macro viruses, install antivirus software that is designed specifically to detect macro viruses.

> [!NOTE]
> After you install an antivirus software program, you must keep it updated to make sure that new macro viruses are detected and removed. For more information about how to update your antivirus software program, contact your antivirus software vendor.

#### Method 2: Configure a macro setting in Word

Word includes the following macro settings to help reduce the chances that a macro virus will infect documents, templates, or add-ins: 

- **Disable all macros without notification**   
- **Disable all macros with notification**

   **Note** This setting is the default setting.    
- **Disable all macros except digitally signed macros**   
- **Enable all macros (not recommended, potentially dangerous code can run)**  

To change the macro setting in Word, follow these steps: 

1. In Word 2007, click Word Options from the Officebutton.

   In Word 2010, click Options from the Filebutton.

2. Select Trust Center, and then click Trust Center Settings.   
3. Click **Macro Settings**.   
4. Under **Macro Settings**, click one of the following macro settings for documents that are not in a trusted location: 
   - **Disable all macros without notification**   
   - **Disable all macros with notification**   
   - **Disable all macros except digitally signed macros**   
   - **Enable all macros (not recommended, potentially dangerous code can run)**    
5. Click **OK** to close the **Trust Center** dialog box.   

#### Method 3: Lock the global template

When you lock the global template and create a password, you can help reduce the chances that a macro virus will gain unauthorized access to the computer.

To lock the global template, follow these steps: 

1. On the **Developer** tab, in the **Code** group, click **Visual Basic**.

   If the **Developer** tab does not appear in Word 2007, follow these steps: 
    1. Click the **Microsoft Office Button**, and then click **Word Options**. 
    2. Click **Personalize**.   
    3. Under **Top options for working with Word**, click to select the **Show Developer tab in the Ribbon** check box.   
    4. Click **OK** to close the **Word Options** dialog box.   

   If the **Developer** tab does not appear in Word 2010, follow these steps: 
    1. Click the **File** button and then click **Options**.   
    2. Click **Customize Ribbon**.   
    3. Check **Developer** from the list on the right.    
2. In Visual Basic Editor, click **This Document** in the **Project** window.

   **Note** If the **Project** window does not appear, click **Project Explorer** on the **View** menu.   
3. On the **Tools** menu, click **Project Properties**.   
4. Click the **Protection** tab, click to select the **Lock project for viewing** check box.   
5.  In the **Password** box, type a password. Then, type the same password in the **Confirm password** box.   
6. Click **OK** to close the **Project Properties** dialog box.   
7. On the **File** menu, click **Close and return to Microsoft Word**.   
8. Exit Word.

   When you receive the following message, click **Yes**: 

   "Changes have been made that affect the global template, Normal.dotm. Do you want to save those changes?"   

## More Information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
