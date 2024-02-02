---
title: SQL Base Diagnostics Collector
description: This article describes the information that may be collected from a computer when the SQL Base Diagnostics Collector tool is running.
ms.date: 11/11/2020
ms.custom: sap:General
ms.reviewer: ramakoni, dansha
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

- SQL Server Always On Configuration Collection
- SQLDIAG Data Collection Scripts

## Support for Windows failover clusters

The SQL Base Diagnostics Collector is cluster-aware and will collect cluster-specific information when the diagnostic tool is run against a Windows Server Failover Cluster.

To diagnose SQL Server Always On Availability Group failovers, or SQL Server cluster resource failovers, you may have to run the SQL Base Diagnostic collector against more than one cluster node to collect all the necessary troubleshooting information:

- Run the SQL Base Diagnostic Collector against the cluster node that currently owns the SQL Server Always On Availability Group or SQL Server cluster resource that experienced the failover. This is necessary as the information that is collected for SQL Server and SQL Server Always On resides on the cluster disk resource, and is failed over with the Always On Availability Group or SQL Server cluster resource to the new owning node.

- Run the SQL Base Diagnostic Collector against the node where the failure occurred. This enables the collection of the cluster log from the cluster node where the failure occurred.

## Information that is collected

- System event log  

    > [!NOTE]
    > The SQL Base Diagnostics Collector collects events from the last 30 days.

    |Description|File name|
    |---|---|
    |System event log in TXT, CSV, and EVT or EVTX formats| _<COMPUTER_NAME>_ evt_System.csv_<br/> _<COMPUTER_NAME>_ evt_System.txt_<br/> _<COMPUTER_NAME>_ evt_System.(evt or evtx)_|

- Application event log  

    > [!NOTE]
    > The SQL Base Diagnostics Collector collects events from the last 30 days.

    |Description|File name|
    |---|---|
    |Application event log in TXT, CSV, and EVT or EVTX formats| _<COMPUTER_NAME>_ evt_Application.csv_ <br/> _<COMPUTER_NAME>_ evt_Application.txt_ <br/> _<COMPUTER_NAME>_ evt_Application.(evt or evtx)_ |

- Registry information that is related to Session Manager and to debugging

    |Description|File name|
    |---|---|
    |Collect Registry Key - HKLM\Software\Microsoft\Windows NT\CurrentVersion\AEDebug| _<COMPUTER_NAME>_Recovery_Registry.txt_|
    |Collect Registry Key - HKLM\Software\Microsoft\DrWatson| _<COMPUTER_NAME>_Recovery_Registry.txt_ |
    |Collect Registry Key - HKLM\System\CurrentControlSet\Services\i8042prt\Parameters| _<COMPUTER_NAME>_Recovery_Registry.txt_ |
    |Collect Registry Key - HKLM\System\CurrentControlSet\Control| _<COMPUTER_NAME>_Recovery_Registry.txt_ |
    |Collect Registry Key - HKLM\System\CurrentControlSet\Control\Session Manager| _<COMPUTER_NAME>_Recovery_Registry.txt_|

- Existing Dr. Watson log files and Windows error reporting memory dumps for the SQL Server process

    |Description|File Name|
    |---|---|
    |Report that contains information about memory dumps and about computer settings that are related to memory dumps in htm and txt formats| _<COMPUTER_NAME>_DumpReport.htm_ <br/> _<COMPUTER_NAME>_DumpReport.txt_ |
    |Windows error reporting memory dump files for SQL Server process that are at most 30 days old and less than or equal to 25 MB| _<COMPUTER_NAME>_ _DMP_(Date).zip<br/><br/>|

- Information about all services that are installed on the destination computer

    |Description|File Name|
    |---|---|
    |Collect information about services that are installed on the target computer| _<COMPUTER_NAME>_SC_Services_Output.txt_ |

- Information about filter drivers that are installed on the destination computer

    |Description|File Name|
    |---|---|
    |Upper and lower filter drivers enumerated by the fltrfind.exe utility| _<COMPUTER_NAME>_ _FltrFind.txt|

- Report of mini-filter drivers

    |Description|File Name|
    |---|---|
    |Enumerate mini-filter drivers by using Fltmc.exe| _<COMPUTER_NAME>_Fltmc.TXT_|

