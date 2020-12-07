---
title: SQL Base Diagnostics Collector
description: This article describes the information that may be collected from a computer when the SQL Base Diagnostics Collector tool is running.
ms.date: 11/11/2020
ms.prod-support-area-path: General
ms.reviewer: ramakoni, dansha
ms.prod: sql
---
# SQL Base Diagnostics Collector for Windows Server

This article describes the information that may be collected from a computer when the SQL Base Diagnostics Collector tool is running.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2696886

## Summary

The SQL Base Diagnostics Collector for Windows Server collects diagnostic information that is useful in troubleshooting a broad class of issues that involve the Microsoft SQL Server engine. The SQL Base Diagnostics collector also collects limited diagnostic information for SQL Server Analysis Services.

The SQL Base Diagnostics Collector supports the SQL Server and SQL Server Analysis Services.

## Prerequisite software

There are different prerequisites to run diagnostic packages, depending on the operating system of the target computer. The diagnostic will automatically check your computer for these prerequisites and start executing if they are already installed. Or, you are prompted to install the prerequisites if they are not already available on the computer. The Microsoft Automated Troubleshooting Service (MATS) may also install required software for you. For example, if Windows PowerShell is not present on the target computer, MATS will install it automatically. For more information, see [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970).

## Required Windows rights

The SQL Server Base Diagnostics Collector must be run by a user who has administrative rights on the computer where the SQL Base Diagnostics Collector is executed.

## SQL Server security requirements

The SQL Base Diagnostics Collector discovers all instances of SQL Server that are installed on the computer where the diagnostics tool is run. As part of the data collection process, the SQL Base Diagnostics Collector will try to connect to each instance of SQL Server that the diagnostic tool discovers to collect information about the current SQL Server configuration and server "state." Database connections are made by using Windows authentication. The user who is executing the SQL Base Diagnostics Collector must have a Windows logon that is a member in the sysadmin fixed server role for the following diagnostic collection tasks to succeed:

- SQL Server AlwaysOn Configuration Collection
- SQLDIAG Data Collection Scripts

## Support for Windows failover clusters

The SQL Base Diagnostics Collector is cluster-aware and will collect cluster-specific information when the diagnostic tool is run against a Windows Server Failover Cluster.

To diagnose SQL Server AlwaysOn Availability Group failovers, or SQL Server cluster resource failovers, you may have to run the SQL Base Diagnostic collector against more than one cluster node to collect all the necessary troubleshooting information:

- Run the SQL Base Diagnostic Collector against the cluster node that currently owns the SQL Server AlwaysOn Availability Group or SQL Server cluster resource that experienced the failover. This is necessary as the information that is collected for SQL Server and SQL Server AlwaysOn resides on the cluster disk resource, and is failed over with the AlwaysOn Availability Group or SQL Server cluster resource to the new owning node.

- Run the SQL Base Diagnostic Collector against the node where the failure occurred. This enables the collection of the cluster log from the cluster node where the failure occurred.

## Information that is collected

- System event log  

    > [!NOTE]
    > The SQL Base Diagnostics Collector collects events from the last 30 days.

    |Description|File name|
    |---|---|
    |System event log in TXT, CSV, and EVT or EVTX formats| *<COMPUTER_NAME>_ evt_System.csv*<br/> *<COMPUTER_NAME>_ evt_System.txt*<br/> *<COMPUTER_NAME>_ evt_System.(evt or evtx)*|
    |||

- Application event log  

    > [!NOTE]
    > The SQL Base Diagnostics Collector collects events from the last 30 days.

    |Description|File name|
    |---|---|
    |Application event log in TXT, CSV, and EVT or EVTX formats| *<COMPUTER_NAME>_ evt_Application.csv* <br/> *<COMPUTER_NAME>_ evt_Application.txt* <br/> *<COMPUTER_NAME>_ evt_Application.(evt or evtx)* |
    |||

