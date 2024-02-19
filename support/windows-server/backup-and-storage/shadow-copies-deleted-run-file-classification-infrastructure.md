---
title: Shadow copies are deleted on Windows Server when you try to run an FCI classification job
description: Describes an issue in which shadow copies are deleted on Windows Server when you try to run an FCI classification job. This occurs when there's insufficient space on the volume for shadow copies.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# Shadow copies are deleted on Windows Server when you try to run an FCI classification job

This article describes an issue in which shadow copies are deleted on Windows Server when you try to run an FCI classification job. This occurs when there's insufficient space on the volume for shadow copies.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 977521

## Symptoms

On a Windows Server computer, you have a volume on which you have enabled shadow copies through a Volume Shadow Copy (VSS) provider. On this volume, you run a File Classification Infrastructure (FCI) classification job. However, the classification job doesn't finish, and older shadow copies are deleted faster than expected from the shadow copies storage area. This may result in all shadow copies being deleted from the volume. Additionally, multiple entries that resemble the following may be logged in the System log:

> The oldest shadow copy of volume **Volume_Letter** : was deleted to keep disk space usage for shadow copies of volume **Volume_Letter** : below the user defined limit.

Also, entries that resemble the following are logged in the FSRM log:

> Warning **DD**/**MM**/**YYYY** **hh** :**mm**:**ss** **AM_PM** SRMSVC 12310 None
>
> Shadow copy '\\\\?\\GLOBALROOT\\Device\\**HarddiskVolumeShadowCopy_File_Name**' was deleted during storage report generation. Volume '**Volume_Letter** :' might be configured with inadequate shadow copy storage area. Storage reports may be temporarily unavailable for this volume.

Additionally, if you run an FSRM storage report, you receive the following error message:

>Error: RunFileQueries, 0x8004532c, A volume shadow copy could not be created or was unexpectedly deleted.
>
> File Server Resource Manager encountered an unexpected error during volume scan of volumes mounted at '\\\\?\\Volume{Volume_PID}\\' ('**Volume_Letter**:'). To find out more information about the root cause for this error please consult the Application/System event log for other FSRM, VSS or VOLSNAP errors related with these volumes. Also, you might want to make sure that you can create shadow copies on these volumes by using the VSSADMIN command like this: VSSADMIN CREATE SHADOW /For=**Volume_Letter** :
>
> Error generating report job with the task name '**Task_name**'.

After you receive this error message, you find that the following error message is logged in the System log:

> Exception encountered = Catastrophic failure (Exception from HRESULT: 0x8000FFFF (E_UNEXPECTED))

## Cause

This issue occurs because the FCI classification process stores properties in each file that is classified. This behavior changes the file on the volume that has shadow copies enabled. These changes are tracked by the VSS provider and are then stored in the shadow copies storage area. When a property is stored in a text file, only a few kilobytes (KB) of data is written. However, when properties are stored in an Office file, the whole Office file is rewritten. This behavior exhausts the VSS storage space much faster.

If the **Maximum Shadow Copy Storage Space** size allocation is insufficient to store all these changes, VSS automatically deletes the oldest shadow copies first. If a large block of files is classified, this process can fail and at the same time delete all the old shadow copies from the storage area. This is especially true when you perform a full classification on a volume for the first time. This action is very likely to generate lots of changes on that volume.

## Resolution

To resolve this issue, use one of the following methods:

### Increase storage area size

Before you run a full classification of a volume for the first time, increase the maximum storage area size. To do this, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, and then right-click **Command Prompt**.
2. Click **Run as administrator**.

    If you're prompted for an administrator password, type the password. If you're prompted for confirmation, click **Continue**.
3. At the command prompt, type the following command, and then press ENTER:

    ```console
     vssadmin list shadowstorage /for=Volume_Letter:
    ```

4. Note the **Maximum Shadow Copy Storage Space** value.
5. At the command prompt, type the following command, and then press ENTER:

    ```console
    vssadmin resize shadowstorage /for=Volume_Letter: /on=Volume_Letter: /maxsize=Storage_Size mb
    ```

    Where the placeholder, **Storage_Size**, is a value that is at least double the value that you noted in step 4.
6. Close the Command Prompt window.

### Incremental classification

When you perform a classification for the first time, classify only one namespace at a time. Don't classify all the namespaces in the same classification job.

### Disable Shadow Copies

You can disable shadow copies on the volume. We don't recommend that you disable shadow copies on the volume. Only use this method if you can't allocate more storage for shadow copies and the incremental classification method still exceeds the storage area allocation.

To disable shadow copies for a volume, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Share and Storage Management**.

2. In the details pane, click the **Volumes** tab.

3. Right-click the volume for which you want to disable shadow copies, and then click **Properties**.

4. In the **Volume_Name Properties** dialog box, click the **Shadow Copies** tab.

5. Click **Disable**, and then click **Yes**.
