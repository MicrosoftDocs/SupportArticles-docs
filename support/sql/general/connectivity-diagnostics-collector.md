---
title: Connectivity Diagnostics Collector
description: This article describes the information that is collected by the SQL Server Connectivity Diagnostics Collector.
ms.date: 08/19/2020
ms.topic: article
---
# Information is collected by the SQL Server Connectivity Diagnostics Collector

This article describes the information that is collected by the SQL Server Connectivity Diagnostics Collector.

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2008, SQL Server 2008 R2, SQL Server 2005  
_Original KB number:_ &nbsp; 2871695

## Summary

The Microsoft SQL Server Connectivity Diagnostics Collector for Windows Server 2003 R2, Windows Vista, Windows Server 2008, Windows Server 2008 R2, Windows 7, Windows 8, Windows 8.1, Windows Server 2012 and Windows Server 2012 R2 collects diagnostic information that is useful in troubleshooting a broad class of connectivity issues with SQL Server. The SQL Server Connectivity Diagnostics Collector also collects limited diagnostic information for SQL Server Analysis Services.

The SQL Server Connectivity Diagnostics Collector supports the following versions of SQL Server:

- SQL Server 2005
- SQL Server 2008
- SQL Server 2008 R2
- SQL Server 2012

## Prerequisite software

There are different prerequisites to run diagnostic packages, depending on the operating system of the destination computer. The diagnostic will automatically check your computer for these prerequisites and start executing if they are already installed. Or, you are prompted to install the prerequisites if they are not already available on the computer. The Microsoft Automated Troubleshooting Service (MATS) may also install required software for you. For example, if Windows PowerShell is not present on the destination computer, MATS will install it automatically. For more information, see [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970).

## Required Windows rights

The SQL Server Connectivity Diagnostics Collector must be run by a user who has administrative rights on the computer on which the SQL Server Connectivity Diagnostics Collector is running.

## SQL Server security requirements

The SQL Server Connectivity Diagnostics Collector discovers all instances of SQL Server that are installed on the computer on which the diagnostics tool is run. As part of the data-collection process, the SQL Server Connectivity Diagnostics Collector tries to connect to each instance of SQL Server that the diagnostic tool discovers to collect information about the current SQL Server configuration and server "state". Database connections are made by using Windows authentication. For the following diagnostic collection tasks to succeed, the user who is executing the SQL Server Connectivity Diagnostics Collector must have a Windows logon that is a member of the sysadmin fixed server role:

- SQL Server Always On Configuration Collection
- SQLDIAG Data Collection Scripts

## Support for Windows failover clusters

To diagnose SQL Server Always On Availability Group connectivity or clustered SQL Server connectivity, you may have to run the SQL Server Connectivity Diagnostic Collector against more than one cluster node to collect all the necessary troubleshooting information as follows:

- Run the SQL Server Connectivity Diagnostic Collector against the cluster node that currently owns the SQL Server Always On Availability Group or SQL Server cluster resource that is experiencing the connectivity issue.

- Run the SQL Server Connectivity Diagnostic Collector against the node where a connectivity failure occurred previously. This enables the collection of various logs from the cluster node where the failure occurred previously.

## Information that is collected

- **General information**

    | Description| File name |
    |---|---|
    |Basic system information. This includes computer name, service pack number, computer model, and processor name and speed.|_<COMPUTER_NAME>_ System_Information.txt_|
    |Virtualization information, and so on.|_<COMPUTER_NAME>_ DiscoveryReport.xml_|
    |List of roles and features that are installed on server media. (Windows Server 2008 R2 and later versions)|_<COMPUTER_NAME>_ ResultReport.xml_|

- **System log**  

    > [!NOTE]
    > The SQL Server Connectivity Diagnostics Collector collects events from the past 15 days.

    | Description| File name |
    |---|---|
    |System log in TXT, CSV, and EVT or EVTX formats|_<COMPUTER_NAME>_ evt_System.csv_</br>_<COMPUTER_NAME>_ evt_System.txt_</br>_<COMPUTER_NAME>_ evt_System.evt_ or</br>_<COMPUTER_NAME>_ evt_System.evtx_|

