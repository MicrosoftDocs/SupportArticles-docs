---
title: Configure antivirus software to work with SQL Server
description: This article describes how to configure antivirus software on computers running SQL Server.
author: pijocoder
ms.author: jopilov
ms.reviewer: jopilov
ms.date: 05/26/2025
ms.custom: sap:Security, Encryption, Auditing, Authorization
---

# Configure antivirus software to work with SQL Server

This article contains general guidelines to help you properly configure antivirus software on computers that are running SQL Server in your environment.

We strongly recommend that you individually assess the security risk for each computer that's running SQL Server in your environment. Based on the assessment, you must select the appropriate tools for the security risk level of each computer that's running SQL Server.

Additionally, we recommend that you test the entire system under a full load to measure any changes in stability and performance before you roll out any virus-protection software.

Virus protection software requires system resources to execute. You must perform testing before and after you install your antivirus software to determine whether there's any adverse performance effects on the computer that's running SQL Server and on SQL Server itself.

## Security risk factors

Consider the following factors when deciding on anti-malware solutions:

- The business value of the information that's stored on the computer.
- The required security level for the information.
- The cost of losing access to the information.
- The risk of either viruses or bad information propagating from that computer.

## High-risk servers

Any server is at some risk of infection. The highest-risk servers generally meet one or more of the following criteria:

- The servers are open to the public Internet.
- The servers have open ports to servers that aren't behind a firewall.
- The servers read or execute files from other servers.
- The servers run HTTP servers, such as Internet Information Services (IIS) or Apache.
- The servers host file shares.
- The servers use [Database Mail](/sql/relational-databases/database-mail/database-mail) to handle incoming or outgoing email messages.

Servers that don't meet the criteria for a high-risk server are generally at a lower risk, although not always.

## Antivirus software types

- Active virus scanning: This kind of scanning checks incoming and outgoing files for viruses.

- Virus sweep software: Virus sweep software scans existing files for file infection. It detects issues after files are infected by a virus. This kind of scanning may cause the following SQL Server database recovery and SQL Server full-text catalog file issues:

  - If the virus sweep software has opened a database file when SQL Server tries to open the database, the database to which the file belongs might be marked as suspect. SQL Server opens a database when it starts or when a database with Auto-Close enabled was closed and is accessed again. SQL Server database files typically have *.mdf*, *.ldf*, or *.ndf* file name extensions.

  - If the virus sweep software has a SQL Server full-text catalog file open when [Full-Text Search](/sql/relational-databases/search/full-text-search) tries to access the file, you may have problems with the full-text catalog.

