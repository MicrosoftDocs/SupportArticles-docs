---
title: Outlook Support Diagnostic
description: This Support Diagnostics Platform (SDP) manifest file collects configuration settings, registry keys, client networking configuration information, event logs, and important file details that are used by the following Microsoft Office applications.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 01/30/2024
---
# [SDP 3][2c425a45-1620-42a4-ae4d-63b453394935] Microsoft Outlook Support Diagnostic

_Original KB number:_ &nbsp; 2680810

## Summary

This Support Diagnostics Platform (SDP) manifest file collects configuration settings, registry keys, client networking configuration information, event logs, and important file details that are used by Outlook.

Also, to help troubleshoot common support issues, a series of configuration checks are run to check whether you may be encountering the conditions that are specified by the checks.

> [!NOTE]
> When you run the Outlook Support Diagnostic, you may be prompted to select a version of Microsoft Office if you have both Office 20013 (Click-to-Run) and an earlier version of Office installed. Make sure that you select the version in which you are experiencing a problem with Outlook.

:::image type="content" source="./media/outlook-support-diagnostic/select-version.png" alt-text="Screenshot of selecting Office version in the Outlook Support Diagnostic." border="false":::

On the **Data Collection Options** page, you are prompted to select either **Full** or **Custom** for the data collection. Always select the **Full** option unless you receive other advice from a support engineer.

:::image type="content" source="./media/outlook-support-diagnostic/data-collection-options.png" alt-text="Screenshot of Data Collection Options." border="false":::

