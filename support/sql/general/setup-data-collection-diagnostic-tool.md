---
title: Setup data collection diagnostic tool
description: This article describes the information that may be collected from a computer when the SQL Server Setup data-collection diagnostic tool is running.
ms.date: 08/19/2020
ms.prod-support-area-path: 
ms.reviewer: amitban, dansha, shonh
ms.topic: article
ms.prod: sql
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
    |System log - Evtx format| *ComputerName _System.evtx*|
    |Application log - Evtx format| *ComputerName _Application.evtx*|
    |Security log - Evtx format| *ComputerName _Security.evtx*|
    |FailoverClustering-Operational - Evtx format| *ComputerName _FailoverClustering-Operational.evtx*|
    |||

    > [!NOTE]
    > Failover Clustering event logs will be collected only on servers that have Failover Clustering configured.

- **Registry information that is related to Session Manager and Debugging**

    |Description|File name|
    |---|---|
    |Collect Registry Key - `HKLM\Software\Microsoft\Windows NT\CurrentVersion\AEDebug`| *ComputerName _ _Recovery_Registry.TXT*|
    |Collect Registry Key - `HKLM\Software\Microsoft\DrWatson`| *ComputerName __Recovery_Registry.TXT*|
    |Collect Registry Key - `HKLM\System\CurrentControlSet\Services\i8042prt\Parameters`| *ComputerName _ _Recovery_Registry.TXT*|
    |Collect Registry Key - `HKLM\System\CurrentControlSet\Control`| *ComputerName __Recovery_Registry.TXT*|
    |Collect Registry Key - `HKLM\System\CurrentControlSet\Control\Session Manager`| *ComputerName _ _Recovery_Registry.TXT*|
    |||

- **Existing Dr. Watson logs files and memory dump reports and files**

    |Description|File name|
    |---|---|
    |Memory dump report| *ComputerName _DumpReport.htm*|
    |Memory dump report| *ComputerName _ DumpReport.txt*|
    |Memory dump file (minidumps)| *ComputerName _DMP_{Date}.zip*|
    |||

- **Information about all services that are installed on the operating system**

    |Description|File name|
    |---|---|
    |Collect information about all OS services| *ComputerName _SC_Services_Output.txt*|
    |||

- **Information about all filter drivers that are active on the computer**

    |Description|File name|
    |---|---|
    |Upper and lower filters information that uses fltrfind.exe utility| *ComputerName _ FltrFind.txt*|
    |||

- **Information about all the running processes and driver details together with their file versions**

    |Description|File name|
    |---|---|
    |`%programfiles%\*.sys`| *ComputerName _sym_ProgramFiles_SYS.CSV*|
    |`%programfiles%\*.sys`| *ComputerName _sym_ProgramFiles_SYS.TXT*|
    |`%windir%\system32\drivers\*.*`| *ComputerName _sym_Drivers.CSV*|
    |`%windir%\system32\drivers\*.*`| *ComputerName _sym_Drivers.TXT*|
    |`%windir%\system32\*.exe`| *ComputerName _sym_System32_exe.CSV*|
    |`%windir%\system32\*.exe`| *ComputerName _sym_System32_exe.TXT*|
    |`%windir%\system32\*.sys`| *ComputerName _sym_System32_sys.CSV*|
    |`%windir%\system32\*.sys`| *ComputerName _sym_System32_sys.TXT*|
    |Running processes| *ComputerName _sym_Process.CSV*|
    |Running processes| *ComputerName _sym_Process.TXT*|
    |Running drivers| *ComputerName _sym_RunningDrivers.CSV*|
    |Running drivers| *ComputerName _sym_RunningDrivers.TXT*|
    |||

- **Performance-related information for the operating system**

    |Description|File name|
    |---|---|
    |System processor basic information| *ComputerName _ Processor_Details.txt*|
    |System processor performance information| *ComputerName _ OS_Perf_Details.txt*|
    |System performance statistics| *ComputerName _ OS_Perf_Statistics.txt*|
    |||

- **Information about the network configuration of the computer**

    |Description|File name|
    |---|---|
    |TCP/IP basic information| *ComputerName _TcpIp-Info.txt*|
    |SMB basic information| *ComputerName _SMB-Info.txt*|
    |||

- **Output of the NetDiag utility**

    |Description|File name|
    |---|---|
    |Networking diagnostic output that uses the NetDiag.exe utility| *ComputerName _NetDiag.txt*|
    |||

    > [!NOTE]
    > NetDiag is a diagnostic tool that helps isolate networking and connectivity problems by performing a series of tests to determine the state of the network client.

- **Information about Windows scheduled tasks that are configured on the computer**

    |Description|File name|
    |---|---|
    |Scheduled tasks list| *ComputerName _schtasks.csv*|
    |Scheduled tasks list| *ComputerName _schtasks.txt*|
    |||

