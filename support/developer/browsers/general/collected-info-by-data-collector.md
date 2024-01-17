---
title: Internet Explorer data collector collected data
description: Provides the information that's collected by the Internet Explorer Data Collector and the interactive troubleshooting tasks performed in Internet Explorer 9.
ms.date: 04/21/2020
ms.reviewer: louiss
---
# Information collected by Internet Explorer Data Collector

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes the information that may be collected from a computer when running Internet Explorer Diagnostics for Windows Client and Server as well as a description of the Interactive troubleshooting tasks performed.

When first launching the Internet Explorer Data collector, the user will select either the **Internet Explorer Data Collector** option or the **Internet Explorer Troubleshooting Tasks** option.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2547207

## Collected information when the Internet Explorer Data Collector option is selected

When selecting the **Internet Explorer Data Collector** option, the following information is collected:

### Operating System

* Machine Name
* OS Name
* Last Reboot/Uptime
* AntiMalware
* User Account Control
* Username

### Computer System

* Computer Model
* Processor(s)
* Machine Domain
* Role

### Environment Variables

|Description|File Name|
|-|-|
|Elevated User:|{Computername}_EnvironmentVariables_MSDT.txt|
|Target User:|{Computername}_EnvironmentVariables_{Username}.txt|
  
### Event Logs

|Description|File Name|
|-|-|
|Filtered Event Logs (.csv):|{Computername}_ApplicationLog.csv|
|Filtered Event Logs (.csv):|{Computername}_SystemLog.csv|
  
### Group Policy and IEAK

|Description|File Name|
|-|-|
|IEAK Logs (.zip):|{Computername}_{Username}_IEAK_Brand.zip|
|HKU:|{Computername}_{Username}_HKU_Policies.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Policies.TXT|
|HKLM:|{Computername}_reg_HKLM_Policies.TXT|
|HKU:|{Computername}_{Username}_HKU_GPHistory.TXT|
|HKLM:|{Computername}_reg_HKLM_GPHistory.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow3264Node_GPHistory.TXT|
|HKLM:|{Computername}_reg_HKLM_GPExtensions.TXT|
|HKLM:|{Computername}_reg_HKLM_CurrentVersion_Polcies.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow3264Node_CurrentVersion_Polcies.TXT|
|SysVol Package:|{Computername}_{Username}_IE_GP_SysVol.zip|
|SysVol Log:|{Computername}_{Username}_IE_GP_SysVol.txt|
|GP User (.txt):|{Computername}_GPResult_User_{Username}.txt|
|GP User (.htm):|{Computername}_GPResult_User_{Username}.htm|
|GP Computer (.txt):|{Computername}_GPResult_Computer.txt|
|GP Computer (.htm):|{Computername}_GPResult_Computer.htm|
  
### Hardware:DXDiag

|Description|File Name|
|-|-|
|DXDiag:|{Computername}_DXDiag.txt|
  
### IEDiag

|Description|File Name|
|-|-|
|IEDiagcmd:|{Computername}_IEDiag.cab|
  
### Internet Explorer Setup Log

|Description|File Name|
|-|-|
| Internet Explorer Setup Log (.log):|{Computername}_IE9_main.log|
  
### Installed updates/hotfixes

|Description|File Name|
|-|-|
|Update/Hotfix history:|{Computername}_Hotfixes.CSV|
|Update/Hotfix history:|{Computername}_Hotfixes.htm|
|Update/Hotfix history:|{Computername}_Hotfixes.TXT|
  
### Internet Explorer Core

|Description|File Name|
|-|-|
|HKU:|{Computername}_{Username}_HKU_InternetExplorer.txt|
|HKU:|{Computername}_{Username}_HKU_InternetSettings.txt|
|HKU:|{Computername}_{Username}_HKU_FTP.txt|
|HKU:|{Computername}_{Username}_HKU_FeatureControl.|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_InternetExplorer.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_InternetSettings.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_FeatureControl.TXT|
|HKLM:|{Computername}_reg_HKLM_InternetSettings.TXT|
|HKLM:|{Computername}_reg_HKLM_FeatureControl.TXT|
  
### Internet Explorer File Versions

|Description|File Name|
|-|-|
|Version Info:|{Computername}_IE_File_Version_Info.txt|
  
### Internet Explorer Zones

|Description|File Name|
|-|-|
|HKU:|{Computername}_{Username}_HKU_Zones_ZoneMap.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_0_YourComputer.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_1_LocalIntranet.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_2_TrustedSites.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_3_Internet.txt|
|HKU:|{Computername}_{Username}_HKU_Zones_4_RestrictedSites.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_0_YourComputer.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_1_LocalIntranet.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_2_TrustedSites.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_3_Internet.txt|
|HKU:|{Computername}_{Username}_HKU_LockedDown_Zones_4_RestrictedSites.txt|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_ZoneMap.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_0_YourComputer.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_1_LocalIntranet.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_2_TrustedSites.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_3_Internet.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_Zones_4_RestrictedSites.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_0_YourComputer.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_1_LocalIntranet.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_2_TrustedSites.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_3_Internet.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_LockedDown_Zones_4_RestrictedSites.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_High.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_Low.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_MedHigh.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_Medium.TXT|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_TemplatePolicies_MedLow.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_ZoneMap.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_0_YourComputer.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_1_LocalIntranet.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_2_TrustedSites.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_3_Internet.TXT|
|HKLM:|{Computername}_reg_HKLM_Zones_4_RestrictedSites.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_0_YourComputer.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_1_LocalIntranet.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_2_TrustedSites.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_3_Internet.TXT|
|HKLM:|{Computername}_reg_HKLM_LockedDown_Zones_4_RestrictedSites.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_High.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_Low.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_MedHigh.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_Medium.TXT|
|HKLM:|{Computername}_reg_HKLM_TemplatePolicies_MedLow.TXT|
  
