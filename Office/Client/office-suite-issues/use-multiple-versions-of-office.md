---
title: Use Office 2013 on a computer that's running another version of Office
description: Describes how to run multiple versions of Office on a computer that has Office 2013 suites and programs installed.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: doakm, offspms, tomol, Jenl
search.appverid: 
  - MET150
appliesto: 
  - Office 2013
ms.date: 03/31/2022
---

# How to use Office 2013 suites and programs (MSI deployment) on a computer running another version of Office

For a Microsoft Office 2010 version of this article, see [2121447](https://support.microsoft.com/help/2121447).

For a Microsoft 365 client version of this article, see [Install and use different versions of Office on the same PC](https://support.office.com/article/Install-and-use-different-versions-of-Office-on-the-same-PC-6ebb44ce-18a3-43f9-a187-b78c513788bf). 

## Introduction

This article contains information about how to use Microsoft Office 2013 suites and programs on a computer that is running another version of Office. This article also provides advice to help prevent conflicts between different versions of Office.

## More Information

You can install and use more than one version of Office on a single computer. For example, you can install and use both Office 2013 and Office 2010 on the same computer. However, we do not recommend this. 

> [!NOTE]
> We do not support the use of multiple versions of Office on versions of Windows that have Terminal Services enabled. If you want to run multiple versions of Office on Windows, you should disable Terminal Services.

### Virtualization

To avoid the issues that are discussed in this article, one or more Office products can be deployed in a virtualized environment by using one of the following solutions.

**Windows Virtual PC and Windows 7**

Windows Virtual PC is a free download for Windows 7 that can be used to install multiple versions of Office on the same Windows 7 computer without conflicts.

For more information about Windows Virtual PC, see [Install and use different versions of Office on the same PC](https://support.microsoft.com/help/958559).

Remote Desktop Services or Terminal Services 

Remote Desktop Services or Terminal Services can be used to host the installation on a server to which clients can connect to provide a complete Windows environment. 

For more information Remote Desktop Services, visit https://technet.microsoft.com/library/bb897474.aspx.

Application Virtualization

Microsoft Application Virtualization (App-V) can enable incompatible applications to run on the same instance of the operating system. The applications are centrally managed services that are never installed, minimize conflicts, and that are streamed on-demand to end-users.

For more information about the Office 2013 Resource Kit, go to the following Microsoft TechNet website:

[Office 2013 Resource Kit](https://technet.microsoft.com/library/cc303401%28v=office.15%29.aspx)

Windows 8 and Hyper-V

Because Hyper-V is included with Windows 8, you do not have to download and install it.

For more information about Hyper-V in Windows 8 and Windows Server 2012, go to the following Microsoft TechNet websites:

- [Client Hyper-V](https://technet.microsoft.com/library/hh857623.aspx )
- [Overview of Hyper-V](https://technet.microsoft.com/library/hh831531.aspx)

### Installation order

If you want to install and use more than one version of Office on the same computer without virtualization, use the following order. 

|Version|Installation order|
|---|---|
|Microsoft Office 2003|First|
|Microsoft Office 2007|Second|
|Microsoft Office 2010 suites and programs (32-bit versions only)|Third|
|Microsoft Office 2013 suites and programs (32-bit versions only)|Fourth|

You must install the earliest version of Office first. For example, if you want to use both Office 2007 and Office 2013 programs on the same computer, install Office 2007 first. You must use this order because of how registry keys, shared programs, file name extensions, and other settings are managed for each version of the Office suites and programs.

> [!NOTE]
> - This installation order also applies to Office stand-alone products, such as Visio.   
> - Office 2003 is not supported on Windows 8   
> - If you uninstall one of the versions of Office, you may have to reinstall the remaining versions of Office in this order for them to work correctly.   
> - You must follow this installation order when you apply Office updates (such as .msp files). This is because, when an update is applied, the targeted Office product is repaired. Applying an update to an older version of Office may cause later versions of Office to function incorrectly. You must apply updates to the earliest version of Office first, and then either repair or apply updates to the later versions of Office in chronological order.   

### Installation types

You can install Office 2013 suites or programs by using either the traditional MSI or Click-to-Run (C2R) deployment methods. Even though you may be able to install Office 2013 by using both methods, we do not support the coexistence of an Office 2013 MSI and Office 2013 Click-to-Run installation on the same computer.

### Office 2013 suites and products 64-bit version

To install and use more than one 64-bit version of Office on the same computer without using virtualization, install them in the following order:

|Version|Installation order|
|---|---|
|Microsoft Office 2010 64-bit|First|
|Microsoft Office 2013 64-bit|Second|

You cannot run the 64-bit version of any Office 2013 suite or program when a 32-bit version of Office is installed on the same computer. The Setup program will detect that you have previous 32-bit versions of Office programs on your computer, and require them to be removed before you can install Office 2013 64-bit. 

**Note** This statement applies to the MSI, Click-to-Run (C2R), and App-V deployment types.

### Office Bin folder location

When you install Office 2013 suites or programs, the Setup program uses the Program Files\Microsoft Office folder as the default folder on a 32-bit version of Windows, or the Program Files (x86)\Microsoft Office folder as the default folder on a 64-bit version of Windows. The Office Bin default folder in these versions of windows are Program Files\Microsoft Office\Office15 and Program Files (x86)\Microsoft Office\Office15 respectively. The Office Bin folder is the folder in which the Office executable files are installed. This location provides a better user experience for those who want to use multiple versions of Office on the same computer. Be aware that you cannot change the name of the Office Bin folder.

### Start menu shortcuts

You can use the Office Customization Tool to specify a different location for the Office 2007, Office 2010, and Office 2013 shortcuts. To access the Office Customization Tool, run the setup /admincommand in the root directory of the Office 2013 CD at a command prompt:

**Note** The Office Customization Tool is available only for non-retail versions of Office 2007, Office 2010, and Office 2013. 

For more information about the Office Customization Tool, go to the following Microsoft TechNet website:

[Office Customization Tool (OCT) reference for Office 2013](https://technet.microsoft.com/library/cc179097%28v=office.15%29.aspx)

### Multiple versions of Outlook

Outlook 2013 cannot coexist with any earlier version of Outlook. When you install Outlook 2013, the Setup program removes any earlier versions of Outlook that are installed. The Setup program removes these versions of Outlook even if you select the **Keep these programs** check box in the **Removing Previous Versions** dialog box. 

### Microsoft Office Groove 2007 and Microsoft SharePoint Workspace 2010

Microsoft SharePoint Workspace 2010 cannot coexist with Microsoft Office Groove 2007. When you install SharePoint Workspace 2010, the Setup program removes Groove 2007. The Setup program removes Groove 2007 even if you select the **Keep these programs** check box in the **Removing Previous Versions** dialog box. 

### Multiple versions of Word

If you have two versions of Word installed on the same computer, you experience a delay when you start Word 2010. This behavior occurs because Word 2010 automatically registers itself on the computer.

You can bypass this registration to enable Word 2010 to start faster. However, we do not recommend this because Word may not function correctly if it cannot register itself.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to change the registry. However, serious problems might occur if you change the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you change it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).  

To disable the automatic registration of Word 2010, follow these steps: 

1. Start Registry Editor.
   - In Windows 7 or Windows Vista, click Start, type regedit in the Start Search box, and then press Enter.

      If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
   
   - In Windows XP, click Start, click Run, type regedit in the Open box, and then click OK.      
2. Locate and then click to select the following registry subkey: 

   **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options**   
3. After you select the subkey that is specified in step 3, point to New on the Edit menu, and then click DWORD Value.   
4. Type NoReReg, and then press Enter.   
5. Right-click NoReReg, and then click Modify.   
6. In the Valuedata box, type 1, and then click OK.   
7. On the File menu, click Exit to close Registry Editor.   

> [!NOTE]
> In order to disable the registration in other versions of Word, this registry key must be created for each version. To do this, replace the version number in the path with the appropriate version of Word.

### Office files in Microsoft Windows Explorer

When you double-click an Office file in Windows Explorer to open the file, the following rules apply. These rules also apply when you double-click the Office file in the Recent Documents folder in Windows.

- If a version of the program in which the file was created is running on the computer, the file is opened in that version.    
- For Access and for Word, if no version of the program in which the file was created is running on the computer, the file is opened in the version of the program that was most recently started.    
- To associate files with the programs that are included with a particular version of Office, run the Office Setup program, and then click **Repair Office**. When you do this, the file associations for that version of Office are registered.    

> [!NOTE]
> You cannot use this method to register file associations in Word or in Access.
> If you install a software update for a version of Office, the software update repairs that version of Office. You may have to repair some or all Office products after you install a software update to restore the file associations. For more information about how to repair Office 2013 features, see [Repair an Office application](https://office2010.microsoft.com/access-help/repair-or-remove-your-office-programs-ha010357402.aspx?ctt=1).

Windows 8 steps to repair or remove Office 2013:

Repair your Office programs

1. From the Windows 8 Start screen, type **Control Panel**.   
2. Click or tap **Control Panel**.   
3. Under **Programs**, click or tap on **Uninstall a program**.   
4. Click or tap the Office program that you want to repair, and then click or tap **Change**.   
5. Click or tap **Repair** > **Continue**. You might have to restart your computer after the repair is completed.   

Uninstall Office

1. From the Windows 8 Start screen, type **Control Panel**.   
2. Click or tap on **Control Panel**.   
3. Under **Programs**, click or tap on **Uninstall a program**.   
4. Select the Office version that you want to uninstall.   
5. Click or tap **Uninstall** > **Continue**. You might have to restart your computer after the removal is completed.   

### Office OLE objects in other programs

If you insert an Office object into another program on a computer that is running multiple versions of Office, the latest version of the program is used. For example, if you insert a Microsoft Excel worksheet object into a Word document, the latest versions of Word and of Excel are used. This may cause problems if you share the container file with users who are not using Office 2010 programs. 

### Shared programs

If you install the different versions of Office in the order that is described in the "Installation order" section, you should not experience any problems when you use shared programs such as Equation Editor and Clip Gallery. However, the **Object** dialog box may display more than one entry for each shared program. This behavior occurs because multiple versions of the shared program are installed on the computer.

### Windows Installer messages in Word

If you have multiple versions of Word installed on the computer, the Windows Installer may start when you start Word 2013. Additionally, a message that states that the Windows Installer is preparing to install Word may be displayed before Word starts. This occurs when the version of Word that you start is not the one that is registered. The repair operation can take several minutes to finish.

### Windows Installer messages in Access

When you start a version of Access on a computer that has multiple versions of Access installed, the Windows Installer may start, and a message that states that the Windows Installer is preparing to install Access may be displayed before Access starts.

Every time that you start Access 2003, Access 2007, or Access 2010 after you use Access 2013, the Windows Installer repair operation registers that version of Access. Similarly, the Windows Installer repair operation registers Access 2010 every time that you start it after you use an earlier version of Access. This does not occur when you start Access 2002, nor does it occur when you start the same version of Access again.
