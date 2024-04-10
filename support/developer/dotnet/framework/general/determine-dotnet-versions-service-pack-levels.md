---
title: .NET Framework versions and service pack levels
description: This article describes how to determine which versions of the .NET Framework are installed on a computer, and helps you determine which .NET Framework service packs have been applied.
ms.date: 05/06/2020
ms.topic: how-to
---
# Determine which versions and service pack levels of .NET Framework are installed

This article helps you determine which version and service pack level of the Microsoft .NET Framework are installed.

_Original product version:_ &nbsp; .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 318785

## Use registry keys

Use the registry information below to determine which version(s) and service pack level(s) of the .NET Framework are installed.

To do it, following the steps below:

1. Click **Start**, type _regedit_ in the **Search programs and files** box (click **Run** and type *regedit* in the **Run** dialog box in Windows XP), and then press Enter.
2. In the Registry Editor, locate the registry key name listed in the **Registry keys for different .NET Framework and service packs** section below, and check the value for the related .NET Framework.

    :::image type="content" source="./media/determine-dotnet-versions-service-pack-levels/registry-editor.png" alt-text="Check the registry key in Registry Editor.":::

### Registry keys for different .NET Framework and service packs

|.NET Framework|Service Pack Level|Registry Key Name|Value|
|---|---|---|---|
|4.6.2|Original Release|<ul><li> HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</li><li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</li></ul>|Name: Release <br/>Type: REG_DWORD<br/>Data:<ul><li>On Windows 10 Anniversary Update: 394802</li><li>On all other OS versions: 394806</li></ul>|
|4.6.1|Original Release|<ul><li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</li> <li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</li> </ul>|Name: Release<br/>Type: REG_DWORD<br/> Data: <ul><li>On Windows 10 November Update systems: 394254 </li> <li>On all other OS versions: 394271</li> </ul>|
|4.6|Original Release| <ul><li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</li> <li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</li> </ul>|Name: Release<br/> Type: REG_DWORD<br/>Data: <ul><li>On Windows 10 systems: 393295</li> <li>On all other OS versions: 393297</li> </ul>|
|4.5.2|Original Release|<ul><li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</li> <li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</li> </ul>|Name: Release<br/>Type: REG_DWORD<br/>Data: 379893|
|4.5.1|Original Release|<ul><li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</li> <li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</li> </ul>|Name: Release<br/>Type: REG_DWORD<br/>Data:<ul><li>On Windows 8.1 or Windows Server 2012 R2: 378675 </li> <li>On Windows 8, Windows 7 SP1, or Windows Vista SP2: 378758</li> </ul>|
|4.5|Original Release|<ul><li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</li> <li>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</li> </ul>|Name: Release<br/> Type: REG_DWORD<br/> Data: 378389|
|4 - Client|Original Release|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client|Name: Install<br/>Type: REG_DWORD<br/>Data: 1|
|||HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client|Name: Version<br/>Type: REG_SZ<br/>Data: 4.0.30319.0 |
|4 - Full|Original Release|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full|Name: Install<br/>Type: REG_DWORD<br/>Data: 1 |
|||HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full|Name: Version<br/>Type: REG_SZ<br/>Data: 4.0.30319.0 |
|3.5|Original Release|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5|Name: Install<br/>Type: REG_DWORD<br/>Data: 1 |
|||HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5|Name: SP<br/>Type: REG_DWORD<br/>Data: 0|
|3.5|Service Pack 1|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5|Name: Install<br/> Type: REG_DWORD<br/> Data: 1|
|||HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5|Name: SP<br/>Type: REG_DWORD<br/> Data: 1 |
|3.0|Original Release|Follow the deployment and detection guidance in [Microsoft .NET Framework 3.0 Deployment Guide](/previous-versions/dotnet/articles/aa480173(v=msdn.10)). |
|||HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0|Name: SP<br/>Type: REG_DWORD<br/>Data: 0|
|3.0|Service Pack 1|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0|Name: Install<br/>Type: REG_DWORD<br/>Data: 1|
|||HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0|Name: SP<br/>Type: REG_DWORD<br/> Data: 1|
|3.0|Service Pack 2|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0|Name: Install<br/> Type: REG_DWORD<br/> Data: 1|
|||HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0|Name: SP<br/> Type: REG_DWORD<br/> Data: 2|
|2.0|Original Release|HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|Name: Install<br/> Type: REG_DWORD<br/>Data: 1|
|||HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|Name: SP<br/>Type: REG_DWORD<br/> Data: 0|
|2.0|Service Pack 1|HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|Name: Install<br/> Type: REG_DWORD<br/> Data: 1|
|||HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|Name: SP<br/> Type: REG_DWORD<br/> Data: 1|
|2.0|Service Pack 2|HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|Name: Install<br/> Type: REG_DWORD<br/> Data: 1|
|||HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|Name: SP<br/> Type: REG_DWORD<br/> Data: 2|
|1.1 (on 32-bit operating systems)|Original Release|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322|Name: Install<br/> Type: REG_DWORD<br/> Data: 1|
|||HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322|Name: SP<br/> Type: REG_DWORD<br/> Data: 0|
|1.1 (on 32-bit operating systems)|Service Pack 1|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322|Name: Install<br/> Type: REG_DWORD<br/>Data: 1|
|1.1 (on 64-bit operating systems)|Original Release|HKLM\SOFTWARE\Wow6432Node\Microsoft\NET Framework Setup\NDP\v1.1.4322|Name: Install<br/> Type: REG_DWORD<br/> Data: 1|
|||HKLM\SOFTWARE\Wow6432Node\Microsoft\NET Framework Setup\NDP\v1.1.4322|Name: SP<br/> Type: REG_DWORD<br/> Data: 0|
|1.1 (on 64-bit operating systems)|Service Pack 1|HKLM\SOFTWARE\Wow6432Node\Microsoft\NET Framework Setup\NDP\v1.1.4322|Name: Install<br/> Type: REG_DWORD<br/> Data: 1|
|||HKLM\SOFTWARE\Wow6432Node\Microsoft\NET Framework Setup\NDP\v1.1.4322|Name: SP<br/> Type: REG_DWORD<br/> Data: 1|
|1.0 (on supported platforms except for Windows XP Media Center and Tablet PC)|Original Release|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{78705f0d-e8db-4b2d-8193-982bdda15ecd}|Name: Version<br/> Type: REG_SZ<br/> Data: 1.0.3705.0 |
|1.0 (on supported platforms except for Windows XP Media Center and Tablet PC)|Service Pack 1|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{78705f0d-e8db-4b2d-8193-982bdda15ecd}|Name: Version<br/>Type: REG_SZ<br/> Data: 1.0.3705.1 |
|1.0 (on supported platforms except for Windows XP Media Center and Tablet PC)|Service Pack 2|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{78705f0d-e8db-4b2d-8193-982bdda15ecd}|Name: Version<br/> Type: REG_SZ<br/> Data: 1.0.3705.2 |
|1.0 (on supported platforms except for Windows XP Media Center and Tablet PC)|Service Pack 3|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{78705f0d-e8db-4b2d-8193-982bdda15ecd}|Name: Version<br/> Type: REG_SZ<br/> Data: 1.0.3705.3 |
|1.0 (shipped with Windows XP Media Center 2002/2004 and Tablet PC 2004)|Service Pack 2|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{FDC11A6F-17D1-48f9-9EA3-9051954BAA24}|Name: Version<br/> Type: REG_SZ<br/> Data: 1.0.3705.2 |
|1.0 (shipped with Windows XP Media Center 2005 and Tablet PC 2005)|Service Pack 3|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{FDC11A6F-17D1-48f9-9EA3-9051954BAA24}|Name: Version<br/> Type: REG_SZ<br/> Data: 1.0.3705.3 |
  
