---
title: Enable or disable hyperlink warning messages in Office programs
description: Describes how to enable or to disable hyperlink warning messages in Microsoft Office programs.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: johnlan, of12sstr
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office 2007
  - Microsoft Office 2010
  - Microsoft Office 2013
  - Microsoft Office 2016
  - Microsoft Office 2019
  - Microsoft 365 Apps for Enterprise
ms.date: 03/31/2022
---

# Enable or disable hyperlink warning messages in Office programs

## Introduction

This step-by-step article describes how to enable or to disable the display of a warning message every time that you click a hyperlink in a Microsoft Office program. 

## More Information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

In Microsoft Office applications, when you click a hyperlink or an object that links to an executable file, you receive the following warning message: 

```adoc
Opening "path/filename". 

Hyperlinks can be harmful to your computer and data. To protect your computer, click only those hyperlinks from trusted sources. Do you want to continue? 
```

This behavior occurs regardless of your security level settings. 

> [!NOTE]
> To locate your security level settings, point to **Macro** on the **Tools** menu, and then click **Security**. 

Additionally, when you open either TIFF images or Microsoft Document Imaging (MDI) files, you receive the following warning message: 

```adoc
Opening path/filename. 

Some files can contain viruses or otherwise be harmful to your computer. It is important to be certain that this file is from a trustworthy source. Would you like to open this file?
```

You receive this warning message even when you have already implemented the registry key that this article describes. This warning message comes from the HLINK.dll file when link navigation is handled. You can differentiate the Microsoft Office hyperlink warning message from the HLINK warning message by looking for quotation marks around the file path in the warning message. The Microsoft Office message contains quotation marks. The HLINK message does not contain quotation marks. Microsoft Office tries to determine whether the file type itself is unsafe by checking the extension, the progid, the classid, and the MIME type of the document.
 
### How to globally enable or disable hyperlink warnings

To enable or to disable the hyperlink warnings in Microsoft Office programs when an https:// address, a notes:// address, or an ftp:// address is used, you must create a new registry subkey. To do this, follow these steps:

1. Click **Start**, and then click **Run**.    
2. In the **Open** dialog box, type **regedit**, and then click **OK**.

    > [!NOTE]
    > - You have to modify only one of these registry subkeys. You do not have to modify both.    
    > - If the Security subkey already exists, go directly to step 6 after you select the Security subkey.   
3. Locate and then select the following registry subkey (if the subkey does not exist, create it manually):
   **HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Common**
   
   **Note** In this subkey, replace "xx.0" with 12.0 for Office 2007, 14.0 for Office 2010, 15.0 for Office 2013, and 16.0 for Office 2016 and later.   
4. Click the registry subkey, point to **New** on the **Edit** menu, and then click **Key**.   
5. Type Security, and then press Enter to name the key.   
6. On the **Edit** menu, point to **New**, and then click **DWORD Value**.    
7. Type DisableHyperlinkWarning, and then press Enter to name the entry.   
8. In the right pane, right-click **DisableHyperlinkWarning**, and then click **Modify**.   
9. In the **Edit DWORD Value** dialog box, click **Decimal**, and then type 1 or 0 under **Value data**.
    > [!NOTE]
    > A value of 0 enables the hyperlink warning message. A value of 1 disables the hyperlink warning message.
10. Click **OK**.   
11. Exit Registry Editor.   

### How to enable or disable hyperlink warnings per protocol

To disable the display of security warnings for a specific protocol, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**. 

2. Locate the following registry subkey: 

    **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\xx.0\Common\Security\Trusted Protocols\All Applications**

    **Note** In this subkey, replace "xx.0" with 12.0 for Office 2007, 14.0 for Office 2010, 15.0 for Office 2013, and 16.0 for Office 2016 and later.      
3. Click the All Applications subkey.   
4. On the **Edit** menu, point to **New**, and then click **Key**.   
5. Type the name of the protocol that you want to exclude. For example, to disable the display of a security warning for the "Notes:" protocol, type Notes:.

   **Note** Make sure that you include the colon (:) character.   
6. Press Enter.   
7. Exit Registry Editor.   

### If you still receive a warning message

After you disable warning messages, you may still receive a warning message from Microsoft Windows. If you continue to receive a warning message after you follow the steps in this article, use one of the following methods to resolve the issue. 

> [!NOTE]
> Method 1 applies only to Windows XP and to earlier versions of Windows. For Windows Vista and for later versions of Windows, use method 2.

#### Method 1: Turn off the "Confirm open after download" option for the file type that you are trying to open

1. Double-click **My Computer**.
1. On the **Tools** menu, click **Folder Options**.
1. On the **File Types** tab, select the appropriate file name extension (for example, WMV) in the **Registered File Types** box, and then click **Advanced**.
1. Click to clear the **Confirm open after download** check box, and then click **OK**.
1. In the **Folder Options** dialog box, click **Close**.

#### Method 2: Modify the HKEY_CLASSES_ROOT\\\<CLSID\>\EditFlags registry subkey

Use this method if the warning message affects multiple computers. 

To disable the warning message, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**. 
2. Locate the following registry subkey:

   **HKEY_CLASSES_ROOT\\\<CLSID\>\EditFlags**
   
   For example, if the file name extension is WMV, select HKEY_CLASSES_ROOT\WMVFile\EditFlags   
3. Click **EditFlags**, and then click **Rename** on the **Edit** menu.
4. Type OldEditFlags, and then press ENTER.   
5. On the **Edit** menu, point to **New**, and then click **DWORD value**.   
6. Type EditFlags, and then press ENTER.   
7. On the **Edit** menu, click **Modify**.
8. In the **Edit DWORD Value** dialog box, click **Hexadecimal** under **Base**.   
9. Type 10000, and then click **OK**.

To re-enable the warning message, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**.   
2. Locate the following registry subkey: 

   **HKEY_CLASSES_ROOT\\\<CLSID\>\EditFlags**   
3. Click **EditFlags**, and then click **Modify** on the **Edit** menu.

4. Type 0, and then click **OK**.    

> [!NOTE]
> Even after you follow these steps, you will receive the warning message if you open files under Protected View.

#### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).