- Information about all the running processes and driver details together with their file versions

    |Description|File Name|
    |---|---|
    |%programfiles%\*.sys| _<COMPUTER_NAME>_sym_ProgramFiles_SYS.CSV_ |
    |%programfiles%\*.sys| _<COMPUTER_NAME>_sym_ProgramFiles_SYS.TXT_ |
    |Running Drivers| _<COMPUTER_NAME>_sym_RunningDrivers.CSV_ |
    |Running Drivers| _<COMPUTER_NAME>_sym_RunningDrivers.TXT_ |
    |%windir%\system32\drivers\*.*| _<COMPUTER_NAME>_sym_Drivers.CSV_|
    |%windir%\system32\drivers\*.*| _<COMPUTER_NAME>_sym_Drivers.TXT_ |
    |%SystemRoot%\System32\iscsi*.*| _<COMPUTER_NAME>_sym_MS_iSCSI.CSV_ |
    |%SystemRoot%\System32\iscsi*.*| _<COMPUTER_NAME>_ _sym_MS_iSCSI.TXT* |
    |Running Processes| _<COMPUTER_NAME>_sym_Process.CSV_ |
    |Running Processes| _<COMPUTER_NAME>_sym_Process.TXT_ |
    |%SystemRoot%\System32\*.DLL| _<COMPUTER_NAME>_sym_System32_DLL.CSV_ |
    |%SystemRoot%\System32\*.DLL| <COMPUTER_NAME>_sym_System32_DLL.TXT* |
    |%SystemRoot%\System32\*.EXE| _<COMPUTER_NAME>_sym_System32_EXE.CSV_ |
    |%SystemRoot%\System32\*.EXE| _<COMPUTER_NAME>_sym_System32_EXE.TXT_ |
    |%SystemRoot%\System32\*.SYS| _<COMPUTER_NAME>_sym_System32_SYS.CSV_ |
    |%SystemRoot%\System32\*.SYS| _<COMPUTER_NAME>_sym_System32_SYS.TXT_ |
    |%SystemRoot%\SysWOW64\*.dll| _<COMPUTER_NAME>_sym_SysWOW64_DLL.CSV_ |
    |%SystemRoot%\SysWOW64\*.dll| _<COMPUTER_NAME>_sym_SysWOW64_DLL.TXT_ |
    |%SystemRoot%\SysWOW64\*.exe| _<COMPUTER_NAME>_sym_SysWOW64_EXE.CSV_ |
    |%SystemRoot%\SysWOW64\*.exe| _<COMPUTER_NAME>_sym_SysWOW64_EXE.TXT_ |
    |%SystemRoot%\SysWOW64\*.sys| _<COMPUTER_NAME>_sym_SysWOW64_SYS.CSV_ |
    |%SystemRoot%\SysWOW64\*.sys| _<COMPUTER_NAME>_sym_SysWOW64_SYS.TXT_ |

- Performance-related information that is captured from the destination computer

    |Description|File Name|
    |---|---|
    |One-minute basic perfmon capture of overall system performance from Windows Server 2008 and later versions| _<COMPUTER_NAME>_Performance Counter.blg_ |
    |One-minute basic perfmon capture of overall system performance from Windows Server 2003| *<COMPUTER_NAME>_Perfmon_(DateAndTime).blg* |
    |System performance report that is generated from the collected perfmon log| _<COMPUTER_NAME>_report.html_|

- Information about the networking configuration of the destination computer

    |Description|File Name|
    |---|---|
    |This report outputs the number of unique local TCP ports in use (above the starting port) for each IP address and process on the target computer| _<COMPUTER_NAME>_PortUsage.txt_|
    |SMB Basic Information| _<COMPUTER_NAME>_SMB-Info.txt_|
    |TCP/IP Basic Information| _<COMPUTER_NAME>_TcpIp-Info.txt_|
    |DNS Client Hosts file| _<COMPUTER_NAME>_DnsClient_HostsFile.TXT_|
    |IPCONFIG /DISPLAYDNS command output| _<COMPUTER_NAME>_DnsClient_ipconfig-displaydns.TXT_|
    |NETSH DNSCLIENT SHOW STATE command output<br/><br/>> [!NOTE]<br/>> This command not valid on Windows Server 2003| _<COMPUTER_NAME>_DnsClient_netsh_dnsclient-show-state.TXT_|
    |DNS Client Registry Entries| *<COMPUTER_NAME>_DnsClient_reg_.TXT*|

