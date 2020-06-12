---
title: Office installation Error 1401, 1402 or 1406
description: Describes an issue that occurs when the Everyone group of the Microsoft Office registry subkey is not set to full control when you install an Office program. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Office 2010
- Office 2007
- Office 2003
---

# Error 1401, 1402 or 1406 when you install an Office program or open an Office program or document

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you install a Microsoft Office program, you may receive one of the following error messages during or at the end of the installation process:

"Error 1401: Setup cannot create Registry Key"

"Error 1402: Setup cannot open Registry Key"

"Error 1406: Setup cannot write the value to the registry key"

The error message that you receive lists the registry subkey that is causing the error to occur.

After the installation, you may receive the following error message when you try to start your Office program:

```adoc
Microsoft program has not been installed for the current user. Please run setup to install the application.
```

> [!NOTE]
> The **program** placeholder represents the name of the Office program that you are trying to start.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1

Set the permission for the **Everyone** group of the registry subkeys that are listed in the error message to Full Control. To do this, use the easy fix solution and follow the steps in [How do I restore security settings to the default settings](https://support.microsoft.com/help/313222).

### Method 2

Disable the third-party application. For example, to disable WebRoot Spy sweeper, follow these steps: 

1. Right-click the WebRoot Spy sweeper icon that is located in the notification area, at the far right of the taskbar.   
2. Left-click the **Shut Down option.   
3. In the **Office installation Error 1406 dialog box, click **Retry**.   
4. When the Office setup is completed, restart the computer, and then re-enable WebRoot Spy sweeper.   

### Method 3

Take the system into a "clean boot" state, and then run Office setup. This disables the third-party applications. The third-party application that is denying access to the registry subkey can no longer deny access. For more information about how to take the system into a "clean boot" state, view [How to perform a clean boot in Windows](https://support.microsoft.com/help/929135).

### Method 4

Some activation problems indicate that the license file is corrupted. If the license file is corrupted, you cannot resolve the problem by removing and then reinstalling the Office product. The license file is not removed when you remove the Office product. Additionally, the license file is not overwritten when you reinstall the Office product. If the license file is corrupted, use one of the following methods to delete the license file.

> [!NOTE]
> This method applies only to Office 2007, Office 2003 and Office XP. Office 2010 does not use the OPA licensing file. 
 
#### Delete the license file manually

Easy fix 50302

For Windows 7 or Windows Vista

1. Log on to the computer by using an Administrator user account.    
2. Start Microsoft Windows Explorer.    
3. On the **Organize** menu, click **Folder and search options**.    
4. Click the **View** tab.    
5. Under **Hidden files and folders**, click **Show hidden files, folders, and drives**.    
6. Click to clear the **Hide extensions for known file types** check box.    
7. Click to clear the **Hide protected operating system file (Recommended)** check box, and then click OK.   
8. On the **Warning** dialog box, click **Yes**.   
9. Open the following folder: C:\Users\All Users\Microsoft\Office\Data\    
10. If you are running Office 2007, right-click **Opa12.dat** or if you are running Office 2003, right-click **Data.dat**, and then click **Properties**.  
11. Click the **Security** tab.    
12. Click **Advanced**.    
13. Click the **Permissions** tab.    
14. Click to select **Everyone** in the **Permission entries** list, and then click **Edit**.    
15. Click to select the **Full Control** check box.    
16. Click **OK** four times. If these steps do not resolve this issue, delete the Opa12.dat, the Opa11.dat file or the Data.dat file from the following folder, and then restart an Office 2007 program, an Office 2003 program or an Office XP program

    C:\Users\All Users\Microsoft\Office\Data   

For Windows XP or Windows Server 2003

1.  Log on to the computer by using an Administrator user account.    
2.  Start Microsoft Windows Explorer.    
3.  On the **Tools** menu, click **Folder Options**.    
4.  Click the **View** tab.    
5.  Under **Hidden files and folders**, click **Show hidden files and folders**.    
6.  Click to clear the **Hide extensions for known file types** check box, and then click **OK**.    
7.  Open the following folder: C:\Documents and Settings\All Users\Application Data\Microsoft\Office\Data\    
8.  If you are running Office 2007, right-click **Opa12.dat**, and then click **Properties**. If you are running Office 2003, right-click **Opa11.dat**, and then click **Properties**. If you are running Office XP, right-click **Data.dat**, and then click **Properties**.    
9. Click the **Security** tab.    
10. Click **Advanced**.    
11. Click the **Permissions** tab.    
12. Click to select **Everyone** in the **Permission entries** list, and then click **Edit**.    
13. Click to select the **Full Control** check box.    
14. Click **OK** three times. If these steps do not resolve this issue, delete the Opa11.dat file or the Data.dat file from the following folder, and then restart an Office 2003 program or an Office XP program: 

    C:\Documents and Settings\All Users\Application Data\Microsoft\Office\Data   


This issue may occur if one of the following scenarios is true: 

- The user who is installing the program, or the user who is opening the program or file does not have sufficient permissions to modify sections of the registry that is required to perform the action. The permission for the Everyone group of the registry subkey noted in the error message is not set to Full Control.    
- There is a third-party application on the system that is denying the required access to the registry subkey. In most cases, this behavior is caused by WebRoot Spy sweeper.   
- The nonadministrative user accounts on the computer do not have permission to modify specific files that are used by the Office 2003 Setup program or the Office XP Setup program. These files are used by the Office 2003 Setup program or the Office XP Setup program to register different accounts for access to the Office programs. This issue may occur if a Group Policy high-security template was applied to the computer and if the high-security template restricts access to the following file: 
  - For Windows XP or Windows Server 2003
    - Office 2007  C:\Documents and Settings\All Users\Application Data\Microsoft\Office\Data\Opa12.dat   
    - Office 2003  C:\Documents and Settings\All Users\Application Data\Microsoft\Office\Data\Opa11.dat   
    - Office XP  C:\Documents and Settings\All Users\Application Data\Microsoft\Office\Data\Data.dat      
  - For Windows Vista or Windows 7
    - Office 2007 C:\Users\All Users\Microsoft\Office\Data\Opa12.dat   
    - Office 2003 C:\Users\All Users\Microsoft\Office\Data\Opa11.dat   
    - Office XP C:\Users\All Users\Microsoft\Office\Data\Data.dat      

If the non-administrative user accounts cannot modify this file, users cannot start any Office 2007 programs, 2003 programs, or Office XP programs on the computer. The Opa12.dat, the Opa11.dat file and the Data.dat file are hardware-specific. Additionally, these files are compiled during installation of Office.    