- Registry information that is related to Session Manager and to debugging

    |Description|File name|
    |---|---|
    |Collect Registry Key - HKLM\Software\Microsoft\Windows NT\CurrentVersion\AEDebug| *<COMPUTER_NAME>_Recovery_Registry.txt*|
    |Collect Registry Key - HKLM\Software\Microsoft\DrWatson| *<COMPUTER_NAME>_Recovery_Registry.txt* |
    |Collect Registry Key - HKLM\System\CurrentControlSet\Services\i8042prt\Parameters| *<COMPUTER_NAME>_Recovery_Registry.txt* |
    |Collect Registry Key - HKLM\System\CurrentControlSet\Control| *<COMPUTER_NAME>_Recovery_Registry.txt* |
    |Collect Registry Key - HKLM\System\CurrentControlSet\Control\Session Manager| *<COMPUTER_NAME>_Recovery_Registry.txt*|
    |||

- Existing Dr. Watson log files and Windows error reporting memory dumps for the SQL Server process

    |Description|File Name|
    |---|---|
    |Report that contains information about memory dumps and about computer settings that are related to memory dumps in htm and txt formats| *<COMPUTER_NAME>_DumpReport.htm* <br/> *<COMPUTER_NAME>_DumpReport.txt* |
    |Windows error reporting memory dump files for SQL Server process that are at most 30 days old and less than or equal to 25 MB| *<COMPUTER_NAME>* _DMP_(Date).zip<br/><br/>|
    |||

- Information about all services that are installed on the destination computer

    |Description|File Name|
    |---|---|
    |Collect information about services that are installed on the target computer| *<COMPUTER_NAME>_SC_Services_Output.txt* |
    |||

- Information about filter drivers that are installed on the destination computer

    |Description|File Name|
    |---|---|
    |Upper and lower filter drivers enumerated by the fltrfind.exe utility| *<COMPUTER_NAME>* _FltrFind.txt|
    |||

- Report of mini-filter drivers

    |Description|File Name|
    |---|---|
    |Enumerate mini-filter drivers by using Fltmc.exe| *<COMPUTER_NAME>_Fltmc.TXT*|
    |||

- Information about all the running processes and driver details together with their file versions

    |Description|File Name|
    |---|---|
    |%programfiles%\*.sys| *<COMPUTER_NAME>_sym_ProgramFiles_SYS.CSV* |
    |%programfiles%\*.sys| *<COMPUTER_NAME>_sym_ProgramFiles_SYS.TXT* |
    |Running Drivers| *<COMPUTER_NAME>_sym_RunningDrivers.CSV* |
    |Running Drivers| *<COMPUTER_NAME>_sym_RunningDrivers.TXT* |
    |%windir%\system32\drivers\*.*| *<COMPUTER_NAME>_sym_Drivers.CSV*|
    |%windir%\system32\drivers\*.*| *<COMPUTER_NAME>_sym_Drivers.TXT* |
    |%SystemRoot%\System32\iscsi*.*| *<COMPUTER_NAME>_sym_MS_iSCSI.CSV* |
    |%SystemRoot%\System32\iscsi*.*| *<COMPUTER_NAME>* _sym_MS_iSCSI.TXT* |
    |Running Processes| *<COMPUTER_NAME>_sym_Process.CSV* |
    |Running Processes| *<COMPUTER_NAME>_sym_Process.TXT* |
    |%SystemRoot%\System32\*.DLL| *<COMPUTER_NAME>_sym_System32_DLL.CSV* |
    |%SystemRoot%\System32\*.DLL| <COMPUTER_NAME>_sym_System32_DLL.TXT* |
    |%SystemRoot%\System32\*.EXE| *<COMPUTER_NAME>_sym_System32_EXE.CSV* |
    |%SystemRoot%\System32\*.EXE| *<COMPUTER_NAME>_sym_System32_EXE.TXT* |
    |%SystemRoot%\System32\*.SYS| *<COMPUTER_NAME>_sym_System32_SYS.CSV* |
    |%SystemRoot%\System32\*.SYS| *<COMPUTER_NAME>_sym_System32_SYS.TXT* |
    |%SystemRoot%\SysWOW64\*.dll| *<COMPUTER_NAME>_sym_SysWOW64_DLL.CSV* |
    |%SystemRoot%\SysWOW64\*.dll| *<COMPUTER_NAME>_sym_SysWOW64_DLL.TXT* |
    |%SystemRoot%\SysWOW64\*.exe| *<COMPUTER_NAME>_sym_SysWOW64_EXE.CSV* |
    |%SystemRoot%\SysWOW64\*.exe| *<COMPUTER_NAME>_sym_SysWOW64_EXE.TXT* |
    |%SystemRoot%\SysWOW64\*.sys| *<COMPUTER_NAME>_sym_SysWOW64_SYS.CSV* |
    |%SystemRoot%\SysWOW64\*.sys| *<COMPUTER_NAME>_sym_SysWOW64_SYS.TXT* |
    |||

