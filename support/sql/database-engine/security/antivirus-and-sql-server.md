---
title: Configure Anti-Virus software to work with SQL Server
description: This article provides guidance on how to use anti-virus software with SQL Server
author: pijocoder
ms.author: jopilov
ms.reviewer: jopilov, pijocoder
ms.date: 04/26/2023
ms.prod: sql
ms.topic: troubleshooting
ms.custom: sap:Security Issues
---
# Configure Anti-Virus software to work with SQL Server


This article contains general guidelines to help you decide on what antivirus software to run on computers that are running SQL Server in your environment.

We strongly recommend that you individually assess the security risk for each computer that is running SQL Server in your environment and that you select the tools that are appropriate for the security risk level of each computer that is running SQL Server.

Additionally, we recommend that before you roll out any virus-protection software, you test the entire system under a full load to measure any changes in stability and performance.

Virus protection software requires some system resources to execute. You must perform testing before and after you install your antivirus
software to determine whether there is any performance effect on the computer that is running SQL Server.

## Security risk factors

Consider the following factors when deciding on anti-malware solutions:

- The value to your business of the information that is stored on the computer
- The required security level for that information
- The cost of losing access to that information
- The risk of either virus or bad information propagating from that computer

## High-risk servers

Any server is at some risk of infection. The highest-risk servers
generally meet one or more of the following criteria:

- The servers are open to public Internet.
- The servers have open ports to servers that are not behind a firewall.
- The servers read or execute files from other servers.
- The servers run HTTP servers, such as Internet Information Services (IIS) or Apache
- The servers host file shares.
- The servers use Database Mail to handle incoming or outgoing email messages.

Servers that do not meet the criteria for a high-risk server are
generally at a lower risk, although not always.

## Anti-Virus software types

- Active virus scanning: This kind of scanning checks incoming and outgoing files for viruses.

- Virus sweep software: Virus sweep software scans existing files for file infection. It detects files after they are infected by a virus. This kind of scanning may cause the following SQL Server database recovery and SQL Server full-text catalog file issues:

  - If the virus sweep has opened a database file and still has it open when SQL Server tries to open the database (such as when SQL Server starts or opens a database that AutoClose has closed), the database to which the file belongs might be marked as suspect. SQL Server database files typically have the .mdf, .ldf, or .ndf file name extensions.

  - If the virus sweep software has a SQL Server full-text catalog file open when Full-text Search tries to access the file, you may have problems with the full text catalog.

