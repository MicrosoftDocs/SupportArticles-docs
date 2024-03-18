---
title: Configuration Manager diagnostics
description: This diagnostic package is designed to collect information used to troubleshoot most System Center 2012 Configuration Manager and Configuration Manager current branch issues.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Site Server and Roles\Site and Component Status Monitoring
---
# [SDP 3][5ee487a8-b2ed-4bc8-80ea-457f9b683c77] System Center Configuration Manager diagnostic

This diagnostic package is designed to collect information used to troubleshoot most System Center 2012 Configuration Manager and Configuration Manager current branch issues.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 2704781

## Configuration Manager client

| Description| File name |
|---|---|
|Summary of information gathered about the Configuration Manager client|{ComputerName}__CMClient_Summary.txt|
|Application enforcement status|{ComputerName}_CMClient_AppHistory.txt|
|Configuration Manager client cache information|{ComputerName}_CMClient_CacheInfo.txt|
|Configuration Manager client file version list|{ComputerName}_CMClient_FileVersions.txt|
|Configuration Manager client inventory version information|{ComputerName}_CMClient_InventoryVersions.txt|
|Software distribution execution history|{ComputerName}_CMClient_ExecutionHistory.txt|
|State Messages from `CCM_StateMsg` WMI class|{ComputerName}_CMClient_StateMessages.txt|
|Update Status from `CCM_UpdateStatus` WMI class|{ComputerName}_CMClient_CCMUpdateStatus.txt|
  
## Configuration Manager logs

| Description| File name |
|---|---|
|SQL Server error logs|{ComputerName}_Logs_SQLError.zip|
|Configuration Manager client, site server, and site system logs|{ComputerName}_Logs_ConfigMgr.zip|
|Windows logs (CBS, Temp, WindowsUpdate, and so on) and Configuration Manager OSD-related logs (SMSTS, INF, Panther, DISM, UDI, Netsetup and so on)|{ComputerName}_Logs_Windows+OSD.zip|
  
## Configuration Manager site database

| Description| File name |
|---|---|
|Summary of information gathered about the SQL Server and Configuration Manager site database.|{ComputerName}__CMServer_Summary.txt|
|Blocked transactions, sp_who2 output and active Snapshot transactions.|{ComputerName}_SQL_Transactions.txt|
|Configuration Manager maintenance tasks.|{ComputerName}_SQL_CMDBInfo.txt|
|Configuration Manager site control file for the current Site.|{ComputerName}_SQL_SiteControlFile.xml.txt|
|DRS replication troubleshooting information|{ComputerName}_SQL_DRSData.zip|
|List of Configuration Manager site systems and distribution points from `SysResList` and `DistributionPoints` tables.|{ComputerName}_SQL_SiteSystems.txt|
|Results of the configuration checks performed against the site database.|{ComputerName}_SQL_ConfigCompliance.txt|
|Software update point synchronization status.|{ComputerName}_SQL_SUPSync.txt|
|SQL Server version, security role members, and database information.|{ComputerName}_SQL_Basic.txt|
|Top stored procedure calls by CPU, elapsed time, and so on.|{ComputerName}_SQL_TopQueries.txt|
|Update servicing troubleshooting information|{ComputerName}_SQL_UpdateServicing.zip|
  
## Configuration Manager site server

| Description| File name |
|---|---|
|Summary of information gathered about the Configuration Manager site server|{ComputerName}__CMServer_Summary.txt|
|Boundaries configured in Configuration Manager|{ComputerName}_CMServer_Boundaries.txt|
|Configuration Manager hierarchy information|{ComputerName}_CMServer_Hierarchy.txt|
|Configuration Manager site server file versions|{ComputerName}_CMServer_FileVersions.txt|
|Directory listing of RCM.box inbox|{ComputerName}_CMServer_RCMFileList.txt|
|SMS_Executive service thread status from registry|{ComputerName}_CMServer_SMSExecThreads.txt|
|SPN information for the site database|{ComputerName}_CMServer_SQLSPN.txt|
  
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
|Reboot pending flag from Windows Update, CBS, ConfigMgr client, and so on|{ComputerName}_OS_RebootPending.txt|
|Resultant set of Group Policies|{ComputerName}_OS_GPResult.*|
|System information|{ComputerName}_OS_MSInfo.nfo|
|SystemInfo output|{ComputerName}_OS_SysInfo.txt|
|WMI quota configuration and loaded providers|{ComputerName}_OS_WMIProviderConfig.txt|
  
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
|Basic TCP/IP and networking configuration information, such as TCP/IP registry key and outputs from `ipconfig`, `netstat`, `nbtstat` and `netsh` commands|{ComputerName}_OS_TCPIP-Info.txt|
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
  
## Server manager and server roles information

| Description| File name |
|---|---|
|List of roles and features installed on server media (Windows Server 2008 R2 and later versions)|resultreport.xml|
  
## Windows Update Agent information

| Description| File name |
|---|---|
|Windows Update Agent version, service security descriptors and registry settings.|{ComputerName}__WUA_Summary.txt|
|File list in `SoftwareDistribution` directory|{ComputerName}_WUA_FileList.txt|
|File version of Windows Update Agent related EXE/DLL files|{ComputerName}_WUA_FileVersions.txt|
  
## WSUS server information

| Description| File name |
|---|---|
|Summary of WSUS server information collected.|{ComputerName}__WSUS_Summary.txt|
|File list of WSUS content directory (only collected with WSUS diagnostics)|{ComputerName}_WSUS_FileList_ContentDir.txt|
|File list of WSUS installation directory (only collected with WSUS diagnostics)|{ComputerName}_WSUS_FileList_InstallDir.txt|
|File versions of EXE/DLL files in WSUS installation directory (only collected with WSUS diagnostics)|{ComputerName}_WSUS_FileVersions.txt|
|List of approved updates (not collected for WSUS 4.0)|{ComputerName}_WSUS_ApprovedUpdates.xml|
|WSUS basic information (not collected for WSUS 4.0)|{ComputerName}_WSUS_BasicInfo.txt|
|WSUS logs|{ComputerName}_Logs_WSUS.zip|
|WSUS setup logs (if available)|{ComputerName}_Logs_WSUSSetup.zip|
  
## Detect symptoms

In addition to collecting the information, this diagnostic package can detect one or more of the following symptoms:

- Configuration Manager database: Database owner is not set to SA.
- Configuration Manager database: User Access mode is not set to **MULTI_USER**.
- Configuration Manager database: Database is marked as **READ_ONLY**.
- Configuration Manager database: Database is not **ONLINE**.
- Configuration Manager database: Recovery Model is not set to **SIMPLE**.
- Configuration Manager database: SQL Server Broker is disabled.
- Configuration Manager database: Recursive triggers are disabled.
- Configuration Manager database: `Trustworthy` property is disabled.
- Configuration Manager database: Honor Broker Priority is set to **False**.
- Configuration Manager database: Snapshot Isolation State is set to **False**.
- Configuration Manager database: Read Committed Snapshot is set to **False**.
- Configuration Manager database: Nested triggers are disabled.
- Configuration Manager database: SQL Server change tracking backlog.
- Configuration Manager database: DBSchemaChangeHistory Excessive Growth.
- root\\CCM WMI namespace connection failure.
- %ServiceName% service is stopped.
- %ServiceName% service is disabled.
- Configuration Manager client is in provisioning mode.

## References

[Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970)