- **Application log**

    > [!NOTE]
    > The SQL Server Connectivity Diagnostics Collector collects events from the past 15 days.

    | Description| File name |
    |---|---|
    |Application log in TXT, CSV, and EVT or EVTX format|_<COMPUTER_NAME>_ evt_Application.csv_</br>_<COMPUTER_NAME>_ evt_Application.txt_</br>_<COMPUTER_NAME>_ evt_Application.evt_ or</br>_<COMPUTER_NAME>_ evt_Application.evtx_|

- **Information about user and system environment variables on the destination computer**

    | Description| File name |
    |---|---|
    |Information about user and system environment variables in the context of the current user on the destination computer in XML and TXT format|_<COMPUTER_NAME>_ EnvironmentVariables.xml_</br>_<COMPUTER_NAME>_ EnvironmentVariables.txt_|

- **Information about all services that are installed on the destination computer**

    | Description| File name |
    |---|---|
    |Information about services that are installed on the destination computer|_<COMPUTER_NAME>_SC_Services_Output.xml_|

- **Information about filter drivers that are installed on the destination computer**

    | Description| File name |
    |---|---|
    |Enumerate upper and lower filter drivers by using Fltrfind.exe|_<COMPUTER_NAME>_FltrFind.txt_|

- **Report of mini-filter drivers**

    | Description| File name |
    |---|---|
    |Enumerate mini-filter drivers by using Fltmc.exe|_<COMPUTER_NAME>_Fltmc.txt_|

- **Information about all the running processes and driver details together with their file versions**

    | Description| File name |
    |---|---|
    |Running drivers|_<COMPUTER_NAME>_sym_RunningDrivers.csv_|
    |Running drivers|_<COMPUTER_NAME>_sym_RunningDrivers.txt_|
    |`%windir%\system32\drivers\*.*`|_<COMPUTER_NAME>_sym_Drivers.csv_|
    |`%windir%\system32\drivers\*.*`|_<COMPUTER_NAME>_sym_Drivers.txt_|
    |Running processes|_<COMPUTER_NAME>_sym_Process.csv_|
    |Running processes|_<COMPUTER_NAME>_sym_Process.txt_|

- **Information about the networking configuration of the destination computer**

    | Description| File name |
    |---|---|
    |Basic SMB configuration information such as output of net.exe subcommands such as net share, net sessions, net use, net accounts, and net config.|_<COMPUTER_NAME>_SMB-Info.txt_|
    |Basic TCP/IP and networking configuration information such as TCP/IP registry key and outputs from ipconfig, netstat, nbtstat, and netsh commands.|_<COMPUTER_NAME>_TcpIp-Info.txt_|
    |DNS Client hosts file|_<COMPUTER_NAME>_DnsClient_HostsFile.txt_|
    | IPCONFIG/DISPLAYDNS command output|_<COMPUTER_NAME>_DnsClient_ipconfig-displaydns.txt_|
    | NETSH DNSCLIENT SHOW STATE command output</br></br> **NOTE** This command is not valid on Windows Server 2003|_<COMPUTER_NAME>_DnsClient_netsh_dnsclient-show-state.TXT_|
    |DNS Client registry entries|*<COMPUTER_NAME>_DnsClient_reg_.txt*|
    |TCP/IP parameters registry key `HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`</br></br>|_<COMPUTER_NAME>_TcpIp_Parameters_Registry.xml_|
    |Network adapter properties|_<COMPUTER_NAME>_NetworkAdapterConfigurations.xml_|