### Networking Information

|Description|File Name|
|-|-|
|Host File:|{Computername}_hosts|
|TCP/IP Basic Information:|{Computername}_TcpIp-Info.txt|
|SMB Basic Information:|{Computername}_SMB-Info.txt|
  
### Operating System Registry

|Description|File Name|
|-|-|
|HKU:|{Computername}_{Username}_HKU_ActiveSetup_All.txt|
|HKU Wow64:|{Computername}_{Username}_HKU_ActiveSetup_ALL_Wow6432Node.txt|
|HKU:|{Computername}_{Username}_HKU_Wintrust.txt|
|HKU:|{Computername}_{Username}_HKU_Ext_Settings.txt|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_ActiveSetup_All.TXT|
|HKLM:|{Computername}_reg_HKLM_Wow6432Node_ActiveX_Compatibility.TXT|
|HKLM:|{Computername}_reg_HKLM_ActiveSetup_All.TXT|
|HKLM:|{Computername}_reg_HKLM_ActiveX_Compatibility.TXT|
|HKLM:|{Computername}_reg_HKLM_Wow6432Node_Classes_Protocols.TXT|
|HKLM:|{Computername}_reg_HKLM_Wow6432Node_Code_Store_Database.TXT|
|HKLM:|{Computername}_reg_HKLM_Wow6432Node_Ext_PreApproved.TXT|
|HKLM:|{Computername}_reg_HKLM_Classes_Mime_Database_Content_Type.TXT|
|HKLM:|{Computername}_reg_HKLM_Classes_Protocols.TXT|
|HKLM:|{Computername}_reg_HKLM_SecurityProviders.TXT|
|HKLM:|{Computername}_reg_HKLM_AEDebug.TXT|
|HKLM:|{Computername}_reg_HKLM_Image_File_Execution_Options.TXT|
|HKLM:|{Computername}_reg_HKLM_Fips_Algorithm_Policy.TXT|
|HKLM:|{Computername}_reg_HKLM_KERB_MaxTokenSize.TXT|
|HKLM:|{Computername}_reg_HKLM_SSL_Ciphers.TXT|
|HKLM:|{Computername}_reg_HKLM_Code_Store_Database.TXT|
|HKLM:|{Computername}_reg_HKLM_Ext_PreApproved.TXT|
  
### REG Export

|Description|File Name|
|-|-|
|HKU:|{Computername}_{Username}_HKU_Internet_Explorer.REG.txt|
|HKU:|{Computername}_{Username}_HKU_Internet_Settings.REG.txt|
|HKU:|{Computername}_{Username}_HKU_Policies.REG.txt|
|HKLM:|{Computername}_{Username}_HKU_Classes.REG.txt|
|HKLM:|{Computername}_HKLM_Internet_Explorer.REG.txt|
|HKLM:|{Computername}_HKLM_Internet_Settings.REG.txt|
|HKLM:|{Computername}_HKLM_Policies.REG.txt|
|HKLM Wow64:|{Computername}_HKLM_Wow6432Node_Internet_Explorer.REG.txt|
|HKLM Wow64:|{Computername}_HKLM_Wow6432Node_Internet_Settings.REG.txt|
|HKLM Wow64:|{Computername}_HKLM_Wow6432Node_Policies.REG.txt|
|HKLM Wow64:|{Computername}_HKLM_Wow6432Node_Classes.REG.txt|
  
### Registry - IEAK

|Description|File Name|
|-|-|
|HKLM Wow64:|{Computername}_reg_HKLM_Wow6432Node_IEAK.TXT|
  
### Windows Setup API Logs

|Description|File Name|
|-|-|
|Windows Setup API Log:|{Computername}_SetupAPI.app.Log|
  
### Windows update log

|Description|File Name|
|-|-|
|Windows Update Log File:|{Computername}_WindowsUpdate.log|
  
## Available tasks and collected information when the Internet Explorer Troubleshooting Tasks option is selected

When the user selects the **Internet Explorer Troubleshooting Tasks** option, the following tasks are available:

### Strace

This task will install STRACE to collect the HTTP HTTPS traffic between this client and a webserver. You will be prompted to uninstall STRACE upon completion of the task.

During this collection, the Temporary Internet Files Cache will be cleared to ensure the collection contains all request between the webserver and this client.

