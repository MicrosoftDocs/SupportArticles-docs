---
title: .NET Framework setup diagnostics
description: Describes the information that may be collected from a computer when you run the Installation Data Collection for Framework and Framework Security updates.
ms.date: 05/11/2020
ms.custom: sap:Installation
ms.reviewer: KelHo
ms.technology: dotnet-installation
---
# .NET Framework setup diagnostics

This article describes the information that may be collected from a computer when running the Installation Data Collection for .NET Framework and .NET Framework security updates.

_Original product version:_ &nbsp; .NET Framework 4.0  
_Original KB number:_ &nbsp; 2681569

## Summary

[Download Microsoft Visual Studio and .NET Framework Log Collection Tool](https://www.microsoft.com/download/details.aspx?id=12493) to collect installation logs. The utility creates a compressed cabinet of all the Visual Studio and .NET Framework logs at `%TEMP%\vslogs.cab`.

The Collection Tool will collect available logs from all Visual Studio 2010 and .NET Framework 4.0 release installations on your computer. If you encounter any setup issues and contact Microsoft Support or Visual Studio on Microsoft Connect, you may need to provide relevant installation logs.

The following files and logs can be collected.

## Registry key files

- HCR_PatchRegistryKey.txt

    HKEY_CLASSES_ROOT registry keys for patches are logged in this file.

- HCR_ProductsRegistryKey.txt

    HKEY_CLASSES_ROOT registry keys for products are logged in this file.

- HKLM_S_1_5_18_PatchRegistryKey.txt

    HKEY_LOCAL_MACHINE registry keys for patches are logged in this file.

## Group Policy Object (GPO) result files

- gpreport.html

    Based on the operating system, information is collected by using the native gpresult.exe, HTML format.

- gpreport.xml

    Based on the operating system, information is collected by using the native gpresult.exe, XML format.

## .NET Framework verification log files

- .NET Framework 1.0.NDPErrorLog
- .NET Framework 1.0.NDPVerifyLog
- .NET Framework 1.1 SP1.NDPErrorLog
- .NET Framework 1.1 SP1.NDPVerifyLog
- .NET Framework 1.1.NDPErrorLog
- .NET Framework 1.1.NDPVerifyLog
- .NET Framework 2.0 SP1.NDPErrorLog
- .NET Framework 2.0 SP1.NDPVerifyLog
- .NET Framework 2.0 SP2.NDPErrorLog
- .NET Framework 2.0 SP2.NDPVerifyLog
- .NET Framework 2.0.NDPErrorLog
- .NET Framework 2.0.NDPVerifyLog
- .NET Framework 3.0 SP1.NDPErrorLog
- .NET Framework 3.0 SP1.NDPVerifyLog
- .NET Framework 3.0 SP2.NDPErrorLog
- .NET Framework 3.0 SP2.NDPVerifyLog
- .NET Framework 3.0.NDPErrorLog
- .NET Framework 3.0.NDPVerifyLog
- .NET Framework 3.5 SP1.NDPErrorLog
- .NET Framework 3.5 SP1.NDPVerifyLog
- .NET Framework 3.5.NDPErrorLog
- .NET Framework 3.5.NDPVerifyLog
- .NET Framework 4 Client.NDPErrorLog
- .NET Framework 4 Client.NDPVerifyLog
- .NET Framework 4 Full.NDPErrorLog
- .NET Framework 4 Full.NDPVerifyLog

## File permissions and system state information

- Output_Permission.txt

    Based on the operating system, information is collected by using the native icacls.exe for the `SystemRoot\assembly` folder.

- System_Information.txt

    Based on the operating system, information is collected by using the native Systeminfo.exe.

## WiCFix logs

- WICFIX_MAIN_Report.xml
- WICFIX_Report(date.and.time).html

The two logs reports on the state of the Windows Installer cache, and includes the following information:

- Machine name
- Missing cache product files (.MSI)
- Missing cache patch files (.MSP)
- Orphaned packages
- Total space (.MSI and .MSP files that can be deleted)
- Total packages installed
- Details on individual packages include:
  - Product Name
  - Package Name
  - Product Code
  - Local Package
  - Publisher
  - URLUpdateInfo
  - URLInfoAbout
  - Help telephone
  - InstallLocation
  - AssignmentType
  - HelpLink
  - InstallDate
  - InstallSource
  - Recommended action required
- Details on individual patches include:
  - Display Named
  - Local Package
  - Patch Last Used Source location
  - PatchPackageName
  - Patch GUID
  - Parent Product Code
  - Parent Product Name
  - Recommended Action Required
