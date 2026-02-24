---
title: 0x80070003 Error and Windows Upgrade Fails During Process Drivers for Migration Operation
description: Discusses how to resolve the "0x80070003" error during the "Process Drivers for Migration" operation of an in-place upgrade of Windows or Windows Server.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-appelgatet
ms.custom:
- sap:windows setup, upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# "0x80070003" error and Windows upgrade fails during "Process Drivers for Migration"

This article discusses how to resolve issues that cause a "0x80070003" error to occur during the "Process Drivers for Migration" operation of an in-place upgrade of Windows or Windows Server.

## Symptoms

When you try to upgrade a Windows Server-based or Windows Client-based computer to a newer version of the operating system (an *in-place upgrade*), the upgrade process fails. When this error occurs, the upgrade process generates a "0x80070003" error.

## Cause

The contents of a servicing stack folder in the WinSxS system folder are missing or damaged. Without the information in this folder, DISM and the upgrade engine can't migrate drivers. The upgrade fails and generates a "0x80070003" error.

## Resolution

> [!IMPORTANT]  
> Before you perform any upgrade operation, back up your system.

### Step 1: Verify the issue

To gather additional information about the issue, examine the relevant logs. You can use a text editor, such as Notepad, to view the log files. Use the **Find** command (CTRL+F) to search for specific strings, as noted. The following tables list the most useful log files. They also list the strings in each file that might provide more information about the error.

| Log files | Location | Description |
| - | - | - |
| SetupAct.log | C:\$WINDOWS.~BT\Sources\Panther | This log records setup activity during the early phase of the upgrade process. |
| Upgrade engine (MOUPG) logs<br />such as the following files:<ul><li>setuperr.log</li><li>setupdiagresults.xml</li><li>Other logs whose file name begins with "MOSetup" or "MOU."</li></ul> | C:\$WINDOWS.~BT\Sources\Panther | These logs show high-level upgrade decisions and phase transitions. |
| DISM.log | C:\Windows\Logs\DISM | This log provides details when DISM (Deployment Image Servicing and Management) commands fail. |
| CBS.log (Component-Based Servicing log) | C:\Windows\Logs\CBS | Windows uses CBS logs to track servicing operations, such as updates and upgrades.<Br /><Br />**Note:** If this file is large, it might be easier to manage by using an alternative text editor, such as Notepad ++. |

| Log files | Strings to search for |
| - | - |
| SetupAct.log | "0x80070003"<br />or text that resembles the following strings:<ul><li>"Failed to open new session: (DISM_{GUID})"</li><li>"Operation failed: Process Drivers for Migration. Error: 0x80070003"</li></ul> |
| MOUPG logs | Text that resembles the following strings:<ul><li>"MoSetupPlatform: Using action error code: [0x80070003]"</li><li>"CDlpActionDriverMigrate::ExecuteRoutine: Result = 0x80070003"</li><li>"Setup phase change: \[SetupPhaseInstall] -> \[SetupPhaseError]"</li></ul> |
| DISM.log | "0x80070003"<br />or text that resembles "Failed to bind the online servicing stack - CDISMOSServiceManager::get_ServicingStackDirectory(hr:0x80070003)" |
| CBS.log | "Failed to create worker session"<br />or repeated strings that mention servicing failures |

Additionally, you can manually check for a damaged servicing stack folder. In the C:\Windows\WinSxS folder, look for at least one folder that has name that includes the "serviceingstack" string. For example, you might find folders that have names that resemble the following strings:

- amd64_microsoft-windows-servicingstack_31bf3856ad364e35_10.0.26100.5074_none_a5532eb7772ad4c4
- amd64_microsoft-windows-servicingstack-inetsrv_31bf3856ad364e35_10.0.26100.5074_none_d120fd2616d820ec
- amd64_microsoft-windows-servicingstack-onecore_31bf3856ad364e35_10.0.26100.5074_none_da44c3c8cf2df25a
- x86_microsoft-windows-servicingstack_31bf3856ad364e35_10.0.26100.5074_none_49349333becd638e
- x86_microsoft-windows-servicingstack-inetsrv_31bf3856ad364e35_10.0.26100.5074_none_750261a25e7aafb6
- x86_microsoft-windows-servicingstack-onecore_31bf3856ad364e35_10.0.26100.5074_none_7e26284516d08124

Such folders shouldn't be empty.

### Step 2: Download and extract files from the latest SSU

1. On the affected computer, open an administrative Command Prompt window, and then run the following command:

   ```console
   reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Version"
   ```

   The command output confirms the current version of the servicing stack on the computer.

1. On the affected computer, create a temporary folder (for example, C:\TemporaryFolder).

1. Download the latest Servicing Stack Update (SSU) for your Windows version from [Servicing Stack Updates (SSU): Frequently Asked Questions](https://support.microsoft.com/topic/servicing-stack-updates-ssu-frequently-asked-questions-06b62771-1cb0-368c-09cf-87c4efc4f2fe).

1. Extract the update files from the .msu package to the temporary folder. For example, run the following command at the command prompt:

   ```console
   expand -F:* C:\<Path>\update.msu C:\TemporaryFolder
   ```

   > [!NOTE]  
   > In this command, \<Path> represents the path to the .msu package.

### Step 3: Replace the corrupted files

> [!Caution]  
>
> - Do not take ownership of the WinSxS folder or its subfolders, and do not change the folder permissions.
> - This procedure uses the `robocopy /B` command to replace the servicing stack folders in the WinSxS folder with servicing stack folders from the downloaded SSU. `Robocopy /B` preserves the file and folder permissions.

1. Open an administrative PowerShell window. To define a set of variables for the robocopy operation, run the following commands, in sequence:

   ```powershell
   $src = "C:\TemporaryFolder"
   $dst = "C:\Windows\WinSxS"
   $log = "C:\Repair\WinSxS_Repair.log"

   New-Item -ItemType Directory -Force -Path (Split-Path $log) | Out-Null
   ```

   > [!NOTE]  
   > These commands continue to use the C:\TemporaryFolder folder that was introduced in the previous section. They also introduce a C:\Repair folder to store a log file in.

1. To view a list of the items without actually copying them, run the following command:

   ```powershell
   Get-ChildItem -Path $src -Directory -Force | ForEach-Object {
     & robocopy $_.FullName $dst /E /COPYALL /B /R:0 /W:0 /L /NFL /NDL /NP /NJH /NJS
   }
   ```

   > [!NOTE]  
   >
   > - The `Get-ChildItem -Directory` cmdlet selects only subfolders. Therefore, the robocopy operation skips root-level files, such as .mum and .manifest files.
   > - For more information about the `Get-ChildItem` cmdlet and its options, see [Get-ChildItem](/powershell/module/microsoft.powershell.management/get-childitem).
   > - For more information about the `robocopy` command and its switches, see [robocopy](/windows-server/administration/windows-commands/robocopy).

1. To copy the subfolders and log the operation, run the following command:

   ```powershell
   Get-ChildItem -Path $src -Directory -Force | ForEach-Object {
     & robocopy $_.FullName $dst /E /COPYALL /B /R:0 /W:0 /LOG+:$log
   }
   ```

   As an alternative to the previous steps, you can run the following command at an administrative command prompt:

   ```console
   for /d %i in (C:\TemporaryFolder\*) do robocopy "%i" "C:\Windows\WinSxS" /E /COPYALL /B /R:0 /W:0
   ```

1. After you finish copying the SSU files, try again to upgrade Windows.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