- List of updates that are installed on the destination computer

    |Description|File Name|
    |---|---|
    |List of updates that are installed on the target computer in CSV, TXT, and HTM format| _<COMPUTER_NAME>_Hotfixes.CSV_<br/> _<COMPUTER_NAME>_Hotfixes.TXT_<br/> _<COMPUTER_NAME>_Hotfixes.HTM_|

- Information about scheduled tasks that are configured on the destination computer

    |Description|File Name|
    |---|---|
    |Scheduled tasks list in CSV and TXT format| _<COMPUTER_NAME>_schtasks.csv_<br/> _<COMPUTER_NAME>_schtasks.txt_|

- Boot configuration data for the destination computer

    |Description|File Name|
    |---|---|
    |Output from Bcdedit.exe<br/><br/>> [!NOTE]<br/>> Only collected from Windows 7, Windows Server 2008 R2, Windows Server 2008, and Windows Vista| _<COMPUTER_NAME>_BCDEdit.TXT_|
    |Output from Bcdedit.exe<br/><br/>> [!NOTE]<br/>> Only collected from Windows 7, Windows Server 2008 R2, Windows Server 2008, and Windows Vista| _<COMPUTER_NAME>_BCD-Backup.BKP_|
    |Boot.ini<br/><br/>> [!NOTE]<br/>> Only collected on Windows Server 2003| _<COMPUTER_NAME>_Boot.ini_|

- Registry backup and text dump files of CurrentControlSet and SQL Server registry hives

    |Description|File Name|
    |---|---|
    |HKLM\System\CurrentControlSet\SessionManagers| _<COMPUTER_NAME>_ _CurrentControlSet_Reg.txt|
    |HKLM\SYSTEM\CurrentControlSet\Control\Lsa| _<COMPUTER_NAME>_ _CurrentControlSet_Reg.txt|
    |HKLM\SYSTEM\CurrentControlSet| _<COMPUTER_NAME>_ _CurrentControlSet_Reg.hiv|
    |HKLM\SOFTWARE\Microsoft\Microsoft SQL Server|<COMPUTER_NAME>_REG_SQL.TXT|
    |HKLM\SOFTWARE\Microsoft\MSSQLServer| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Microsoft\Microsoft SQL Server 2005 Redist| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\Software\Microsoft\MSFTESQLInstMap| <COMPUTER_NAME>_REG_SQL.TXT|
    |HKLM\SOFTWARE\Microsoft\Microsoft SQL Native Client| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Microsoft\OLAP Server| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Microsoft\SNAC| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Microsoft\SQLXML4| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\Software\Microsoft\Vsa| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\ODBC|_<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Microsoft\MSDTS| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Microsoft\MSXML 6.0 Parser and SDK|_<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Microsoft\MSXML60| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKCU\Software\Microsoft\Microsoft SQL Server| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Microsoft\Microsoft SQL Server| _<COMPUTER_NAME>_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\MSSQLServer| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server 2005 Redist| <COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Native Client| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Native Client 10.0| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\SNAC| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\SQLXML4| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |HKLM\Software\Wow6432Node\Microsoft\Vsa| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Wow6432Node\ODBC| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |HKLM\SOFTWARE\Wow6432Node\Microsoft\MSDTS| _<COMPUTER_NAME>_Wow6432Node_REG_SQL.TXT_|
    |Backup of HKLM\SOFTWARE\Microsoft\Microsoft SQL Server key in HIV format| _<COMPUTER_NAME>_Microsoft_SQL_Server.HIV_|

- Output of PSTAT utility

    |Description|File Name|
    |---|---|
    |Output from PSTAT.EXE| _<COMPUTER_NAME>_PStat.txt_|

