---
title: Setup data collection diagnostic tool
description: This article describes the information that may be collected from a computer when the SQL Server Setup data-collection diagnostic tool is running.
ms.date: 08/19/2020
ms.reviewer: amitban, dansha, shonh
ms.topic: article
---
# SQL Server Setup data-collection diagnostic tool

This article describes the information that may be collected from a computer when the SQL Server Setup data-collection diagnostic tool is running.

_Original product version:_ &nbsp; SQL Server 2008  
_Original KB number:_ &nbsp; 2621109

## Summary

The SQL Server Setup Data Collector for Windows 7, Windows Server 2008 R2, Windows 8, Windows Server 2012, Windows 8.1 and Windows Server 2012 R2 collects diagnostic information that is useful in troubleshooting setup-related issues for Microsoft SQL Server 2008, for SQL Server 2008 R2, and for SQL Server 2012.

SQL Server features are categorized as Instance Features or as Shared Features.

## Instance Features

The Instance Features are as follows:

- Database Engine Features (SQL Server Replication, Full-text, and Semantics Extractions search, Data Quality Services)
- Analysis Services
- Reporting Services - Native

## Shared Features

The Shared Features are as follows:

- Reporting Services - SharePoint
- Reporting Services Add-in for SharePoint Products
- Business Intelligence Development Studio
- Client Tools Connectivity
- Integration Services
- Client Tools Backward Compatibility
- Client Tools SDK
- SQL Server Books Online
- Management Tools - Basic (Management Tools - Complete)
- SQL Client Connectivity SDK
- Microsoft Sync Framework
- Data Quality Client
- Master Data Services
- Distributed Replay Controller
- Distributed Replay Client

The SQL Server Setup Data Collector is cluster-aware and will collect cluster-specific information when the SQL Server Setup Data Collector is run against a clustered instance of SQL Server. When you troubleshoot a Setup failure that occurred on a Windows cluster, the SQL Server Setup Data Collector should be run against the cluster node at which the Setup failure occurred. To troubleshoot multiple Setup failures on multiple nodes that are joined to the same cluster, the SQL Server Setup Data Collector must be run against each node at which the failure occurred.

The SQL Server Setup Data Collector should be run under the security context of the account that was used to run Setup. Also, the SQL Server Setup Data Collector must be run by a user who has administrative rights on the computer on which the data collector will be run.

## Information that is collected

- **All event logs**

    |Description|File name|
    |---|---|
    |System log - Evtx format| _ComputerName_System.evtx_|
    |Application log - Evtx format| _ComputerName_Application.evtx_|
    |Security log - Evtx format| _ComputerName_Security.evtx_|
    |FailoverClustering-Operational - Evtx format| _ComputerName_FailoverClustering-Operational.evtx_|

    > [!NOTE]
    > Failover Clustering event logs will be collected only on servers that have Failover Clustering configured.

- **Registry information that is related to Session Manager and Debugging**

    |Description|File name|
    |---|---|
    |Collect Registry Key - `HKLM\Software\Microsoft\Windows NT\CurrentVersion\AEDebug`| _ComputerName_ _Recovery_Registry.TXT_|
    |Collect Registry Key - `HKLM\Software\Microsoft\DrWatson`| _ComputerName __Recovery_Registry.TXT_|
    |Collect Registry Key - `HKLM\System\CurrentControlSet\Services\i8042prt\Parameters`| _ComputerName_ _Recovery_Registry.TXT_|
    |Collect Registry Key - `HKLM\System\CurrentControlSet\Control`| _ComputerName __Recovery_Registry.TXT_|
    |Collect Registry Key - `HKLM\System\CurrentControlSet\Control\Session Manager`| _ComputerName_ _Recovery_Registry.TXT_|

- **Existing Dr. Watson logs files and memory dump reports and files**

    |Description|File name|
    |---|---|
    |Memory dump report| _ComputerName_DumpReport.htm_|
    |Memory dump report| _ComputerName_ DumpReport.txt_|
    |Memory dump file (minidumps)| *ComputerName _DMP_{Date}.zip*|

- **Information about all services that are installed on the operating system**

    |Description|File name|
    |---|---|
    |Collect information about all OS services| _ComputerName_SC_Services_Output.txt_|

- **Information about all filter drivers that are active on the computer**

    |Description|File name|
    |---|---|
    |Upper and lower filters information that uses fltrfind.exe utility| _ComputerName_ FltrFind.txt_|