- Performance-related information that is captured from the destination computer

    |Description|File Name|
    |---|---|
    |One-minute basic perfmon capture of overall system performance from Windows Server 2008 and later versions| *<COMPUTER_NAME>_Performance Counter.blg* |
    |One-minute basic perfmon capture of overall system performance from Windows Server 2003| *<COMPUTER_NAME>_Perfmon_(DateAndTime).blg* |
    |System performance report that is generated from the collected perfmon log| *<COMPUTER_NAME>_report.html*|
    |||

- Information about the networking configuration of the destination computer

    |Description|File Name|
    |---|---|
    |This report outputs the number of unique local TCP ports in use (above the starting port) for each IP address and process on the target computer| *<COMPUTER_NAME>_PortUsage.txt*|
    |SMB Basic Information| *<COMPUTER_NAME>_SMB-Info.txt*|
    |TCP/IP Basic Information| *<COMPUTER_NAME>_TcpIp-Info.txt*|
    |DNS Client Hosts file| *<COMPUTER_NAME>_DnsClient_HostsFile.TXT*|
    |IPCONFIG /DISPLAYDNS command output| *<COMPUTER_NAME>_DnsClient_ipconfig-displaydns.TXT*|
    |NETSH DNSCLIENT SHOW STATE command output<br/><br/>> [!NOTE]<br/>> This command not valid on Windows Server 2003| *<COMPUTER_NAME>_DnsClient_netsh_dnsclient-show-state.TXT*|
    |DNS Client Registry Entries| *<COMPUTER_NAME>_DnsClient_reg_.TXT*|
    |||

- List of updates that are installed on the destination computer

    |Description|File Name|
    |---|---|
    |List of updates that are installed on the target computer in CSV, TXT, and HTM format| *<COMPUTER_NAME>_Hotfixes.CSV*<br/> *<COMPUTER_NAME>_Hotfixes.TXT*<br/> *<COMPUTER_NAME>_Hotfixes.HTM*|
    |||

- Information about scheduled tasks that are configured on the destination computer 

    |Description|File Name|
    |---|---|
    |Scheduled tasks list in CSV and TXT format| *<COMPUTER_NAME>_schtasks.csv*<br/> *<COMPUTER_NAME>_schtasks.txt*|
    |||

- Boot configuration data for the destination computer

    |Description|File Name|
    |---|---|
    |Output from Bcdedit.exe<br/><br/>> [!NOTE]<br/>> Only collected from Windows 7, Windows Server 2008 R2, Windows Server 2008, and Windows Vista| *<COMPUTER_NAME>_BCDEdit.TXT*|
    |Output from Bcdedit.exe<br/><br/>> [!NOTE]<br/>> Only collected from Windows 7, Windows Server 2008 R2, Windows Server 2008, and Windows Vista| *<COMPUTER_NAME>_BCD-Backup.BKP*|
    |Boot.ini<br/><br/>> [!NOTE]<br/>> Only collected on Windows Server 2003| *<COMPUTER_NAME>_Boot.ini*|
    |||