> [!NOTE]
> Depending on your version of Windows and the updates you have installed, you may also be prompted to install [Microsoft .NET Framework 4.5.2 (Web Installer)](https://www.microsoft.com/download/details.aspx?id=42643).
>
> .NET Framework 4.5 (or later) is required by the Microsoft Office Configuration Analyzer Tool 2.0 which is the main diagnostic engine utilized by this support diagnostic package.

> [!NOTE]
> If Microsoft Office Configuration Analyzer Tool (OffCAT) 2.0 is not installed when you run this support diagnostic package, you will be prompted to keep or uninstall it when the support diagnostic package has finished running. For more information about the OffCAT tool, see [Office Configuration Analyzer Tool (OffCAT) information](https://support.microsoft.com/help/2812744).

## More information

### Notes

- This diagnostic can be used on the following versions of Windows:
  - Windows 8
  - Windows 7
  - Windows Vista
  - Windows XP
  - Windows Server 2003
  - Windows Server 2008

- All file names in the data collection are prefaced with <*ComputerName*>. This placeholder represents the name of the computer on which the Microsoft Support Diagnostic Tool is run.
- Some file names in the data collection include <*full path*>. This placeholder represents the full path of the file on the hard disk.

### Third-party add-ins that are installed for Outlook

|Description|File name|
|---|---|
|TXT file containing a list of third-party add-ins| *{Computername}*_3rd_party_addins.txt|
|TXT file containing a list of Microsoft add-ins| *{Computername}*_msft_addins.txt|

### Third-party modules that are running under Outlook

|Description|File name|
|---|---|
|TXT file containing a list of third-party modules running under the selected process| *{Computername}*_3rd_party_Modules.txt|

### Performance details about installed COM add-ins in Outlook 2013

|Description|File name|
|---|---|
|TXT file containing details about add-in load times, disabled add-ins, and managed COM add-ins in Outlook 2013| *{Computername}*_Outlook_AddIn_Performance_Details.txt|

### Autodiscover configuration information

> [!NOTE]
> The diagnostic uses the default Outlook profile that is configured on your computer to retrieve this information.

|Description|File name|
|---|---|
|Autodiscover configuration| *{Computername}*_Autodiscover.xml|
|Autodiscover related settings in the registry| *{Computername}*_AutodiscoverSettings.txt|

### Autorun information

For more information about the Autoruns utility that is used to collect this information, go to [Autoruns for Windows v13.98](/sysinternals/downloads/autoruns).

|Description|File name|
|---|---|
|Autorun information in .htm file format| *{Computername}*_Autoruns.htm|
|Autorun information in .xml file format| *{Computername}*_Autoruns.xml|

### Background Intelligent Transfer Service (BITS) information

BitsAdmin log and registry data that is related to BITS

|Description|File name|
|---|---|
|BitsAdmin Command to display current jobs.| *{Computername}*_BitsClient_bitsadmin-list-allusers-verbose.txt|
|BITS Client Registry Keys| *{Computername}*_BitsClient_reg.txt|

### CalCheck Tool logging

Log file from the CalCheck tool.

For more information about the CalCheck tool, see [Information about the Calendar Checking Tool for Outlook (CalCheck)](https://support.microsoft.com/help/2678030).

|Description|File name|
|---|---|
|Text file containing the results from the CalCheck tool.|{*Computername*}_CalCheck.log|

### Details on Click-to-run installations of Office 2013

Configuration-related information about Office 2013 Click-to-run installations.

|Description|File name|
|---|---|
|Text file containing Click-to-run configuration details.| *{Computername}_Click-To-Run_Details*.txt|

### Outlook-Exchange delegate configuration

> [!NOTE]
> The diagnostic uses the default Outlook profile that is configured on your computer to retrieve this information.

|Description|File name|
|---|---|
|Delegate configuration details. File is in .txt format.| *{Computername}*_DelegateInfo.txt|

### Environment variables

Text file that contains environment variables and their values. The same set of environment variables is a subset of the values that are displayed by running the Set command in a command prompt window.

|Description|File name|
|---|---|
|Text file containing environment variables and their values.| *{Computername}* _EnvironmentVariables.txt|

### Application log

Events from the last 15 days that were recorded in additional formats (.csv, and .txt) and in the full Application log (.evtx).

|Description|File name|
|---|---|
|Export of the Application event log in .csv format.| *{Computername}*_evt_Application.csv|
|Export of the Application event log in .evtx format. Use Event Viewer to read.| *{Computername}*_evt_Application.evtx|
|Export of the Application event log in .txt format.| *{Computername}*_evt_Application.txt|

### BITS event log

Events from the last 15 days are recorded in additional formats (.csv, and .txt) and in the full System log (.evtx).

|Description|File name|
|---|---|
|Export of the Bits-Client Operational event log in .csv format.| *{Computername}*_evt_BitsClient-Operational.csv|
|Export of the Bits-Client Operational event log in .evtx format. Use Event Viewer to read.| *{Computername}*_evt_BitsClient-Operational.evtx|
|Export of the Bits-Client Operational event log in .txt format.| *{Computername}*_evt_BitsClient-Operational.txt|

### Microsoft Office Alerts log files

Events over the last five (5) days from the Microsoft Office Alerts log files.

|Description|File name|
|---|---|
|Export of the Microsoft Office Alerts event log file in .csv format.| *{Computername}*_evt_OAlerts.csv|
|Export of the Microsoft Office Alerts event log file in .evtx format.| *{Computername}*_evt_OAlerts.evtx|
|Export of the Microsoft Office Alerts event log file in .txt format.| *{Computername}*_evt_OAlerts.txt|

### System log

Events from the last 15 days are recorded in additional formats (.csv, and .txt) and in the full System log (.evtx).

|Description|File name|
|---|---|
|Export of the System log in .csv format.| *{Computername}*_evt_System.csv |
|Export of the Application log in .evtx format.| *{Computername}*_evt_System.evtx |
|Export of the Application log in .txt format.| *{Computername}*_evt_System.txt|

### Resultant Set of Policy (RSoP) generated by GPResult.exe

|Description|File name|
|---|---|
|Output from running GPResult.exe. File is in .htm format.|*{Computername}*_GPResult.htm|
|Output from running GPResult.exe. File is in .txt format.|*{Computername}*_GPResult.tx|

### Updates that are installed on the computer

|Description|File name|
|---|---|
|List of updates that are installed on the client in .csv format.| *{Computername}*_Hotfixes.csv|
|List of updates that are installed on the client in .htm format.| *{Computername}*_Hotfixes.htm|
|List of updates that are installed on the client in .txt format.| *{Computername}*_Hotfixes.txt|

### Identity logging

If "Identity" logging has been enabled, the diagnostic will collect the logs generated by this logging. This logging information is specific to Office 2013 account functionality configurable in the backstage.

|Description|File name|
|---|---|
|Zip file containing the MsoidLiteTrace log file and MsoCredProv.txt.| *{Computername}*_IdentityLogging.zip|

### Internet Explorer proxy settings

|Description|File name|
|---|---|
|Text file summarizing the proxy settings on the Local Area Network (LAN) Settings dialog box.| *{Computername}*_IE_Proxy_Settings.txt|

### Installed products on the computer

|Description|File name|
|---|---|
|List of installed products on the client in .csv format.|*{Computername}*_Installed_Products.csv|

### Junk e-mail Safe Senders, Safe Recipients, and Blocked Senders lists

> [!NOTE]
> The diagnostic uses the *default* Outlook profile to retrieve this information.

|Description|File name|
|---|---|
|Text file containing the entries from the Safe Senders, Safe Recipients, and Blocked Senders lists (junk e-mail settings).| *{Computername}_Junkmail_Settings*.txt|

### Module signatures

> [!NOTE]
> The diagnostic uses the *default* Outlook profile to retrieve this information.

|Description|File name|
|---|---|
|Text file containing the Authenticode signature status of each module loaded by the Outlook.exe process.| *{Computername}_Module_Signature_Status*.txt|

### Microsoft add-ins installed for Outlook

|Description|File name|
|---|---|
|TXT file containing a list of Microsoft add-ins| *{Computername}*_msft_addins.txt|

### Office Configuration Analyzer Tool (OffCAT) result files

For more information about the OffCAT tool, see [Office Configuration Analyzer Tool (OffCAT) information](https://support.microsoft.com/help/2812744).

|Description|File name|
|---|---|
|HTML version of the OffCAT scan. A shortcut to a locally saved copy of this file is also created on the user's desktop.| *{Computername}*_OffCAT_Report.html|
|OffCAT version 1.2 scan result file.| *{Computername}*_OffCAT_Results.xml|
|OffCAT scan log file.| *{Computername}*_OffCAT_Results.xml.log|
|OffCAT version2 scan result file.| *{Computername}*_OffCAT_Results.offx|

### Outlook configuration summary

|Description|File name|
|---|---|
|Text file that contains a summary report of profile settings|{*Computername*}_Outlook_Configuration _Summary.txt|

### Processes that are running on the computer

|Description|File name|
|---|---|
|List of processes and related services that are running on the computer| *{Computername}*_Processes.txt|

### Windows registry keys

Text files that contain exported keys from the Windows registry.

|Description|File name|
|---|---|
|HKEY_CURRENT_USER\Software\Microsoft\Exchange| *{Computername}*_reg_Outlook_HKCU_Exchange.reg<br/><br/> *{Computername}*_reg_Outlook_HKCU_Exchange.txt|
|HKEY_CURRENT_USER\Software\Microsoft\Office| *{Computername}*_reg_HKCU_Office.reg<br/><br/> *{Computername}*_reg_HKCU_Office.txt|
|HKEY_CURRENT_USER\Software\Policies| *{Computername}*_reg_HKCU_Policies.reg<br/><br/> *{Computername}*_reg_HKCU_Policies.txt|
|HKEY_LOCAL_MACHINE\Software\Clients<br/><br/>HKEY_LOCAL_MACHINE\Software\Wow6432Node\Clients| *{Computername}*_reg_Outlook_HKLM_Clients.reg<br/><br/> *{Computername}*_reg_Outlook_HKLM_Clients.txt|
|HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem<br/><br/>HKEY_LOCAL_MACHINE\Software\Microsoft\Windows Messaging Subsystem<br/><br/>HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows Messaging Subsystem| *{Computername}*_reg_Outlook_MsgSubSys.reg<br/><br/> *{Computername}*_reg_Outlook_MsgSubSys.txt<br/><br/> **Note** For Outlook 2013 only, the following 2 files are generated:<br/><br/> *{Computername}*_HKCU_Outlook2013_Profiles.reg<br/><br/> *{Computername}*_HKCU_Outlook2013_Profiles.txt|
|HKEY_LOCAL_MACHINE \SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-21-124525095-708259637-1543119021-5094<br/><br/>HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-21-124525095-708259637-1543119021-5094| *{Computername}*_reg_RoamingProfileSettings.reg<br/><br/> *{Computername}*_reg_RoamingProfileSettings.txt|
|HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options<br/><br/>HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options| *{Computername}*_reg_HKLM_IFEO.reg<br/><br/> *{Computername}*_reg_HKLM_IFEO.txt|
|HKEY_LOCAL_MACHINE\Software\Microsoft\Office<br/><br/>HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office| *{Computername}*_reg_HKLM_Office.reg<br/><br/> *{Computername}*_reg_HKLM_Office.txt|
|HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Office| *{Computername}*_reg_HKLM_Policies.reg<br/><br/> *{Computername}*_reg_HKLM_Policies.txt|

### Networking details

|Description|File name|
|---|---|
|Text file containing network-related parameters.| *{Computername}*_SMB-Info.txt|
|Text file containing TCP/IP related information from the computer.| *{Computername}*_TcpIp-Info.txt|

### Information about important Outlook and MAPI files

Text and .csv files that contain details about important files used by Outlook. File details include the following:

- Version
- Location
- Description
- Size
- Date
- Company

|Description|File name|
|---|---|
|Details on the files in Office specific folders (for example, Office14) in the \Program Files\Common Files\Microsoft Shared folder.| *{Computername}*_sym_CommonProgramFilesOffice.csv<br/><br/> *{Computername}*_sym_CommonProgramFilesOffice.txt|
|Details on the files in the \Program Files\Common Files\System folder.| *{Computername}*_sym_CommonProgramFilesSystem.csv<br/><br/> *{Computername}*_sym_CommonProgramFilesSystem.txt|
|Details on the files in the \Program Files\Common Files\Microsoft Shared\VSTO folder.| *{Computername}*_CommonProgramFilesVSTO.csv<br/><br/> *{Computername}*_CommonProgramFilesVSTO.txt|
|Details on the files in Office specific folders (for example, Office14) in the \Program Files (x86)\Common Files\Microsoft Shared folder.| *{Computername}* _sym_CommonProgramFilesx86Office.csv<br/><br/> *{Computername}* _sym_CommonProgramFilesx86Office.txt|
|Details on the files in the \Program Files (x86)\Common Files\System folder.| *{Computername}*_sym_CommonProgramFilesx86System.csv<br/><br/> *{Computername}*_sym_CommonProgramFilesx86System.txt|
|Details on the files in the \Program Files (x86)\Common Files\Microsoft Shared\VBA folder.| *{Computername}*_CommonProgramFilesx86VBA.csv<br/><br/> *{Computername}*_CommonProgramFilesx86VBA.txt|
|Details on the files in the \Program Files (x86)\Common Files\Microsoft Shared\VSTO folder.| *{Computername}*_CommonProgramFilesx86VSTO.csv<br/><br/> *{Computername}*_CommonProgramFilesx86VSTO.txt|
|Details on the files in Office specific folders (for example, Office14) in the \Program Files\Microsoft Office or \Program Files (x86)\Microsoft Office folder.| *{Computername}*_sym_ProgramFilesOffice.csv<br/><br/> *{Computername}*_sym_ProgramFilesOffice.txt|
|Details on the files in Office specific folders (for example, Office14) in the \Program Files\Microsoft Office\Office14\Addins or \Program Files (x86)\Microsoft Office\Office14\Addins folder.| *{Computername}*_sym_ProgramFilesOfficeAddins.csv<br/><br/> *{Computername}*_sym_ProgramFilesOfficeAddins.txt|
|Details on the dll files in the \Windows\system32 folder.| *{Computername}*_sym_System32.csv<br/><br/> *{Computername}*_sym_System32.txt|
|Details on the dll files in the \Windows\SysWow64 folder.| *{Computername}*_sym_Syswow64.csv<br/><br/> *{Computername}*_sym_Syswow64.txt|
|Details on the files in the \Program Files\Microsoft Office 15\root\vfs\programfilescommonx64 folder and its subfolders. Files are only collected on Click-to-Run installations of Office 2013.| *{Computername}*_Sym_C2R_ProgramFilesCommonx64.CSV<br/> *{Computername}*_Sym_C2R_ProgramFilesCommonx64.TXT|
|Details on the files in the \Program Files\Microsoft Office 15\root\vfs\programfilescommonx86 folder and its subfolders. Files are only collected on Click-to-Run installations of Office 2013.| *{Computername}*_Sym_C2R_ProgramFilesCommonx86.CSV<br/> *{Computername}*_Sym_C2R_ProgramFilesCommonx86.TXT|

### DLL files that are running under the Outlook.exe process

|Description|File name|
|---|---|
|List of DLL files that are currently running under the Outlook.exe process. File is in .csv format.| *{Computername}*_sym_Outlook_Process.csv|
|List of DLL files that are currently running under the Outlook.exe process. File is in .txt format.| *{Computername}*_sym_Outlook_Process.txt|

### Robust Office Inventory Scan output

|Description|File name|
|---|---|
|Text file that contains a list of all installed applications of the supported Office families.| *{Computername}*_ROIScan.log|
|XML file that contains a list of all installed applications of the supported Office families.| *{Computername}*_ROIScan.xml|

### Uploaded files

Zip file containing one or more files you elected to upload to Microsoft.

|Description|File name|
|---|---|
|Zip file containing the file(s) you selected to have uploaded to Microsoft.| *{Computername}*_File.zip|

## References

[Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970)
