---
title: Error 0x800F0818 - 0x20003 Occurs During Upgrade from Windows 10 to Windows 11
description: Provides a solution for error 0x800F0818 - 0x20003. This error occurs on some computers when you upgrade from Windows 10 to Windows 11.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jaysenb, kaushika
ms.custom:
- sap:windows setup,upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

# "0x800F0818 - 0x20003" error during upgrade from Windows 10 to Windows 11

This article provides a solution for an error that occurs on some computers when you upgrade them from Windows 10 to Windows 11.

## Symptoms

You use one of the following systems to service Windows client computers:

- System Center Configuration Manager (SCCM)
- Windows Server Update Services (WSUS)
- Windows Update for Business

A feature update from Windows 10 22H2 to Windows 11 23H2 or 24H2 fails in the Safe_OS phase, and generates error 0x800F0818 - 0x20003. After the failure occurs, the update rolls back.

If you run a diagnostic tool such as [SetupDiag](/windows/deployment/upgrade/setupdiag), the tool returns the same error code.

An error entry is logged in the C:\\$Windows.~BT\\Sources\\Rollback\\setupact_rollback.log file that contains text that resembles the following excerpt:

```output
YYYY-MM-DD HH:MM:SS, Info MOUPG InitializeRoutine: MOSETUP_ACTION_IMAGE_EXIT
YYYY-MM-DD HH:MM:SS, Info MOUPG ImageExit: Initializing SetupResult: [0x800f0818]
YYYY-MM-DD HH:MM:SS, Info MOUPG ImageExit: Initializing Extended: [0x20003]
YYYY-MM-DD HH:MM:SS, Info MOUPG ImageExit: Initializing Scenario: [6]
YYYY-MM-DD HH:MM:SS, Info MOUPG ImageExit: Initializing Mode: [5]
YYYY-MM-DD HH:MM:SS, Info MOUPG ImageExit: Initializing Product: [1]
YYYY-MM-DD HH:MM:SS, Info MOUPG ImageExit: Initializing Target: [C]
YYYY-MM-DD HH:MM:SS, Info MOUPG ImageExit: Initializing SQM: [FALSE]
YYYY-MM-DD HH:MM:SS, Info MOUPG ImageExit: Initializing PostReboot: [TRUE]
```

Additionally, multiple error entries are logged in the C:\\$Windows.~BT\\Sources\\Panther\\setupact.log file. The contents of these entries resemble the following excerpts:

```output
YYYY-MM-DD HH:MM:SS, Info MOUPG SetupHost::Initialize: CmdLine = [/Product Client /PreDownload /Package /Priority Normal /Quiet /ReportId 96CEE****************3-2D4E1B1306F5.1 /FlightData "RS:24944" "/CancelId" "C-757a2**********************4256ca34" "/PauseId" "P-757a20**********************" "/CorrelationVector" "otIKT***B0mTOyAl.1.1.28.4" "/DownloadSizeInMB" "3046" /InstallLangPacks C:\ProgramData\Temp\Inplaceupgrade\W10_22H2\LP /PostOOBE C:\ProgramData\Temp\Inplaceupgrade\W10_22H2\Scripts\SetupComplete.cmd /PostRollback C:\ProgramData\Temp\Inplaceupgrade\W10_22H2\Scripts\ErrorHandler.cmd /DynamicUpdate Disable /Compat IgnoreWarning]
```

```output
YYYY-MM-DD HH:MM:SS, Info MOUPG SetupManager: Copying user-provided langpack package files from [C:\ProgramData\Temp\Inplaceupgrade\W10_22H2\LP] -> [C:\$WINDOWS.~BT\LangPacks\User]...
```

```output
YYYY-MM-DD HH:MM:SS, Info CBS Appl: Evaluating package applicability for package Microsoft-Windows-Xps-Xps-Viewer-Opt-Package~31bf3856ad364e35~amd64~~10.0.22621.1, applicable state: Installed

YYYY-MM-DD HH:MM:SS, Info CBS Package doesn't match FOD for the current OS, package: Microsoft-Windows-LanguageFeatures-Basic-hu-hu-Package~31bf3856ad364e35~amd64~~10.0.19041.1, expected:Microsoft-Windows-LanguageFeatures-Basic-hu-hu-Package~31bf3856ad364e35~amd64~~10.0.22621.1 [HRESULT = 0x800f0818 - CBS_E_IDENTITY_MISMATCH]

YYYY-MM-DD HH:MM:SS, Info CBS Failed to check capability logic [HRESULT = 0x800f0818 - CBS_E_IDENTITY_MISMATCH]
```

## Cause

This issue affects devices that have one of the following histories:

- The device previously received a Windows 10 feature update that used a custom SetupConfig.ini file.
- Earlier updates or upgrades to the device used language packs or post-upgrade scripts that were manually configured or deployed.

The upgrade failed because of a legacy SetupConfig.ini file that contains hard-coded paths to outdated language packs and scripts. Those language packs and scripts aren't compatible with Windows 11. The path to the legacy file typically is C:\Users\Default\AppData\Local\Microsoft\Windows\WSUS\SetupConfig.ini. The contents of the file resemble the following excerpt:

```output
[SetupConfig]
InstallLangPacks=C:\ProgramData\Temp\Inplaceupgrade\W10_22H2\LP
PostOOBE=C:\ProgramData\Temp\Inplaceupgrade\W10_22H2\Scripts\SetupComplete.cmd
PostRollback=C:\ProgramData\Temp\Inplaceupgrade\W10_22H2\Scripts\ErrorHandler.cmd
DynamicUpdate=Disable
```

These outdated references cause identity mismatches during the upgrade process. Therefore, the upgrade fails and rolls back.

## Resolution

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

To remove the legacy information, follow these steps:

1. On the affected computer, open File Explorer, and then go to C:\\Users\\Default\\AppData\\Local\\Microsoft\\Windows\\WSUS\\.
   > [!NOTE]  
   > If you can't see the AppData folder, select **View** > **Show**, then select **Hidden items** to view hidden files and folders.

1. Delete the SetupConfig.ini file.

1. Open Registry Editor, and then go to the `HKEY_LOCAL_MACHINE\SYSTEM\Setup` subkey.

1. Delete the `UnattendFile` registry entry.

## More information

- [SetupDiag](/windows/deployment/upgrade/setupdiag)
- [Resolve Windows upgrade errors: Technical information for IT Pros](/windows/deployment/upgrade/resolve-windows-upgrade-errors)
- [Windows upgrade log files](/windows/deployment/upgrade/log-files)