- **Registry backup and text dump files of CurrentControlSet and SQL Server registry hives**

    | Description| File name |
    |---|---|
    |`HKLM\System\CurrentControlSet\SessionManagers`|_<COMPUTER_NAME>_CurrentControlSet_Reg.txt_|
    |`HKLM\SYSTEM\CurrentControlSet\Control\Lsa`|_<COMPUTER_NAME>_CurrentControlSet_Reg.txt_|
    |`HKLM\SYSTEM\CurrentControlSet`|_<COMPUTER_NAME>_CurrentControlSet_Reg.hiv_|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\MSSQLServer`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server 2005 Redist`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\Software\Microsoft\MSFTESQLInstMap`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Native Client`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\OLAP Server`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\SNAC`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\SQLXML4`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\Software\Microsoft\Vsa`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\ODBC`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\MSDTS`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\MSXML 6.0 Parser and SDK`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\MSXML60`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKCU\Software\Microsoft\Microsoft SQL Server`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server`|_<COMPUTER_NAME>_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\Microsoft\MSSQLServer`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Server 2005 Redist`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Native Client`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\Microsoft\Microsoft SQL Native Client 10.0`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\Microsoft\SNAC`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\Microsoft\SQLXML4`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\Software\Wow6432Node\Microsoft\Vsa`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\ODBC`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`HKLM\SOFTWARE\Wow6432Node\Microsoft\MSDTS`|_<COMPUTER_NAME>_Wow6432Node_REG_SQL.txt_|
    |`Backup of HKLM\SOFTWARE\Microsoft\Microsoft SQL Server key in HIV format`|_<COMPUTER_NAME>_Microsoft_SQL_Server.hiv_|

- **Output of the PSTAT utility**

    | Description| File name |
    |---|---|
    |Output from PSTAT.EXE|_<COMPUTER_NAME>_PStat.txt_|