- Registry backup and text dump files of CurrentControlSet and SQL Server registry hives

    |Description|File Name|
    |---|---|
    |HKLM\System\CurrentControlSet\SessionManagers| *<COMPUTER_NAME>* _CurrentControlSet_Reg.txt|
    |HKLM\SYSTEM\CurrentControlSet\Control\Lsa| *<COMPUTER_NAME>* _CurrentControlSet_Reg.txt|
    |HKLM\SYSTEM\CurrentControlSet| *<COMPUTER_NAME>* _CurrentControlSet_Reg.hiv|
    |HKLM\SOFTWARE\Microsoft\Microsoft SQL Server|<COMPUTER_NAME>_REG_SQL.TXT|
    |HKLM\SOFTWARE\Microsoft\MSSQLServer| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Microsoft\Microsoft SQL Server 2005 Redist| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\Software\Microsoft\MSFTESQLInstMap| <COMPUTER_NAME>_REG_SQL.TXT|
    |HKLM\SOFTWARE\Microsoft\Microsoft SQL Native Client| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Microsoft\OLAP Server| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Microsoft\SNAC| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Microsoft\SQLXML4| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\Software\Microsoft\Vsa| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\ODBC|*<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Microsoft\MSDTS| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Microsoft\MSXML 6.0 Parser and SDK|*<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Microsoft\MSXML60| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKCU\Software\Microsoft\Microsoft SQL Server| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Microsoft\Microsoft SQL Server| *<COMPUTER_NAME>_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\MSSQLServer| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server 2005 Redist| <COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Native Client| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Native Client 10.0| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\SNAC| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\SQLXML4| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |HKLM\Software\Wow6432Node\Microsoft\Vsa| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Wow6432Node\ODBC| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\MSDTS| *<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT*|
    |Backup of HKLM\SOFTWARE\Microsoft\Microsoft SQL Server key in HIV format| *<COMPUTER_NAME>_Microsoft_SQL_Server.HIV*|
    |||

- Output of PSTAT utility

    |Description|File Name|
    |---|---|
    |Output from PSTAT.EXE| *<COMPUTER_NAME>_PStat.txt*|
    |||

- Windows firewall information

    |Description|File name|
    |---|---|
    |Windows Firewall Advanced Security event log in TXT, CSV, and EVTX formats<br/><br/>> [!NOTE]<br/>> Available only on Windows 7 and Windows Server 2008 R2| *<COMPUTER_NAME>_evt_WindowsFirewallWithAdvancedSecurity-Firewall_evt_.csv*<br/><br/> *<COMPUTER_NAME>_evt_WindowsFirewallWithAdvancedSecurity-Firewall_evt_.txt*<br/><br/> *<COMPUTER_NAME>_evt_WindowsFirewallWithAdvancedSecurity-Firewall_evt_.evtx*|
    |Output of NETSH ADVFIREWALL SHOW command together with various options| *<COMPUTER_NAME>_Firewall_netsh_advfirewall.TXT*<br/><br/>|
    |Output of NETSH advfirewall consec show rule name=all<br/><br/>| *<COMPUTER_NAME>_Firewall_netsh_advfirewall-consec-rules.TXT*|
    |Output of netsh advfirewall export| *<COMPUTER_NAME>_Firewall_netsh_advfirewall-export.wfw*|
    |Output of netsh advfirewall firewall show rule name=all<br/><br/>| *<COMPUTER_NAME>_Firewall_netsh_advfw-firewall-rules.TXT*|
    |HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |HKLM\SYSTEM\CurrentControlSet\Services\BFE| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |HKLM\SYSTEM\CurrentControlSet\Services\MpsSvc| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess"| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |||