## Recommended deployment detection

To detect the existence of a specific .NET Framework version regardless of the service pack level, or to detect a service pack level or a later service pack level of the same .NET Framework version, use the registry information that is listed in the following table.

|.NET Framework| Service Pack Level| Registry Key Name|Value|
|---|---|---|---|
|4 - Client| Any Version|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client|Install = 1|
|4 - Full| Any Version|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full|Install = 1|
|3.5| Any Version|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5|Install = 1|
|3.5| Service Pack 1 or Greater|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5|SP >=1|
|3.0| Any Version|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0|Install = 1|
|3.0| Service Pack 1 or Greater|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0|SP >= 1|
|3.0| Service Pack 2 or Greater|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0|SP >= 2|
|2.0| Any Version|HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|Install = 1|
|2.0| Service Pack 1 or Greater|HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|SP >= 1|
|2.0| Service Pack 2 or Greater|HKEY_LOCAL_MACHINE\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727|SP >= 2|
|1.1| Any Version|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322|Install = 1|
|1.1| Service Pack 1 or Greater|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322|SP >= 1|
|1.0| Any Version|HKEY_LOCAL_MACHINE\Software\Microsoft\\.NET Framework\Policy\v1.0|Name: 3705, Type: REG_SZ, exists|
|1.0 (on supported platforms except for Windows XP Media Center and Tablet PC)| Service Pack 1 or Greater|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{78705f0d-e8db-4b2d-8193-982bdda15ecd}|Version >= 1.0.3705.1|
|1.0 (on supported platforms except for Windows XP Media Center and Tablet PC)| Service Pack 2 or Greater|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{78705f0d-e8db-4b2d-8193-982bdda15ecd}|Version >= 1.0.3705.2|
|1.0 (on supported platforms except for Windows XP Media Center and Tablet PC)| Service Pack 3 or Greater|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{78705f0d-e8db-4b2d-8193-982bdda15ecd}|Version >= 1.0.3705.3|
|1.0 (shipped with Windows XP Media Center 2002/2004 and Tablet PC 2004)| Service Pack 2 or Greater|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{FDC11A6F-17D1-48f9-9EA3-9051954BAA24}|Version >= 1.0.3705.2|
|1.0 (shipped with Windows XP Media Center 2005 and Tablet PC 2005)| Service Pack 3 or Greater|HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\\{FDC11A6F-17D1-48f9-9EA3-9051954BAA24}|Version >= 1.0.3705.3|
  
## References

- [How to: Determine which .NET Framework versions are installed](/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed)

- [Benefits of the Microsoft .NET Framework](https://support.microsoft.com/help/829019)

- [Microsoft Lifecycle Policy](/lifecycle/)

- [Windows registry information for advanced users](https://support.microsoft.com/help/256986)