- Windows firewall information

    |Description|File name|
    |---|---|
    |Windows Firewall Advanced Security event log in TXT, CSV, and EVTX formats<br/><br/>> [!NOTE]<br/>> Available only on Windows 7 and Windows Server 2008 R2| *<COMPUTER_NAME>_evt_WindowsFirewallWithAdvancedSecurity-Firewall_evt_.csv*<br/><br/> *<COMPUTER_NAME>_evt_WindowsFirewallWithAdvancedSecurity-Firewall_evt_.txt*<br/><br/> *<COMPUTER_NAME>_evt_WindowsFirewallWithAdvancedSecurity-Firewall_evt_.evtx*|
    |Output of NETSH ADVFIREWALL SHOW command together with various options| _<COMPUTER_NAME>_Firewall_netsh_advfirewall.TXT_<br/><br/>|
    |Output of NETSH advfirewall consec show rule name=all<br/><br/>| _<COMPUTER_NAME>_Firewall_netsh_advfirewall-consec-rules.TXT_|
    |Output of netsh advfirewall export| _<COMPUTER_NAME>_Firewall_netsh_advfirewall-export.wfw_|
    |Output of netsh advfirewall firewall show rule name=all<br/><br/>| _<COMPUTER_NAME>_Firewall_netsh_advfw-firewall-rules.TXT_|
    |HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |HKLM\SYSTEM\CurrentControlSet\Services\BFE| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |HKLM\SYSTEM\CurrentControlSet\Services\MpsSvc| *<COMPUTER_NAME>_Firewall_reg_.TXT*|
    |HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess"| *<COMPUTER_NAME>_Firewall_reg_.TXT*|

- Basic Information that is collected when the SQL Base Diagnostics Collector is run on a Windows failover cluster

    |Description|File name|
    |---|---|
    |Cluster logs that are generated by Get-ClusterLog Windows PowerShell cmdlet| _<COMPUTER_NAME>_cluster.log_|
    |Cluster Properties| _<COMPUTER_NAME>_ClusterProperties.txt_|
    |Cluster Dependency Report| _<COMPUTER_NAME>_ag_DependencyReport.mht_|
    |Names and versions of clustering binaries| _<COMPUTER_NAME>_sym_Cluster.CSV_|
    |Names and versions of clustering binaries| _<COMPUTER_NAME>_sym_Cluster.TXT_|
    |Failover Cluster Manager Administrative event log in TXT, CSV, and EVTX formats<br/><br/><br/><br/>> [!NOTE]<br/>> Available only on Windows Server 2008 R2 failover cluster nodes| _<COMPUTER_NAME>_evt_FailoverClusteringManager-Admin.csv_<br/><br/> _<COMPUTER_NAME>_evt_FailoverClusteringManager-Admin.txt_<br/><br/> _<COMPUTER_NAME>_evt_FailoverClusteringManager-Admin.evtx_|
    |Failover Cluster Operational Eventlog in TXT, CSV, and EVTX formats<br/><br/>> [!NOTE]<br/>> Available only on Windows Server 2008 R2 failover cluster nodes| _<COMPUTER_NAME>_evt_FailoverClustering-Operational.csv_<br/><br/> _<COMPUTER_NAME>_evt_FailoverClustering-Operational.txt_<br/><br/> _<COMPUTER_NAME>_evt_FailoverClustering-Operational.evtx_<br/><br/>|

- Windows cluster registry keys

    |Description|File name|
    |---|---|
    |HKLM\System\CurrentControlSet\services\CluDisk| _<COMPUTER_NAME>_reg_ClusDisk.txt_|
    |HKLM\System\CurrentControlSet\services\ClusSvc| _<COMPUTER_NAME>_reg_ClusSvc.txt_|
    |HKLM\Cluster| _<COMPUTER_NAME>_reg_Cluster.hiv_|

- Information about user rights assignments on the destination computer

    |Description|File name|
    |---|---|
    |Local User Rights Assignments| _<COMPUTER_NAME>_UserRights.txt_|

- Information about the domain the destination computer is joined to

    |Description|File name|
    |---|---|
    |Information about the domain the target computer is joined to| _<COMPUTER_NAME>_DSMisc.txt_|

- Information about the operating system and whether the destination computer is a VM

    |Description|File name|
    |---|---|
    |Reports virtualization status of target VM| _<COMPUTER_NAME>_Virtualization.htm_|
    |Reports virtualization status of target VM| _<COMPUTER_NAME>_Virtualization.TXT_|

- Information about Active Directory Group Policies that are applied to the destination computer

    |Description|File name|
    |---|---|
    |Information about group policies that are applied to the target computer| _<COMPUTER_NAME>_GPResult.txt_|
    |Information about group policies that are applied to the target computer| _<COMPUTER_NAME>_GPResult.htm_|

- Autorun information

    > [!NOTE]
    > For more information about the Autorun utility, see [Autoruns for Windows v13.98](/sysinternals/downloads/autoruns).

    |Description|File name|
    |---|---|
    |Autorun information in .htm format| _<COMPUTER_NAME>_Autoruns.htm_|
    |Autorun information in .xml format| _<COMPUTER_NAME>_Autoruns.XML_|