- Basic Information that is collected when the SQL Base Diagnostics Collector is run on a Windows failover cluster

    |Description|File name|
    |---|---|
    |Cluster logs that are generated by Get-ClusterLog Windows PowerShell cmdlet| *<COMPUTER_NAME>_cluster.log*|
    |Cluster Properties| *<COMPUTER_NAME>_ClusterProperties.txt*|
    |Cluster Dependency Report| *<COMPUTER_NAME>_ag_DependencyReport.mht*|
    |Names and versions of clustering binaries| *<COMPUTER_NAME>_sym_Cluster.CSV*|
    |Names and versions of clustering binaries| *<COMPUTER_NAME>_sym_Cluster.TXT*|
    |Failover Cluster Manager Administrative event log in TXT, CSV, and EVTX formats<br/><br/><br/><br/>> [!NOTE]<br/>> Available only on Windows Server 2008 R2 failover cluster nodes| *<COMPUTER_NAME>_evt_FailoverClusteringManager-Admin.csv*<br/><br/> *<COMPUTER_NAME>_evt_FailoverClusteringManager-Admin.txt*<br/><br/> *<COMPUTER_NAME>_evt_FailoverClusteringManager-Admin.evtx*|
    |Failover Cluster Operational Eventlog in TXT, CSV, and EVTX formats<br/><br/>> [!NOTE]<br/>> Available only on Windows Server 2008 R2 failover cluster nodes| *<COMPUTER_NAME>_evt_FailoverClustering-Operational.csv*<br/><br/> *<COMPUTER_NAME>_evt_FailoverClustering-Operational.txt*<br/><br/> *<COMPUTER_NAME>_evt_FailoverClustering-Operational.evtx*<br/><br/>|
    |||

- Windows cluster registry keys

    |Description|File name|
    |---|---|
    |HKLM\System\CurrentControlSet\services\CluDisk| *<COMPUTER_NAME>_reg_ClusDisk.txt*|
    |HKLM\System\CurrentControlSet\services\ClusSvc| *<COMPUTER_NAME>_reg_ClusSvc.txt*|
    |HKLM\Cluster| *<COMPUTER_NAME>_reg_Cluster.hiv*|
    |||

- Information about user rights assignments on the destination computer

    |Description|File name|
    |---|---|
    |Local User Rights Assignments| *<COMPUTER_NAME>_UserRights.txt*|
    |||

- Information about the domain the destination computer is joined to

    |Description|File name|
    |---|---|
    |Information about the domain the target computer is joined to| *<COMPUTER_NAME>_DSMisc.txt*|
    |||

- Information about the operating system and whether the destination computer is a VM

    |Description|File name|
    |---|---|
    |Reports virtualization status of target VM| *<COMPUTER_NAME>_Virtualization.htm*|
    |Reports virtualization status of target VM| *<COMPUTER_NAME>_Virtualization.TXT*|
    |||

- Information about Active Directory Group Policies that are applied to the destination computer

    |Description|File name|
    |---|---|
    |Information about group policies that are applied to the target computer| *<COMPUTER_NAME>_GPResult.txt*|
    |Information about group policies that are applied to the target computer| *<COMPUTER_NAME>_GPResult.htm*|
    |||

- Autorun information

    > [!NOTE]
    > For more information about the Autorun utility, see [Autoruns for Windows v13.98](/sysinternals/downloads/autoruns).

    |Description|File name|
    |---|---|
    |Autorun information in .htm format| *<COMPUTER_NAME>_Autoruns.htm*|
    |Autorun information in .xml format| *<COMPUTER_NAME>_Autoruns.XML*|
    |||

- Kerberos tickets and TGT

    |Description|File name|
    |---|---|
    |Kerberos tickets and TGT| *<COMPUTER_NAME>_ Kerberos_klist.txt*|
    |||

- Information about the Windows Volume Shadow Copy Service configuration on the destination computer

    |Description|File name|
    |---|---|
    |Windows Volume Shadow Copy Service information| *<COMPUTER_NAME>_VSSAdmin.TXT*|
    |||