- **Boot configuration data of the computer**

    |Description|File name|
    |---|---|
    |Output from Bcdedit.exe utility| *ComputerName _BCDEdit.txt*|
    |Output from Bcdedit.exe utility| *ComputerName _BCD-Backup.bak*|
    |||

- **Servicing information for the computer**

    |Description|File name|
    |---|---|
    |Component-Based Servicing logs that are located at `%windir%\Logs\CBS`| *ComputerName _CBS\*.log*|
    |DPX Setup Act log that is located at `%windir%\logs\DPX`| *ComputerName _setupact.log*|
    |Pending Operations Queue Exec log that is located at `%windir%\winsxs`| *ComputerName _poqexec.log*|
    |Windows Side-by-Side Pending Bad log that is located at `%windir%\ winsxs`| *ComputerName _pending.xml.bad*|
    |Windows Side-by-Side Pending log that is located at `%windir%\ winsxs`| *ComputerName _pending.xml*|
    |||

- **Operating system SetupAPI logs**

    |Description|File name|
    |---|---|
    |SetupAPI logs that are located in `%windir%\inf` folder| *ComputerName _SetupApi.app.log*<br/><br/> *ComputerName _SetupApi.evt.log*<br/><br/> *ComputerName _SetupApi.offline.log*<br/><br/> *ComputerName _SetupApi.Dev.log*|
    |||

- **Information about all hotfixes that are applied on the computer**

    |Description|File name|
    |---|---|
    |Installed updates and hotfixes| *ComputerName _Hotfixes.CSV*<br/><br/> *ComputerName _Hotfixes.Txt*<br/><br/> *ComputerName _Hotfixes.HTM*|
    |||

- **Backup of CurrentControlSet and SQL Server registry hives**

    |Description|File name|
    |---|---|
    |`HKLM\System\CurrentControlSet\SessionManagers`| *ComputerName _CurrentControlSet_Reg.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Control\Lsa`| *ComputerName _CurrentControlSet_Reg.txt*|
    |`HKLM\SYSTEM\CurrentControlSet`| *ComputerName _CurrentControlSet.Hiv*|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\MSSQLServer`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server 2005 Redist`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\Software\Microsoft\MSFTESQLInstMap`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Native Client`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\OLAP Server`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\SNAC`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\SQLXML4`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\Software\Microsoft\Vsa`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\ODBC`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\MSDTS`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\MSXML 6.0 Parser and SDK`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\MSXML60`| *ComputerName _REG_SQL.TXT*|
    |`HKCU\Software\Microsoft\Microsoft SQL Server`| *ComputerName _REG_SQL.TXT*|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server`| *ComputerName _Microsoft_SQL_Server.HIV*|
    |||

- **Output of MSINFO32**

    |Description|File name|
    |---|---|
    |Microsoft System Information report| *ComputerName _MSINFO32.NFO*<br/><br/> *ComputerName _MSINFO32.TXT*|
    |||

- **Output of PStat utility**

    |Description|File name|
    |---|---|
    |PStat.exe output| *ComputerName _Pstat.txt*|
    |||

    > [!NOTE]
    > PStat is a character-based tool that lists all running threads and displays their status.

