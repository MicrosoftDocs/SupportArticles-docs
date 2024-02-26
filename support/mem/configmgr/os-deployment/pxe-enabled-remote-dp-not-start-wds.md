---
title: WDS doesn't start on a PXE enabled remote distribution point
description: Fixes an issue in which Windows Deployment Services (WDS) doesn't start on a PXE enabled remote distribution point in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, frankroj
---
# WDS doesn't start on a PXE enabled remote distribution point in Configuration Manager

This article fixes an issue in which Windows Deployment Services (WDS) doesn't start on a PXE enabled remote distribution point in Configuration Manager.

_Original product version:_ &nbsp; System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2712387

## Symptoms

After enabling the PXE feature of a remote Configuration Manager distribution point (DP), Windows Deployment Services (WDS) and PXE install correctly, however WDS never starts. Attempting to manually start WDS via the Services console results in the following error message:

> Windows could not start the Windows Deployment Services Server on Local Computer. For more information, review the System Event Log. If this is a non-Microsoft service, contact the service vendor, or refer to service-specific error code -1056505588.

Looking at the Application System event log on a 64-bit server reveals the following error messages:

> Log Name:&nbsp;&nbsp;&nbsp; Application  
> Source:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SideBySide  
> Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<Date>\<Time>  
> Event ID:&nbsp;&nbsp;&nbsp; 33  
> Task Category: None  
> Level:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error  
> Keywords:&nbsp;&nbsp;Classic  
> User:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N/A  
> Computer:&nbsp;&nbsp;&nbsp;\<Remote_DP_Server>  
> Description:  
> Activation context generation failed for "C:\SMS_DP$\sms\bin\smspxe.dll". Dependent Assembly Microsoft.VC90.CRT,processorArchitecture="amd64",publicKeyToken="1fc8b3b9a1e18e3b",type="win32",version="9.0.30729.4148" could not be found. Please use sxstrace.exe for detailed diagnosis.

> Log Name:&nbsp;&nbsp;&nbsp;Application  
> Source:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WDSPXE  
> Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<Date>\<Time>  
> Event ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 259  
> Task Category: WDSPXE  
> Level:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error  
> Keywords:&nbsp;&nbsp;&nbsp;Classic  
> User:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N/A  
> Computer:&nbsp;&nbsp;&nbsp;&nbsp;\<Remote_DP_Server>  
> Description:  
> An error occurred while trying to load the module from C:\SMS_DP$\sms\bin\smspxe.dll for provider SMSPXE. If the provider is marked as critical, the Windows Deployment Services server will be shutdown.

> Log Name:&nbsp;&nbsp;&nbsp;Application  
> Source:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WDSPXE  
> Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<Date>\<Time>  
> Event ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 264  
> Task Category: WDSPXE  
> Level:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error  
> Keywords:&nbsp;&nbsp;&nbsp;Classic  
> User:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N/A  
> Computer:&nbsp;&nbsp;&nbsp;\<Remote_DP_Server>  
> Description:  
> An error occurred while trying to initialize provider SMSPXE. Since the provider isn't marked as critical, the Windows Deployment Services server will remain started.
>
> Error Information: 0x36B1

> Log Name:&nbsp;&nbsp;&nbsp;Application  
> Source:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WDSPXE  
> Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<Date>\<Time>  
> Event ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 268  
> Task Category: WDSPXE  
> Level:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error  
> Keywords:&nbsp;&nbsp;&nbsp;Classic  
> User:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N/A  
> Computer:&nbsp;&nbsp;&nbsp;\<Remote_DP_Server>  
> Description:  
> All registered providers failed to initialize. Please review the Event Log for specific error messages for each provider. Windows Deployment Server will be shutdown.

> Log Name:&nbsp;&nbsp;&nbsp;Application  
> Source:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WDSServer  
> Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<Date>\<Time>  
> Event ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 513  
> Task Category: WDSServer  
> Level:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error  
> Keywords:&nbsp;&nbsp;&nbsp;Classic  
> User:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N/A  
> Computer:&nbsp;&nbsp;&nbsp;\<Remote_DP_Server>  
> Description:  
> An error occurred while trying to initialize provider WDSPXE from C:\Windows\system32\wdspxe.dll. Windows Deployment Services server will be shutdown.
>
> Error Information: 0xC107010C

> Log Name:&nbsp;&nbsp;&nbsp;Application  
> Source:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WDSServer  
> Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<Date>\<Time>  
> Event ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 257  
> Task Category: WDSServer  
> Level:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error  
> Keywords:&nbsp;&nbsp;&nbsp;Classic  
> User:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N/A  
> Computer:&nbsp;&nbsp;&nbsp;\<Remote_DP_Server>  
> Description:  
> An error occurred while trying to start the Windows Deployment Services server.
>
> Error Information: 0xC107010C

## Cause

This issue can occur when a dependent component, `Microsoft.VC90.CRT`, is not available. This component is normally available via a DLL installed by Microsoft Visual C++ 2008 Redistributable. Microsoft Visual C++ 2008 Redistributable is normally installed during the Configuration Manager client install via the install file **vcredist_x86.exe** or **vcredist_x64.exe**. If the Configuration Manager client has not been installed on the server hosting the PXE enabled remote DP, the Microsoft Visual C++ 2008 Redistributable will also not have been installed and `Microsoft.VC90.CRT` will not be available.

> [!NOTE]
> Microsoft Visual C++ 2008 Redistributable is a common install for many different software install packages. It may be installed on the server even if the Configuration Manager client is not installed on the server.

## Resolution

To resolve the problem, install the Configuration Manager client on the server hosting the PXE enabled remote DP.

If the PXE enabled remote DP server is not going to also be a Configuration Manager client and therefore the Configuration Manager client install is not desired, Microsoft Visual C++ 2008 Redistributable can be installed separately on the server by manually running either **vcredist_x86.exe** (32-bit Windows) **orvcredist_x64.exe** (64-bit Windows) from the Configuration Manager client install files. These install files can be found in the client install directory on the parent primary site server under the following paths:

- vcredist_x86.exe: `<Configuration Manager_2012_Install_Directory>\Client\i386`
- vcredist_x64.exe: `<Configuration Manager_2012_Install_Directory>\Client\x64`

Once the Microsoft Visual C++ 2008 Redistributable has been installed via the Configuration Manager client install or a manual install, manually start WDS via the Services console. WDS should subsequently be able to start automatically.