- **Information about all the running processes and driver details together with their file versions**

    |Description|File name|
    |---|---|
    |`%programfiles%\*.sys`| _ComputerName_sym_ProgramFiles_SYS.CSV_|
    |`%programfiles%\*.sys`| _ComputerName_sym_ProgramFiles_SYS.TXT_|
    |`%windir%\system32\drivers\*.*`| _ComputerName_sym_Drivers.CSV_|
    |`%windir%\system32\drivers\*.*`| _ComputerName_sym_Drivers.TXT_|
    |`%windir%\system32\*.exe`| _ComputerName_sym_System32_exe.CSV_|
    |`%windir%\system32\*.exe`| _ComputerName_sym_System32_exe.TXT_|
    |`%windir%\system32\*.sys`| _ComputerName_sym_System32_sys.CSV_|
    |`%windir%\system32\*.sys`| _ComputerName_sym_System32_sys.TXT_|
    |Running processes| _ComputerName_sym_Process.CSV_|
    |Running processes| _ComputerName_sym_Process.TXT_|
    |Running drivers| _ComputerName_sym_RunningDrivers.CSV_|
    |Running drivers| _ComputerName_sym_RunningDrivers.TXT_|

- **Performance-related information for the operating system**

    |Description|File name|
    |---|---|
    |System processor basic information| _ComputerName_ Processor_Details.txt_|
    |System processor performance information| _ComputerName_ OS_Perf_Details.txt_|
    |System performance statistics| _ComputerName_ OS_Perf_Statistics.txt_|

- **Information about the network configuration of the computer**

    |Description|File name|
    |---|---|
    |TCP/IP basic information| _ComputerName_TcpIp-Info.txt_|
    |SMB basic information| _ComputerName_SMB-Info.txt_|

- **Output of the NetDiag utility**

    |Description|File name|
    |---|---|
    |Networking diagnostic output that uses the NetDiag.exe utility| _ComputerName_NetDiag.txt_|

    > [!NOTE]
    > NetDiag is a diagnostic tool that helps isolate networking and connectivity problems by performing a series of tests to determine the state of the network client.

- **Information about Windows scheduled tasks that are configured on the computer**

    |Description|File name|
    |---|---|
    |Scheduled tasks list| _ComputerName_schtasks.csv_|
    |Scheduled tasks list| _ComputerName_schtasks.txt_|

- **Boot configuration data of the computer**

    |Description|File name|
    |---|---|
    |Output from Bcdedit.exe utility| _ComputerName_BCDEdit.txt_|
    |Output from Bcdedit.exe utility| _ComputerName_BCD-Backup.bak_|

- **Servicing information for the computer**

    |Description|File name|
    |---|---|
    |Component-Based Servicing logs that are located at `%windir%\Logs\CBS`| *ComputerName _CBS\*.log*|
    |DPX Setup Act log that is located at `%windir%\logs\DPX`| _ComputerName_setupact.log_|
    |Pending Operations Queue Exec log that is located at `%windir%\winsxs`| _ComputerName_poqexec.log_|
    |Windows Side-by-Side Pending Bad log that is located at `%windir%\ winsxs`| _ComputerName_pending.xml.bad_|
    |Windows Side-by-Side Pending log that is located at `%windir%\ winsxs`| _ComputerName_pending.xml_|

- **Operating system SetupAPI logs**

    |Description|File name|
    |---|---|
    |SetupAPI logs that are located in `%windir%\inf` folder| _ComputerName_SetupApi.app.log_<br/><br/>_ComputerName_SetupApi.evt.log_<br/><br/>_ComputerName_SetupApi.offline.log_<br/><br/>_ComputerName_SetupApi.Dev.log_|

- **Information about all hotfixes that are applied on the computer**

    |Description|File name|
    |---|---|
    |Installed updates and hotfixes| _ComputerName_Hotfixes.CSV_<br/><br/>_ComputerName_Hotfixes.Txt_<br/><br/>_ComputerName_Hotfixes.HTM_|

