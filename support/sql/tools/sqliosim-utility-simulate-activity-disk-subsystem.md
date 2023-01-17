---
title: SQLIOSim utility simulates disk subsystem activity
description: This article describes how to use the SQLIOSim utility to perform stress tests on disk subsystems to simulate SQL Server activity.
ms.date: 09/25/2020
ms.custom: sap:Other tools
ms.reviewer: rdorr, bobward
ms.topic: how-to
ms.prod: sql
---
# Use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem

This article describes how to use the SQLIOSim utility to perform stress tests on disk subsystems to simulate SQL Server activity.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 231619

## Summary

For Microsoft SQL Server 2005, SQLIOSim was shipped as a separate download package. Starting with SQL Server 2008, SQLIOSim is included with the SQL Server product installation. When you install SQL Server, you find the SQLIOSim tool in the BINN folder of your SQL Server installation. It is recommended to use these updated versions of the tool to simulate the IO activity on the disk subsystem.

The SQLIOSim utility replaces the SQLIOStress utility. The SQLIOStress utility was formerly known as the SQL70IOStress utility.

This article also contains download information for the SQLIOSim utility.

## Introduction

This article describes the SQLIOSim tool. You can use this tool to perform reliability and integrity tests on disk subsystems. These tests simulate read, write, checkpoint, backup, sort, and read-ahead activities for Microsoft SQL Server. However, if you have to perform benchmark tests and determine the I/O capacity of the storage system, you should use the [Diskspd](https://www.microsoft.com/?ref=aka) tool.

## Overview

The SQLIOSim utility has been upgraded from the SQLIOStress utility. The SQLIOSim utility more accurately simulates the I/O patterns of Microsoft SQL Server.

For more information about SQL Server I/O patterns, see [SQL Server I/O Basics, Chapter 2](/previous-versions/sql/sql-server-2005/administrator/cc917726(v=technet.10)).

> [!NOTE]
> To help maintain appropriate data integrity and security, we recommend that you perform stress tests of your I/O subsystem before you deploy SQL Server on new hardware. The SQLIOSim utility simulates the read patterns, the write patterns, and the problem identification techniques of SQL Server. To perform these tasks, the SQLIOSim utility simulates the user activity and the system activity of a SQL Server system. The SQLIOSim utility performs this simulation independent of the SQL Server engine.

The SQLIOSim utility does not guarantee or warrant data security or integrity. The utility was designed to provide baseline testing of a system environment. The SQLIOSim utility may expose potential data integrity issues.

For more information about logging and data storage, see [Description of logging and data storage algorithms that extend data reliability in SQL Server](https://support.microsoft.com/help/230785).

The download package contains two executable files, SQLIOSim.com and SQLIOSim.exe. Both executable files provide identical simulation capabilities. SQLIOSim.com is a command-line tool that you can configure to run without user interaction. To do this, you can use command-line parameters, a configuration file, or a combination of both of these methods. SQLIOSim.exe is a graphical application that accepts no command-line parameters. However, SQLIOSim.exe does load default configuration data from configuration files.

## SQLIOSim.com command-line parameters

SQLIOSim.com accepts a limited number of command-line parameters to control basic behavior. The configuration file for the SQLIOSim utility provides advanced behavior control. When command-line parameters and configuration file options overlap, the command-line parameters take precedence.

| Parameter| Comment |
|---|---|
| -cfg **file**|Override the Sqliosim.cfg.ini default configuration file. The SQLIOSim utility returns an error if the utility cannot find the file.|
| -save **file**|Save the resulting configuration in the configuration file. You can use this option to create the initial configuration file.|
| -log **file**|Specify the error log file name and the error log file path. The default file name is Sqliosim.log.xml.|
| -dir **dir**|Set the location to create the data (.mdf) file and the log (.ldf) file. You can run this command multiple times. In most cases, this location is a drive root or a volume mount point. This location can be a long path or a UNC path.|
| -d **seconds**|Set the duration of the main run. This value excludes the preparation phase and the verification phase.|
| -size **MB**|Set the initial size of the data file in megabytes (MB). The file can grow up to two times the initial size. The size of the log file is calculated as half the size of the data file. However, the log file cannot be larger than 50 MB.|
  
## SQLIOSim configuration file

Sample configuration files for various tests can be downloaded from SQL Server support team's github repo [here](https://github.com/microsoft/mssql-support/tree/master/sqliosim).

You do not have to use a configuration file. If you do not use a configuration file, all parameters take default values except the data file location and the log file location. You must use one of the following methods to specify the data file location and the log file location:

- Use the command-line parameters in the SQLIOSim.com file.
- Use the **Files and Configuration** dialog box after you run the SQLIOSim.exe file.
- Use the File**x** section of the configuration file.

> [!NOTE]
>
> - If the name of the parameter indicates that the parameter is a ratio or a percentage, the value of the parameter is expressed as the percentage or the ratio, divided by 0.01. For example, the value of the `CacheHitRatio` parameter is **10 percent**. This value is expressed as 1000 because 10, divided by 0.01, equals 1000. The maximum value of a percentage parameter is **10000**.
> - If the parameter type is numeric, and you assign a non-numeric value to the parameter, the SQLIOSim utility sets the parameter to **0**.
> - If the parameter type is `Boolean`, the valid values that you can assign to the parameter are true and false . Additionally, the values are case sensitive. The SQLIOSim utility ignores any invalid values.
> - If a pair of parameters indicates a minimum value and a maximum value, the minimum value must not be larger than the maximum value. For example, the value of the `MinIOChainLength` parameter must not be larger than the value of the `MaxIOChainLength` parameter.
> - If the parameter indicates a number of pages, the SQLIOSim utility checks the value that you assign to the parameter against the file that the SQLIOSim utility processes. The SQLIOSim utility performs this check to make sure that the number of pages does not exceed the file size.

## CONFIG section

The SQLIOSim utility takes the values that you specify in the CONFIG section of the SQLIOSim configuration file to establish global testing behavior.

| Parameter| Default value| Description| Comments |
|---|---|---|---|
| _ErrorFile_| sqliosim.log.xml|Name of the XML type log file||
| _CPUCount_|Number of CPUs on the computer|Number of logical CPUs to create|The maximum is 64 CPUs.|
| _Affinity_| 0|Physical CPU affinity mask to apply for logical CPUs|The affinity mask should be within the active CPU mask. A value of<br/> 0 means that all available CPUs will be used.|
| _MaxMemoryMB_|Available physical memory when the SQLIOSim utility starts|Size of the buffer pool in MB|The value cannot exceed the total amount of physical memory on the computer.|
| _StopOnError_| true|Stops the simulation when the first error occurs||
| _TestCycles_| 1|Number of full test cycles to perform|A value of 0 indicates an infinite number of test cycles.|
| _TestCycleDuration_| 300|Duration of a test cycle in seconds, excluding the audit pass at the end of the cycle||
| _CacheHitRatio_| 1000|Simulated cache hit ratio when the SQLIOSim utility reads from the disk||
| _MaxOutstandingIO_| 0|Maximum number of outstanding I/O operations that are allowed process-wide|The value cannot exceed 140000. A value of 0 means that up to approximately 140,000 I/O operations are allowed. This is the limit of the utility.|
| _TargetIODuration_| 100|Duration of I/O operations, in milliseconds, that are targeted by throttling|If the average I/O duration exceeds the target I/O duration, the SQLIOSim utility throttles the number of outstanding I/O operations to decrease the load and to improve I/O completion time.|
| _AllowIOBursts_| true|Allow for turning off throttling to post many I/O requests|I/O bursts are enabled during the initial update, initial checkpoint, and final checkpoint passes at the end of test cycles. The _MaxOutstandingIO_ parameter is still honored. You can expect long I/O warnings.|
| _NoBuffering_| true|Use the FILE_FLAG_NO_BUFFERING option|SQL Server opens database files by using FILE_FLAG_NO_BUFFERING == true. Some utilities and services, such as Analysis Services, use FILE_FLAG_NO_BUFFERING == false. To fully test a server, execute one test for each setting.|
| _WriteThrough_| true|Use the FILE_FLAG_WRITE_THROUGH option|SQL Server opens database files by using FILE_FLAG_WRITE_THROUGH == true. However, some utilities and services open the database files by using FILE_FLAG_WRITE_THROUGH == false. For example, SQL Server Analysis Services opens the database files by using FILE_FLAG_WRITE_THROUGH == false. To fully test a server, execute one test for each setting.|
| _ScatterGather_| true|Use ReadScatter/WriteGather APIs|If this parameter is set to true, the _NoBuffering_ parameter is also set to true.<br/><br/>SQL Server uses scatter/gather I/Os for most I/O requests.|
| _ForceReadAhead_| true|Perform a read-ahead operation even if the data is already read|The SQLIOSim utility issues the read command even if the data page is already in the buffer pool.<br/><br/>Microsoft SQL Server Support has successfully used the true setting to expose I/O problems.|
| _DeleteFilesAtStartup_| true|Delete files at startup if files exist|A file may contain multiple data streams. Only streams that are specified in the File **x** FileName entry are truncated in the file. If the default stream is specified, all streams are deleted.|
| _DeleteFilesAtShutdown_| false|Delete files after the test is finished|A file may contain multiple data streams. Only data streams that you specify in the File **x** FileName entry are truncated in the file. If the default data stream is specified, the SQLIOSim utility deletes all data streams.|
| _StampFiles_| false|Expand the file by stamping zeros|This process may take a long time if the file is large. If you set this parameter to false, the SQLIOSim utility extends the file by setting a valid data marker.<br/><br/>SQL Server 2005 uses the instant file initialization feature for data files. If the data file is a log file, or if instant file initialization is not enabled, SQL Server performs zero stamping. Versions of SQL Server earlier than SQL Server 2000 always perform zero stamping.<br/><br/>You should switch the value of the _StampFiles_ parameter during testing to make sure that both instant file initialization and zero stamping are operating correctly.|
  
## Filex section

The SQLIOSim utility is designed to allow for multiple file testings. The File **x** section is represented as [File1], [File2] for each file in the test.

| Parameter| Default value| Description| Comments |
|---|---|---|---|
| _FileName_| **No default value**|File name and path|The _FileName_ parameter can be a long path or a UNC path. It can also include a secondary stream name and type. For example, the _FileName_ parameter may be set to file.mdf:stream2.<br/><br/> **NOTE** In SQL Server 2005, DBCC operations use streams. We recommend that you perform stream tests.|
| _InitialSize_| **No default value**|Initial size in MB|If the existing file is larger than the value that is specified for the _InitialSize_ parameter, the SQLIOSim utility does not shrink the existing file. If the existing file is smaller, the SQLIOSim utility expands the existing file.|
| _MaxSize_| **No default value**|Maximum size in MB|A file cannot grow larger than the value that you specify for the _MaxSize_ parameter.|
| _Increment_| 0|Size in MB of the increment by which the file grows or shrinks. For more information, see the "ShrinkUser section" part of this article.|The SQLIOSim utility adjusts the _Increment_ parameter at startup so that the following situation is established:Increment * MaxExtents < MaxMemoryMB / NumberOfDataFiles<br/>If the result is 0, the SQLIOSim utility sets the file as non-shrinkable.|
| _Shrinkable_| false|Indicates whether the file can be shrunk or expanded|If you set the _Increment_ parameter to 0, you set the file to be non-shrinkable. In this case, you must set the _Shrinkable_ parameter to false. If you set the _Increment_ parameter to a value other than 0, you set the file to be shrinkable. In this case, you must set the _Shrinkable_ parameter to true.|
| _Sparse_| false|Indicates whether the Sparse attribute should be set on the files|For existing files, the SQLIOSim utility does not clear the Sparse attribute when you set the _Sparse_ parameter to false.<br/><br/>SQL Server 2005 uses sparse files to support snapshot databases and the secondary DBCC streams.<br/><br/>We recommend that you enable both the sparse file and the streams, and then perform a test pass.<br/><br/> **NOTE** If you set Sparse = true for the file settings, do not specify NoBuffering = false in the config section. If you use these two conflicting combinations, you may receive an error that resembles the following from the tool:<br/><br/>Error:-=====Error: 0x80070467<br/>Error Text: While accessing the hard disk, a disk operation failed even after retries.<br/>Description: Buffer validation failed on `C:\SQLIOSim.mdx Page: 28097`|
| _LogFile_| false|Indicates whether a file contains user or transaction log data|You should define at least one-log file.|
  
## RandomUser section

The SQLIOSim utility takes the values that you specify in the RandomUser section to simulate a SQL Server worker that is performing random query operations, such as Online Transaction Processing (OLTP) I/O patterns.

| Parameter| Default value| Description| Comments |
|---|---|---|---|
| _UserCount_| -1|Number of random access threads that are executing at the same time|The value cannot exceed the following value: CPUCount*1023-100 <br/>The total number of all users also cannot exceed this value. A value of 0 means that you cannot create random access users. A value of -1 means that you must use the automatic configuration of the following value: min(CPUCount*2, 8) <br/>**NOTE** A SQL Server system may have thousands of sessions. Most of the sessions do not have active requests. Use the `count(*)` function in queries against the `sys.dm_exec_requests` dynamic management view (DMV) as a baseline for establishing this test parameter value.<br/><br/> CPUCount here refers to the value of the _CPUCount_ parameter in the CONFIG section.<br/><br/>The `min(CPUCount*2, 8)` value results in the smaller of the values between CPUCount*2 and 8.|
| _JumpToNewRegionPercentage_| 500|The chance of a jump to a new region of the file|The start of the region is randomly selected. The size of the region is a random value between the value of the _MinIOChainLength_ parameter and the value of the _MaxIOChainLength_ parameter.|
| _MinIOChainLength_| 1|Minimum region size in pages||
| _MaxIOChainLength_| 100|Maximum region size in pages|SQL Server 2005 Enterprise Edition and SQL Server 2000 Enterprise Edition can read ahead up to 1,024 pages.<br/><br/>The minimum value is 0. The maximum value is limited by system memory.<br/><br/>Typically, random user activity causes small scanning operations to occur. Use the values that are specified in the ReadAheadUser section to simulate larger scanning operations.|
| _RandomUserReadWriteRatio_| 9000|Percentage of pages to be updated|A random-length chain is selected in the region and may be read. This parameter defines the percentage of the pages to be updated and written to disk.|
| _MinLogPerBuffer_| 64|Minimum log record size in bytes|The value must be either a multiple of the on-disk sector size or a size that fits evenly into the on-disk sector size.|
| _MaxLogPerBuffer_| 8192|Maximum log record size in bytes|This value cannot exceed 64000. The value must be a multiple of the on-disk sector size.|
| _RollbackChance_| 100|The chance that an in-memory operation will occur that causes a rollback operation to occur.|When this rollback operation occurs, SQL Server does not write to the log file.|
| _SleepAfter_| 5|Sleep time after each cycle, in milliseconds||
  
## AuditUser section

The SQLIOSim utility takes the values that you specify in the AuditUser section to simulate DBCC activity to read and to audit the information about the page. Validation occurs even if the value of the _UserCount_ parameter is set to 0.

| Parameter| Default value| Description| Comments |
|---|---|---|---|
| _UserCount_| 2|Number of Audit threads|The value cannot exceed the following value: CPUCount*1023-100 <br/>The total number of all users also cannot exceed this value. A value of 0 means that you cannot create random access users. A value of -1 means that you must use the automatic configuration of the following value: min(CPUCount*2, 8) <br/> **NOTE** A SQL Server system may have thousands of sessions. Most of the sessions do not have active requests. Use the `count(*)` function in queries against the `sys.dm_exec_requests` DMV as a baseline for establishing this test parameter value.<br/><br/> CPUCount here refers to the value of the `CPUCount` parameter in the CONFIG section.<br/><br/>The `min(CPUCount*2, 8)` value results in the smaller of the values between CPUCount*2 and 8.|
| _BuffersValidated_| 64|||
| _DelayAfterCycles_| 2|Apply the _AuditDelay_ parameter after the number of _BuffersValidated_ cycles is completed||
| _AuditDelay_| 200|Number of milliseconds to wait after each _DelayAfterCycles_ operation||
  
## ReadAheadUser section

The SQLIOSim utility takes the values that are specified in the ReadAheadUser section to simulate SQL Server read-ahead activity. SQL Server takes advantage of read-ahead activity to maximize asynchronous I/O capabilities and to limit query delays.

| Parameter| Default value| Description| Comments |
|---|---|---|---|
| _UserCount_| 2|Number of read-ahead threads|The value cannot exceed the following value: CPUCount*1023-100 <br/>The total number of all users also cannot exceed this value. A value of 0 means that you cannot create random access users. A value of -1 means that you must use the automatic configuration of the following value: min(CPUCount*2, 8) <br/> **NOTE** A SQL Server system may have thousands of sessions. Most of the sessions do not have active requests. Use the `count(*)` function in queries against the `sys.dm_exec_requests` DMV as a baseline for establishing this test parameter value.<br/><br/> CPUCount here refers to the value of the _CPUCount_ parameter in the CONFIG section.<br/><br/>The `min(CPUCount*2, 8)` value results in the smaller of the values between CPUCount*2 and 8.|
| _BuffersRAMin_| 32|Minimum number of pages to read per cycle|The minimum value is 0. The maximum value is limited by system memory.|
| _BuffersRAMax_| 64|Maximum number of pages to read per cycle|SQL Server Enterprise editions can read up to 1,024 pages in a single request. If you install SQL Server on a computer that has lots of CPU, memory, and disk resources, we recommend that you increase the file size and the read-ahead size.|
| _DelayAfterCycles_| 2|Apply the _RADelay_ parameter after the specified number of cycles is completed||
|RADelay| 200|Number of milliseconds to wait after each DelayAfterCycles operation||
  
## BulkUpdateUser section

The SQLIOSim utility takes the values that you specify in the BulkUpdateUser section to simulate bulk operations, such as SELECT...INTO operations and BULK INSERT operations.

| Parameter| Default value| Description| Comments |
|---|---|---|---|
| _UserCount_| -1|Number of BULK UPDATE threads|The value cannot exceed the following value: `CPUCount*1023-100` <br/>A value of **-1** means that you must use the automatic configuration of the following value: `min(CPUCount*2, 8)` <br/> **NOTE** A SQL Server system may have thousands of sessions. Most of the sessions do not have active requests. Use the `count(*)` function in queries against the `sys.dm_exec_requests` DMV as a baseline for establishing this test parameter value.<br/><br/> CPUCount here refers to the value of the `CPUCount` parameter in the CONFIG section.<br/><br/>The `min(CPUCount*2, 8)` value results in the smaller of the values between CPUCount*2 and 8.|
| _BuffersBUMin_| 64|Minimum number of pages to update per cycle||
| _BuffersBUMax_| 128|Maximum number of pages to update per cycle|The minimum value is 0. The maximum value is limited by system memory.|
| _DelayAfterCycles_| 2|Apply the `BUDelay` parameter after the specified number of cycles is completed||
| _BUDelay_| 10|Number of milliseconds to wait after each DelayAfterCycles operation||
  
## ShrinkUser section

The SQLIOSim utility takes the values that you specify in the ShrinkUser section to simulate DBCC shrink operations. The SQLIOSim utility can also use the ShrinkUser section to make the file grow.

| Parameter| Default value| Description |
|---|---|---|
| _MinShrinkInterval_| 120|Minimum interval between shrink operations, in seconds|
| _MaxShrinkInterval_| 600|Maximum interval between shrink operations, in seconds|
| _MinExtends_| 1|Minimum number of increments by which the SQLIOSim utility will grow or shrink the file|
| _MaxExtends_| 20|Maximum number of increments by which the SQLIOSim utility will grow or shrink the file|
  
## Configuration .ini file comments

The semicolon character (;) at the start of a line in the configuration .ini file causes the line to be treated as a single comment.

## File creation

The SQLIOSim utility creates separate data files and log files to simulate the I/O patterns that SQL Server generates in its data file and in its log file. The SQLIOSim utility does not use the SQL Server engine to perform stress activity. Therefore, you can use the SQLIOSim utility to test a computer before you install SQL Server.

When you run the SQLIOSim utility, make sure that you specify the same file location that you use for your SQL Server database files. When you do this, the utility simulates the same I/O path as your SQL Server database.

You can enable the compress attribute or the encrypt attribute for the existing test files. You can also enable these attributes for the existing directory where the test files will be created. The corresponding options to enable these attributes are located in the **Properties** dialog box for a file or for a directory.

By default, the SQLIOSim utility creates test files that have the .mdx and.ldx file name extensions. Therefore, these files will not overwrite existing data and log files.

> [!WARNING]
> Do not specify the actual SQL Server database files for testing. The SQLIOSim utility will overwrite the data with random test patterns, and your actual SQL Server data will be lost.

## SQLIOSim error log and handling

The SQLIOSim utility creates the error log file in one of the following locations:

- The location that you specify in the log startup parameter
- The location that you specify in the ErrorFile= line in the Sqliosim.cfg.ini file

The SQLIOSim.log.xml error log contains details about the execution. These details include error information. Review the log carefully for error information and for warning information.

> [!NOTE]
> If you experience an error in the SQLIOSim utility, we recommend that you ask your hardware manufacturer to help determine the root cause of the issue.

## Multiple copies

The SQLIOSim utility accommodates multiple-file-level testing and multiple-user-level testing. The SQLIOSim utility does not require multiple invocations. However, the SQLIOStress utility requires multiple invocations. You can run multiple copies of the SQLIOSim utility if the following conditions are true:

- All copies reference unique testing files per instance of the utility.
- The `MaxMemoryMB` parameter of each instance provides for a non-overlapping memory region that is sufficient for each instance.

The sum of the `MaxMemoryMB` parameter for each instance must be less than or equal to the total physical memory. Some testing phases, such as checkpoint simulation, can be memory-intensive and may create out-of-memory conditions when you run multiple copies. If you experience out-of-memory errors, you can reduce the number of utility copies that are running.

## Sample configuration files

In addition to the default Sqliosim.cfg.ini file, the package provides the following sample files.

| Sample file| Description| Parameters that differ from the default configuration file |
|---|---|---|
|Sqliosim.hwcache.cfg.ini|Minimize reads<br/><br/>Files are made small to keep them fully in memory<br/><br/>No sequential reads|For the AuditUser section and for the ReadAheadUser section:<br/><br/> _CacheHitRatio=10000_ <br/> _UserCount=0_ |
|Sqliosim.nothrottle.cfg.ini|Remove I/O throttling<br/><br/>Minimize the time to wait to increase I/O volume| _TargetIODuration=1000000_ <br/> _AuditDelay=10_ <br/> _RADelay=10_ |
|Sqliosim.seqwrites.cfg.ini|Minimize reads<br/><br/>Files are made small to keep them fully in memory<br/><br/>Files are made non-shrinkable<br/><br/>No sequential reads<br/><br/>No random access<br/><br/>Bulk update in large chunks without delays| _Shrinkable=FALSE_ <br/><br/>For the AuditUser section, for the ReadAheadUser section, and for the RandomUser section:<br/><br/> _CacheHitRatio=10000_ <br/> _ForceReadAhead=FALSE_ <br/> _BuffersBUMin=600_ <br/> _BuffersBUMax=1000_ <br/> _BUDelay=1_ <br/> _UserCount=0_ |
|Sqliosim.sparse.cfg.ini|Use only 32 MB of memory<br/><br/>Make target I/O duration large enough to enable many outstanding I/O requests<br/><br/>Disable scatter/gather APIs to issue separate I/O requests for every 8-KB page<br/><br/>Create a 1-GB non-shrinkable file<br/><br/>Create a 1-GB non-shrinkable secondary sparse stream in the file| _MaxMemoryMB=32_ <br/> _TestCycles=3_ <br/> _TestCycleDuration=600_ <br/> _TargetIODuration=10000_ <br/> _UseScatterGather=FALSE_ <br/><br/>[File1]<br/> _FileName=sqliosim.mdx_ <br/> _InitialSize=1000 MaxSize=1000_ <br/> _Increment=10_ <br/> _Shrinkable=FALSE_ <br/> _LogFile=FALSE_ <br/> _Sparse=FALSE_ <br/><br/>[File2]<br/> _FileName=sqliosim.ldx_ <br/> _InitialSize=50_ <br/> _MaxSize=50_ <br/> _Increment=0_ <br/> _Shrinkable=FALSE_ <br/> _LogFile=TRUE_ <br/> _Sparse=FALSE_ <br/><br/>[File3]<br/> _FileName=sqliosim.mdx:replica_ <br/> _InitialSize=1000_ <br/> _MaxSize=1000_ <br/> _Increment=10_ <br/> _Shrinkable=FALSE_ <br/> _LogFile=FALSE_ <br/> _Sparse=TRUE_ |
  
## References

- [Use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem on Linux](sqliosim-utility-simulate-activity-disk-subsystem-linux.md)

- [Description of caching disk controllers in SQL Server](https://support.microsoft.com/help/86903)

- [Information about using disk drive caches with SQL Server that every database administrator should know](https://support.microsoft.com/help/234656)

- [KB826433 - SQL Server diagnostics added to detect unreported I/O problems due to stale reads or lost writes](https://support.microsoft.com/help/826433)