- SQL Server error logs

  The SQL Base Diagnostics Collector will collect up to 20 SQL Server error logs for each discovered instance that meets the following criteria:

  - Each error log file size must be 200 MB or less.
  - The maximum total uncompressed size of all collected error log files cannot exceed 250 MB. When the 250-MB limit is reached, no additional error logs are collected for the instance of SQL Server.

  |Description|File name|
  |---|---|
  |Collects SQL Server error logs for all instances that are installed on the computer on which the diagnostic tool is executed.| Named instance: <br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_1033_ERRORLOG[.n]*<br/><br/> Default instance: <br/> *<COMPUTER_NAME>_MSSQLSERVER_ERRORLOG[.n]*|
  |||

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server error logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server Agent logs

  The SQL Base Diagnostics Collector will collect up to 20 SQL Server Agent logs for each discovered instance that meets the following criteria:

  - Each SQL Server Agent log file size must be 200 MB or less.
  - The maximum total uncompressed size of all collected SQL Server Agent log files cannot exceed 250 MB. When the 250-MB limit is reached, no additional SQL Server Agent log files are collected for the instance of SQL Server.

  |Description|File name|
  |---|---|
  |Collects SQL Server Agent logs for all instances that are installed on the computer on which the diagnostic tool is executed.| Named instance: <br/> `<COMPUTER_NAME>_<INSTANCE_NAME>_1033_SQLAGENT.[OUT|n]` <br/> Default instance: <br/> `<COMPUTER_NAME>_MSSQLSERVER__1033_SQLAGENT.[OUT|n]`|
  |||

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server Agent logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server minidump files

  The SQL Base Diagnostics Collector will collect up to 10 SQL Server minidump files for each discovered instance of SQL Server. The files are collected in descending order, based on the creation date of the minidump file. This means that the most recently generated files are collected first. The collected files must meet the following criteria:

  - Each minidump file size must be 250 MB or less.
  - Each minidump file must be 30 days old or less.
  - The maximum total uncompressed size of all collected minidump files for a given instance of SQL Server cannot exceed 300 MB. When the 300-MB limit is reached, no additional minidump files are collected for the instance of SQL Server

  > [!NOTE]
  > All the files for a given instance are compressed into a zip archive before they are collected.

  |Description|File name|
  |---|---|
  |SQL Server minidump files| Named instance: <br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_1033_SqlMiniDumps.zip*<br/><br/> Default instance: <br/> *<COMPUTER_NAME>_MSSQLSERVER_1033_SqlMiniDumps.zip*|
  |A dump inventory report is generated and collected for each discovered instance of SQL Server| Named instance: <br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_DumpInventory.log*<br/><br/> Default Instance: <br/> *<COMPUTER_NAME>_MSSQLSERVER_DumpInventory.log*|
  |||

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server minidump files are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQLDIAG data collection script

  The SQLDIAG data collection script will be executed against each instance of SQL Server that has a service status of "RUNNING." The script output is redirected to a file and collected by the diagnostic.

  |Description|File name|
  |---|---|
  |SQLDIAG script output| Named instance: <br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_1033_sp_sqldiag_Shutdown.OUT*<br/><br/> Default Instance: <br/> *<COMPUTER_NAME>_MSSQLSERVER_1033_sp_sqldiag_Shutdown.OUT*|
  |||

- SQL Server AlwaysOn configuration information

  > [!NOTE]
  > The SQL Server AlwaysOn configuration information is only collected from SQL Server 2012 instances.

  |Description|File name|
  |---|---|
  |SQL Server AlwaysOn configuration information| Named instance: <br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_1033_AlwaysOn.OUT*<br/><br/> Default Instance: <br/> *<COMPUTER_NAME>_MSSQLSERVER_1033_AlwaysOn.OUT*|
  |||

