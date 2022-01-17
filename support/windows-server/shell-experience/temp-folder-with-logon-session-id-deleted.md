---
title: The %TEMP% folder with logon session ID is deleted
description: Discusses an issue in which the %TEMP% folder that includes the logon session ID is deleted in Windows Server that has Desktop Experience installed.
ms.date: 1/10/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:file-explorer/windows-explorer, csstroubleshoot
ms.technology: windows-server-shell-experience
---
# %TEMP% folder that includes the logon session ID is deleted unexpectedly

This article provides workarounds for an issue where the `%TEMP%` folder that includes the logon session ID is deleted in Windows Server with Desktop Experience installed.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019  
_Original KB number:_ &nbsp; 4506040

## Symptoms

In Windows Server that has Desktop Experience installed, the `%TEMP%` folder that includes the session ID is deleted if you remain logged on to the computer for more than seven days. Therefore, some applications that have to access `%TEMP%` don't work correctly after that time.

To determine the `%TEMP%` folder path and verify that the folder was deleted, run the following commands. Example output is shown.

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

- The `%TEMP%` folder isn't included the logon session ID. For example, `C:\Users\<User Account>\AppData\Local\Temp`.
- `%TEMP%` folder isn't empty.
- Nobody logs on to the server, or any user session is ended within seven days.

## Cause

This behavior is by design.

The `%TEMP%` folder is deleted by the **SilentCleanup** task (Cleanmgr.exe) when the logon session exceeds seven days. **SilentCleanup** is scheduled daily together with Automatic Maintenance.

To work around this issue, use one of the following methods.

## Workaround 1 (recommended): Remove %TEMP% entry from Folder value

1. Start **Registry Editor**. Select **Start** > **Run**, type *regedit*, and then select **OK**.
1. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files`

1. Right-click **Folder**, and then select **Modify**.
1. In the **Value data** box, delete the **%TEMP%** entry, and then select **OK**. For example:

    **Value before editing:**  

    `%TEMP%|%WINDIR%\Temp|%WINDIR%\Logs|%WINDIR%\System32\LogFiles`

    **Value after editing:**  

     `%WINDIR%\Temp|%WINDIR%\Logs|%WINDIR%\System32\LogFiles`

1. Exit **Registry Editor**.

> [!NOTE]
> After you make this configuration, you must manually delete the `%TEMP%` folder to avoid exhausting free space.

## Workaround 2: Modify the LastAccess value

> [!NOTE]
> For Windows Server 2019, install [April cumulative update](https://support.microsoft.com/help/4490481) first, and then follow these steps.

1. Start **Registry Editor**. Select **Start** > **Run**, type *regedit*, and then select **OK**.
1. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files`

1. Right-click **LastAccess**, and then select **Modify**.
1. In the **Value data** box, type a value in days. The default value is **7**. The maximum value that can be set is the number of days from January 1, 1601 to the present.
1. Exit **Registry Editor**.

> [!NOTE]
> After you make this configuration, the **LastAccess** value controls the period during which Cleanmgr.exe deletes files in all temporary folders. If the **LastAccess** value is set too high, this may exhaust free space.
