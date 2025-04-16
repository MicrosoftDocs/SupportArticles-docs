---
title: Troubleshoot Windows Update Error 0x80070002
description: Learn how to resolve the Windows Update error 0x80070002, which occurs due to missing or corrupt files or incomplete updates.
ms.date: 04/16/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: scotro,mwesley
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---
# Troubleshoot Windows Update error 0x80070002

The Windows Update error 0x80070002 typically occurs because of missing or corrupt files necessary for the update or incomplete previous updates. Understanding the root causes and following the appropriate troubleshooting steps can help resolve this issue effectively.

:::image type="content" source="./media/troubleshoot-windows-update-error-0x80070002/wusa-error-0x80070002.png" alt-text="Screenshot showing the Windows Update error 0x80070002.":::

## Prerequisites

Before proceeding with the troubleshooting steps, ensure you have backed up your operating system (OS) disk. This precautionary step is crucial to prevent data loss during the resolution process.

## Root cause

The error 0x80070002 is primarily caused by missing or corrupt files that are necessary for the update process. This issue can occur due to:

- Incomplete previous updates that left the system in an inconsistent state.
- Missing DLLs or system files in critical directories.
- Registry entries pointing to nonexistent services or files.

## Symptom 1: Security monthly rollup installation failure

If the Security Monthly Rollup fails to install with error 0x80070002, check the **CBS.log** file located at `C:\Windows\Logs\CBS\CBS.log`. You might find entries indicating missing files or services that failed to start.

```output
Info CSI 000000fb Begin executing advanced installer phase 50 (0x00000032) index 0 (sequence 0)
Error CSI 000000fc@2018/9/29:08:45:29.414 (F) Failed in StartService for [30]"clr_optimization_v4.0.30319_32" with error code 2[gle=0x80004005]
Error CSI 000000fd (F) 80070002 [Warning,Facility=FACILITY_NTWIN32,Code=ERROR_FILE_NOT_FOUND] #17049# from Windows::COM::NgenOnlineServiceTickler(...)[gle=0x80070002]
```

Check the directory `C:\Windows\Microsoft.NET\Framework\v4.0.30319` to confirm if it's empty.

:::image type="content" source="./media/troubleshoot-windows-update-error-0x80070002/empty-directory-explorer.png" alt-text="Screenshot showing the empty directory in Windows Explorer." lightbox="./media/troubleshoot-windows-update-error-0x80070002/empty-directory-explorer.png":::

### Resolution: Registry key deletion

[!INCLUDE [Registry alert](../../includes/registry-important-alert.md)]

1. Navigate to the following registry locations:
   - `HKLM\System\CurrentControlSet\services\clr_optimization_v4.0.30319_32`
   - `HKLM\System\CurrentControlSet\services\clr_optimization_v4.0.30319_64`

   :::image type="content" source="./media/troubleshoot-windows-update-error-0x80070002/registry-keys-hklm.png" alt-text="Screenshot showing Registry keys for clr_optimization." lightbox="./media/troubleshoot-windows-update-error-0x80070002/registry-keys-hklm.png":::

2. Back up and delete these registry keys.
3. Attempt to install the update again.

## Symptom 2: Update installation failure

If you encounter error 0x80070002 during update installation, review the **CBS.log** file for entries like the following:

```output
Error CSI 00000e47 (F) STATUS_OBJECT_NAME_NOT_FOUND #13367681# from Windows::Rtl::SystemImplementation::DirectFileSystemProvider::SysCreateFile(flags = (AllowSharingViolation), handle = {provider=NULL, handle=0, name= ("null")}, da = (SYNCHRONIZE|FILE_READ_ATTRIBUTES), oa = @0xa130e9e088->OBJECT_ATTRIBUTES {s:48; rd:NULL; on:[69]"\??\C:\ProgramData\Microsoft\Windows\Start Menu\Programs\System Tools"; a:(OBJ_CASE_INSENSITIVE)}, iosb = @0xa130e9e068, as = (null), fa = 0, sa = (FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_SHARE_DELETE), cd = FILE_OPEN, co = (FILE_SYNCHRONOUS_IO_NONALERT|0x00004000), eab = NULL, eal = 0, disp = Invalid)
```

