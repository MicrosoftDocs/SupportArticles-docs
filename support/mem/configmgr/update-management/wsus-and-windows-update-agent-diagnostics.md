---
title: WSUS and Windows Update Agent diagnostics
description: This diagnostic package is designed to collect information used to troubleshoot most Windows Update issues.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Software Update Management (SUM)\WSUS Installation or Configuration
---
# [SDP3][721e15b6-76f5-43d0-a435-191d3474a359] Windows Server Update Services and Windows Update Agent diagnostics

This diagnostic package is designed to collect information used to troubleshoot most Windows Update issues.

_Original product version:_ &nbsp; Windows Server Update Services  
_Original KB number:_ &nbsp; 2793732

## Custom uploads

| Description| File name |
|---|---|
|Compressed copy of file specified by user|{ComputerName}_filename.zip|
  
## General information

| Description| File name |
|---|---|
|Summary of information gathered about the operating system|{ComputerName}__OS_Summary.txt|
|List of running tasks|{ComputerName}_OS_TaskList.txt|
|Basic system information including machine name, service pack, computer model, and processor name and speed|resultreport.xml|
|Environment variables|{ComputerName}_OS_EnvironmentVariables.txt|
|Event logs for last 14 days (Application, System, and Security)|{ComputerName}_OS_EventLogs.zip|
|List of installed certificates (Computer and User stores)|{ComputerName}_OS_Certificates.txt|
|List of installed services|{ComputerName}_OS_Services.txt|
|List of installed updates and hotfixes installed|{ComputerName}_Hotfixes.*|
|List of user rights (privileges) using showpriv.exe tool|{ComputerName}_UserRights.txt|
|Reboot pending flag from Windows Update, CBS, ConfigMgr Client, and so on|{ComputerName}_OS_RebootPending.txt|
|Resultant set of Group Policies|{ComputerName}_OS_GPResult.*|
|System information|{ComputerName}_OS_MSInfo.nfo|
|SystemInfo output|{ComputerName}_OS_SysInfo.txt|
|WMI quota configuration and loaded providers.|{ComputerName}_OS_WMIProviderConfig.txt|
  
## IIS information

| Description| File name |
|---|---|
|IIS configuration information|{ComputerName}_IISConfiguration.zip|
|IIS logs (last 5 days)|{ComputerName}_Logs_IIS.zip|
|Virtual directory list and configuration|{ComputerName}_IIS_VDirInfo.txt|
  
## Networking basic information

| Description| File name |
|---|---|
|Summary of networking information collected|{ComputerName}__NET_Summary.txt|
|Active BITS jobs|{ComputerName}_OS_BITSTransfers.txt|
|Basic SMB configuration information, such as output of net.exe subcommands, such as `net share`, `net sessions`, `net use`, `net accounts`, `net config`|{ComputerName}_OS_SMB-Info.txt|
|Basic TCP/IP and networking configuration information, such as TCP/IP registry key and outputs from `ipconfig`, `netstat`, `nbtstat`, and `netsh` commands|{ComputerName}_OS_TCPIP-Info.txt|
|Enabled Windows Firewall rules|{ComputerName}_OS_EnabledFirewallRules.txt|
|Proxy configuration|{ComputerName}_OS_ProxyInfo.txt|
  
## Registry keys

| Description| File name |
|---|---|
|HKEY_CURRENT_USER\Software\Policies|{ComputerName}_RegistryKey_HKCUPolicies.txt|
|HKEY_LOCAL_MACHINE\Software\Microsoft\CCM|{ComputerName}_RegistryKey_CCM.txt|
|HKEY_LOCAL_MACHINE\Software\Microsoft\OLE|{ComputerName}_RegistryKey_DCOM.txt|
|HKEY_LOCAL_MACHINE\Software\Microsoft\SMS|{ComputerName}_RegistryKey_SMS.txt|
|HKEY_LOCAL_MACHINE\Software\Microsoft\Update Services|{ComputerName}_RegistryKey_WSUS.txt|
|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall|{ComputerName}_RegistryKey_Uninstall.txt|
|HKEY_LOCAL_MACHINE\Software\Policies|{ComputerName}_RegistryKey_HKLMPolicies.txt|
|HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services|{ComputerName}_RegistryKey_Services.txt|
  
## Robust Office inventory scan output

| Description| File name |
|---|---|
|File containing a list of all installed applications of the supported Office families.|{ComputerName}_ROIScan.log|
|File containing a list of all installed applications of the supported Office families.|{ComputerName}_ROIScan.zip|
  
## Server manager and server roles information

| Description| File name |
|---|---|
|List of roles and features installed on server media (Windows Server 2008 R2 and later versions)|resultreport.xml|
  
## Windows Update Agent information

| Description| File name |
|---|---|
|Windows Update Agent version, service security descriptors, and registry settings.|{ComputerName}__WUA_Summary.txt|
|File list in `SoftwareDistribution` directory|{ComputerName}_WUA_FileList.txt|
|File version of Windows Update Agent related EXE/DLL files|{ComputerName}_WUA_FileVersions.txt|
  
## WSUS database information

| Description| File name |
|---|---|
|Database version and security information|{ComputerName}_SQL_Basic.txt|
|Dead deployments|{ComputerName}_SQL_DeadDeployments.txt|
|Output of `tbConfiguration` tables|{ComputerName}_SQL_SUSDBConfig.txt|
|Output of `tbSchema` tables|{ComputerName}_SQL_SUSDBSchema.txt|
  
## WSUS server information

| Description| File name |
|---|---|
|Summary of WSUS server information collected.|{ComputerName}__WSUS_Summary.txt|
|File list of WSUS content directory (only collected with WSUS diagnostics)|{ComputerName}_WSUS_FileList_ContentDir.txt<br/>|
|File list of WSUS installation directory (only collected with WSUS Diagnostics)|{ComputerName}_WSUS_FileList_InstallDir.txt|
|File versions of EXE/DLL files in WSUS installation directory (only collected with WSUS diagnostics)|{ComputerName}_WSUS_FileVersions.txt|
|List of approved updates (Not collected for WSUS 4.0)|{ComputerName}_WSUS_ApprovedUpdates.xml|
|WSUS basic information|{ComputerName}_WSUS_BasicInfo.txt|
|WSUS logs|{ComputerName}_Logs_WSUS.zip|
|WSUS setup logs (if available)|{ComputerName}_Logs_WSUSSetup.zip|
  
## References

[Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970)