- Vulnerability scanning software: The Microsoft Security Compliance Toolkit includes a set of tools that enables enterprise security
 administrators to download, analyze, test, edit, and store Microsoft-recommended security configuration baselines for Windows and other Microsoft products and compare them against other security configurations. To download it, go to [Microsoft Security
 Compliance Toolkit 1.0](https://www.microsoft.com/en-us/download/details.aspx?id=55319)

 Additionally, Microsoft released the Microsoft [Windows Malicious Software Removal Tool](https://www.microsoft.com/en-us/download/details.aspx?id=9905) to help remove specific, prevalent malicious software from computers. For more information about the Microsoft Windows Malicious Software Removal Tool, see the following article in the Microsoft Knowledge Base:

 [890830](https://support.microsoft.com/en-us/topic/remove-specific-prevalent-malware-with-windows-malicious-software-removal-tool-kb890830-ba51b71f-39cd-cdec-73eb-61979b0661e0) Remove specific prevalent malware with Windows Malicious Software Removal Tool

> [!NOTE]  
> Windows Server 2016 and later versions automatically enables Windows Defender. Make sure that Windows Defender is configured to exclude **Filestream **files. Failure to do this can result in decreased performance for backup and restore operations.

For more information, see [Configure and validate exclusions for Windows Defender Antivirus scans](/windows/security/threat-protection/windows-defender-antivirus/configure-exclusions-windows-defender-antivirus).


## SQL Server processes to exclude from virus scanning

- SQLServr.exe (SQL Server Database Engine)
- SQLAgent.exe (SQL Server Agent)
- ReportingServicesService.exe (SQL Server Reporting Services)
- MSMDSrv.exe  (SQL Server Analysis Services) 
- sqlbrowser.exe (SQL Server Browser service)
- MsDtsSrvr.exe (SQL Server Integration Services)
- %ProgramFiles%\\Microsoft SQL Server\\1xx\\Shared\\SQLDumper.exe (SQLDumper utility)

For an updated list of services and file paths reference [Services installed by SQL Server](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions#Service_Details)

Applications that are installed on SQL Server computer can load modules into the SQL Server process (sqlservr.exe). The applications can do this to run specific business logic or enhanced functionality, or for intrusion monitoring and protection. To detect if an unknown module or a module from a third-party software was loaded into the process memory space, check the output of the `sys.dm_os_loaded_modules` Dynamic Management View(DMV).

In some cases applications or drivers may be used to detour SQL Server or Windows code to provide malware protection or monitoring services. However, such applications or drivers if not designed correctly may cause a wide variety of issues to products like SQL Server. For information about third-party detours or similar techniques in SQL Server, review [Detours or similar techniques may cause unexpected behaviors with SQL Server](../../general/issue-detours-similar-techniques.md).

## Configure antivirus software to work with SQL Server Database Engine 

This section applies to SQL Server installations running on Windows Systems, both stand-alone and Failover cluster instances (FCI).

## Directories and file name extensions to exclude from virus scanning

When you configure your antivirus software settings, make sure that you exclude the following files or directories (as applicable) from virus scanning. This improves the performance and ensures that the files are not locked when the SQL Server service must use them. However, if these files become infected, your antivirus software cannot detect the infection. For more information about the default file locations for SQL Server, see [File Locations for Default and Named Instances of SQL Server](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server).

- SQL Server data files
  These files usually have one of the following file name extensions:
  - .mdf
  - .ldf
  - .ndf

- SQL Server backup files
    These files frequently have one of the following file name extensions:
  - .bak
  - .trn

- Full-Text catalog files
  - Default instance: Program Files\\Microsoft SQL Server\\MSSQL\\FTDATA
  - Named instance: Program Files\\Microsoft SQL Server\\MSSQL\$instancename\\FTDATA

- Trace files

  These files usually have the .trc file name extension. These files can be generated either when you configure [SQL tracing manually](/sql/relational-databases/sql-trace/create-a-trace-transact-sql) or when you enable [C2 auditing](/sql/database-engine/configure-windows/c2-audit-mode-server-configuration-option) for the server.

-  SQL audit files
 These files have the .sqlaudit file name extension. For more information, review [SQL Server Audit (Database Engine)](/sql/relational-databases/security/auditing/sql-server-audit-database-engine)

- SQL query files

   These files typically have the .sql file name extension and contain Transact-SQL statements.

- Filestream data files

  - No specific file extension for the files.
  - Files are present under the folder structure identified by the container of type FILE_STREAM from `sys.database_files`.

- Remote Blob Storage files

- The directory that holds Reporting Services temporary files and Logs (RSTempFiles and LogFiles). For more information review [Reporting
 Services Log Files and Sources - SQL Server Reporting Services (SSRS)](/sql/reporting-services/report-server/reporting-services-log-files-and-sources) and [RsReportServer.config Configuration File - SQL Server Reporting Services (SSRS)](/sql/reporting-services/report-server/rsreportserver-config-configuration-file)

- Extended Event file targets
  - Typically saved as .xel or .xem.
  - System generated files are saved in the LOG folder for that instance

- Exception dump files
  - Typically use the.mdmp file name extension.
  - System generated files are saved in the LOG folder for that instance

- In-memory OLTP files

  - Native procedure and in-memory table definition-related files
    - Present in a xtp sub-folder under the DATA directory for instance
    - File formats include the following:

      - xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.c
      - xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.dll
      - xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.obj
      - xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.out
      - xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.pdb
      - xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.xml

  - Checkpoint and delta files
    - No specific file extension for the files
    - Files are present under the folder structure identified by the container of type FILE_STREAM from sys.database_files

- DBCC CHECKDB files

  - Files will be of the format: <*Database_data_filename.extension*\>\_MSSQL_DBCC\<*database_id_of_snapshot*\>
  - These are temporary files
  - For more information, review [Internal database snapshot](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#how-dbcc-checkdb-creates-an-internal-snapshot-database-beginning-with-sql-server-2014)

- Replication

  - Replicationexecutables and server-side COM objects.
    - x86 default location:\<*drive*\>:\\Program Files (x86)\\Microsoft SQL Server\\\<*nnn*\>\\COM\\
    - x64 default location: \<*drive*\>:\\Program Files\\Microsoft SQL Server\\\<*nnn*\>\\COM\\

    The *\<nnn\>* place holder is for version-specific information. To specify the correct value, check your installation or search for "Replication and server-side COM objects" in the Specifying File Paths table in [File Locations for Default and Named Instances of SQL Server](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server). For example, the full path for SQL Server 2022 would be\<*drive*\>:\\Program Files\\Microsoft SQL Server\\160\\COM\\.

- Starting with SQL Server 2017 CU22 (including SQL 2019 RTM and later versions), if using Transactional Replication and the Distribution Agent is utilizing OLEDB streaming profile or you are using -UseOledbStreaming parameter, the Distribution Agent creates temporary files (\*.lob) in the AppData folder of the account running the distribution agent where the job is being invoked. For prior versions of SQL the default COM folder (already listed) is used.
  - c:\\Users\\\<*DistributionAgentAccount\>*\\AppData\\Temp\\*.lob

  For more information, please review our troubleshooting document ["The distribution agent failed to create temporary files" error message](/troubleshoot/sql/database-engine/replication/error-run-distribution-agent)

- Files in Replication Snapshot folder

  The default path for the snapshot files is \\Microsoft SQL Server\\MSSQLxx.MSSQLSERVER\\**MSSQL\\ReplData.**These files typically have file name extensions of.sch, .idx, .bcp, .pre, .cft, .dri, .trg or .prc.

### Considerations for Failover Cluster instances (Always On FCI)

You can run antivirus software on a SQL Server cluster. However, you must make sure that the antivirus software is a cluster-aware version.
Contact your antivirus vendor about cluster-aware versions and interoperability.

If you are running antivirus software on a cluster, make sure that you also exclude these locations from virus scanning:

- Q:\\ (Quorum drive)
- C:\\Windows\\
- ClusterMSDTC directory in the MSDTC drive

If you back up the database to a disk or if you back up the transaction log to a disk, you can exclude the backup files from the virus scanning.

For more information about additional antivirus considerations on a
cluster, see the following article:

[Antivirus software cause problems with Cluster Services - Windows Server](/troubleshoot/windows-server/high-availability/not-cluster-aware-antivirus-software-cause-issue)

## Configure antivirus software to work with Analysis Services

**Processes to exclude from virus scanning**

For default instance:%ProgramFiles%\\Microsoft SQLServer\\*\<MSASXX\>.MSSQLSERVER* \\OLAP\\Bin\\MSMDSrv.exeFor named
instance:


%ProgramFiles%\\Microsoft SQL Server\\*MSASXX\>.Instance Name\>*\\OLAP\\Bin\\MSMDSrv.exeThe XX is the build ID. For example, a default Analysis Services 2016 instance binary installation location by default is C:\\Program Files\\Microsoft SQL Server\\MSAS13.MSSQLSERVER\\OLAP\\bin.

**Directories and file name extensions to exclude from virus scanning**

When you configure your antivirus software settings, make sure that you exclude the following files or directories (as applicable) from virus scanning. This improves the performance of the files and helps make sure that the files are not locked when the SQL Server service must use them. However, if these files become infected, your antivirus software cannot detect the infection.

The directory that holds Analysis Services data

**Note** The directory that holds all Analysis Services data is specified by the DataDir property of the instance of Analysis
Services. By default, the path of this directory for a default Analysis Service instance is C:\\Program Files\\Microsoft SQL
Server\\MSASXX.MSSQLSERVER \\OLAP\\Data. The default data path of the Analysis Services named instance is C:\\Program Files\\Microsoft SQL
Server\\MSASXX.\<instance name\>\\OLAP\\Data.

**Note** For Analysis Services 2012 and later versions, temporary files during processing are specified by the TempDir property of the
instance of Analysis Services. By default, this property is empty. When this property is empty, the default directory is used. By
default, the Temp path for a default Analysis Service instance is C:\\Program Files\\Microsoft SQL Server\\MSASXX.MSSQLSERVER
\\OLAP\\Temp. The default Temp path of the Analysis Services named instance is C:\\Program Files\\Microsoft SQL Server\\MSASXX.\<instance name\>\\OLAP\\Temp.

-

 Analysis Services backup files

> **Note** By default, in Analysis Services 2012 and later versions, the backup file location is the location that is specified by the BackupDir property. By default, the Backup path for default Analysis Service instance is C:\\Program Files\\Microsoft SQL Server\\MSASXX.MSSQLSERVER \\OLAP\\Backup. The default Backup path of the Analysis Services named instance is C:\\Program Files\\Microsoft SQL Server\\MSASXX.\<instance name\>\\OLAP\\Backup. You can change this directory in the properties of the instance of Analysis Services. Any backup command can point to a different location. Or, the backup files can be copied elsewhere.

-
- The directory that holds Analysis Services log files

 By default, in Analysis Services 2012 and later versions, the log file location is the location that is specified by the LogDir property. By default, the Log path for a default Analysis Service instance is C:\\Program Files\\Microsoft SQL Server\\MSASXX.MSSQLSERVER \\OLAP\\Log. The default data path of the Analysis Services named instance is C:\\Program Files\\Microsoft SQL Server\\MSASXX.\<instance name\>\\OLAP\\log.

- Directories for any Analysis Services 2012 and later-version partitions that are not stored in the default data directories.

When you create the partitions, these locations are defined in theStorage locationsection of theProcessing and Storage Locationspage of the Partition Wizard.

## Configure antivirus software to work with SQL Server Integration services (SSIS)

??????

## Configure antivirus software to work with Polybase

**Processes to exclude from virus scanning**

PolyBase Engine service (%ProgramFiles%\\Microsoft SQL Server\\\<Instance_ID\>.\<Instance Name\>\\MSSQL\\Binn\\Polybase\\mpdwsvc.exe)

> [!NOTE]  
> PolyBase Data Movement service (DMS) and Engine services use same executable with different command line parameters.

**Directories and file name extensions to exclude from virus scanning**

When you configure your antivirus software settings, make sure that you exclude the following files or directories (as applicable) from virus scanning. This improves the performance of the files and helps make sure that the files are not locked when the Polybase service must use them. However, if these files become infected, your antivirus software cannot detect the infection.

PolyBase log files (%ProgramFiles%\\Microsoft SQL Server\\\<Instance_ID\>.\<Instance Name\>\\MSSQL\\Log\\Polybase\\)

## Configure antivirus software to work with Reporting Services

**Processes to exclude from virus scanning**

%ProgramFiles%\\Microsoft SQL Server\\*\<Instance_ID\>*.*\<Instance Name\>*\\Reporting Services\\ReportServer\\Bin\\ReportingServicesService.exe

**Directories and file name extensions to exclude from virus scanning**

\<?\>

**References**

To find general information about SQL Server security, see the following
SQL Server topics:

[[Securing SQL Server](/sql/relational-databases/security/securing-sql-server)

For general recommendations from Microsoft for scanning on Enterprise
systems, see the following article:
 [822158](https://support.microsoft.com/help/822158) Virus scanning recommendations for Enterprise computers that are running currently supported versions of Windows

For more information on performance issues that can occur when third party modules are loaded into SQL Server review

[Performance and consistency issues when modules or driver are loaded](/troubleshoot/sql/database-engine/performance/performance-consistency-issues-filter-drivers-modules)


## Configure a Firewall with SQL Server products

The following table contains information about how to use a firewall with SQL Server.

| Product | Information about Firewall configuration |
| --- | --- |
| SQL Server Database Engine | [Configure the Windows Firewall to allow SQL Server access](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access) |
| Analysis Services (SSAS) | [Configure the Windows Firewall to Allow Analysis Services Access](/analysis-services/instances/configure-the-windows-firewall-to-allow-analysis-services-access) |
| Integration Services (SSIS) | [Configure the Windows Firewall to allow SQL Server access with Integration Services](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access#ports-used-by-integration-services) |
| Polybase | [Which ports should I allow through my firewall for PolyBase?](/sql/relational-databases/polybase/polybase-faq#which-ports-should-i-allow-through-my-firewall-for-polybase) |
| Reporting services (SSRS) | [Configure a Firewall for Report Server Access](/sql/reporting-services/report-server/configure-a-firewall-for-report-server-access) |