Verify the existence of the folder `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\System Tools`.

### Resolution: Copy missing folders

Copy the **System Tools** folder from a working machine to the affected machine, ensuring all shortcuts are included.

## Symptom 3: Missing DLLs in C:\Windows\WinSxS

Monthly rollups might fail with error 0x80070002 due to missing DLLs in the Side-by-Side store. Check the **WindowsUpdate.log** and **CBS.log** for missing files like `DWrite.dll` and `FntCache.dll`.

```output
Info CBS Failed to find file: x86_microsoft-windows-directwrite_31bf3856ad364e35_7.1.7601.23545_none_229deeb1ba2a85d3DWrite.dll [HRESULT = 0x80070002 - ERROR_FILE_NOT_FOUND]
```

### Resolution: Restore missing DLLs

1. Identify missing DLLs from the **CBS logs** file.
2. Source these files from a working server and place them in the correct directories. To do so, run the following commands:

   ```console
   takeown /f c:\windows\winsxs
   icacls c:\windows\winsxs /grant administrators:F
   cd c:\windows\winsxs   
   ```

   Then, run the `mkdir` command to create a folder for the missing DLL file. For example, if the file **x86_microsoft-windows-directwrite_31bf3856ad364e35_7.1.7601.23545_none_229deeb1ba2a85d3DWrite.dll** is missing, run the following command:

   ```console
   mkdir x86_microsoft-windows-directwrite_31bf3856ad364e35_7.1.7601.23545_none_229deeb1ba2a85d3
   ```

3. Run the following command to check for corruptions:

   ```console
   DISM.exe /Online /Cleanup-image /Restorehealth
   ```

4. Download and install the standalone package for the Monthly Rollup from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx).

## Symptom 4: Cumulative update rollback

If a cumulative update on Windows Server rolls back after a restart, check the Event Viewer for error 0x80070002 and review the CBS logs for driver update issues.

Here's a sample of the event log:

```output
Log Name: System  
Source: Microsoft-Windows-WindowsUpdateClient  
Date: DD/MM/yyyy hh:ss:ff  
Event ID: 20  
Task Category: Windows Update Agent  
Level: Error  
Keywords: Installation,Installation  
User: SYSTEM  
Computer: <ComputerName>  
Description:  
Installation Failure: Windows failed to install the following update with error 0x80070002: Security Update for Windows (KB4586793).
```

The failure is caused by an issue during update drivers operation. For example, the following **CBS.log** file indicates the `flpydisk.inf` driver is the cause:

```output
Info CBS INSTALL index: 55, phase: 2, result 2, inf: flpydisk.inf
Info CBS Doqe: Failed installing driver updates [HRESULT = 0x80070002 - ERROR_FILE_NOT_FOUND]
```

### Resolution: Import registry keys

To fix the issue, you need to export the registry keys for the driver on a working computer, and then import them on the computer with the issue.

The resolution depends on what is missing. For example, to fix the issue with `flpydisk.inf`, which is listed as an example in the symptom section, export and import the following two registry keys.

- `HKLM\System\CurrentControlSet\Services\flpydisk`
- `HKLM\System\CurrentControlSet\Services\sfloppy`

## Symptom 5: Windows upgrade failure

For Windows upgrade failures with error 0x80070002, examine the **Setupact.log** file for issues related to mounting WIM files.

```output
Warning SP Failed to get WimMount ImagePath, 0x80070002
Error SP CMountWIM::DoExecute: Failed to mount WIM file C:\$WINDOWS.~BT\Sources\SafeOS\winre.wim. Error 0xC1420121[gle=0xc1420121]
```

### Resolution: Restore WIMMOUNT.sys

Export `WIMMOUNT.sys` from the location `%SystemRoot%\system32\drivers\wimmount.sys` and the registry `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Wimmount` on a working server. Then, merge them on the affected server.

## Next steps

After resolving the issue, ensure that your system is up to date with the latest updates and patches. Regularly check for updates to prevent similar issues in the future.
