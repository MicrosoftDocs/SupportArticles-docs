---
title: The %TEMP% folder with logon session ID is deleted
description: Discusses an issue in which the %TEMP% folder that includes the logon session ID is deleted in Windows Server that has Desktop Experience installed.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:file-explorer/windows-explorer, csstroubleshoot
---
# %TEMP% folder that includes the logon session ID is deleted unexpectedly

This article provides workarounds for an issue where the *%TEMP%* folder that includes the logon session ID is deleted in Windows Server with Desktop Experience installed.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019  
_Original KB number:_ &nbsp; 4506040

## Symptoms

In Windows Server that has Desktop Experience installed, the *%TEMP%* folder that includes the session ID is deleted if you remain logged on to the computer for more than seven days. Therefore, some applications that have to access *%TEMP%* don't work correctly after that time.

To determine the *%TEMP%* folder path and verify that the folder was deleted, run the following commands. Example output is shown.

```console
C:\Users\Administrator>set TEMP
TEMP=C:\Users\ADMINI~1\AppData\Local\Temp\1
```

```output
C:\Users\Administrator>dir %TEMP%
Volume in drive C has no label.

Volume Serial Number is C861-D3EF

Directory of C:\Users\ADMINI~1\AppData\Local\Temp

File Not Found
```

You don't experience the issue in the following scenarios:

- The *%TEMP%* folder isn't included the logon session ID. For example, `C:\Users\<User Account>\AppData\Local\Temp`.
- *%TEMP%* folder isn't empty.
- Nobody logs on to the server, or any user session is ended within seven days.

## %TEMP% folder is deleted by SilentCleanup (cleanmgr.exe) or Storage Sense (storsvc.exe)

This behavior is by design.

The *%TEMP%* folder is deleted by the **SilentCleanup** task (*cleanmgr.exe*) when the logon session exceeds seven days. **SilentCleanup** is scheduled daily together with Automatic Maintenance.

When Storage Sense (*storsvc.exe*) is enabled, the *%TEMP%* folder may be deleted. Storage Sense is disabled by default, but it may be enabled when the C drive runs out of free space.

To work around this issue, follow these steps:

1. [Remove %TEMP% entry from Folder value (recommended) or modify the LastAccess value](#step-1-remove-temp-entry-from-folder-value-or-modify-lastaccess-value).
2. [Disable Storage Sense (if Storage Sense is enabled)](#step-2-disable-storage-sense-if-storage-sense-is-enabled).
3. [Disable low free disk space warning](#step-3-disable-low-free-disk-space-warning).
4. [Disable Storage Sense by using Group Policy (Windows Server 2022 only)](#step-4-disable-storage-sense-by-using-group-policy-windows-server-2022-only).

## Step 1: Remove %TEMP% entry from Folder value or modify LastAccess value

### Remove %TEMP% entry (recommended)

1. Open **Registry Editor**. Select **Start** > **Run**, type *regedit*, and then select **OK**.
2. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files`

3. Right-click **Folder**, and then select **Modify**.
4. In the **Value data** box, delete the **%TEMP%** entry, and then select **OK**. For example:

    **Value before editing:**  

    `%TEMP%|%WINDIR%\Temp|%WINDIR%\Logs|%WINDIR%\System32\LogFiles`

    **Value after editing:**  

     `%WINDIR%\Temp|%WINDIR%\Logs|%WINDIR%\System32\LogFiles`

5. Exit **Registry Editor**.

> [!NOTE]
> After you make this configuration, you must manually delete the *%TEMP%* folder to avoid exhausting free space.

You can also modify the **LastAccess** value alternatively.

### Modify the LastAccess value

> [!NOTE]
> For Windows Server 2019, install [April cumulative update](https://support.microsoft.com/help/4490481) first, and then follow these steps.

1. Open **Registry Editor**. Select **Start** > **Run**, type *regedit*, and then select **OK**.
2. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files`

3. Right-click **LastAccess**, and then select **Modify**.
4. In the **Value data** box, type a value in days. The default value is **7**. The maximum value that can be set is the number of days from January 1, 1601 to the present.
5. Exit **Registry Editor**.

> [!NOTE]
> After you make this configuration, the **LastAccess** value controls the period during which *cleanmgr.exe* deletes files in all temporary folders. If the **LastAccess** value is set too high, this may exhaust free space.

In addition to the *cleanmgr.exe* settings, make the following settings for Storage Sense.

> [!NOTE]
> After you make the configuration for Storage Sense, be careful not to run out of free space on the C drive.

## Step 2: Disable Storage Sense (if Storage Sense is enabled)

1. Go to **Start** > **Settings** > **System** > **Storage**.
2. Turn off **Storage Sense**.
3. Exit **Settings**.

## Step 3: Disable low free disk space warning

When the C drive runs out of free disk space, Storage Sense may be enabled. You can disable low free disk space warning by using the following steps:

1. Open **Registry Editor**. Select **Start** > **Run**, type *regedit*, and select **OK**.
2. Locate and select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`
3. Go to **Edit**, and select **New** > **DWORD Value**.
4. Enter *NoLowDiskSpaceChecks* and press Enter.
5. Right-click the **NoLowDiskSpaceChecks** value, and select **Modify**.
6. Type *1* in the **Value data** box and select **OK**.
7. Close **Registry Editor**.
8. Restart the computer.

## Step 4: Disable Storage Sense by using Group Policy (Windows Server 2022 only)

For Windows Server 2022, you also need to disable Storage Sense by using Group Policy as follows:

1. Open **Group Policy Editor**. Select **Start** > **Run**, type *gpedit.msc*, and select **OK**.
2. Locate the following policy:

   **Computer Configuration** > **Administrative Templates** > **System** > **Storage Sense**
3. Edit the **Allow Storage Sense** policy to **Disabled**.
4. Close **Group Policy Editor**.

## Reference

For more information about Storage Sense, see [Manage drive space with Storage Sense](https://support.microsoft.com/windows/manage-drive-space-with-storage-sense-654f6ada-7bfc-45e5-966b-e24aded96ad5).