- Vulnerability scanning software: The [Microsoft Security Compliance Toolkit](/windows/security/threat-protection/windows-security-configuration-framework/security-compliance-toolkit-10) includes a set of tools that enable enterprise administrators to perform a wide range of security tasks. These tasks include download, analyze, test, edit, store Microsoft-recommended security configuration baselines for Windows and other Microsoft products, and compare them against other security configurations. To download it, go to [Microsoft Security Compliance Toolkit 1.0](https://www.microsoft.com/download/details.aspx?id=55319).

- Microsoft also released the [Windows Malicious Software Removal Tool](https://www.microsoft.com/download/details.aspx?id=9905) to help remove specific, prevalent malicious software from computers. For more information about the Microsoft Windows Malicious Software Removal Tool, see [Remove specific prevalent malware with Windows Malicious Software Removal Tool (KB890830)](https://support.microsoft.com//topic/remove-specific-prevalent-malware-with-windows-malicious-software-removal-tool-kb890830-ba51b71f-39cd-cdec-73eb-61979b0661e0).
  
> [!NOTE]  
> Windows Server 2016 and later versions automatically enable Windows Defender. Make sure that Windows Defender is configured to exclude *Filestream* files. Failure to do this can result in decreased backup and restore operations performance. For more information, see [Configure and validate exclusions for Windows Defender Antivirus scans](/windows/security/threat-protection/windows-defender-antivirus/configure-exclusions-windows-defender-antivirus).

## SQL Server processes to exclude from virus scanning

When you configure your antivirus software settings, make sure that you exclude the following processes (as applicable) from virus scanning.

- [sqlservr.exe](/sql/tools/sqlservr-application) (SQL Server Database Engine)
- *sqlagent.exe* (SQL Server Agent)
- *sqlbrowser.exe* (SQL Server Browser service)
- *%ProgramFiles%\\Microsoft SQL Server\\1\<NN\>\\Shared\\SQLDumper.exe* ([SQLDumper utility](../../tools/use-sqldumper-generate-dump-file.md))

For an updated list of services and file paths, see [Services installed by SQL Server](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions#Service_Details).

Applications installed on a SQL Server computer can load modules into the SQL Server process (*sqlservr.exe*). The applications use this functionality to run business logic or for intrusion monitoring and protection. To detect if an unknown module or a module from third-party software was loaded into the process memory space, check the output of the [sys.dm_os_loaded_modules](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-loaded-modules-transact-sql) Dynamic Management View (DMV).

In some cases, applications or drivers may be used to detour SQL Server or Windows code to provide malware protection or monitoring services. However, if such applications or drivers aren't designed correctly, they may cause a wide variety of issues for products like SQL Server. For information about third-party detours or similar techniques in SQL Server, see [Detours or similar techniques may cause unexpected behaviors with SQL Server](../../general/issue-detours-similar-techniques.md).

## Configure antivirus software to work with SQL Server Database Engine

This section applies to SQL Server installations running on Windows operating systems, both stand-alone and Failover Cluster Instances (FCI).

### Directories and file name extensions to exclude from virus scanning

When you configure your antivirus software settings, make sure that you exclude the following files or directories (as applicable) from virus scanning. Exclusion may improve SQL Server performance and ensures that the files aren't locked when the SQL Server service must use them. However, if these files become infected, your antivirus software can't detect the infection. For more information about the default file locations for SQL Server, see [File Locations for Default and Named Instances of SQL Server](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server).

#### SQL Server data files

These files usually have one of the following file name extensions:

- *.mdf*
- *.ldf*
- *.ndf*

By default, the data files are located in the following directories. However, the database administrators of the system can place them in any directory.

|SQL Server instance   | Default data directory|
|-------               |---------              |
|SQL Server default instance  |*%ProgramFiles%\\Microsoft SQL Server\\MSSQL\<NN\>.MSSQLSERVER\\MSSQL\\DATA*  |
|SQL Server named instance    |*%ProgramFiles%\\Microsoft SQL Server\\MSSQL\<NN\>.\<InstanceName\>\\MSSQL\\DATA* |  

> [!NOTE]
> `<NN>` and `<InstanceName>` are placeholders.

#### SQL Server backup files

These files typically have one of the following file name extensions:

- *.bak*
- *.trn*

By default, the backup folders are located in the following directories. However, backup files can be placed in any directory by the database administrators of the system.

|SQL Server instance   | Default backup directory|
|-------               |---------                |
|SQL Server default instance  |*%ProgramFiles%\\Microsoft SQL Server\\MSSQL\<NN\>.MSSQLSERVER\\MSSQL\\Backup*  |
|SQL Server named instance    |*%ProgramFiles%\\Microsoft SQL Server\\MSSQL\<NN\>.\<InstanceName\>\\MSSQL\\Backup* |  

#### Full-Text catalog files
  
|SQL Server instance   | Process/Executable file|
|-------               |---------               |
|SQL Server default instance  |*%ProgramFiles%\\Microsoft SQL Server\\MSSQL\<NN\>.MSSQLSERVER\\MSSQL\\FTDATA*  |
|SQL Server named instance    |*%ProgramFiles%\\Microsoft SQL Server\\MSSQL\<NN\>.\<InstanceName\>\\MSSQL\\FTDATA* |  

#### Trace files

These files usually have the *.trc* file name extension. These files can be generated when you configure [SQL tracing manually](/sql/relational-databases/sql-trace/create-a-trace-transact-sql) or when you enable [C2 auditing](/sql/database-engine/configure-windows/c2-audit-mode-server-configuration-option) for the server.

#### Extended Event file targets

- Typically saved as *.xel* or *.xem*.
- System-generated files are saved in the *LOG* folder for that instance.

#### SQL audit files

These files have the *.sqlaudit* file name extension. For more information, see [SQL Server Audit (Database Engine)](/sql/relational-databases/security/auditing/sql-server-audit-database-engine).

#### SQL query files

These files typically have the *.sql* file name extension and contain Transact-SQL statements.

#### Filestream data files

- No specific file extension for the files.
- Files are present under the folder structure identified by the container type FILESTREAM from [sys.database_files](/sql/relational-databases/system-catalog-views/sys-database-files-transact-sql).
- <drive\>:\RsFxName
  - The `<drive>` refers to the root drive of the folder structure identified by the container type FILESTREAM from [sys.database_files](/sql/relational-databases/system-catalog-views/sys-database-files-transact-sql).

#### Remote Blob Storage files

- Refers to the directory that stores Reporting Services temporary files and logs (*RSTempFiles* and *LogFiles*). For more information, see [Reporting Services Log Files and Sources - SQL Server Reporting Services (SSRS)](/sql/reporting-services/report-server/reporting-services-log-files-and-sources) and [RsReportServer.config Configuration File - SQL Server Reporting Services (SSRS)](/sql/reporting-services/report-server/rsreportserver-config-configuration-file).

#### Exception dump files

The memory dump files typically use the *.mdmp* file name extension. These are system-generated files, which are saved in the *\\LOG* subfolder for that instance or in the folder that following registry key points to: HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Microsoft SQL Server\\\<instance name\>\\CPE.
For more information about memory dumps, see [Use the Sqldumper.exe tool to generate a dump file in SQL Server](../../tools/use-sqldumper-generate-dump-file.md).

#### In-memory OLTP files

In essence, the In-Memory OLTP technology has two sets of files:

- Files related to [natively compiled stored procedures and memory-optimized tables](/sql/relational-databases/in-memory-oltp/creating-a-memory-optimized-table-and-a-natively-compiled-stored-procedure).

  - The In-memory OLTP files are typically stored in an *xtp* subfolder under the *DATA* directory for the instance.
  - File formats include the following types:

    - *xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.c*
    - *xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.dll*
    - *xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.obj*
    - *xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.out*
    - *xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.pdb*
    - *xtp\_\<t/p\>\_\<dbid\>\_\<objid\>.xml*
  
    > [!NOTE]
    > *xtp* is a prefix used to indicate the association with In-memory OLTP. The placeholder `<t/p>` represents either "t" for table or "p" for procedure. The placeholder `<dbid>` refers to the database ID of the user database where the memory-optimized object is located. The placeholder `<objid>` indicates the object ID assigned to the memory-optimized object (either the table or the procedure).

- Files related to [checkpoint](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-xtp-checkpoint-files-transact-sql) and [delta files](/sql/relational-databases/in-memory-oltp/durability-for-memory-optimized-tables).

  - No specific file extension for the files.
  - Files are present under the folder structure identified by the container type FILESTREAM from `sys.database_files`.

#### DBCC CHECKDB files

The DBCC CHECKDB files use the following format:

  <Database_data_filename.extension\>\_MSSQL_DBCC\<database_id_of_snapshot\>

These are temporary files. For more information, see [Internal database snapshot](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#how-dbcc-checkdb-creates-an-internal-snapshot-database-beginning-with-sql-server-2014).

#### Replication

The following table contains the Replication executables and server-side COM objects. DBCC CHECKDB creates temporary files for the duration of the `DBCC` command after which they get removed automatically.

- Replication executables and server-side COM objects

  |Default location     | Process/Executable directory|
  |-------              |---------                    |
  |x86 default location |*\<drive\>:\\Program Files (x86)\\Microsoft SQL Server\\\<NNN\>\\COM\\*  |
  |x64 default location |*\<drive\>:\\Program Files\\Microsoft SQL Server\\\<NNN\>\\COM\\*  |
  
  > [!NOTE]
  > The `<NNN>` is a placeholder for version-specific information. To specify the correct value, check your installation or search for "Replication and server-side COM objects" in [Specifying File Paths](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server#specifying-file-paths). For example, the full path for SQL Server 2022 would be *<drive\>:\\Program Files\\Microsoft SQL Server\\160\\COM\\*.
  
- Starting with SQL Server 2017 CU22 (including SQL 2019 RTM and later versions), if you're using Transactional Replication and the Distribution Agent is using OLEDB streaming profile, or you're using the `-UseOledbStreaming` parameter, the Distribution Agent creates temporary files (*\*.lob*) in the *AppData* folder of the account running the distribution agent where the job is being invoked. For example, *C:\\Users\\\<DistributionAgentAccount\>\\AppData\\Temp\\\*.lob*. For prior versions of SQL Server, the default *COM* folder (already listed) is used.

  For more information, see ["The distribution agent failed to create temporary files" error message](../replication/error-run-distribution-agent.md).

- Files in the Replication Snapshot folder

  The default path for the snapshot files is *\\Microsoft SQL Server\\MSSQL\<NN\>.MSSQLSERVER\\MSSQL\\ReplData*. These files typically have file name extensions such as *.sch*, *.idx*, *.bcp*, *.pre*, *.cft*, *.dri*, *.trg*, or *.prc*.

### Considerations for Failover Cluster instances (Always On FCI)

You can run antivirus software on a SQL Server cluster. However, you must make sure that the antivirus software is a cluster-aware version.

Contact your antivirus vendor about cluster-aware versions and interoperability.

If you're running antivirus software on a cluster, make sure that you also exclude these locations from virus scanning:

- *Q:\\* (Quorum drive)
- *C:\\Windows\\Cluster*
- *MSDTC* directory in the *MSDTC* drive

If you back up the database to a disk or back up the transaction log to a disk, you can exclude the backup files from the virus scanning.

For more information about antivirus considerations on a cluster, see [Antivirus software that isn't cluster-aware may cause problems with Cluster Services](../../../windows-server/high-availability/not-cluster-aware-antivirus-software-cause-issue.md).

### Arc-enabled SQL Server

When you run antivirus software on an [Arc-enabled SQL Server](/sql/sql-server/azure-arc/connect) instance, some files and executables (also referred to as system objects) might be flagged. However, these [system objects](/sql/sql-server/azure-arc/agent-extension-files) are necessary for Arc-enabled SQL Server to function properly. To ensure optimal performance and stability, we recommend that you exclude these [necessary system objects](/sql/sql-server/azure-arc/agent-extension-files) from antivirus scanning.

Starting with SQL Server 2025, SQL Server instances can use the Azure Arc machine's managed identity. You might need to add an exemption for the token folder. Follow the steps in [Set up a managed identity for Arc-enabled SQL Server](/sql/sql-server/azure-arc/managed-identity) for the proper setup and the folder path.

We also recommend that you keep the extension up to date, as it includes ongoing security and feature updates. For more information, see the [latest extension release](/sql/sql-server/azure-arc/release-notes).

## Configure antivirus software to work with Analysis Services (SSAS)

The following Analysis Services directories and processes can be excluded from antivirus scanning.

### SSAS processes to exclude from virus scanning

|SSAS instance         | Process/Executable file|
|-------               |---------               |
|Default instance |*%ProgramFiles%\\Microsoft SQL Server\\\MSAS\<ID\>.MSSQLSERVER\\OLAP\\bin\\MSMDSrv.exe*|
|Named instance   |*%ProgramFiles%\\Microsoft SQL Server\\\MSAS\<ID\>.<InstanceName\>\\OLAP\\bin\\MSMDSrv.exe*|

The `<ID>` is a placeholder for the build ID. For example, a default Analysis Services 2016 instance binary installation location by default is *C:\\Program Files\\Microsoft SQL Server\\MSAS13.MSSQLSERVER\OLAP\bin*.

### SSAS directories and file name extensions to exclude from virus scanning

When you configure your antivirus software settings, make sure that you exclude the following SSAS files or directories (as applicable) from virus scanning. Excluding the files improves SSAS performance and helps make sure that the files aren't locked when the SQL Server service must use them. However, if these files become infected, your antivirus software can't detect the infection.

#### Data directory for Analysis Services

The directory that holds all Analysis Services data files is specified in the `DataDir` property of the instance of Analysis Services. The following table shows the default path of the SSAS instance:

|SSAS instance      | Default data directory|
|---------          |---------              |
|Default instance   | *C:\\Program Files\\Microsoft SQL Server\\MSAS\<ID\>.MSSQLSERVER\\OLAP\\Data*     |
|Named instance     | *C:\\Program Files\\Microsoft SQL Server\\MSAS\<ID\>.\<InstanceName\>\\OLAP\\Data* |

#### Temporary files for Analysis Services

For Analysis Services 2012 and later versions, temporary files during processing are specified by the `TempDir` property of the instance of Analysis Services. By default, this property is empty. When this property is empty, the default directory is used. The following table shows the *Temp* path by default.

|SSAS instance      | Temporary files directory|
|---------          |---------                 |
|Default instance   | *C:\\Program Files\\Microsoft SQL Server\\MSAS\<ID\>.MSSQLSERVER\\OLAP\\Temp*         |
|Named instance     | *C:\\Program Files\\Microsoft SQL Server\\MSAS\<ID\>.\<InstanceName\>\\OLAP\\Temp*|

#### The backup files for Analysis Services

In Analysis Services 2012 and later versions, the backup file location is the location that is specified by the `BackupDir` property. The following table shows the default backup path for the Analysis Service instance:

|SSAS instance      | Backup files directory (default)|
|---------          |---------                        |
|Default instance   | *C:\\Program Files\\Microsoft SQL Server\\MSAS\<ID\>.MSSQLSERVER\\OLAP\\Backup*     |
|Named instance     | *C:\\Program Files\\Microsoft SQL Server\\MSAS\<ID\>.\<InstanceName\>\\OLAP\\Backup* |

You can change this directory in the properties of the instance of Analysis Services. Any backup command can point to a different location also. Or, the backup files can be copied elsewhere for restore.

#### The directory that holds Analysis Services log files

By default, in Analysis Services 2012 and later versions, the log file location is the location that is specified by the `LogDir` property. By default, the *Log* path is located as follows:

|SSAS instance      | Log files directory|
|---------          |---------           |
|Default instance   | *C:\\Program Files\\Microsoft SQL Server\\MSAS\<ID\>.MSSQLSERVER\\OLAP\\Log*     |
|Named instance     | *C:\\Program Files\\Microsoft SQL Server\\MSAS\<ID\>.\<InstanceName\>\\OLAP\\Log* |

#### Directories for partitions not stored in the default data directories for Analysis Services 2012 and later versions

When you create the partitions, these locations are defined in the **Storage** location section of the **Processing and Storage Locations** page of the **Partition Wizard**. Be sure to exclude those from scanning.

## Configure antivirus software to work with SQL Server Integration Services (SSIS)

The following processes and directories for the SSIS services are to be excluded from antivirus scanning.

### SSIS processes to exclude from virus scanning

|Service           | Process/Executable file|
|---------         |---------               |
|SSIS instance     | *%Program Files%\\Microsoft SQL Server\\\<VersionNum\>\\DTS\\Binn\\ISServerExec.exe*   |
|DTSExec instance  | *%Program Files%\\Microsoft SQL Server\\\<VersionNum\>\\DTS\\Binn\\DTExec.exe*         |

> [!NOTE]
> The placeholder `<VersionNum>` refers to the version-specific details.

### SSIS directories to exclude from virus scanning

When you configure your antivirus software settings, make sure that you exclude the following files or directories (as applicable) from virus scanning. This improves the performance of the files and helps make sure that the files aren't locked when the SSIS service must use them. However, if these files become infected, your antivirus software can't detect the infection.

|Description             | Directories to exclude|
|---------               |---------              |
|Directories to exclude  |*%Program Files%\\Microsoft SQL Server\\\<VersionNum\>\\DTS* |

> [!NOTE]
> The placeholder `<VersionNum>` refers to the version-specific details.

## Configure antivirus software to work with PolyBase

The following processes and directories for the PolyBase services are to be excluded from anti-virus scanning.

### PolyBase processes to exclude from virus scanning

|Service     | Process/Executable file|
|---------   |---------               |
|PolyBase Engine service| *%ProgramFiles%\\Microsoft SQL Server\\\<InstanceID\>.\<InstanceName\>\\MSSQL\\Binn\\Polybase\\mpdwsvc.exe* |
|PolyBase Data Movement (DMS) and Engine services | *%ProgramFiles%\\Microsoft SQL Server\\\<InstanceID\>.\<InstanceName\>\\MSSQL\\Binn\\Polybase\\mpdwsvc.exe* |

PolyBase Data Movement service (DMS) and Engine services use the same executable with different command line parameters.

### PolyBase directories and file name extensions to exclude from virus scanning

When you configure your antivirus software settings, make sure that you exclude the following files or directories (as applicable) from virus scanning. This improves the performance of the files and helps make sure that the files aren't locked when the PolyBase service must use them. However, if these files become infected, your antivirus software can't detect the infection.

|Description          | Directories to exclude  |
|---------            |---------                |
|PolyBase log files   |*%ProgramFiles%\\Microsoft SQL Server\\\<InstanceID\>.\<InstanceName\>\\MSSQL\\Log\\Polybase\\*|

## Configure antivirus software to work with Reporting Services (SSRS)

The following processes and directories for the SQL Server Reporting Services (SSRS) must be excluded from antivirus scanning.

### SSRS processes to exclude from virus scanning

The executables that must be excluded have evolved across different versions of SSRS. The following table lists them according to the SSRS version.

|SSRS version       | Process/Executable file|
|---------          |---------               |
|SSRS 2014 | *%ProgramFiles%\\Microsoft SQL Server\\<InstanceID\>.\<InstanceName\>\\Reporting Services\\ReportServer\\Bin\\ReportingServicesService.exe*|
|SSRS 2016 | *%ProgramFiles%\Microsoft SQL Server\\<InstanceID\>.\<InstanceName\>\\Reporting Services\\ReportServer\\Bin\ReportingServicesService.exe* </br></br> *%ProgramFiles%\Microsoft SQL Server\\<InstanceID\>.\<InstanceName\>\\Reporting Services\\RSWebApp\Microsoft.ReportingServices.Portal.WebHost.exe*  |
|SSRS 2017 and later versions| *%ProgramFiles%\\Microsoft SQL Server Reporting Services\\SSRS\Management\\RSManagement.exe*</br> </br>  *%ProgramFiles%\\Microsoft SQL Server Reporting Services\\SSRS\\Portal\\RSPortal.exe* </br></br>  *%ProgramFiles%\\Microsoft SQL Server Reporting Services\\SSRS\\ReportServer\\bin\\ReportingServicesService.exe*  </br></br> *%ProgramFiles%\\Microsoft SQL Server Reporting Services\\SSRS\\RSHostingService\\RSHostingService.exe* |

### SSRS directories to exclude from virus scanning

The following table lists the SSRS directories that must be excluded:

|SSRS version   | Directories to exclude                                                               |
|---------      |---------                                                                             |
|SSRS 2014      | *%ProgramFiles%\Microsoft SQL Server\\<InstanceID\>.\<InstanceName\>\\Reporting Services* |
|SSRS 2016      | *%ProgramFiles%\Microsoft SQL Server\\<InstanceID\>.\<InstanceName\>\\Reporting Services* |
|SSRS 2017 and later versions|*%ProgramFiles%\\Microsoft SQL Server Reporting Services\\SSRS* </br></br> *%ProgramFiles%\\Microsoft SQL Server Reporting Services\\Shared Tools* |

## Power BI Report Server

For Power BI Report Server, the following exclusions can be made:

### Power BI Report Server processes to exclude from virus scanning

- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\ASEngine\\msmdsrv.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\Management\\RSManagement.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\Office\\RSOffice.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\Portal\\RSPortal.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\PowerBI\\Microsoft.Mashup.Container.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\PowerBI\\Microsoft.Mashup.Container.NetFX40.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\PowerBI\\Microsoft.Mashup.Container.NetFX45.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\PowerBI\\RSPowerBI.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\ReportServer\\bin\\ReportingServicesService.exe*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS\\RSHostingService\\RSHostingService.exe*

### Power BI Report Server directories to exclude from virus scanning

- *%ProgramFiles%\\Microsoft Power BI Report Server\\PBIRS*
- *%ProgramFiles%\\Microsoft Power BI Report Server\\Shared Tools*

## How to check which volumes are scanned by antivirus programs

Antivirus programs use filter drivers to attach to the I/O path on a computer and scan the I/O packets for known virus patterns. In Windows, you can use the [Fltmc utility](/windows-hardware/drivers/ifs/development-and-testing-tools#fltmcexe-command) to enumerate the filter drivers and the volumes they're configured to scan. The `fltmc instances` output may guide you through excluding volumes or folders from scanning.

### 1. Run run this command from a Command Prompt or PowerShell prompt in elevated mode

```console
fltmc instances
```

### 2. Use the output to identify which driver is installed and used by the antivirus program on your computer

Here's a sample output. You need the [Allocated filter altitudes document](/windows-hardware/drivers/ifs/allocated-altitudes) to look up filter drivers by using the uniquely assigned altitude. For example, you may find that the altitude `328010` is in the [320000 - 329998: FSFilter Anti-Virus](/windows-hardware/drivers/ifs/allocated-altitudes#320000---329998-fsfilter-anti-virus) table in the document. Therefore, based on the table name in the document, you know that the `WdFilter.sys` driver is used by the antivirus program on your computer and that it's developed by Microsoft.

```output
Filter                Volume Name                              Altitude        Instance Name       Frame   SprtFtrs  VlStatus
--------------------  -------------------------------------  ------------  ----------------------  -----   --------  --------
CldFlt                C:                                        180451     CldFlt                    0     0000000f
CldFlt                \Device\HarddiskVolumeShadowCopy3         180451     CldFlt                    0     0000000f
FileInfo                                                         40500     FileInfo                  0     0000000f
FileInfo              C:                                         40500     FileInfo                  0     0000000f
FileInfo                                                         40500     FileInfo                  0     0000000f
FileInfo              \Device\HarddiskVolumeShadowCopy3          40500     FileInfo                  0     0000000f
FileInfo              X:\MSSQL15.SQL10\MSSQL\DATA                40500     FileInfo                  0     0000000f
FileInfo              \Device\Mup                                40500     FileInfo                  0     0000000f
FileInfo              \Device\RsFx0603                           40500     FileInfo                  0     0000000f
MsSecFlt                                                        385600     MsSecFlt Instance         0     0000000f
MsSecFlt              C:                                        385600     MsSecFlt Instance         0     0000000f
MsSecFlt                                                        385600     MsSecFlt Instance         0     0000000f
MsSecFlt              \Device\HarddiskVolumeShadowCopy3         385600     MsSecFlt Instance         0     0000000f
MsSecFlt              \Device\Mailslot                          385600     MsSecFlt Instance         0     0000000f
MsSecFlt              \Device\Mup                               385600     MsSecFlt Instance         0     0000000f
MsSecFlt              \Device\NamedPipe                         385600     MsSecFlt Instance         0     0000000f
MsSecFlt              \Device\RsFx0603                          385600     MsSecFlt Instance         0     0000000f
RsFx0603              C:                                         41006.03  RsFx0603 MiniFilter Instance    0     00000000
RsFx0603              \Device\Mup                                41006.03  RsFx0603 MiniFilter Instance    0     00000000
WdFilter                                                        328010     WdFilter Instance         0     0000000f
WdFilter              C:                                        328010     WdFilter Instance         0     0000000f
WdFilter                                                        328010     WdFilter Instance         0     0000000f
WdFilter              X:\MSSQL15.SQL10\MSSQL\DATA               328010     WdFilter Instance         0     0000000f
WdFilter              \Device\HarddiskVolumeShadowCopy3         328010     WdFilter Instance         0     0000000f
WdFilter              \Device\Mup                               328010     WdFilter Instance         0     0000000f
WdFilter              \Device\RsFx0603                          328010     WdFilter Instance         0     0000000f
Wof                   C:                                         40700     Wof Instance              0     0000000f
Wof                                                              40700     Wof Instance              0     0000000f
Wof                   \Device\HarddiskVolumeShadowCopy3          40700     Wof Instance              0     0000000f
bfs                                                             150000     bfs                       0     0000000f
bfs                   C:                                        150000     bfs                       0     0000000f
bfs                                                             150000     bfs                       0     0000000f
bfs                   \Device\HarddiskVolumeShadowCopy3         150000     bfs                       0     0000000f
bfs                   \Device\Mailslot                          150000     bfs                       0     0000000f
bfs                   \Device\Mup                               150000     bfs                       0     0000000f
bfs                   \Device\NamedPipe                         150000     bfs                       0     0000000f
bfs                   \Device\RsFx0603                          150000     bfs                       0     0000000f
bindflt               C:                                        409800     bindflt Instance          0     0000000f
luafv                 C:                                        135000     luafv                     0     0000000f
npsvctrig             \Device\NamedPipe                          46000     npsvctrig                 0     00000008
storqosflt            C:                                        244000     storqosflt                0     0000000f
```

### 3. Find the volumes scanned by the antivirus driver

In the sample output, you may notice that the `WdFilter.sys` driver scans the *X:\MSSQL15.SQL10\MSSQL\DATA* folder, which appears to be a SQL Server data folder. This folder is a good candidate to be excluded from antivirus scanning.

## Configure a firewall with SQL Server products

The following table contains information about how to use a firewall with SQL Server:

| Product | Information about firewall configuration |
| ---     |---                                       |
| SQL Server Database Engine | [Configure the Windows Firewall to allow SQL Server access](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access) |
| Analysis Services (SSAS) | [Configure the Windows Firewall to Allow Analysis Services Access](/analysis-services/instances/configure-the-windows-firewall-to-allow-analysis-services-access) |
| Integration Services (SSIS) | [Configure the Windows Firewall to allow SQL Server access with Integration Services](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access#ports-used-by-integration-services) |
| PolyBase | [Which ports should I allow through my firewall for PolyBase?](/sql/relational-databases/polybase/polybase-faq#which-ports-should-i-allow-through-my-firewall-for-polybase) |
| Reporting services (SSRS) | [Configure a Firewall for Report Server Access](/sql/reporting-services/report-server/configure-a-firewall-for-report-server-access) |

## More information

- For more information on performance issues caused by third-party modules and drivers to SQL Server, see [Performance and consistency issues when certain modules or filter drivers are loaded](../performance/performance-consistency-issues-filter-drivers-modules.md).
- To find general information about SQL Server security, see [Securing SQL Server](/sql/relational-databases/security/securing-sql-server).
- For general recommendations from Microsoft for scanning on Enterprise systems, see [Virus scanning recommendations for Enterprise computers that are running Windows or Windows Server (KB822158)](https://support.microsoft.com/help/822158).