STRACE is a socket/SSL tracer that is based on the 'detours' utility. The tool has been designed to generate LOG for Internet Explorer but it can be used with many other applications.

Using STRACE with Internet Explorer is equivalent to use a (non-full) debug build of WININET.DLL to generate a WININET LOG. The STRACE LOG contains clear text HTTP traffic (with socket information) and encrypted or decrypted SSL data.

From the STRACE LOG, you can 'replay' a full navigation scenario using the HTTPREPLAY tool. This can be useful to reproduce a problem or browse web sites offline.

#### Data collected

_Strace network logs_

|Description|File Name|
|-|-|
|Strace Logs (.strace):|STRACE_IEXPLORE_PID_{ProcessID}_{date}_{time}.STRACE|
  
### ProcDump a process

This task will allow you to collect process dump of Internet Explorer or any other process.

* If you select the **hang** option, ProcDump will collect dumps of the process you select.

* If you select the **crash** option, Procdump will monitor the process you select for an expected crash.

* If you select the **highcpu** option, Procdump will monitor the process you select and once the CPU utilization exceeds 30% for more than 10 seconds a process dump will be collected. Procdump will continue to monitor the process and collect two additional process dumps for a total of three dumps each 10 seconds apart.

  > [!NOTE]
  > The process must exceed the 30% threshold for 10 seconds otherwise the dump will not be collected. See [ProcDump v9.0](/sysinternals/downloads/procdump) for details on Procdump.

#### Data collected

_Memory Dump Files_

|Description|File Name|
|-|-|
|Hangdump file(.out):|{computername}_{processname}.out|
|MemoryDump Files:|{computername}_DumpFile_Information.txt|
|MemoryDump Files:|{computername}_{processname}_{date}_{time}.zip|
  
### Internet Explorer WPAD

* Prompt to choose the affected user

* Prompt for user credentials

* Clear Temporary Internet Files on Internet Explorer 7 and newer, delete .pac/.dat files on Internet Explorer 6

* Start network trace (NetSh for Win7/2k8r2, NMCap for Vista/2k8, NetCap for XP 2k3)
  > [!NOTE]
  > It will prompt and open browser to NM3.4 download on Vista/2k8 if not already installed.

* Prompt that includes information on the deletion of the contents of Internet Explorer Connections registry keys

* Save connections keys to user's desktop.

* Delete Connections key contents under HKCU, HKLM and under the `Wow6432Nodes` keys for HKCU and HKLM if they exist.

* Release and renew IP address

* Launch Internet Explorer as selected user

* Stop and collect network traces. For more information on what is collected by the Internet Explorer WPAD task, see the Internet Explorer WPAD SDP [KB2668985](https://support.microsoft.com/help/2668985).

### Internet Explorer Simultaneous Fiddler and Netmon

The Internet Explorer Simultaneous Fiddler and Netmon data collection will perform the following items.

User dialog prompt to choose data collection options including:

* Initial address for Internet Explorer to access upon launch
* Select affected user
* Run Internet Explorer as selected user
* Collect Network Monitor trace
* Collect Fiddler trace
* Clear Temporary Internet Files
* Set `TabProcGrowth` to **0** for testing
* Reset Connection settings:

  * Prompt that includes information on the deletion of the contents of Internet Explorer Connections registry keys.

  * Save connections keys to user's desktop.

  * Delete Connections key contents under HKCU, HKLM and under the `Wow6432Nodes` keys for HKCU and HKLM if they exist.

* Release and renew the IP address
* Launch Internet Explorer without extensions (`-extoff`)

Upon acceptance of the dialog, Internet Explorer will launch to the specified address.

At this time reproduce the issue and upon closing Internet Explorer tracing will stop, TabProcGrowth, and proxy settings will be restored. The Fiddler trace, Network Monitor trace, and any log files associated with the tracing will be collected.

#### Data collected

_Autoproxy Files_

|Description|File Name|
|-|-|
|Autoproxy File:|{computername}_{username}_Autoproxy_file_log__Date_{date}_{time}.txt|
  
_Fiddler Capture_

|Description|File Name|
|-|-|
|Fiddler Capture File \[Password Protected](.zip):|{computername}_{username}_Fiddler__Date_{date}_{time}.zip|
  
_Network Trace_

|Description|File Name|
|-|-|
|NMCap Trace Log:|{computername}_{username}_NMcap_Trace_DisplayNet__Date_{date}_{time}.txt|
|Network Monitor trace file:|{computername}_{username}_NMcap_Date_{date}_{time}.cap|
  
### Generate an AXIS log (Windows Vista+)

This task will allow you to collect an installation log during attempts to install an `ActiveX` control via the ActiveX Installer Service.

See [Implementing and Administering the ActiveX Installer Service](/previous-versions/windows/it-pro/windows-vista/cc721964(v=ws.10)) for details on the ActiveX Installer Service.

#### Data collected

_AxtiveX Installer Service Logging_

|Description|File Name|
|-|-|
|AXIS Event Log:|{computername}_Run_Date_{month}_{day}_{year}_Time_{time}_AxisServiceLog.evt|
  