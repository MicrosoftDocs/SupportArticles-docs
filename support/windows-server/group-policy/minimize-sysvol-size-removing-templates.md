---
title: Minimize SYSVOL size by removing administrative templates
description: Describes how to minimize SYSVOL size by removing administrative templates (.adm files).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:sysvol-access-or-replication-issues, csstroubleshoot
---
# How to minimize SYSVOL size by removing administrative templates (.adm files)

This article describes how to minimize SYSVOL size by removing administrative templates (.adm files).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 813338

## Summary

For domains with many policies, and domain controllers with slow wide area network (WAN) lines, replicating the SYSVOL share can take a long time. It's most noticeable when you promote a new domain controller at a location with slow connectivity or when you run a non-authoritative restore of SYSVOL. To speed up the process, reduce the number of files and amount of data that must be replicated in the SYSVOL share.

Because Administrative Templates (that is, .adm files) take up the most space in policies, remove them to significantly reduce the size of SYSVOL. For example, with the default Administrative Templates, each policy takes up 870 kilobytes (KB) of disk space. If you have 1,300 policies, you can reduce the size of SYSVOL from 1,100 megabytes (MB) to 35 MB (or 27 KB per policy).

You can use Group Policy settings to change the behavior of Group Policy Editor about .adm files in Microsoft Windows Server 2003. For more information, see [Recommendations for managing Group Policy administrative template (.adm) files](https://support.microsoft.com/help/816662).

## More information

Only the computer that you target with Group Policy Object Editor has to have the Administrative Templates. By default, it's the Primary Domain Controller (PDC) emulator.

Removing the ADM files from the SYSVOL replication is a three-step process.

1. The ADM files must be removed from the policies.
2. A filter is set in FRS or DFSR for SYSVOL so that ADM files are no longer replicated.
3. The ADM files are copied back to the SYSVOL on the PDC Emulator.

### Step 1: Remove the ADM files

An easy way to remove Administrative Templates if you haven't added any special or custom ones is to search in Explorer on the PDC emulator for *.adm files. Sort the results by name, and then delete all the Administrative Template folders. After you make these changes, wait until the replication process has successfully replicated the changes to the other domain controllers. To complete the process, set the filter for Administrative Templates.

If you have custom Administrative Templates, copy these to a different directory structure. For best results, use the Robust File Copy utility (Robocopy.exe) from the Resource Kit. The command syntax is:  
`robocopy PDC sysvol backup_directory *.adm /s /mov`

An example of the command to copy custom Administrative Templates to a different directory structure is the following one:  
`robocopy \\mydom-pdc\sysvol\mydom.com\policies c:\sysvol-adm-backup\ *.adm /s /mov`

After running this command to remove ADM file from the policies in the SYSVOL, the change will be replicated to all other DCs in the domain. Wait for file replication to complete before proceeding to step 2.

> [!NOTE]
> Backup your Sysvol before making any changes to the file structure

### Step 2: Set Replication Filter for ADM files

The File Replication System (FRS) or the Distributed File System Replication (DFSR) can be used to replicate the SYSVOL. Use the correct method for the target domain.

#### Steps for FRS

You can specify a file filter in the FRS object for the replica set (after you remove the Administrative Templates). For best results, use Adsiedit.msc from the Support Tools. The Attribute is fRSFileFilter. By default, its content is **\*.tmp, \*.bak, ~\***.

To edit this attribute:

1. In ADSIEDIT, locate the following object:

    CN=Domain System Volume (SYSVOL share),CN=File Replication Service,CN=System,DC= **your_domain**

2. In the properties for the object, select **fRSFileFilter** in **Select a property to view**. The value appears in the **Value** line.
3. Select **Clear** to bring the attribute to the **Edit Attribute** line.
4. Change this line to **\*.tmp, \*.bak, \*.adm, ~\***.
5. Select **Set**.
6. Select **OK**.

#### Steps for DFSR

1. Open ADSIEDIT.MSC.
2. Browse to DC=\<DominanName>,CN=System,CN=DFSR GlobalSettings, CN=Domain System Volume,CN=Content.
3. Right click **CN=Sysvol Share** and select **Properties**. Locate the **msDFSR-FileFiler** attribute.
4. Edit the **msDFSR-FileFiler** attribute and add ,*.ADM.
5. Select **Apply** and then select **OK**.

### Step 3: Copy the ADM files back to the PDC's SYSVOL

You can then use the Robust File Copy utility to copy the Administrative Template folders back to the guid folders if you want. The command syntax is:  
`robocopy backup_directory PDC sysvol /s`

An example of the command to copy the Administrative Template folders back to the guid folders is the following one:  
`robocopy c:\sysvol-adm-backup\\mydom-pdc\sysvol\mydom.com\policies /s`

Technically, if you don't have any custom Administrative Templates, you don't have to add the Administrative Template folders back to the PDC emulator. The folders will be automatically regenerated by using the local Administrative Templates whenever someone edits the Group Policy object (GPO).

If you move the PDC emulator role, you may also want to move the Administrative Templates. For best results, use the Robust File Copy utility. The command syntax is:  
`robocopy old_PDC_SYSVOL PDC_SYSVOL *.adm /s /mov`

An example of the command to move the Administrative Templates is the following one:  
`robocopy \\mydom-pdc\sysvol\mydom.com\policies \\mydom-res-pdc\sysvol\mydom.com\policies *.adm /s /mov`

If you have custom Administrative Templates, make sure they have unique file names across policies. You can then distribute these Administrative Templates to all the computers that run Group Policy Object Editor. Copy the Administrative Template files to the NT\\Inf folder.

Unless you have specific Administrative Template requirements (for example, you use certain Administrative Templates only for certain policies), a good idea is to combine these approaches to have a complete set of Administrative Templates for editing a GPO.

Windows 2000, Windows 2003, Windows 2003 R2, and Windows XP use ADM files. Windows 2008 and later OSs use ADMX files and can also use custom ADM files. For more information on ADMX files, see [Managing Group Policy ADMX Files Step-by-Step Guide](/previous-versions/windows/it-pro/windows-vista/cc709647(v=ws.10)).
