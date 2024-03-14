---
title: Uninstall Office updates
description: Provides information about how to remove Microsoft Office updates. The ability to remove Office updates was added to certain Office updates that are dated July 12, 2005 and later.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: Entirenet, lthurman, jesko, sloanc, chikae, evasand
appliesto: 
  - Office 2010
  - Office 2007
ms.date: 03/31/2022
---

# Information about the ability to uninstall Office updates

## Summary

This article contains more information about the following topics that are related to the removal of Office updates:

- The requirements to remove Office updates by using the Add or Remove Programs tool.
- How to determine whether an Office update can be removed by using the Add or Remove Programs tool.
- Known issue that may occur when you try to remove Office updates.
- How to remove an update by using a Microsoft Windows Installer command.

> [!NOTE]
> Some Office updates can't be removed. Some examples include:
>
> - Service packs
> - Office server product updates
> - Some updates to Office shared components. In this case, the Microsoft Knowledge Base article that describes the update notes that the update cannot be removed.

## More Information

### The requirements to remove Office updates by using the Add or Remove Programs tool

The computer that is running Microsoft Office must meet the following prerequisites to use the Add or Remove Programs tool to remove Office updates:

- Microsoft Windows Installer version 3.0 or version 3.1 must be installed before you install the removable Office update.

  > [!NOTE]
  >
  > - Microsoft Windows Installer version 3.1 is preferred. For more information about how to obtain Windows Installer 3.1 (v2), see [Windows Installer 3.1 v2 (3.1.4000.2435) is available](https://support.microsoft.com/help/893803).
  > - Windows XP Service Pack 2 (SP2) already includes Microsoft Windows Installer 3.0.3790.2180. Additionally, the 2007 Microsoft Office suites require Windows XP SP2.
  > - Windows Server 2003 Service Pack 1 (SP1) already includes Microsoft Windows Installer 3.1.4000.1830.
  > - Windows Vista and Windows Server 2008 already includes Microsoft Windows Installer 4.00.6001.0.

- The computer must be running Windows Vista, Windows XP SP2, Windows Server 2008, or Windows Server 2003 SP1.

    > [!NOTE]
    > When you install either of these service packs, the Add or Remove Programs tool is updated to display Windows Installer updates under the product name.
- Removing an Office XP update requires the original installation source to be available. Removing an Office 2003 update requires the original installation source to be available if the Local Installation Source feature in Office 2003 Setup is not used.

### How to determine whether an Office update can be removed by using the Add or Remove Programs tool

#### Windows XP and Windows Server 2003

To determine whether an Office update can be removed by using the Add or Remove Programs tool, follow these steps:

1. Click **Start**, click **Run**, type `appwiz.cpl` in the **Open** box, and then click **OK**.
2. In the left column, click **Change or Remove Programs**.
3. Click to select the **Show Updates** check box.
4. In the **Currently installed programs and updates** list, click the update that you want to remove.

If the **Remove** button is available, you can remove the Office update.

#### Windows Vista and Windows Server 2008

To determine whether you can use the Add or Remove Programs tool to remove an Office update, follow these steps:

1. Click **Start**, type `appwiz.cpl` in the **Start Search** box, and then press ENTER.
2. Under **Tasks**, click **View installed updates**.
3. Locate and select the update in the list.
4. If the update can be removed, the
**Uninstall** option will be available in the toolbar.

### Known issue that may occur when you try to remove Office updates

#### The computer meets the prerequisites, but you can't remove an update

This issue may occur if the computer did not meet the prerequisites at the time that the update was installed. The computer must be running Windows Installer version 3.0 or version 3.1 before you install the removable update.

### How to remove an update by using a Windows Installer

There are some cases in which you do not have the option to remove an update when you use the Add or Remove Programs tool.

If this issue occurs, you can remove the update by using Windows Installer 3.1. The Windows Installer 3.1 redistributable system component will install on the following operating systems:

- Microsoft Windows 2000 Service Pack 3 (SP3) and Microsoft Windows 2000 Service Pack 4 (SP4)
- Windows XP original release version, Windows XP Service Pack 1 (SP1), and Windows XP SP2
- Windows Server 2003 original release version

  > [!NOTE]
  > Windows Server 2003 SP1 already includes Windows Installer 3.1.

For more information about how to obtain Windows Installer 3.1 (v2), see[Windows Installer 3.1 v2 (3.1.4000.2435) is available](https://support.microsoft.com/help/893803).

#### Command syntax

With Windows Installer 3.1, you can remove an update by typing a command in the **Run** dialog box. For example, to remove an update, click **Start**, click **Run**, type the following command in the **Open** box, and then click
 **OK**:

`msiexec /package {product_code} /uninstall "full_path_to_.msp_file" /qb`

> [!NOTE]
>
> - When you try to remove an Office update, you may be prompted for your Office source CD-ROM.
> - The following explains the placeholders for this command:
>
>   - The **product_code** placeholder represents the product code GUID that is associated with the Office product that you installed an update for.
>   - The **full_path_to_.msp_file** placeholder represents the full path of the update package (.msp file).
> - The following explains the parameters for this command:
>
>   The `/qb` switch: If you use the `/qb` switch, you're prompted if an update isn't removable. If you use the `/passive` switch, you aren't prompted if an update isn't removable. If you use the `/qb` switch, and if an update isn't removable, you receive the following message:  
>
>   Uninstallation of the patch package is not supported.

For example, to remove an update where the product code is "{0C9840E7-7F0B-C648-10F0-4641926FE463}", and the path of the .msp file is "C:\Update\file name.msp", type the following in the **Run** dialog box:

`msiexec /package {0C9840E7-7F0B-C648-10F0-4641926FE463} /uninstall "c:\update\file name.msp" /qb`

To obtain the full path of the .msp file, follow these steps:

1. Locate the .exe file that you used to install the Office update. If you do not have the file saved to the hard disk drive, download and then save the Office update to a folder on the computer.
2. Use a file extraction utility, such as WinZip, to extract the files from the .exe update file.

    One of the files that is extracted should be a .msp file. This is the file that you must point to when you run the command to remove the Office update.

> [!NOTE]
> Instead of the full path of the .msp file, you can also specify the patch GUID. For example, to remove an update where the product code is "{0C9840E7-7F0B-C648-10F0-4641926FE463}", and the patch GUID is "{EB8C947C-78B2-85A0-644D-86CEEF8E07C0}", type the following in the **Run** dialog box:
>  
> `msiexec /package {0C9840E7-7F0B-C648-10F0-4641926FE463} /uninstall {EB8C947C-78B2-85A0-644D-86CEEF8E07C0} /qb`

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

## References

For more information about how to remove Office updates that are installed by using Windows Installer version 3.0 or version 3.1, see [Uninstalling Patches](/windows/win32/msi/uninstalling-patches?redirectedfrom=MSDN).