- **Backup of cluster-related registry keys**

    |Registry key|File name|
    |---|---|
    |`HKLM\Software\Microsoft\Windows NT\CurrentVersion`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion`| *ComputerName _reg_CurrentVersion.TXT*|
    |`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`| *ComputerName _reg_Uninstall.TXT*|
    |`HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions`| *ComputerName _reg_ProductOptions.TXT*|
    |`HKLM\System\MountedDevices`| *ComputerName _reg_MountedDevices.\**|
    |`HKLM\System\CurrentControlSet\Control\CrashControl`<br/>`HKLM\System\CurrentControlSet\Control\Session Manager`<br/>`HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management`<br/>`HKLM\Software\Microsoft\Windows NT\CurrentVersion\AeDebug`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options`<br/>`HKLM\Software\Microsoft\Windows\Windows Error Reporting`<br/>`HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting`| *ComputerName _reg_Recovery.TXT*|
    |`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\Runonce`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\RunonceEx`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run`<br/>`HKLM\ Software\Microsoft\Windows\CurrentVersion\Run`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\Runonce`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\RunonceEx`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce`<br/>`HKLM\Software\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad`<br/>`HKCU\Software\Microsoft\Windows NT\CurrentVersion\Load`<br/>`HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\Run`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit`| *ComputerName _reg_Startup.TXT*|
    |`HKLM\SYSTEM\CurrentControlSet\Control\Print`| *ComputerName _reg_Print.HIV*|
    |`HKCU\Software\Policies`<br/>`HKLM\Software\Policies`<br/>`HKCU\Software\Microsoft\Windows\CurrentVersion\Policies`<br/>`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies`| *ComputerName _reg_Policies.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones`| *ComputerName _reg_TimeZone.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Terminal Server`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Terminal Server Web Access`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\TermService`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\TermDD`| *ComputerName _reg_TermServices.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\MRxSmb`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\SMB`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\MRxSmb10`<br/>`HKLM\SYSTEM\CurrentControlSet\Services\MRxSmb20`| *ComputerName _reg_SMB.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`| *ComputerName _reg_TCPIPParameters*|
    |`HKLM\SYSTEM\CurrentControlSet\Services\VSS`| *ComputerName _reg_VSS.TXT*|
    |`HKLM\SYSTEM\CurrentControlSet\Services\iScsiPrt`<br/>`HKLM\SOFTWARE\Microsoft\iSCSI Target`<br/>`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\iSCSI`| *ComputerName _reg_iSCSI.TXT*|
    |`HKLM\System\CurrentControlSet\Control\MPDev`<br/>`HKLM\System\CurrentControlSet\Control\iSCSIPrt`<br/>`HKLM\System\CurrentControlSet\Services\MSiSCSI`<br/>`HKLM\System\CurrentControlSet\Services\MSDsm`<br/>`HKLM\System\CurrentControlSet\Services\MPIO`<br/>`HKLM\System\CurrentControlSet\Control\Class\{4d36e97b-e325-11ce-bfc1-08002be10318}`<br/>`HKLM\System\CurrentControlSet\Services\Tcpip`| *ComputerName _reg_Storage.TXT*|
    |`HKLM\SYSTEM\CurrentControlSet\Enum`| *ComputerName _reg_Enum.TXT*|
    |`HKLM\System\CurrentControlSet\services\ClusSvc`<br>`HKLM\System\CurrentControlSet\services\CluDisk`| *ComputerName _reg_ClusSvc.TXT*|
    |`HKLM\Cluster`| *ComputerName _Cluster.hiv*|
    |||
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
  |Cluster logs that are generated by Get-ClusterLog Windows PowerShell cmdlet| *ComputerName _Cluster.Log*|
  |Cluster MPS Tool (clusmps.exe) output| *ComputerName _Cluster_MPS_Information.txt*|
  |Cluster validation reports files that are located at `\Windows\Cluster\Reports\*.mht`| *ComputerName _\*.mht*|
  |Cluster reports XML files that are located at `\Windows\Cluster\Reports\*.xml`| *ComputerName _\*.xml*|
  |Cluster validation log files from `\Windows\Cluster\Reports\Validate*.log`| *ComputerName _Validade\*.log*|
  |Cluster resources properties that use the Windows PowerShell Get-ClusterResource cmdlet| *ComputerName _ClusterProperties.txt*|
  |Cluster Dependency Report that is generated by the Get-ClusterResourceDependencyReport Windows PowerShell cmdlet| *ComputerName _DependencyReport.mht*|
  |Cluster Shared Volume information - HTML format| *ComputerName _CSVInfo.htm*|
  |Cluster basic Validation Report that is generated by the Test-Cluster Windows PowerShell cmdlet| *ComputerName _ValidationReport.mht*|
  |||
    > [!NOTE]
    > This information will be collected if the SQL Server Setup data-collection diagnostic tool detects that the computer on which the tool is running is a cluster.

- **Information about SQL Server instances that are installed on the computer**

    |Description|File name|
    |---|---|
    |MSI Installer information for SQL Server products| *ComputerName _FindSQLInstalls.txt*|
    |||

- **Information about TCP/IP ports that are used on the computer**

    |Description|File name|
    |---|---|
    |TCP/IP port usage information| *ComputerName _PortUsage.txt*|
    |||

- **Information about User Rights Assignments**

    |Description|File name|
    |---|---|
    |Local User Right Assignments| *ComputerName _userrights.txt*|
    |||

- **Backup of the Setup Bootstrap folder for SQL Server installations**

    |Description|File name|
    |---|---|
    |Compressed directory `%programfiles%\ Microsoft SQL Server\90\Setup Bootstrap\Log`| *ComputerName _SQL90_Bootstrap.Cab*|
    |Compressed directory `%programfiles%\ Microsoft SQL Server\100\Setup Bootstrap\Log`| *ComputerName _SQL100_Bootstrap.Cab*|
    |Compressed directory `%programfiles%\ Microsoft SQL Server\110\Setup Bootstrap\Log`| *ComputerName _SQL110_Bootstrap.Cab*|
    |||

- **SQL Server error logs for all instances of SQL Server that are installed on the computer**

    |Description|File name|
    |---|---|
    |Collects SQL Server error logs for all instances that are installed on the computer on which the diagnostic tool is executed. The number of files that are collected is determined by how many error logs exist on the file system.|Named instance:<br/> *ComputerName _ instance_name _.errorlog*<br/>Default instance:<br/> *ComputerName _MSSQLSERVER_.errorlog*|
    |||

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