- Kerberos tickets and TGT

    |Description|File name|
    |---|---|
    |Kerberos tickets and TGT| _<COMPUTER_NAME>_ Kerberos_klist.txt_|

- Information about the Windows Volume Shadow Copy Service configuration on the destination computer

    |Description|File name|
    |---|---|
    |Windows Volume Shadow Copy Service information| _<COMPUTER_NAME>_VSSAdmin.TXT_|

- SQL Server error logs

  The SQL Base Diagnostics Collector will collect up to 20 SQL Server error logs for each discovered instance that meets the following criteria:

  - Each error log file size must be 200 MB or less.
  - The maximum total uncompressed size of all collected error log files cannot exceed 250 MB. When the 250-MB limit is reached, no additional error logs are collected for the instance of SQL Server.

  |Description|File name|
  |---|---|
  |Collects SQL Server error logs for all instances that are installed on the computer on which the diagnostic tool is executed.| Named instance: <br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_1033_ERRORLOG[.n]_<br/><br/> Default instance: <br/> _<COMPUTER_NAME>_MSSQLSERVER_ERRORLOG[.n]_|

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server error logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server Agent logs

  The SQL Base Diagnostics Collector will collect up to 20 SQL Server Agent logs for each discovered instance that meets the following criteria:

  - Each SQL Server Agent log file size must be 200 MB or less.
  - The maximum total uncompressed size of all collected SQL Server Agent log files cannot exceed 250 MB. When the 250-MB limit is reached, no additional SQL Server Agent log files are collected for the instance of SQL Server.

  |Description|File name|
  |---|---|
  |Collects SQL Server Agent logs for all instances that are installed on the computer on which the diagnostic tool is executed.| Named instance: <br/> `<COMPUTER_NAME>_<INSTANCE_NAME>_1033_SQLAGENT.[OUT|n]` <br/> Default instance: <br/> `<COMPUTER_NAME>_MSSQLSERVER__1033_SQLAGENT.[OUT|n]`|

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
  |SQL Server minidump files| Named instance: <br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_1033_SqlMiniDumps.zip_<br/><br/> Default instance: <br/> _<COMPUTER_NAME>_MSSQLSERVER_1033_SqlMiniDumps.zip_|
  |A dump inventory report is generated and collected for each discovered instance of SQL Server| Named instance: <br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_DumpInventory.log_<br/><br/> Default Instance: <br/> _<COMPUTER_NAME>_MSSQLSERVER_DumpInventory.log_|

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server minidump files are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQLDIAG data collection script

  The SQLDIAG data collection script will be executed against each instance of SQL Server that has a service status of "RUNNING." The script output is redirected to a file and collected by the diagnostic.

  |Description|File name|
  |---|---|
  |SQLDIAG script output| Named instance: <br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_1033_sp_sqldiag_Shutdown.OUT_<br/><br/> Default Instance: <br/> _<COMPUTER_NAME>_MSSQLSERVER_1033_sp_sqldiag_Shutdown.OUT_|

- SQL Server Always On configuration information

  > [!NOTE]
  > The SQL Server Always On configuration information is only collected from SQL Server 2012 instances.

  |Description|File name|
  |---|---|
  |SQL Server Always On configuration information| Named instance: <br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_1033_AlwaysOn.OUT_<br/><br/> Default Instance: <br/> _<COMPUTER_NAME>_MSSQLSERVER_1033_AlwaysOn.OUT_|