- **Backup of CurrentControlSet and SQL Server registry hives**

    |Description|File name|
    |---|---|
    |`HKLM\System\CurrentControlSet\SessionManagers`| _ComputerName_CurrentControlSet_Reg.txt_|
    |`HKLM\SYSTEM\CurrentControlSet\Control\Lsa`| _ComputerName_CurrentControlSet_Reg.txt_|
    |`HKLM\SYSTEM\CurrentControlSet`| _ComputerName_CurrentControlSet.Hiv_|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\MSSQLServer`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server 2005 Redist`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\Software\Microsoft\MSFTESQLInstMap`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Native Client`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\OLAP Server`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\SNAC`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\SQLXML4`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\Software\Microsoft\Vsa`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\ODBC`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\MSDTS`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\MSXML 6.0 Parser and SDK`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\MSXML60`| _ComputerName_REG_SQL.TXT_|
    |`HKCU\Software\Microsoft\Microsoft SQL Server`| _ComputerName_REG_SQL.TXT_|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server`| _ComputerName_Microsoft_SQL_Server.HIV_|

- **Output of MSINFO32**

    |Description|File name|
    |---|---|
    |Microsoft System Information report| _ComputerName_MSINFO32.NFO_<br/><br/>_ComputerName_MSINFO32.TXT_|

- **Output of PStat utility**

    |Description|File name|
    |---|---|
    |PStat.exe output| _ComputerName_Pstat.txt_|

    > [!NOTE]
    > PStat is a character-based tool that lists all running threads and displays their status.

- **Backup of cluster-related registry keys**

    |Registry key|File name|
    |---|---|
    |`HKLM\Software\Microsoft\Windows NT\CurrentVersion`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion`| _ComputerName_reg_CurrentVersion.TXT_|
    |`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`| _ComputerName_reg_Uninstall.TXT_|
    |`HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions`| _ComputerName_reg_ProductOptions.TXT_|
    |`HKLM\System\MountedDevices`| *ComputerName _reg_MountedDevices.\**|
    |`HKLM\System\CurrentControlSet\Control\CrashControl`<br/>`HKLM\System\CurrentControlSet\Control\Session Manager`<br/>`HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management`<br/>`HKLM\Software\Microsoft\Windows NT\CurrentVersion\AeDebug`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options`<br/>`HKLM\Software\Microsoft\Windows\Windows Error Reporting`<br/>`HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting`| _ComputerName_reg_Recovery.TXT_|
    |`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\Runonce`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\RunonceEx`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run`<br/>`HKLM\ Software\Microsoft\Windows\CurrentVersion\Run`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\Runonce`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\RunonceEx`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad`<br/>`HKCU\Software\Microsoft\Windows NT\CurrentVersion\Load`<br/>`HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\Run`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit`| _ComputerName_reg_Startup.TXT_|
    |`HKLM\SYSTEM\CurrentControlSet\Control\Print`| _ComputerName_reg_Print.HIV_|
    |`HKCU\Software\Policies`<br/>`HKLM\Software\Policies`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\Policies`<br/>`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies`| _ComputerName_reg_Policies.txt_|
    |`HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones`| _ComputerName_reg_TimeZone.txt_|
    |`HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Terminal Server`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Terminal Server Web Access`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\TermService`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\TermDD`| _ComputerName_reg_TermServices.txt_|
    |`HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\MRxSmb`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\SMB`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\MRxSmb10`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\MRxSmb20`| _ComputerName_reg_SMB.txt_|
    |`HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`| _ComputerName_reg_TCPIPParameters_|
    |`HKLM\SYSTEM\CurrentControlSet\Services\VSS`| _ComputerName_reg_VSS.TXT_|
    |`HKLM\SYSTEM\CurrentControlSet\Services\iScsiPrt`<br/>`HKLM\SOFTWARE\Microsoft\iSCSI Target`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\iSCSI`| _ComputerName_reg_iSCSI.TXT_|
    |`HKLM\System\CurrentControlSet\Control\MPDev`<br/>`HKLM\System\CurrentControlSet\Control\iSCSIPrt`<br/>`HKLM\System\CurrentControlSet\Services\MSiSCSI`<br/>`HKLM\System\CurrentControlSet\Services\MSDsm`<br/>`HKLM\System\CurrentControlSet\Services\MPIO`<br/>`HKLM\System\CurrentControlSet\Control\Class\{4d36e97b-e325-11ce-bfc1-08002be10318}`<br/>`HKLM\System\CurrentControlSet\Services\Tcpip`| _ComputerName_reg_Storage.TXT_|
    |`HKLM\SYSTEM\CurrentControlSet\Enum`| _ComputerName_reg_Enum.TXT_|
    |`HKLM\System\CurrentControlSet\services\ClusSvc`<br>`HKLM\System\CurrentControlSet\services\CluDisk`| _ComputerName_reg_ClusSvc.TXT_|
    |`HKLM\Cluster`| _ComputerName_Cluster.hiv_|

    > [!NOTE]
    > This information will be collected if the SQL Server Setup data-collection diagnostic tool detects that the computer on which the tool is running is a cluster.

- **Basic information about Windows Failover Cluster**

    The data that is collected includes the following:

  - Cluster logs
  - Shared volume information
  - Cluster resource properties
  - Cluster reports folder
  - Cluster resource dependency
  - Cluster validation report

  |Description|File name|
  |---|---|
  |Cluster logs that are generated by Get-ClusterLog Windows PowerShell cmdlet| _ComputerName_Cluster.Log_|
  |Cluster MPS Tool (clusmps.exe) output| _ComputerName_Cluster_MPS_Information.txt_|
  |Cluster validation reports files that are located at `\Windows\Cluster\Reports\*.mht`| *ComputerName _\*.mht*|
  |Cluster reports XML files that are located at `\Windows\Cluster\Reports\*.xml`| *ComputerName _\*.xml*|
  |Cluster validation log files from `\Windows\Cluster\Reports\Validate*.log`| *ComputerName _Validade\*.log*|
  |Cluster resources properties that use the Windows PowerShell Get-ClusterResource cmdlet| _ComputerName_ClusterProperties.txt_|
  |Cluster Dependency Report that is generated by the Get-ClusterResourceDependencyReport Windows PowerShell cmdlet| _ComputerName_DependencyReport.mht_|
  |Cluster Shared Volume information - HTML format| _ComputerName_CSVInfo.htm_|
  |Cluster basic Validation Report that is generated by the Test-Cluster Windows PowerShell cmdlet| _ComputerName_ValidationReport.mht_|

   > [!NOTE]
   > This information will be collected if the SQL Server Setup data-collection diagnostic tool detects that the computer on which the tool is running is a cluster.

- **Information about SQL Server instances that are installed on the computer**

    |Description|File name|
    |---|---|
    |MSI Installer information for SQL Server products| _ComputerName_FindSQLInstalls.txt_|

- **Information about TCP/IP ports that are used on the computer**

    |Description|File name|
    |---|---|
    |TCP/IP port usage information| _ComputerName_PortUsage.txt_|

- **Information about User Rights Assignments**

    |Description|File name|
    |---|---|
    |Local User Right Assignments| _ComputerName_userrights.txt_|

- **Backup of the Setup Bootstrap folder for SQL Server installations**

    |Description|File name|
    |---|---|
    |Compressed directory `%programfiles%\ Microsoft SQL Server\90\Setup Bootstrap\Log`| _ComputerName_SQL90_Bootstrap.Cab_|
    |Compressed directory `%programfiles%\ Microsoft SQL Server\100\Setup Bootstrap\Log`| _ComputerName_SQL100_Bootstrap.Cab_|
    |Compressed directory `%programfiles%\ Microsoft SQL Server\110\Setup Bootstrap\Log`| _ComputerName_SQL110_Bootstrap.Cab_|

- **SQL Server error logs for all instances of SQL Server that are installed on the computer**

    |Description|File name|
    |---|---|
    |Collects SQL Server error logs for all instances that are installed on the computer on which the diagnostic tool is executed. The number of files that are collected is determined by how many error logs exist on the file system.|Named instance:<br/> _ComputerName_ instance_name _.errorlog_<br/>Default instance:<br/> *ComputerName _MSSQLSERVER_.errorlog*|

    > [!NOTE]
    > The SQL Server Setup data-collection diagnostic tool will collect error logs for a clustered instance only if the shared drive that is storing the error log is currently owned by the server on which the utility is being executed.

## More information

In addition to the files that are collected and listed here, this troubleshooter can detect one or more of the following situations:

- The computer is running in a virtual environment.
- The cluster service of a FailoverCluster node is not running.
- The state of any of the cluster nodes is Offline.
- Any of the cluster groups is offline.
- There is a problem in obtaining cluster information.

## Applies to

- SQL Server 2008 Enterprise
- SQL Server 2008 Developer
- SQL Server 2008 Express
- SQL Server 2008 Express with Advanced Services
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2008 Standard
- SQL Server 2008 Standard Edition for Small Business
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Workgroup
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