- **Windows firewall information**

    | Description| File name |
    |---|---|
    |Output of the netsh advfirewall show command together with various options|_<COMPUTER_NAME>_Firewall_netsh_advfirewall.txt_|
    |Output of netsh advfirewall consec show rule name=all|_<COMPUTER_NAME>_Firewall_netsh_advfirewall-consec-rules.txt_|
    |Output of netsh advfirewall export|_<COMPUTER_NAME>_Firewall_netsh_advfirewall-export.wfw_|
    |Output of netsh advfirewall firewall show rule name=all|_<COMPUTER_NAME>_Firewall_netsh_advfirewall-firewall-rules.txt_|
    |Output of netsh wfp show netevents|_<COMPUTER_NAME>_Firewall_netsh_wfp-show-netevents.txt_|
    |`HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall`|*<COMPUTER_NAME>_Firewall_reg_.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Services\BFE`|*<COMPUTER_NAME>_Firewall_reg_.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT`|*<COMPUTER_NAME>_Firewall_reg_.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Services\MpsSvc`|*<COMPUTER_NAME>_Firewall_reg_.txt*|
    |`HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess`|*<COMPUTER_NAME>_Firewall_reg_.txt*|

- **Information about user rights assignments on the destination computer**

    | Description| File name |
    |---|---|
    |Local user rights assignments|_<COMPUTER_NAME>_UserRights.txt_|

- **Information about the domain to which the destination computer is joined**

    | Description| File name |
    |---|---|
    |Information about the domain to which the destination computer is joined.|_<COMPUTER_NAME>_DSMisc.txt_|

- **Kerberos tickets and TGT**  

    | Description| File name |
    |---|---|
    |Kerberos tickets and TGT|_<COMPUTER_NAME>_ Kerberos_klist.txt_|

- **Kerberos, LSA, and SChannel registry keys on the destination computer**

    | Description| File name |
    |---|---|
    |`HKLM:\System\CurrentControlSet\Control\Lsa`</br>`HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0`</br>`HKLM:\System\CurrentControlSet\Control\Lsa\Kerberos\Parameters`</br>`HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters`</br>`HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL`|_<COMPUTER_NAME>_ Authentication_Registry.xml_|

- **Server network configuration of all instances of SQL Server on the destination computer**

    | Description| File name |
    |---|---|
    |SQL Server network configurations (TCP/IP, NP, Shared Memory, and so on) for all instances of SQL Server. Also, (Database Engine) instances on the destination computer. This includes both 64-bit and 32-bit instances on a 64-bit computer.|_<COMPUTER_NAME>_ SqlServer_Network_Configurations.xml_|

- **Active Directory properties and SPNs of SQL Server service accounts on the destination computer**

    | Description| File name |
    |---|---|
    |Active directory properties and SPNs of SQL Server service accounts on the destination computer|_<COMPUTER_NAME>_ SqlServiceAccounts_SPN_ADProperties.xml_</br>_<COMPUTER_NAME>_ SQLInstances_Spn_Summary.xml_|

- **SQL Server error logs**

    The SQL Server Connectivity Diagnostics Collector will collect up to 20 SQL Server error logs for each discovered instance that meets the following criteria:

  - The size of each error log file must be 200 MB or less.
  - The maximum total uncompressed size of all collected error log files cannot exceed 250 MB. When the 250-MB limit is reached, no additional error logs are collected for the instance of SQL Server.

   | Description| File name |
   |---|---|
   |Collects SQL Server error logs for all instances that are installed on the computer on which the diagnostic tool is executed.| Named instance: </br>_<COMPUTER_NAME>_<INSTANCE_NAME>_1033_ERRORLOG[.n]_</br></br> Default instance: </br>_<COMPUTER_NAME>_MSSQLSERVER_ERRORLOG[.n]_|

    > [!NOTE]
    > When the SQL Server Connectivity Diagnostics Collector is executed against a Windows failover cluster, SQL Server error logs are only collected if they are stored on a drive that is "owned" and "online" to the destination cluster node.

- **SQL Server Agent logs**

    The SQL Server Connectivity Diagnostics Collector will collect up to 20 SQL Server Agent logs for each discovered instance that meets the following criteria:

  - The size of each SQL Server Agent log file must be 200 MB or less.
  - The maximum total uncompressed size of all collected SQL Server Agent log files cannot exceed 250 MB. When the 250-MB limit is reached, no additional SQL Server Agent log files are collected for the instance of SQL Server.

  | Description| File name |
  |---|---|
  |Collects SQL Server Agent logs for all instances that are installed on the computer on which the diagnostic tool is executed.| Named instance: </br>*<COMPUTER_NAME>_<INSTANCE_NAME >_1033_SQLAGENT.[OUT \| n]*</br></br> Default instance: </br>*<COMPUTER_NAME>_MSSQLSERVER__1033_SQLAGENT.[OUT \|n]*|

    > [!NOTE]
    > When the SQL Server Connectivity Diagnostics Collector is executed against a Windows failover cluster, SQL Server Agent logs are only collected if they are stored on a drive that is "owned" and "online" to the destination cluster node.

- **SQL Server minidump files**

    The SQL Server Connectivity Diagnostics Collector will collect up to 10 SQL Server minidump files for each discovered instance of SQL Server. The files are collected in descending order, based on the creation date of the minidump file. This means that the most recently generated files are collected first. The collected files must meet the following criteria:

  - The size of each minidump file must be 100 megabytes (MB) or less.
  - Each minidump file must be 30 days old or less.
  - The maximum total uncompressed size of all collected minidump files for a given instance of SQL Server cannot exceed 200 MB. When the 200-MB limit is reached, no additional minidump files are collected for the instance of SQL Server.

    > [!NOTE]
    > All the files for a given instance are compressed into a zip archive before they are collected.

  | Description| File name |
  |---|---|
  |SQL Server minidump files| Named instance: </br>_<COMPUTER_NAME>_<INSTANCE_NAME>_1033_SqlMiniDumps.zip_</br></br> Default instance: </br>_<COMPUTER_NAME>_MSSQLSERVER_1033_SqlMiniDumps .zip_|
  |A dump inventory report is generated and collected for each discovered instance of SQL Server.| Named instance: </br>_<COMPUTER_NAME>_<INSTANCE_NAME>_DumpInventory.log_</br></br> Default Instance: </br>_<COMPUTER_NAME>_MSSQLSERVER_DumpInventory.log_|

    > [!NOTE]
    > When the SQL Server Connectivity Diagnostics Collector is executed against a Windows failover cluster, SQL Server minidump files are only collected if they are stored on a drive that is "owned" and "online" to the destination cluster node.

- **SQLDIAG data-collection script**

    The SQLDIAG data-collection script will be executed against each instance of SQL Server that has a service status of "RUNNING." The script output is redirected to a file and collected by the diagnostic.

    | Description| File name |
    |---|---|
    |SQLDIAG script output| Named instance: </br>_<COMPUTER_NAME>_<INSTANCE_NAME>_1033_sp_sqldiag_Shutdown.out_</br></br> Default Instance: </br>_<COMPUTER_NAME>_MSSQLSERVER_1033_sp_sqldiag_Shutdown.out_|

- **SQL Server Always On configuration information**

    > [!NOTE]
    > The SQL Server Always On configuration information is collected only from instances of SQL Server 2012.

    | Description| File name |
    |---|---|
    |SQL Server Always On configuration information| Named instance: </br>_<COMPUTER_NAME>_<INSTANCE_NAME>_1033_AlwaysOn.out_</br></br> Default Instance: </br>_<COMPUTER_NAME>_MSSQLSERVER_1033_AlwaysOn.out_|

- **SQL Server Always On health logs**

    SQL Server Always On health session logs are collected from each instance of SQL Server 2012 that is installed on the destination computer. The files are collected and compressed into "instance specific" compressed archives.

    The maximum number of SQL Server Always On Health logs that will be collected for each discovered instance is 20. The files are collected in descending order, based on the creation date of the file.

    | Description| File name |
    |---|---|
    |SQL Server Always On health logs| Named instance: </br>_<COMPUTER_NAME>_<INSTANCE_NAME>_AlwaysOn_health_XeLogs.zip_</br></br> Default Instance: </br>_<COMPUTER_NAME>_MSSQLSERVER_AlwaysOn_health_XeLogs.zip_|

    > [!NOTE]
    > When the SQL Server Connectivity Diagnostics Collector is executed against a Windows failover cluster, SQL Server Always On health logs are collected only if they are stored on a drive that is "owned" and "online" to the destination cluster node.

- **SQL Server failover cluster health logs**

    SQL Server failover cluster health logs are collected from each "clustered" instance of SQL Server 2012 that is installed on the destination computer. The files are collected and compressed into "instance specific" compressed archives.

    The maximum number of failover cluster health logs that will be collected for each instance is 20. The files are collected in descending order, based on the creation date of the file.

    | Description| File name |
    |---|---|
    |SQL Server failover cluster health logs| Named instance: </br>_<COMPUTER_NAME>_<INSTANCE_NAME>_FailoverCluster_health_XeLogs.zip_</br></br> Default Instance: </br>_<COMPUTER_NAME>_MSSQLSERVER_FailoverCluster_health_XeLogs.zip_|

    > [!NOTE]
    > The SQL Server failover cluster health logs are collected only if they are stored on a drive that is "owned" and "online" to the destination cluster node.

- **SQL Server default system health logs**

    SQL Server default system health logs are collected from each instance of SQL Server 2012 that is installed on the destination computer. The files are collected and compressed into "instance specific" compressed archives.

    | Description| File name |
    |---|---|
    |SQL Server default system health logs| Named instance: </br>_<COMPUTER_NAME>_<INSTANCE_NAME>_system_health_XeLogs.zip_</br></br> Default Instance: </br>_<COMPUTER_NAME>_MSSQLSERVER_system_health_XeLogs.zip_|

    > [!NOTE]
    > When the SQL Server Connectivity Diagnostics Collector is executed against a Windows failover cluster, SQL Server default system health logs are collected only if they are stored on a drive that is "owned" and "online" to the destination cluster node.

## Applies to

- SQL Server 2012 Business Intelligence
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Parallel Data Warehouse
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 Standard
- SQL Server 2008 Standard Edition for Small Business
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2008 Express with Advanced Services
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Parallel Data Warehouse
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2005 Developer Edition
- SQL Server 2005 Enterprise Edition
- SQL Server 2005 Enterprise X64 Edition
- SQL Server 2005 Evaluation Edition
- SQL Server 2005 Express Edition
- SQL Server 2005 Express Edition with Advanced Services
- SQL Server 2005 Standard Edition
- SQL Server 2005 Standard X64 Edition
- SQL Server 2005 Workgroup Edition