- SQL Server Always On health logs

  SQL Server Always On health session logs are collected from each SQL Server 2012 instance that is installed on the destination computer. The files are collected and compressed into "instance specific" zip archives.

  The maximum number of SQL Server Always On Health logs that will be collected for each discovered instance is 20. The files are collected in descending order, based on the creation date of the file.

  |Description|File name|
  |---|---|
  |SQL Server Always On health logs| Named instance: <br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_AlwaysOn_health_XeLogs.zip_<br/><br/> Default Instance: <br/> _<COMPUTER_NAME>_MSSQLSERVER_AlwaysOn_health_XeLogs.zip_|

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server Always On health logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server failover cluster health logs

  SQL Server failover cluster health logs are collected from each "clustered" SQL Server 2012 instance that is installed on the destination computer. The files are collected and compressed into "instance specific" zip archives.

  The maximum number of failover cluster health logs that will be collected for each instance is 20. The files are collected in descending order, based on the creation date of the file.

  |Description|File name|
  |---|---|
  |SQL Server failover cluster health logs| Named instance: <br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_FailoverCluster_health_XeLogs.zip_<br/><br/> Default Instance: <br/> _<COMPUTER_NAME>_MSSQLSERVER_FailoverCluster_health_XeLogs.zip_|

  > [!NOTE]
  > The SQL Server failover cluster health logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server default system health logs

  SQL Server default system health logs are collected from each SQL Server 2012 instance that is installed on the destination computer. The files are collected and compressed into "instance specific" ZIP archives

  |Description|File name|
  |---|---|
  |SQL Server default system health logs| Named instance: <br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_system_health_XeLogs.zip_<br/><br/> Default Instance: <br/> _<COMPUTER_NAME>_MSSQLSERVER_system_health_XeLogs.zip_|

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server default system health logs are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server Analysis Services configuration file

  The SQL Server Analysis Services configuration file will be collected for each Analysis Services instance that is discovered on the destination computer.

  |Description|File name|
  |---|---|
  |SQL Server Analysis Services configuration file| _<COMPUTER_NAME>_<INSTANCE_NAME>_1033_msmdsrv.ini_|

  > [!NOTE]
  > When the SQL Base Diagnostics Collector is executed against a Windows failover cluster, SQL Server Analysis Services configuration files are only collected if they are stored on a drive that is "owned" and "online" to the target cluster node.

- SQL Server Analysis Services registry keys

  |Description|File name|
  |---|---|
  |HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\<OLAP_INSTANCE_ROOT_KEY>| _<COMPUTER_NAME>_reg_HKLM_OLAP_IntanceRoot_all.txt_<br/>|
  |HKCR:\MSOLAP<br/>HKCR:\MSOLAP.2<br/>HKCR:\MSOLAP.3<br/>HKCR:\MSOLAP.4| _<COMPUTER_NAME>_reg_HKCR_MSOLAP_all.txt_<br/><br/>|
  |HKLM:\System\CurrentControlSet\Services\<OLAP_Service_Name>| _<COMPUTER_NAME>_reg_HKLM_CurrentControlSet_Services_OLAP.txt_|

- SQL Server Analysis Services log file  

  The SQL Server Analysis Services log file will be collected for each Analysis Services instance that is discovered on the destination computer.

  |Description|File name|
  |---|---|
  |SQL Server Analysis Services log file| _<COMPUTER_NAME><INSTANCE_NAME>_msmdsrv.log_|

- SQL Server Analysis Services Flight Recorder traces  

  The SQL Server Analysis Services flight recorder traces will be collected for each Analysis Services instance that is discovered on the destination computer  

  |Description|File name|
  |---|---|
  |Current SQL Server Analysis Services Flight recorder| _<COMPUTER_NAME>-<INSTANCE_NAME>_FlightRecorderCurrent.trc_|
  |Previous SQL Server Analysis Services Flight recorder| _<COMPUTER_NAME>-<INSTANCE_NAME>_FlightRecorderBack.trc_|

- SQL Server Analysis Services minidump files

  The SQL Base Diagnostics Collector will collect up to 10 SQL Server Analysis Services minidump files for each discovered instance of SQL Server Analysis Service. The files are collected in descending order, based on the creation date of the minidump file. This means that the most recently generated files are collected first. The collected files must meet the following criteria:

  - Each minidump file size must be 250 MB or less.
  - Each minidump file must be 30 days old or less.
  - The maximum total uncompressed size of all collected minidump files for a given instance of SQL Server cannot exceed 300 MB. When the 300-MB limit is reached, no additional minidump files are collected for the instance of SQL Server Analysis Services.

  > [!NOTE]
  > All the files for a given instance are compressed into a zip archive before they are collected.

  |Description|File name|
  |---|---|
  |SQL Server Analysis Services minidump files|Named instance:<br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_1033_ASMiniDumps_<br/>.zip<br/><br/>Default instance:<br/> _<COMPUTER_NAME>_MSSQLSERVER_1033_ASMiniDumps .zip_|
  |A dump inventory report is generated and collected for each discovered instance of SQL Server Analysis Services|Named instance:<br/> _<COMPUTER_NAME>_<INSTANCE_NAME>_DumpInventory.log_<br/><br/>Default Instance:<br/> _<COMPUTER_NAME>_MSSQLSERVER_DumpInventory.log_|