- SQL Server AlwaysOn health logs

  SQL Server AlwaysOn health session logs are collected from each SQL Server 2012 instance that is installed on the destination computer. The files are collected and compressed into "instance specific" zip archives.

  The maximum number of SQL Server AlwaysOn Health logs that will be collected for each discovered instance is 20. The files are collected in descending order, based on the creation date of the file.

  |Description|File name|
  |---|---|
  |SQL Server AlwaysOn health logs| Named instance: <br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_AlwaysOn_health_XeLogs.zip*<br/><br/> Default Instance: <br/> *<COMPUTER_NAME>_MSSQLSERVER_AlwaysOn_health_XeLogs.zip*|
  |||

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server AlwaysOn health logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server failover cluster health logs

  SQL Server failover cluster health logs are collected from each "clustered" SQL Server 2012 instance that is installed on the destination computer. The files are collected and compressed into "instance specific" zip archives.

  The maximum number of failover cluster health logs that will be collected for each instance is 20. The files are collected in descending order, based on the creation date of the file.

  |Description|File name|
  |---|---|
  |SQL Server failover cluster health logs| Named instance: <br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_FailoverCluster_health_XeLogs.zip*<br/><br/> Default Instance: <br/> *<COMPUTER_NAME>_MSSQLSERVER_FailoverCluster_health_XeLogs.zip*|
  |||

  > [!NOTE]
  > The SQL Server failover cluster health logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server default system health logs

  SQL Server default system health logs are collected from each SQL Server 2012 instance that is installed on the destination computer. The files are collected and compressed into "instance specific" ZIP archives

  |Description|File name|
  |---|---|
  |SQL Server default system health logs| Named instance: <br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_system_health_XeLogs.zip*<br/><br/> Default Instance: <br/> *<COMPUTER_NAME>_MSSQLSERVER_system_health_XeLogs.zip*|
  |||

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server default system health logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server Analysis Services configuration file

  The SQL Server Analysis Services configuration file will be collected for each Analysis Services instance that is discovered on the destination computer.

  |Description|File name|
  |---|---|
  |SQL Server Analysis Services configuration file| *<COMPUTER_NAME>_<INSTANCE_NAME>_1033_msmdsrv.ini*|
  |||

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server Analysis Services configuration files are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server Analysis Services registry keys

  |Description|File name|
  |---|---|
  |HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\<OLAP_INSTANCE_ROOT_KEY>| *<COMPUTER_NAME>_reg_HKLM_OLAP_IntanceRoot_all.txt*<br/>|
  |HKCR:\MSOLAP<br/>HKCR:\MSOLAP.2<br/>HKCR:\MSOLAP.3<br/>HKCR:\MSOLAP.4| *<COMPUTER_NAME>_reg_HKCR_MSOLAP_all.txt*<br/><br/>|
  |HKLM:\System\CurrentControlSet\Services\<OLAP_Service_Name>| *<COMPUTER_NAME>_reg_HKLM_CurrentControlSet_Services_OLAP.txt*|
  |||

- SQL Server Analysis Services log file  

  The SQL Server Analysis Services log file will be collected for each Analysis Services instance that is discovered on the destination computer.

  |Description|File name|
  |---|---|
  |SQL Server Analysis Services log file| *<COMPUTER_NAME><INSTANCE_NAME>_msmdsrv.log*|
  |||

- SQL Server Analysis Services Flight Recorder traces  

  The SQL Server Analysis Services flight recorder traces will be collected for each Analysis Services instance that is discovered on the destination computer  

  |Description|File name|
  |---|---|
  |Current SQL Server Analysis Services Flight recorder| *<COMPUTER_NAME>-<INSTANCE_NAME>_FlightRecorderCurrent.trc*|
  |Previous SQL Server Analysis Services Flight recorder| *<COMPUTER_NAME>-<INSTANCE_NAME>_FlightRecorderBack.trc*|
  |||

- SQL Server Analysis Services minidump files

  The SQL Base Diagnostics Collector will collect up to 10 SQL Server Analysis Services minidump files for each discovered instance of SQL Server Analysis Service. The files are collected in descending order, based on the creation date of the minidump file. This means that the most recently generated files are collected first. The collected files must meet the following criteria:

  - Each minidump file size must be 250 MB or less.
  - Each minidump file must be 30 days old or less.
  - The maximum total uncompressed size of all collected minidump files for a given instance of SQL Server cannot exceed 300 MB. When the 300-MB limit is reached, no additional minidump files are collected for the instance of SQL Server Analysis Services.

  > [!NOTE]
  > All the files for a given instance are compressed into a zip archive before they are collected.

  |Description|File name|
  |---|---|
  |SQL Server Analysis Services minidump files|Named instance:<br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_1033_ASMiniDumps*<br/>.zip<br/><br/>Default instance:<br/> *<COMPUTER_NAME>_MSSQLSERVER_1033_ASMiniDumps .zip*|
  |A dump inventory report is generated and collected for each discovered instance of SQL Server Analysis Services|Named instance:<br/> *<COMPUTER_NAME>_<INSTANCE_NAME>_DumpInventory.log*<br/><br/>Default Instance:<br/> *<COMPUTER_NAME>_MSSQLSERVER_DumpInventory.log*|
  |||
